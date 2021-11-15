Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330FB4502C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 11:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhKOKuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 05:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhKOKuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 05:50:07 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD77C061746
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Nov 2021 02:47:10 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e144so20679095iof.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Nov 2021 02:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzqLZgdAxB6s3kHdKPWMBHG+3sPES+0fKNo4iARoqeo=;
        b=qdpCOQVNakKyTN3QuNmGIqU1LKri0BzlaNKRvj3JqK+KPLStKIBllPwtjkllun9SuN
         csaJ6RQqPXgGqvg5y0in5SJ3qeHdOVolgaRZOQRBO/vuVHOYKF8rRyaW8TP0WS+FA+lN
         f6rxv89uxfcx/5XUIBlKDAEIDwTfEdtriOVcWPrYu+pP5yOTaFR5xKRK8Ee2U3KKqKul
         EkfiIAY4Bjzs3g/JJjoSto1bbGB4BSxM0TvLto/HBXswfyQKsBt1Sw1wZhPSLYsvA+Db
         E3inlIkxiJO2B0o8U7LN/RpR7Yk5aD4y45uLv28JQc0ougrt2+OOGfctjg6NNPK3iAO9
         N2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzqLZgdAxB6s3kHdKPWMBHG+3sPES+0fKNo4iARoqeo=;
        b=tqGrITuk8ihFH8M7SMK8z5R0UFD2xrFXJ6AWVEmw7I0p0TifXo5JtP+t5qXiEufZud
         Rxa8q3T3KxXrskx77jXmJtmMUZJEi7YccQCcrOyTtFYoEVVppPxf4aE1tG3Zuep3Gtat
         2cVxOUwhZvnf6nlZ826TOgAyhiz45Wg3NqpkaR24ImAO4In4v07BG6tzL2J3V/TEiE3O
         75oRSg1DGOr60M5hckCcMesJ/DrM2n0OJ1X1PL3nUw3it0gPLblmGk0ahU8YYV/wna5I
         hxtaZSKNASV28YfSyckG5J3tfCVR0dlZFKbufesX0WQT9n8BiU/8AHb3kjHjSSOPMwbe
         45bg==
X-Gm-Message-State: AOAM531X4JeCZyZIraSVrWd45rxLrHtkAeKy1B3+LW62Sj+7aNoY47Aj
        WZKn816naE0nRRLo1CW1snl74KW3UsWX5sLoPyY=
X-Google-Smtp-Source: ABdhPJwohQAGGvw8gh2iDcifKnFFK1hhEW3YZE1DJJrpGoeBTfQh0cw0vVFbBEy+A3krh9FZvky6/YZZcnE3azJ3dmE=
X-Received: by 2002:a05:6602:2e03:: with SMTP id o3mr25217238iow.14.1636973229456;
 Mon, 15 Nov 2021 02:47:09 -0800 (PST)
MIME-Version: 1.0
References: <2586108.vuYhMxLoTh@cwmtaff>
In-Reply-To: <2586108.vuYhMxLoTh@cwmtaff>
From:   Kai Krakow <hurikhan77+btrfs@gmail.com>
Date:   Mon, 15 Nov 2021 11:46:43 +0100
Message-ID: <CAMthOuMxvff2d0THhKWCpErQFumrJA9vmNqS6vtBNDwUwf3j-w@mail.gmail.com>
Subject: Re: Help recovering filesystem (if possible)
To:     Matthew Dawson <matthew@mjdsystems.ca>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Mo., 15. Nov. 2021 um 02:55 Uhr schrieb Matthew Dawson
<matthew@mjdsystems.ca>:
> I recently upgrade one of my machines to the 5.15.2 kernel.  on the first
> reboot, I had a kernel fault during the initialization (I didn't get to
> capture the printed stack trace, but I'm 99% sure it did not have BTRFS
> related calls).  I then rebooted the machine back to a 5.14 kernel, but the
> BCache (writeback) cache was corrupted.  I then force started the underlying
> disks, but now my BTRFS filesystem will no longer mount.  I realize there may
> be missing/corrupted data, but I would like to ideally get any data I can off
> the disks.

I had a similar issue lately where the system didn't reboot cleanly
(there's some issue in the BIOS or with the SSD firmware where it
would disconnect the SSD from SATA a few seconds after boot, forcing
bcache into detaching dirty caches).

Since you are seeing transaction IDs lacking behind expectations, I
think you've lost dirty writeback data from bcache. Do fix this in the
future, you should use bcache only in writearound or writethrough
mode.

> This system involves 10 8TB disk, some are doing BCache -> LUKS -> BTRFS, some
> are doing LUKS -> BTRFS.

Not LUKS here, and all my btrfs pool members are attached to a single
SSD as caching frontend.

> When I try to mount the filesystem, I get the following in dmesg:
> [117632.798339] BTRFS info (device dm-0): flagging fs with big metadata feature
> [117632.798344] BTRFS info (device dm-0): disk space caching is enabled
> [117632.798346] BTRFS info (device dm-0): has skinny extents
> [117632.873186] BTRFS error (device dm-0): parent transid verify failed on
> 132806584614912 wanted 3240123 found 3240119

I had luck with the following steps:

* ensure that all members are attached to bcache as they should
* ensure bcache is running in writearound mode for each member
* ensure that btrfs did scan for all members

Next, I started `btrfs check` for each member disk, eventually one
would contain the needed disk structures and only showed a few errors.

I was then able to mount btrfs through that device node, open ctree
didn't fail this time. I don't remember if I used "usebackuproot" for
mount or a similar switch for "btrfs check".

I then ran `btrfs scrub` which fixed the broken metadata. Luckily, I
had only metadata corruption on the disks which had dirty writeback
cleared, and metadata runs in RAID-1 mode for me.

"btrfs check" then didn't find any errors. Reboot worked fine.

[...]
> Is there any hope in recovering this data?  Or should I give up on it at this
> point and reformat?  Most of the data is backed up (or are backups
> themselves), but I'd like to get what I can.

Well, I'm doing daily backups with borg - to a different technology
(no btrfs, no bcache, different system). I don't think backing up
btrfs to btrfs is a brilliant idea, especially not when both are
mounted to the same system.

You may try my steps above. If you've found a member device which
shows fewer errors, you COULD try to repair it if mount still fails
(or try one of the recovery mount options). But you may want to ask
the experts again here.

Depending on how much dirty writeback you've lost in bcache, chances
may be good that one of the members has enough metadata to
successfully mount or repair the filesystem. Or at least, it's a good
start for "btrfs restore" then.

What do we learn from this?

* probably do not use bcache in writeback mode if you can avoid it
* switch bcache to writearound mode before kernel upgrades, wait for
writeback to finish
* success mounting btrfs may depend a lot on which member device you
actually mount


HTH
Kai
