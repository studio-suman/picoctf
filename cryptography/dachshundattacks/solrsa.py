import binascii
import codecs
from matplotlib.pyplot import flag
import ContinuedFractions, Arithmetic, RSAvulnerableKeyGenerator
from Crypto.Util.number import long_to_bytes

e= 65537
n= 72139999020264739529805978634146434767345148098661939826131359246038290981855278090350071130966235464435955982231472113964335331730611368037020563830293508633076636832164923852756433320976662962512634589960726352837444763205689766009596856597290493848363593465414054595915753026386106403571108728094212636713
c= 46540671159782489688856945915267307687057887006188281656688343669315696324414911823695317798332467574994494407392097332879191006144968876831212362685848396082458782373389765865089169007906609885122439993802427022530287646205604010980454330576441738530095968483778530184555401044866449720367711872227114159016


def hack_RSA(e,n):
    '''
    Finds d knowing (e,n)
    applying the Wiener continued fraction attack
    '''
    frac = ContinuedFractions.rational_to_contfrac(e, n)
    convergents = ContinuedFractions.convergents_from_contfrac(frac)
    
    for (k,d) in convergents:
        
        #check if d is actually the key
        if k!=0 and (e*d-1)%k == 0:
            phi = (e*d-1)//k
            s = n - phi + 1
            # check if the equation x^2 - s*x + n = 0
            # has integer roots
            discr = s*s - 4*n
            if(discr>=0):
                t = Arithmetic.is_perfect_square(discr)
                if t!=-1 and (s+t)%2==0:
                    print("Hacked!")
                    return d

# TEST functions

def test_hack_RSA():
    print("Testing Wiener Attack")
    times = 5
    
    while(times>0):
        e,n,d = RSAvulnerableKeyGenerator.generateKeys(1024)
        print("(e,n) is (", e, ", ", n, ")")
        print("d = ", d)
    
        hacked_d = hack_RSA(e, n)
    
        if d == hacked_d:
            print("Hack WORKED!")
        else:
            print("Hack FAILED")
        
        print("d = ", d, ", hacked_d = ", hacked_d)
        print("-------------------------")
        times -= 1

d = hack_RSA(e,n)
print(d)
#d = 7268149982847508719202959093120582119259608447004218564858482228055621305303

h = pow(c,d,n)
#f = long_to_bytes(941933892304675161847270966567339952457392820388980203540018105706600842035482107745420371175759061830129151082438241208027570883920840933575065999067215571422673671944589245280504348788618865240307081319751777253463277756907020688486166320544466596179220461246716269786154875898584466729465152100022323300)

f = "{:x}".format(h)
print(f)
print(binascii.unhexlify(f))
