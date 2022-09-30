syms varphi vartheta psi T_ T P6x P6y P6z

T = Find_P06(psi,vartheta,varphi,P6x,P6y,P6z)
function T_ = Find_P06(psi,vartheta,varphi,P6x,P6y,P6z)
    T_ = [cos(varphi)*cos(vartheta) cos(varphi)*sin(vartheta)*sin(psi)-sin(varphi)*cos(psi) cos(varphi)*sin(vartheta)*cos(psi)+sin(varphi)*sin(psi) P6x;
                    sin(varphi)*cos(vartheta) sin(varphi)*sin(vartheta)*sin(psi)+cos(varphi)*cos(psi) sin(varphi)*sin(vartheta)*cos(psi)-cos(varphi)*sin(psi) P6y;
                    -sin(varphi) cos(varphi)*sin(psi) cos(varphi)*cos(psi) P6z;
                    0 0 0 1];
end

