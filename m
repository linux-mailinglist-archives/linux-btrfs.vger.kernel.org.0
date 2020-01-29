Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6A814D1B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 21:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA2UEo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 15:04:44 -0500
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:48750 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbgA2UEn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 15:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1580328281;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=QM418DtdDbmBEWEzBBro12C3eVBvYHMTEoKgpd8Cg0c=;
        b=kcmchAr0BkDcxjC2SRloQctNxBopGEHjcon1xs6SLPlaeo0f3UI+90eT6GASJz/t
        x1a5o4fu7+Z+Ym23krP5nl6iLeqzKjH8iaHbWAJlrTsJhqvN7HHDNGGA4KJpcQqq4BG
        w+aM4DjM2B9Yoqfy3n81y2Zgo15p+HsQ2w+xCQN0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1580328281;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=QM418DtdDbmBEWEzBBro12C3eVBvYHMTEoKgpd8Cg0c=;
        b=Ps05W0usOStns07XZUZgSf+POLYcvwV8ruTKWaJszhgi9R2Sqb3rcgk5HZJrrQy8
        kuw5Q5UTvP+EStohRt3QeE8rDJE1XCv0V0gW+b9YSUWC4FlO2nWhfS5ORniThIxv9UA
        Lo3tverwJ8FRQbzAo9cQhOeAAAkKqNqQuTg/1ZPA=
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org
References: <112911984.cFFYNXyRg4@merkaba>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016ff2e7e3ad-6b776470-32f1-4b3d-9063-d3c96921df89-000000@eu-west-1.amazonses.com>
Date:   Wed, 29 Jan 2020 20:04:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <112911984.cFFYNXyRg4@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.01.29-54.240.4.3
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29.01.2020 20:33 Martin Steigerwald wrote:
> Hi!
>
> I thought this would not happen anymore, but see yourself:
>
> % LANG=en df -hT /daten
> Filesystem             Type   Size  Used Avail Use% Mounted on
> /dev/mapper/sata-daten btrfs  400G  310G     0 100% /daten
>
> I removed some larger files but to no avail.

I have the same issue since 5.4. This patch should fix it:
https://lore.kernel.org/linux-btrfs/f1f1a2ab-ed09-d841-6a93-a44a8fb2312f@gmx.com/T/
Confirm by writing to the file system. It shouldn't say that it is out
of space (only df report says zero).

As far as I know, it is unfortunately not fixed in any released kernel yet.

>
>
> However, also according to btrfs fi usage it is perfectly good:
>
> % btrfs fi usage -T /daten
> Overall:
>     Device size:                 400.00GiB
>     Device allocated:            311.04GiB
>     Device unallocated:           88.96GiB
>     Device missing:                  0.00B
>     Used:                        309.50GiB
>     Free (estimated):             90.16GiB      (min: 90.16GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              364.03MiB      (used: 0.00B)
>
>                           Data      Metadata  System              
> Id Path                   single    single    single   Unallocated
> -- ---------------------- --------- --------- -------- -----------
>  1 /dev/mapper/sata-daten 310.00GiB   1.01GiB 32.00MiB    88.96GiB
> -- ---------------------- --------- --------- -------- -----------
>    Total                  310.00GiB   1.01GiB 32.00MiB    88.96GiB
>    Used                   308.80GiB 714.67MiB 64.00KiB
>
>
> Even in a state where I think that no balance is required. I started one 
> for some duration and it was able to relocate some block groups just 
> fine:
>
> [88593.639061] BTRFS info (device dm-4): relocating block group 
> 352409616384 flags data
> [88594.076177] BTRFS info (device dm-4): found 1 extents
> [88594.147171] BTRFS info (device dm-4): found 1 extents
> [88594.185681] BTRFS info (device dm-4): relocating block group 
> 351335874560 flags data
> [88597.089032] BTRFS info (device dm-4): found 559 extents
> [88597.170087] BTRFS info (device dm-4): found 550 extents
> [88597.206519] BTRFS info (device dm-4): relocating block group 
> 350262132736 flags data
> [88601.850606] BTRFS info (device dm-4): found 1908 extents
> [88601.988330] BTRFS info (device dm-4): found 1908 extents
>
> I aborted it after some time ago, cause from the values above a balance 
> is not required, I'd say.
>
>
> Also btrfs check seems to be happy:
>
> % btrfs check /dev/sata/daten
> Opening filesystem to check...
> Checking filesystem on /dev/sata/daten
> UUID: […]
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 332322398208 bytes used, no error found
> total csum bytes: 323723112
> total tree bytes: 749453312
> total fs tree bytes: 367476736
> total extent tree bytes: 34422784
> btree space waste bytes: 98074732
> file data blocks allocated: 468393074688
>  referenced 331312160768
>
>
> I believe I switched this filesystem to space cache v2 some time ago. 
> However looking at the mount options I am not entirely sure:
>
> /dev/mapper/sata-daten on /daten type btrfs 
> (rw,noatime,ssd,space_cache,subvolid=257,subvol=/daten)
>
> I just cleared the space_cache:
>
> % mount -o remount,clear_cache,space_cache=v2 /daten
>
> % dmesg | tail -3
> [89385.503291] BTRFS info (device dm-4): force clearing of disk cache
> [89385.503302] BTRFS info (device dm-4): enabling free space tree
> [89385.503305] BTRFS info (device dm-4): using free space tree
>
> Still to no avail:
>
> % LANG=en df -hT /daten
> Filesystem             Type   Size  Used Avail Use% Mounted on
> /dev/mapper/sata-daten btrfs  400G  310G     0 100% /daten
>
>
> There are no permanent snapshots on the filesystem. Backup scripts 
> create a snapshot, but delete it after the backup is completely.
>
> A scrub of the data, which I started just in case, reports no errors.
>
> There is nothing unusual about the filesystem in /var/log/kern.log*
>
>
> ThinkPad T520 running Debian Sid with self-compiled Linux kernel 5.5. 
> BTRFS is on Samsung SSD 860 Pro 1 TB. btrfs-progs v5.4.1.
>
>
> The filesystem mostly has large files I store there once and then they 
> stay there. However recently I copied a bunch of root filesystems of a 
> Proxmox VE cluster to them via rsync -aAHXS, so there are more smaller 
> files on it now as well. There really is no frequent write activity on 
> it. The generation number is just 5857. The filesystem is also quite 
> new, having been created at 2018-08-11. No compression, no raid, no 
> fancy features used.
>
>
> So what is going on here?
>
> Any way to recover the lost space… without redoing the filesystem from 
> scratch? I can redo it easily enough, but if I can spare the time,I'd 
> appreciate it.
>
>
> I am really surprised that this bogus out of space thing can still 
> happen. Especially on such an underutilized filesystem.
>
> Thanks,


