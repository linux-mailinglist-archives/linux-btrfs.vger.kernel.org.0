Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486B132DFE0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 04:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCEDCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Mar 2021 22:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCEDCR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Mar 2021 22:02:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AAEC061574
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Mar 2021 19:02:17 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l22so142547wme.1
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Mar 2021 19:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YFBk4FBa20x6kVq/ErIcWGNcsK29m+e4y++PrwqgRU=;
        b=TnHojb/gpN3fg9RmY2Zy0XYI9fEuOcImi9x4t8JiP+l//+SkgWK9CaFdhW9ynQNCXw
         x4oaC99JqVkB8WkeEFH4UNnFs+lZSfupdnio1YJEiKE1aBh7siirvspXfQ0aGVsC4Ofm
         y2/5X6l3J67KaxiLlEVSIYqW1bStHjndhZrem/S+cGrbAXjLBSHu0RhpbcDV+CZPWnsF
         Cj4D6FBtkzgPLKz5N5OWlwRUf4h8bkhDiCxsRUZPLOC3bQej1fDV6TQylSn5NJ2FlAfe
         aKGM9s0FfWc5jyRL91el8avgtCZKJ624ktveM7IndNyvZ1zXgIOmP0spjIg8I5yWxspN
         JszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YFBk4FBa20x6kVq/ErIcWGNcsK29m+e4y++PrwqgRU=;
        b=qCuwoySIL6Izi2RUjuR1wAv/3GGHWQ4WTkv09vgTjdoOpZTbwzY0kzqYAfYHZ5TT9V
         TVh2ZN9kk3iR202vlRti3iTpnu6FNz35XXL6hMH7JASNK08iol5GJ0nyTbFUdaU1FjnH
         uRUfdTz092D+1KGT6/BJXWJ/bdBk1hOmtRuP0E5wCS7ENE5efAobPNPuGzcMww9blXXt
         Mwtkwqk+dOJuK71jGTLk8lTEeEsPw/ZK8S+e+FJzzHvSSXWtB3dAAs3SG/rBV49QXfVl
         MeYEK1hafw1lqgcdHyVU+JiSaGOiWtcPXWF7bXpvZ0btHQhYwt4dSstJITysFKkcp2CD
         1PgQ==
X-Gm-Message-State: AOAM532VR1i4Ilzn3MdQ0AWpR4QpvtIpDUt8wEz3S0wgN7zCp0d+YEzQ
        CKO48Vi7Ps+QjoqteYuU5y1XK8kXBaGFzOXXqmnKkA==
X-Google-Smtp-Source: ABdhPJwGx5D27ylMHBYKHkksShKDY9ji70zhak5oQJfN9c/iiagYyZoRh5cEcGeI9mxdkSGfyO9zWOdP6AV45qC42KM=
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr2580599wmc.168.1614913335909;
 Thu, 04 Mar 2021 19:02:15 -0800 (PST)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
 <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com>
 <CALS+qHOg89Qtd26NFC4WT+SCv_VxH_k3Erk4=a_pzEMdKZ1Kbw@mail.gmail.com>
 <CAJCQCtRAdn5GsMOGW8VP9K5ysQLepdBT5nt+dtp5UBabQ5yh0A@mail.gmail.com> <CALS+qHN8cL1sQt4kjP_n_TrzqO84qV5X-hP2zhnRLjigTq0g2g@mail.gmail.com>
In-Reply-To: <CALS+qHN8cL1sQt4kjP_n_TrzqO84qV5X-hP2zhnRLjigTq0g2g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 4 Mar 2021 20:01:59 -0700
Message-ID: <CAJCQCtR8pXnfVwrtBEvbvm8qrDwMyqyckZyNNgrSwO8++ShfdA@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Sebastian Roller <sebastian.roller@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 4, 2021 at 8:35 AM Sebastian Roller
<sebastian.roller@gmail.com> wrote:
>
> > I don't know. The exact nature of the damage of a failing controller
> > is adding a significant unknown component to it. If it was just a
> > matter of not writing anything at all, then there'd be no problem. But
> > it sounds like it wrote spurious or corrupt data, possibly into
> > locations that weren't even supposed to be written to.
>
> Unfortunately I cannot figure out exactly what happened. Logs end
> Friday night while the backup script was running -- which also
> includes a finalizing balancing of the device. Monday morning after
> some exchange of hardware the machine came up being unable to mount
> the device.

It's probably not discernible with logs anyway. What hardware does
when it goes berserk? It's chaos. And all file systems have write
order requirements. It's fine if at a certain point writes just
abruptly stop going to stable media. But if things are written out of
order, or if the hardware acknowledges critical metadata writes are
written but were actually dropped, it's bad. For all file systems.


> OK -- I now had the chance to temporarily switch to 5.11.2. Output
> looks cleaner, but the error stays the same.
>
> root@hikitty:/mnt$ mount -o ro,rescue=all /dev/sdi1 hist/
>
> [ 3937.815083] BTRFS info (device sdi1): enabling all of the rescue options
> [ 3937.815090] BTRFS info (device sdi1): ignoring data csums
> [ 3937.815093] BTRFS info (device sdi1): ignoring bad roots
> [ 3937.815095] BTRFS info (device sdi1): disabling log replay at mount time
> [ 3937.815098] BTRFS info (device sdi1): disk space caching is enabled
> [ 3937.815100] BTRFS info (device sdi1): has skinny extents
> [ 3938.903454] BTRFS error (device sdi1): bad tree block start, want
> 122583416078336 have 0
> [ 3938.994662] BTRFS error (device sdi1): bad tree block start, want
> 99593231630336 have 0
> [ 3939.201321] BTRFS error (device sdi1): bad tree block start, want
> 124762809384960 have 0
> [ 3939.221395] BTRFS error (device sdi1): bad tree block start, want
> 124762809384960 have 0
> [ 3939.221476] BTRFS error (device sdi1): failed to read block groups: -5
> [ 3939.268928] BTRFS error (device sdi1): open_ctree failed

This looks like a super is expecting something that just isn't there
at all. If spurious behavior lasted only briefly during the hardware
failure, there's a chance of recovery. But this diminishes greatly if
the chaotic behavior was on-going for a while, many seconds or a few
minutes.


> I still hope that there might be some error in the fs created by the
> crash, which can be resolved instead of real damage to all the data in
> the FS trees. I used a lot of snapshots and deduplication on that
> device, so that I expect some damage by a hardware error. But I find
> it hard to believe that every file got damaged.

Correct. They aren't actually damaged.

However, there's maybe 5-15 MiB of critical metadata on Btrfs, and if
it gets corrupt, the keys to the maze are lost. And it becomes
difficult, sometimes impossible, to "bootstrap" the file system. There
are backup entry points, but depending on the workload, they go stale
in seconds to a few minutes, and can be subject to being overwritten.

When 'btrfs restore' is doing partial recovery that ends up with a lot
of damage and holes tells me it's found stale parts of the file system
- it's on old rails so to speak, there's nothing available to tell it
that this portion of the tree is just old and not valid anymore (or
only partially valid), but also the restore code is designed to be
more tolerant of errors because otherwise it would just do nothing at
all.

I think if you're able to find the most recent root node for a
snapshot you want to restore, along with an intact chunk tree it
should be possible to get data out of that snapshot. The difficulty is
finding it, because it could be almost anywhere.

OK so you said there's an original and backup file system, are they
both in equally bad shape, having been on the same controller? Are
they both btrfs?

What do you get for

btrfs insp dump-s -f /dev/sdXY

There might be a backup tree root in there that can be used with btrfs
restore -t

Also, sometimes easier to do this on  IRC on freenode.net in the channel #btrfs


-- 
Chris Murphy
