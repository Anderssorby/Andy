
math.randomseed(os.time())

wallpapers = {
    "delicate-arch-night-stars-landscape.jpg"
}
l = 1

return {
    get_random_wallpaper = function ()
        dir = os.getenv("HOME") .. "/Images/wallpapers/"
        r = math.random(l)
        return dir .. wallpapers[r]
    end
}
