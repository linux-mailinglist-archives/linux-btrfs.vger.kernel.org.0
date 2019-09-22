Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287ECBA366
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2019 19:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbfIVRr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Sep 2019 13:47:29 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38324 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbfIVRr3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Sep 2019 13:47:29 -0400
Received: by mail-wr1-f44.google.com with SMTP id l11so11477672wrx.5
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Sep 2019 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfH1bb7uTlI4VSowM+PpiKHSdy/4+dp+7yDnrEd9gpk=;
        b=qMXGArLfl3vKEEFl5BHFispXzwSnEs8wdCFZBziOmLW0yCWEmCm9N0IJHFH/uOQc9H
         g9vboASSeJhugp5qOSMudXlH9wwlLMPhZ5iranzkOFoQ1ZjklK05MSXfGav4AM9Ho+tp
         6moMUX2BZ3lQxQSsSDRtYcYYD6WwvPYgda2yHHm4vLk90ZBIjXkhQxMu8HCpoY9v4Mpf
         Pilnin7QJLX/QexogPyXtA0xGEyJc/klYf23ABvk/rEhjZp027AEQbIEuRsF/WMxUADO
         yj/IFLgUKuKGlrP+76tFM5R4/hsrR2h2sJz8dV1Ln4nlpTnbGo9llucwscgQaWdidhJl
         qcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfH1bb7uTlI4VSowM+PpiKHSdy/4+dp+7yDnrEd9gpk=;
        b=ji96YbLfFoU9G2S71b+iEv6F9EOD23LGSvmWnauVAyIuPrfSn7ZJCkgecfGJH45gHb
         FNdz4gxCJ2roUK1OPudF03sRDu2efgSCuCwA7CSUE/FPp9JpWRWdL0RekYdF0WA5Sn/k
         w4oMfLvhoSbRb7hwofp3aN1WD2mp+sA76aRVk4f2OCnmJF0EtHFs5GahOoGs/VSRJhGC
         5QZiYt/JYMr9Y0lHT4E866kT2weUK8JFBYnss87XxUXGhYiW+48QwW+2uQG0PzAH+sy/
         KFSc3vGDLw1FPBoCJYfd2QufhNyUKpOoW02BmZYhf+/QD8qjFJ5kiZjGUD4nfu3x8Yrc
         mpYg==
X-Gm-Message-State: APjAAAVTPGtpG0pjQ2fBNDU6SRq6sFV2pAfsaaO8vvmh89t0dhXD21wQ
        ikp5x0MdId132jmOcrRzlXHFVsT6JpYIhtqCYZpiI9KX0PEzeg==
X-Google-Smtp-Source: APXvYqwWBTudr6FIeponPrZuza0m3n10r+BRXU4oV3YOxNVGWEo9LxbREduSz+LPpAVIA0QeNWekSU3ffEL5cM5XbeY=
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr6443875wrr.390.1569174445976;
 Sun, 22 Sep 2019 10:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
In-Reply-To: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 22 Sep 2019 11:47:15 -0600
Message-ID: <CAJCQCtRAnJR+Z8Z8Bq91YXiMpfmwOiHK0tQ+9zAJvSVvexHnxg@mail.gmail.com>
Subject: Re: Balance ENOSPC during balance despite additional storage added
To:     Pete <pete@petezilla.co.uk>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 20, 2019 at 8:31 AM Pete <pete@petezilla.co.uk> wrote:
>
> I have a btrfs that is on top of an lvm logical volume on top of
> dm-crypt on a single nvme drive (Samsung 870 Pro 512GB).
>
> I added a second logical volume to give more space to get rid of ENOSPC
> errors during balance, but to no avail.  This was after I started
> getting enospc during balance.  Without this additional logical device,
> before balance, I had run out of space owning to some unfortunate
> scripting interacting with lxc snapshots (non btrfs backed in the
> config, so a copy) and some copying.  I was performing a balance,
> following some deletions, when trying to get things back to a better state.
>
> root@phoenix:/var/lib/lxc# btrfs balance start /var/lib/lxc
> WARNING:
>
>          Full balance without filters requested. This operation is very
>          intense and takes potentially very long. It is recommended to
>          use the balance filters to narrow down the scope of balance.
>          Use 'btrfs balance start --full-balance' option to skip this
>          warning. The operation will start in 10 seconds.
>          Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting balance without any filters.
> ERROR: error during balancing '/var/lib/lxc': No space left on device
> There may be more info in syslog - try dmesg | tail
> root@phoenix:/var/lib/lxc#
>
> I can still write to the filesystem.
>
>
> Kernel 5.1.21 (downgraded from 5.2.12)
>
> root@phoenix:/var/lib/lxc# btrfs --version
> btrfs-progs v5.1
>
> root@phoenix:/var/lib/lxc# btrfs fi show /var/lib/lxc
> Label: 'LXC_BTRFS'  uuid: 6b0245ec-bdd4-4076-b800-2243d466b174
>          Total devices 2 FS bytes used 79.74GiB
>          devid    1 size 250.00GiB used 93.03GiB path
> /dev/mapper/nvme0_vg-lxc
>          devid    2 size 80.00GiB used 0.00B path
> /dev/mapper/nvme0_vg-tempdel
>
> root@phoenix:/var/lib/lxc# btrfs fi u /var/lib/lxc
> Overall:
>      Device size:                 330.00GiB
>      Device allocated:             93.03GiB
>      Device unallocated:          236.97GiB
>      Device missing:                  0.00B
>      Used:                         79.74GiB
>      Free (estimated):            237.70GiB      (min: 237.70GiB)
>      Data ratio:                       1.00
>      Metadata ratio:                   1.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>
> Data,single: Size:71.00GiB, Used:70.26GiB
>     /dev/mapper/nvme0_vg-lxc       71.00GiB
>
> Metadata,single: Size:22.00GiB, Used:9.48GiB
>     /dev/mapper/nvme0_vg-lxc       22.00GiB
>
> System,single: Size:32.00MiB, Used:16.00KiB
>     /dev/mapper/nvme0_vg-lxc       32.00MiB
>
> Unallocated:
>     /dev/mapper/nvme0_vg-lxc      156.97GiB
>     /dev/mapper/nvme0_vg-tempdel   80.00GiB
>
> btrfs fi df /var/lib/lxc
> Data, single: total=71.00GiB, used=70.26GiB
> System, single: total=32.00MiB, used=16.00KiB
> Metadata, single: total=22.00GiB, used=9.48GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> root@phoenix:/var/lib/lxc#
>
>
>
> An unfiltered balance shows ENOSPC errors:
> btrfs balance start /var/lib/lxc
>
> Last bit of:
> dmesg | tail -n 100
>
>
> [  920.915627] BTRFS info (device dm-4): found 67520 extents
> [  922.037071] BTRFS info (device dm-4): relocating block group
> 1703106576384 flags data
> [  924.742432] BTRFS info (device dm-4): found 57082 extents
> [  927.245236] BTRFS info (device dm-4): found 57082 extents
> [  928.371624] BTRFS info (device dm-4): relocating block group
> 1702032834560 flags data
> [  931.230841] BTRFS info (device dm-4): found 60454 extents
> [  933.373249] BTRFS info (device dm-4): found 60454 extents
> [  934.336628] BTRFS info (device dm-4): relocating block group
> 1700959092736 flags data
> [  937.330097] BTRFS info (device dm-4): found 67151 extents
> [  940.296250] BTRFS info (device dm-4): found 67151 extents
> [  941.524664] BTRFS info (device dm-4): relocating block group
> 1699885350912 flags data
> [  944.264618] BTRFS info (device dm-4): found 54931 extents
> [  945.910666] BTRFS info (device dm-4): found 54931 extents
> [  946.796308] BTRFS info (device dm-4): relocating block group
> 1698811609088 flags data
> [  949.426823] BTRFS info (device dm-4): found 55428 extents
> [  950.880553] BTRFS info (device dm-4): found 55428 extents
> [  951.622569] BTRFS info (device dm-4): relocating block group
> 1697737867264 flags data
> [  955.223382] BTRFS info (device dm-4): found 52897 extents
> [  956.544084] BTRFS info (device dm-4): found 52897 extents
> [  957.300021] BTRFS info (device dm-4): relocating block group
> 1696664125440 flags data
> [  959.936585] BTRFS info (device dm-4): found 48407 extents
> [  961.421771] BTRFS info (device dm-4): found 48407 extents
> [  962.203680] BTRFS info (device dm-4): relocating block group
> 1695590383616 flags data
> [  964.281128] BTRFS info (device dm-4): found 28238 extents
> [  965.325130] BTRFS info (device dm-4): found 28238 extents
> [  965.886794] BTRFS info (device dm-4): relocating block group
> 1694516641792 flags data
> [  968.999507] BTRFS info (device dm-4): found 46060 extents
> [  970.447815] BTRFS info (device dm-4): found 46060 extents
> [  971.276287] BTRFS info (device dm-4): relocating block group
> 1693442899968 flags data
> [  974.914746] BTRFS info (device dm-4): found 55159 extents
> [  976.914228] BTRFS info (device dm-4): found 55159 extents
> [  977.758643] BTRFS info (device dm-4): relocating block group
> 1692369158144 flags data
> [  980.081069] BTRFS info (device dm-4): found 36859 extents
> [  981.630065] BTRFS info (device dm-4): found 36859 extents
> [  982.498586] BTRFS info (device dm-4): relocating block group
> 1691295416320 flags data
> [  984.929101] BTRFS info (device dm-4): found 50062 extents
> [  986.440469] BTRFS info (device dm-4): found 50062 extents
> [  987.281364] BTRFS info (device dm-4): 11 enospc errors during balance
> [  987.281365] BTRFS info (device dm-4): balance: ended with status: -28
>
> Unfortunately I don't seem to have any more info in dmesg of the enospc
> errors:

You need to mount with enospc_debug to get more information, it might
be useful for a developer. This -28 error is one that has mostly gone
away, I don't know if the cause was ever discovered, but my
recollection is once you're hitting it, you're better off creating a
new file system rather than chasing it.

But you could use 5.2.15 or newer, mount with enospc_debug, and do
filtered balance. You could start with 1% increments, e.g. -dusage=1,
-dusage=2, up to 5. And then do it in 5% increments up to 70. The idea
of that is just to try and avoid enospc while picking off the low
hanging fruit first (the block groups with the most free space). At
that point I would then start a full balance, no filter. Maybe that'll
get it back on track. I haven't ever experienced this so this strategy
is totally a spitball method of trying to fix it. There is some degree
of metadata rewrites that happens as part of balance, and balance is
pretty complicated, and not entirely deterministic - meaning it's
plausible the filtered balance followed by a full balance could fix
it. But I don't understand it well enough.

Also I'd remove any snapshots you don't really need, it'll make the
balance less complicated and faster.


-- 
Chris Murphy
