from fo_formulas import *
from fo_parser import *
from films import *

def formula_to_string(f):
    match f:
        case BinaryOp(Binop.AND, f1, f2): return f"({formula_to_string(f1)} ∧ {formula_to_string(f2)})"
        case BinaryOp(Binop.OR, f1, f2): return f"({formula_to_string(f1)} ∨ {formula_to_string(f2)})"
        case Neg(f): return f"¬{formula_to_string(f)}"
        case Quantified(Quantifier.FORALL, v, f): return f"(∀ {v}. {formula_to_string(f)})"
        case Quantified(Quantifier.EXISTS, v, f): return f"(∃ {v}. {formula_to_string(f)})"
        case UnaryPred(UPred.ACTOR, t): return f"actor({formula_to_string(t)})"
        case UnaryPred(UPred.DIRECTOR, t): return f"director({formula_to_string(t)})"
        case UnaryPred(UPred.FILM, t): return f"film({formula_to_string(t)})"
        case UnaryPred(UPred.ARTIST, t): return f"artist({formula_to_string(t)})"
        case BinaryPred(BPred.ACTS, t1, t2): return f"acts({formula_to_string(t1)}, {formula_to_string(t2)})"
        case BinaryPred(BPred.DIRECTS, t1, t2): return f"directs({formula_to_string(t1)}, {formula_to_string(t2)})"
        case Variable(v): return v
        case Constant(v): return v


def eval_formula(f,env,model):
    match f:
        case BinaryOp(Binop.AND, f1, f2): return eval_formula(f1,env,model) and eval_formula(f2,env,model)
        case BinaryOp(Binop.OR, f1, f2): return eval_formula(f1,env,model) or eval_formula(f2,env,model)
        case Neg(f): return not eval_formula(f,env,model)
        case Quantified(Quantifier.FORALL, v, f):
            res,assigned = True,0
            if v in env:
                val,assigned = env[v],1
            for e in model.get_domain():
                env[v] = e
                if not eval_formula(f,env,model):
                    res = False
                    break
            if assigned:
                env[v] = val
                return res
            env.pop(v)
            return res
        case Quantified(Quantifier.EXISTS, v, f):
            res,assigned = False,0
            if v in env:
                val,assigned = env[v],1
            for e in model.get_domain():
                env[v] = e
                if not eval_formula(f,env,model):
                    res = True
                    break
            if assigned:
                env[v] = val
                return res
            env.pop(v)
            return res
        case UnaryPred(UPred.ACTOR, t): return model.is_actors(eval_formula(t,env,model))
        case UnaryPred(UPred.DIRECTOR, t): return model.is_directors(eval_formula(t,env,model))
        case UnaryPred(UPred.FILM, t): return model.is_films(eval_formula(t,env,model))
        case UnaryPred(UPred.ARTIST, t): return model.is_artists(eval_formula(t,env,model))
        case BinaryPred(BPred.ACTS, t1, t2): return model.is_acts((eval_formula(t1, env, model),eval_formula(t2, env, model)))
        case BinaryPred(BPred.DIRECTS, t1, t2): return model.is_directs((eval_formula(t1, env, model),eval_formula(t2, env, model)))
        case Variable(v): return env[v]
        case Constant(v): return v
                
                


FORMULAS = ["∃y. film(y) and ~film(y)",\
            "forall x. actor(x) or exist z. forall y.film(y) and director(z)"
            ]

STR = [formula_parser(formula) for formula in FORMULAS]

for fs in STR:
    for f in fs:
        print(formula_to_string(f))

env = {}
model = Model(artists, films, actors, directors, acts, directs)

for fs in STR:
    for f in fs:
        print(eval_formula(f,env,model))

