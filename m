Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3F139CFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgAMW4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 17:56:12 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:50753 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAMW4M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 17:56:12 -0500
Received: by mail-wm1-f44.google.com with SMTP id a5so11687376wmb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 14:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=189gQZ+qlVs/CZqjCnoNNHExEKLvB9sEEHklu47pkyQ=;
        b=LWJxLiqj+cMIGuJ+uaO26CNfAcGKrMXjgV1sBkls+dG4jTu09mONK0CvFqUmDGLjI/
         ePLpQMEAcH+p3Hvjtiq1ozz0TGAfc5KC41tYLu033z0jp+5AazcBGpXxBtsxXIA8vsaC
         RoJIciPZ55aV3bVEOrd5hvabhcckVXWrJUp1BtDY79Avn2akByachGXAAI7ijZByGKQs
         byXAVZG0HiGp/Og1IPBgY8zz9xc1yO0M8XpXWxCFJKXVI9/GXhtfgVfMj6dOS1mjA44X
         Xe1wnuE5797P9e/mEKAYwW46w1bp8kttcKkMrb//QJTOqdjXWpPbf8DbUd1t+VS9djkT
         /G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=189gQZ+qlVs/CZqjCnoNNHExEKLvB9sEEHklu47pkyQ=;
        b=frAfOP5lBdsFF5UdvUvVuRTY1g8cIJV0+y78cKD223E9Z4LuXuqrmT76b99aSWAOXg
         xH835bNe/udQpMfjKsGgGxP1lgzGvoT3IXxTmGaXFe88uWdoHnA3atngr6ngwO6MVDLN
         zQ5ixwv8wtvndT9wQIMZigZ/7EB2djqzDSWG5tY4dKQ7QGo5+setio6Pq+0bcjglyKSk
         Pk3Zed/gKwE8t/HvUuEus+ogMzKROw49tBTE5TRXrzLEgRPOxyjjWpWNQov6S0MgLFKz
         N1KoZGCx3Vbo13J6FfdgPA6uk1ZDQCtJj6ZttOjCe5qxphq8laDnln48sQnG4ZLNV8WV
         LO2w==
X-Gm-Message-State: APjAAAWaJ0AoNtm4saG6LVVJ/Q1lCjGFqM1bAl6XK9he3m33FCtlCGed
        XTVgfim0dkNPkCDIQELE8NWVNwM7+AKnSfLq4e50AeJ4VizftA==
X-Google-Smtp-Source: APXvYqyKvLExhW5ZWCjQky6wPv71ROvlqUFZE3PYfYosF5LwZ1yTUwGf/xC1tYa7mQ6Lyk7X34vTv+Su4LUpKQ8XSPM=
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr23110664wmh.164.1578956170310;
 Mon, 13 Jan 2020 14:56:10 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.99999.375.2001131400390.21037@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.21.99999.375.2001131400390.21037@trent.utfs.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 13 Jan 2020 15:55:54 -0700
Message-ID: <CAJCQCtS9rx0M30zLxkND5MYTwLEPxYG=8BuRB3b1Bi8Vr3KTqg@mail.gmail.com>
Subject: Re: file system full on a single disk?
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 13, 2020 at 3:28 PM Christian Kujau <lists@nerdbynature.de> wrote:
>
> Hi,
>
> I realize that this comes up every now and then but always for slightly
> more complicated setups, or so I thought:
>
>
> ============================================================
> # df -h /
> Filesystem             Size  Used Avail Use% Mounted on
> /dev/mapper/luks-root  825G  389G     0 100% /
>
> # btrfs filesystem show /
> Label: 'root'  uuid: 75a6d93a-5a5c-48e0-a237-007b2e812477
>         Total devices 1 FS bytes used 388.00GiB
>         devid    1 size 824.40GiB used 395.02GiB path /dev/mapper/luks-root
>
> # blockdev --getsize64 /dev/mapper/luks-root | awk '{print $1/1024^3, "GB"}'
> 824.398 GB
>
> # btrfs filesystem df /
> Data, single: total=388.01GiB, used=387.44GiB
> System, single: total=4.00MiB, used=64.00KiB
> Metadata, single: total=2.01GiB, used=1.57GiB
> GlobalReserve, single: total=512.00MiB, used=80.00KiB
> ============================================================
>
>
> This is on a Fedora 31 (5.4.8-200.fc31.x86_64) workstation. Where did the
> other 436 GB go? Or, why are only 395 GB allocated from the 824 GB device?

It's a reporting bug. File system is fine.


> I'm running a --full-balance now and it's progressing, slowly. I've seen
> tricks on the interwebs to temporarily add a ramdisk, run another balance,
> remove the ramdisk again - but that seems hackish.

I'd stop the balance. Balancing metadata in particular appears to make
the problem more common. And you're right, it's hackish, it's not a
great work around for anything these days, and if it is, good chance
it's a bug.


> Isn't there a way to prevent this from happening? (Apart from better
> monitoring, so I can run the balance at an earlier stage next time).

In theory it should be enough to unmount then remount the file system;
of course for sysroot that'd be a reboot. There may be certain
workloads that encourage it, that could be worked around temporarily
using mount option metadata_ratio=1.

-- 
Chris Murphy
