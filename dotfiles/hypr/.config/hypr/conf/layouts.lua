-- Layouts — stock example values.

-- https://wiki.hypr.land/configuring/layouts/dwindle-layout/
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- https://wiki.hypr.land/configuring/layouts/master-layout/
hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hypr.land/configuring/layouts/scrolling-layout/
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})
