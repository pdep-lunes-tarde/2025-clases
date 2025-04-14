module Library where

import PdePreludat


-- Refactorizar esta función:
esPositivo :: Number -> Bool
esPositivo numero
   | numero > 0 = True
   | otherwise = False

                                                                                
--     /\      |
--    /**\     |
--   /****\    | 2 kg/cm
--  /******\   | 
-- ----------  ┼  3 m
-- /********\  |
--     ||      | 3 kg/cm
--     ||      | 
pesoPino :: Number -> Number
pesoPino alturaPino
   | alturaPino > 3 = (alturaPino-3) * 100 * 2 + 900
   | alturaPino <= 3 = alturaPino * 100 *3

-- ¿Qué pasa si ahora cambia el requerimiento a?:
--     /\      |
--    /**\     |
--   /****\    | 2 kg/cm
-- ----------  ┼  4 m
--  /******\   | 
-- /********\  |
--     ||      | 3 kg/cm
--     ||      |
pesoPino' :: Number -> Number
pesoPino' alturaPino = implementame









-- pesoPino :: Number -> Number
-- pesoPino alturaPino =
--    pesoParteInferior alturaPino + pesoParteSuperior alturaPino
