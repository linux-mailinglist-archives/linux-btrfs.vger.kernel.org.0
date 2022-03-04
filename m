Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88624CE0FF
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 00:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiCDXeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 18:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCDXeN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 18:34:13 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29F5172E67
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 15:33:22 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id m41so4391331vkf.7
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Mar 2022 15:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jankanis-nl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ULkEF2tvXeYt0+pjThBOJ/8HUh+scxd4RpSHd6NwPNw=;
        b=Py/ycF9Q4IzWzM4fPuDWtbIVbqC3f3WDMytDdBYrHA6aXwh1oEbLUe5MhmIaW0LuP3
         y6KgyhtpJDnp+iI9B6w2HILGpgr/i7PYnSelzj0wZ8l6CHdhdtNWaVOr48CGGdFru+rC
         dMrsMDLW2utWH4UKcjZT2J3jd1qvwbF/q7TqocOnsKE+1S1Lol0hLkhv6B3Zo37iOzr0
         ANcESWzfHKHxffvPlgt0pnZbS+unGdfgcD4uqqPXQ3crVobgRRW8OEAcp14Cbc7RlMQP
         qkiBE8UkVvIWAIqDZy9mKZreuio5TEDy1JUJ04hXoD02XmSvXsBuwV83mK9ogscDSBsz
         HO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ULkEF2tvXeYt0+pjThBOJ/8HUh+scxd4RpSHd6NwPNw=;
        b=Dpwypxk6xLw3tYgKDNn/rECNYsH3Jl1pUbaDQ5wz3kwcXIEN1PsohuFZ2GrNMuaGNK
         jv5uWAN5EH3pJQZYHy5CGi3IIzb6ggUTjsbljyhdmDXoowR72kwVWU05GGTT5Q8zrgF4
         vhh9s7ducYAIHeTjxMbO4b4AFgcXqrbeOXaxQLp4T4tx41DohpARx61huHf9vU5HSAO6
         Q+kWnytX8+YcXOAs188cdGAnR8hPemaFREZxpFPrgHfWWdo6TNoayXEXjtNnSQex/qjB
         U7dQXiK2MI/QaZbUO4lwUmbK3cUu057TvlXfqY/MjnL1dWmytJNeCg8DLMLD5qIE6oiH
         ft6w==
X-Gm-Message-State: AOAM532Hz+UqY9iBoYfFAznH6Teh3WraF5ZguYfjOh+BGfjF1dGlhnIF
        OGhQg61F1q2/bafUEDbL3mspEx0DxHxJ+rwt
X-Google-Smtp-Source: ABdhPJxxx7G+0/4l/8WmITTczxJzlPplcae91VFJXFgdAvCdiYU3OJRDb05bJnx1iE8gJdmzGB2uTw==
X-Received: by 2002:a05:6122:c6e:b0:330:cc8a:47bf with SMTP id i46-20020a0561220c6e00b00330cc8a47bfmr503452vkr.13.1646436801895;
        Fri, 04 Mar 2022 15:33:21 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id x32-20020ab048a3000000b00342b5e4ab73sm980345uac.7.2022.03.04.15.33.21
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 15:33:21 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id u124so3752612vsb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Mar 2022 15:33:21 -0800 (PST)
X-Received: by 2002:a05:6102:c54:b0:320:7af9:607c with SMTP id
 y20-20020a0561020c5400b003207af9607cmr485849vss.87.1646436800944; Fri, 04 Mar
 2022 15:33:20 -0800 (PST)
MIME-Version: 1.0
From:   Jan Kanis <jan.code@jankanis.nl>
Date:   Sat, 5 Mar 2022 00:33:07 +0100
X-Gmail-Original-Message-ID: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
Message-ID: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
Subject: Is this error fixable or do I need to rebuild the drive?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a btrfs filesystem with two disks in raid 1. Each btrfs device
sits on top of a LUKS encrypted volume, which consists of a raw drive
partition on a SMR hard disk, though I don't think that's relevant.

One of the drives failed, the sata link appears to have died, if I'm
interpreting the system logs right. As it's a raid 1 the system kept
running and I didn't notice the dead drive until some time later,
during which I kept using the filesystem.
Something wasn't behaving right, so I decided to reboot. After the
reboot the btrfs filesystem didn't come up and one of the drives was
dead. I was able to mount from the remaining device with
degraded/read-only, all data seemed to be there.
I took out the dead drive and put it into another system for
examination. After some fiddling the drive came up again, so it wasn't
permanently dead after all. I was able to mount it degraded/read-only.
It looked good except for missing the latest changes I made to some
files I was working with, so it was a bit out of date. A btrfs scrub
showed no corruptions.
I put the drive back in the original system, thinking that btrfs would
either refuse to mount it or fix it from the other copy. The
filesystem automatically mounted rw without a 'degraded' option, and
the filesystem could be used again. The logs showed some "parent
transid verify failed" errors, which I assumed would be corrected from
the other copy. Attempting to mount only the drive that had failed
with degraded/read-only now no longer worked.

It's now some days later, the filesystem is still working, but I'm
also still getting "parent transid verify failed" errors in the logs,
and "read error corrected". So by now I'm thinking that btrfs
apparently does not fix this error by itself. What's happening here,
and why isn't btrfs fixing it, it has two copies of everything?
What's the best way to fix it manually? Rebalance the data? scrub it?
delete, wipe and re-add the device that failed so the mirror can be
rebuilt?

best,
Jan
