# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bolos           = Kind.create(name: 'bolos & tortas')
sobremesas      = Kind.create(name: 'sobremesas')
acompanhamentos = Kind.create(name: 'acompanhamentos')
massas          = Kind.create(name: 'massas')
carnes          = Kind.create(name: 'carnes')
entradas        = Kind.create(name: 'entradas')

brasileira  = Cuisine.create(name: 'brasileira')
italiana    = Cuisine.create(name: 'italiana')
francesa    = Cuisine.create(name: 'francesa')
japonesa    = Cuisine.create(name: 'japonesa')
americana   = Cuisine.create(name: 'norte-americana')

john = User.create(name: 'John Doe',
                   email: 'john.doe@example.com',
                   city: 'São Paulo',
                   facebook: '#johndoe_5678',
                   twitter: '@johndoe',
                   password: 'john123',
                   password_confirmation: 'john123')

mary = User.create(name: 'Mary Jane',
                  email: 'mary.jane@example.com',
                  city: 'Nova York',
                  facebook: '#maryjane_5678',
                  twitter: '@maryjane',
                  password: 'mary123',
                  password_confirmation: 'mary123')

fries = mary.recipes.create( title: 'Spider fries',
                      cuisine: norte-americana,
                      kind: entradas,
                      portions: 4,
                      preparation: 20,
                      difficulty: 'fácil'
                      ingredients: '- 1 pacote de batata-fritas\n
                        - 1 tanto bom de óleo\n
                        - Muito bacon\n
                        - Muito queijo mussarela ralado'
                      directions: '1. Refogue o bacon em uma frigideira separada.
                        Escorra o óleo.\n
                        2. Frite a batata e coloque em uma tigela média.\n
                        3. Cubra a batata com uma generosa camada de bacon.\n
                        Em seguida, cubra a camada de bacon com outra generosa
                        camada de queijo ralado.\n
                        4. Leve a tigela ao forno pré-aquecido. Deixe de 1 a 3
                        minutos no forno, até que o queijo derreta por completo.'
                     )

pudim = mary.recipes.create( title: 'Pudim gringo',
                      cuisine: brasileira,
                      kind: sobremesas,
                      portions: 6,
                      preparation: 20,
                      difficulty: 'fácil'
                      ingredients: '- 1 lata de leite condensado\n
                      - 2 latas de leite (use a lata de leite condensado como medida)\n
                      - 4 ovos\n
                      - 1/2 xícara de açúcar\n
                      - 1/3 xícara de água'
                      directions: '1. Prepare o pudim batendo todos os ingredientes no liquidificador\n
                      2. Prepare a calda colocando água e açúcar em uma forma refratária com buraco no meio, de 24 cm de diâmetro\n
                      3. Leve ao microondas na temperatura máxima por 8 minutos, até caramelizar o açúcar\n
                      4. Retire a forma do microondas e girando-a entre as mãos, faça a calda cobrir as paredes da forma\n
                      5. Deixe esfriar um pouco\n
                      6. Coloque na forma a mistura do liquidificador e cubra parcialmente com filme plástico ou prato\n
                      7. Leve ao microondas na temperatura máxima por 9 a 10 minutos\n
                      8. Retire do microondas e deixe esfriar\n
                      9. Leve à geladeira'
                    )

bolo = john.recipes.create( title: 'Bolo de cenoura',
                      cuisine: brasileira,
                      kind: bolos,
                      portions: 16,
                      preparation: 60,
                      difficulty: 'fácil'
                      ingredients: '- cenouras\n
                      - leite\n
                      - 3 ovos\n
                      - 1/2 colher de chá de fermento em pó\n
                      - açúcar\n
                      - margarina\n
                      - chocolate em pó / achocolatado'
                      directions: '1. Misture tudo, menos o chocolate em pó / achocolatado.\n
                      2. Unte a forma, despeje a massa e bote pra assar por 40 minutos.\n
                      #### Cobertura\n
                      - Faça a cobertura com o achocolatado, leite e margarina. Coloque a cobertura logo após tirar o bolo do forno, enquanto estiver quente.\n
                      Sucesso!'
                    )
