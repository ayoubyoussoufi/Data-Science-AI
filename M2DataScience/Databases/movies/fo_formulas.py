from enum import Enum


class Model():
    __match_args__ = ('artists', 'films', 'actors', 'directors', 'acts', 'directs')
    def __init__(self, artists, films, actors, directors, acts, directs):
        # these 4 variables are of type set
        self.__artists = artists
        self.__films = films
        self.__actors = actors
        self.__directors = directors
        
        #these 2 variables are set of pairs
        self.__acts = acts
        self.__directs = directs
        
        self.__domain = self.__artists.union(self.__films)
        
    def get_domain(self):
        return self.__domain
        
    def get_artists(self):
        return self.__artists
        
    def get_films(self):
        return self.__films
        
    def get_actors(self):
        return self.__actors
        
    def get_directors(self):
        return self.__directors
        
    def get_acts(self):
        return self.__acts
        
    def get_directs(self):
        return self.__directs
        
    def is_artists(self,art):
        return art in self.get_artists()
    def is_films(self,film):
        return film in self.get_films()
    def is_actors(self,act):
        return act in self.get_actors()
    def is_directors(self,direct):
        return direct in self.get_directors()
    def is_acts(self,acts):
        return acts in self.get_acts()
    def is_directs(self,directs):
        return directs in self.get_directs()
        
        # we have to add functions for adding new artists, films, ....


class Evaluable:
    def eval(self, model, env):
       pass 

class Quantifier(Enum):
    FORALL = 1
    EXISTS = 2

# bound variable => attribuer une valeur a une variable
#si on a va attribuer 

class Quantified(Evaluable):
    __match_args__ = ('quantifier', 'bound_var', 'formula')

    def __init__(self, quantifier, var, f):
        self.quantifier = quantifier
        self.bound_var = var
        self.formula = f

    def get_quantifier(self):
        return self.quantifier

    def get_var(self):
        return self.var

    def get_sub_formula(self):
        self.formula
# ex of env = [x:'first artist', y:'second film',...]

                #attribuer e a la valeur bound_var
      # -->          #we can use a pair of variale_name and value and when we finish we remove it
                # or after we finish we restorre the env [after the quantifier]
                # or we can use a copy of env
    def eval(self, model, env):
        assigned = 0
        # we will check if the bound_var is already in the environment or not
        if self.bound_var in env:
            val,assigned = env[self.bound_var],1
            
        if self.quantifier == Quantifier.FORALL:
            res = True
            for e in model.get_domain():  
                env[self.bound_var] = e
                if not self.formula.eval(model,env):
                    res = False
                    break
        
        elif self.quantifier == Quantifier.EXISTS:
            res = False
            for e in model.get_domain():
                env[self.bound_var] = e
                if self.formula.eval(model,env):
                    res = True
                    break
        
        if assigned:
            env[self.bound_var] = val
            return res
        env.pop(self.bound_var)
        return res
                
                


class Binop(Enum):
    OR = 1
    AND = 2


class BinaryOp(Evaluable):
    __match_args__ = ('op', 'left', 'right')

    def __init__(self, op, f1, f2):
        self.op = op
        self.left = f1
        self.right = f2

    def get_op(self):
        return self.op

    def get_left(self):
        return self.left

    def get_right(self):
        return self.right

    def eval(self, model, env):
        if self.op == Binop.AND:
            return self.get_left().eval(model,env) and self.get_right().eval(model,env)
        elif self.op == Binop.OR:
            return self.get_left().eval(model,env) or self.get_right().eval(model,env)
    
    
    #model is a database we use, like table, 
    #env [sigma] mapping from varaiables to value in model - dictionnary
    #variable and value will be string

class Neg(Evaluable):
    def __init__(self, f):
        self.formula = f

    def eval(self, model, env):
        return not self.formula.eval(model,env)

    def get_sub_formula(self, f):
        return self.formula


class BPred(Enum):
    EQ = 1              #normal equality
    ACTS = 2             #look at the table if the subterm included or not
    DIRECTS = 3


class BinaryPred(Evaluable):
    __match_args__ = ('predicate', 'arg1', 'arg2')
    #predicate: eq, acts, directs
    # arg1 is x quantified in the formula
    # arg2 is a constant and we have to check if arg1 and arg2 in the predicate

    def __init__(self, pred, t1, t2):
        self.predicacte = pred
        self.arg1 = t1
        self.arg2 = t2

    def get_predicate(self):
        return self.predicate

    def get_arg1(self):
        return self.arg1

    def get_arg2(self):
        return self.arg2

    def eval(self, model, env):
        if self.predicacte == BPred.EQ:
            return self.arg1.eval(model,env) == self.arg2.eval(model,env)
        elif self.predicacte == BPred.ACTS:
            return (self.arg1.eval(model,env), self.arg2.eval(model,env)) in model.get_acts()
        elif self.predicate == BPred.DIRECTS:
            return (self.arg1.eval(model,env), self.arg2.eval(model,env)) in model.get_directs()




class UPred(Enum):
    ACTOR = 1
    FILM = 2
    ARTIST = 3
    DIRECTOR = 4

class UnaryPred(Evaluable):
    __match_args__ = ('predicate', 'arg')
    #valuate the argument and check if it is in the predicate ; actor, film, ...

    def __init__(self, pred, t):
        self.predicate = pred
        self.arg = t

    def get_predicate(self):
        return self.predicate

    def get_arg(self):
        return self.arg

    def eval(self, model, env):
        if self.predicate == UPred.ACTOR:
            return self.arg.eval(model,env) in model.get_actors() 
        elif self.predicate == UPred.FILM:
            return self.arg.eval(model,env) in model.get_films()
        elif self.predicate == UPred.ARTIST:
            return self.arg.eval(model,env) in model.get_artists()
        elif self.predicate == UPred.DIRECTOR:
            return self.arg.eval(model,env) in model.get_directors()
        


class Variable(Evaluable):
    __match_args__ = ('name',)

    def __init__(self, name):
        self.name = name

    def eval(self, model, env):
        #to evaluate the variable
        return env[self.get_name()]

    def get_name(self):
        return self.name


class Constant(Evaluable):
    __match_args__ = ('value',)

    def __init__(self, val):
        self.value = val

    def eval(self, model, env):
        #return None
        return self.value

    def get_value(self):
        return self.value


# next week compute the set of free variable in the formula