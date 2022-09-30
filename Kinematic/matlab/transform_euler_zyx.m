syms varphi vartheta psi T_ T

function T_ = transform_euler_zyx_func(T,psi,vartheta,varphi)
    R_matrix = [cos(varphi)*cos(vartheta) cos(varphi)*sin(vartheta)*sin(psi)-sin(varphi)*cos(psi) cos(varphi)*sin(vartheta)*cos(psi)+sin(varphi)*sin(vartheta)
                    sin(varphi)*cos(vartheta) sin(varphi)*sin(vartheta)*sin(psi)+cos(varphi)*cos(vartheta) sin(varphi)*sin(vartheta)*cos(psi)-cos(varphi)*sin(vartheta);
                    -sin(varphi) cos(varphi)*sin(psi) cos(varphi)*cos(psi)];
    T_ = T*R_matrix;

end

