
math.randomseed(os.time())

wallpapers = {
    "wall1.jpg",
    "wall2.jpg",
    "wall3.jpg",
    "wall4.jpg",
    "wall5.jpg",
}
l = 5

return {
    get_random_wallpaper = function ()
        dir = os.getenv("HOME") .. "/Images/wallpapers/"
        r = math.random(l)
        return dir .. wallpapers[r]
    end
}
