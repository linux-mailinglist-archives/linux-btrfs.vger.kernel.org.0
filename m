Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6816A34D7C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 21:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhC2TG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 15:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhC2TG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 15:06:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4B2C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 12:06:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j18so13932839wra.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TjpI7v1Dy9VuxUPnTVfhUlc2ga7Wivn16ukNlgEbBY=;
        b=XDrBXfpyZGyZM/Cj2ENAgaj1UhkDUHqBUNxUpLxOGeJR4aubmAQyAe/LcH9kcrR2HV
         2bmvmGuq1dn6132eWUVr804B7WxbqALiLdKX9948Ze6obuURlMO8Tx9mUUa5sBQ921XG
         4pu8IsuPBVXHDEk+2lp/oJEzUCZBLL7fqBkSzlpmwlqHPVZaSiUq1xKlhyXdwEOlaegD
         fbXtqbTbDM9IqcLuWRdkmWBLeG7jedLkGlUF95KxhNdB28b2vo2iBQX5TVKJBuWs6lsS
         dzqRk/GfZysu9agD+V667vrW4MfZSr3RsqEROttlE1eBf4d0Hl1RfieURoTmHta5Umx7
         Nbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TjpI7v1Dy9VuxUPnTVfhUlc2ga7Wivn16ukNlgEbBY=;
        b=OGCg+9/4sIIGkHHJxAQnQfILgzl9O6fA+EJScSRpwqbTtOyx3Cs6Ck4aSy3fIHE6u4
         UKxeF35/puLv7e6C04e66bQ4RK+8XveiBMUOQYOVpz0fFCTawmwMT7DVrSxzjlRZs+uB
         3VZG56dgn6+d69CaziC4GpZLXYpPMmenVM6re5rY4tysxRpvJqkFdIW/o4Xh1oB014uK
         BczamyG4VzthbzrqtQ45YV09DgQGcnlpzEtshYXFycsf95oLRfrI0hQsUkr9OXJtjknh
         3XQVBIIQEg4bAyhv8IxE9DKp7AtfV45gtN4KBhR7ysa0J6SprwUyrVFbSyHO/mWsko1R
         VeNg==
X-Gm-Message-State: AOAM532Ka+ajWwLYx0yW/MFM4gVcqFTfLbnu3nAyIWggzPBQ/hEicegt
        2U9e3h8CeC+JJFn/dkbJ7smXPreqCL1dD80QMYhHMZCictxnPbe6
X-Google-Smtp-Source: ABdhPJwHX1bVTFm7U61cJ8MOIYEgTJsKyXoPFUMreCQqkVGAumvyKA1gOycAViiIuJHVtU+g72+IzfuakvJ2TesN0Rw=
X-Received: by 2002:adf:eec9:: with SMTP id a9mr30017167wrp.252.1617044815372;
 Mon, 29 Mar 2021 12:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <e445de94c7ed4e8341b45725415a998a9aeaff08.camel@gmail.com>
In-Reply-To: <e445de94c7ed4e8341b45725415a998a9aeaff08.camel@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 29 Mar 2021 13:06:39 -0600
Message-ID: <CAJCQCtRi3nOpTpANffvEj_7gE6LhizRooYY+3tA0+KofnEDLxg@mail.gmail.com>
Subject: Re: help needed with raid 6 filesystem with errors
To:     Bas Hulsken <bas.hulsken@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 29, 2021 at 4:22 AM Bas Hulsken <bas.hulsken@gmail.com> wrote:
>
> Dear list,
>
> due to a disk intermittently failing in my 4 disk array, I'm getting
> "transid verify failed" errors on my btrfs filesystem (see attached
> dmesg | grep -i btrfs dump in btrfs_dmesg.txt). When I run a scrub, the
> bad disk (/dev/sdd) becomes unresponsive, so I'm hesitant to try that
> again (happened 3 times now, and was the root cause of the transid
> verify failed errors possibly, at least they did not show up earlier
> than the failed scrub).

Is the dmesg filtered? An unfiltered dmesg might help understand what
might be going on with the drive being unresponsive, if it's spitting
out any kind of errors itself or if there are kernel link reset
messages.

Check if the drive supports SCT ERC.

smartctl -l scterc /dev/sdX

If it does but it isn't enabled, enable it. This is true for all the drives.

smartctl -l scterc,70,70

That will result in the drive giving up on errors much sooner rather
than doing the very slow "deep recovery" on reads. If this goes beyond
30 seconds, the kernel's command timer will think the device is
unresponsive and issue a link reset which is ... bad for this use
case. You really want the drive to error out quickly and allow Btrfs
to do the fixups.

If you can't configure the SCT ERC on the drives, you'll need to
increase the kernel command timeout which is a per device value in
/sys/block/sdX/device/timeout  - default is 30 and chances are 180 is
enough (which sounds terribly high and it is but reportedly some
consumer drives can have such high timeouts).

Basically you want the drive timeout to be shorter than the kernel's.

>A new disk is on it's way to use btrfs replace,
> but I'm not sure whehter that will be a wise choice for a filesystem
> with errors. There was never a crash/power failure, so the filesystem
> was unmounted at every reboot, but as said on 3 occasions (after a
> scrub), that unmount was with on of the four drives unresponsive.

The least amount of risk is to not change anything. When you do the
replace, make sure you use recent btrfs-progs and use 'btrfs replace'
instead of 'btrfs device add/remove'

https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/

If metadata is raid5 too, or if it's not already using space_cache v2,
I'd probably leave it alone until after the flakey device is replaced.


> Funnily enough, after a reboot every time the filesystem gets mounted
> without issues (the unresponsive drive is back online), and btrfs check
> --readonly claims the filesystem has no errors (see attached
> btrfs_sdd_check.txt).

I'd take advantage of it's cooperative moment by making sure backups
are fresh in case things get worse.

> Not sure what to do next, so seeking your advice! The important data on
> the drive is backed up, and I'll be running a verify to see if there
> are any corruptions overnight. Would still like to try to save the
> filesystem if possible though.



-- 
Chris Murphy
