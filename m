Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324B022A510
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 04:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbgGWCIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 22:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387627AbgGWCIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 22:08:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25811C0619DC
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 19:08:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so3615130wrj.13
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 19:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5mEb0Xr26AhRwbugtmyAZXR82WSR0owTqUPBtuhdwQ=;
        b=zmwLZyxfmpX8Fm1F1uXnx7x9UmblezpX6/dqLBlqc0wlCul8cazxML5bScI4v1CnEm
         8l0PDL3e2rOLxfZJN1GNVLGmio2RvvK7b5hv5fLw/NoRZLx0m2Prj/1UP71DxBh7VOAx
         iNNjiG6VtVbETuW20XkBXf9hlSfDDYqQ/vZ/QytjtymZZvs3Tpm2lwoNrelUVG8nAIAv
         ntAEGCxxVqcL72RgUPfM38OwTygRiG4kcWOTooOHiXjkwJ8l5dNVysbmUyvMtT0dOkmI
         4h80op8cjj/RZLTGnz+Q9AEayZPFxhQhgHq3SpO95SgPU0ftBQEvus3VDOpqX2F3R1ei
         wKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5mEb0Xr26AhRwbugtmyAZXR82WSR0owTqUPBtuhdwQ=;
        b=kjSOog+7i68veNvI9tSRC7np1bnsnpsA1Xmh1fiP0ElzoPuN47ISWKx3KabFQviCtB
         hkYuaH5pzBp4yyf7M6gzKWguDFdosC5VQnLGEL9YTRAaVm0NBo/9nWccnXb4YByOtkb1
         qf4tYEe/z9DC5ThRjsoM7EKKhcD8+eJ61BE3ytlR0RNWc80opySNFVwgHCM8Ev5PPu19
         71YSvqL7euMmVijLwPBplzAC0MqGdcYLJwggHef1jujDFWK+YliMQrqPIWMM4v+q/LmS
         jHamqQd1IOk8j11VboG4lsVIwJV2PYl10J3iMeUjMJvZ51pC1yJyccr/WHH9jaiwptpp
         jlSg==
X-Gm-Message-State: AOAM531jUH7Eq9xieyqbaZB3dcgxnZax0LDmQDVzrow06yc1NUKXZynz
        Eto4Gjc4o8cH9d/CMV2M12SabQVdhxoSjv43Hls7hA==
X-Google-Smtp-Source: ABdhPJxrbGVQj3XAqE0PInRyPTN9SRDP2y1bvW4M9K0WR6SB2DqcozpPYV8OBMwCFF4ZQEao22aGjEPl2GtEIptB9gI=
X-Received: by 2002:adf:a19e:: with SMTP id u30mr1896539wru.274.1595470126680;
 Wed, 22 Jul 2020 19:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
In-Reply-To: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 22 Jul 2020 20:08:30 -0600
Message-ID: <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Vojtech Myslivec <vojtech@xmyslivec.cz>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        Michal Moravec <michal.moravec@logicworks.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 2:55 PM Vojtech Myslivec <vojtech@xmyslivec.cz> wrote:
>
> This host serves as a backup server and it runs regular backup tasks.
> When a backup is performed, one (read only) snapshot of one of my
> subvolumes on the btrfs filesystem is created and one snapshot is
> deleted afterwards.

This is likely to be a decently metadata centric workflow, lots of
small file changes, and metadata (file system) changes. Parity raid
performance in such workloads is often not great. It's just the way it
goes. But what does iostat tell you about drive utilization during
these backups? And during the problem? Are they balanced? Are they
nearly fully utilized?



>
> Once in several days (irregularly, as I noticed), the `md1_raid6`
> process starts to consume 100 % of one CPU core and during that time,
> creating a snapshot (during the regular backup process) of a btrfs
> subvolume get stucked. User space processes accessing this particular
> subvolume then start to hang in *disk sleep* state. Access to other
> subvolumes seems to be unaffected until another backup process tries to
> create another snapshot (of different subvolume).

Snapshot results in flush. And snapshot delete result in btrfs-cleaner
process, which involves a lot of reas and writes to track down the
extents to be freed. But your call traces seem stuck in snapshot
creation.

Can you provide mdadm -E and -D output respectively? I wonder if the
setup is just not well suited for the workload. Default mdadm 512KiB
chunk may not align well with this workload.

Also, a complete dmesg might be useful.



>
> In most cases, after several "IO" actions like listing files (ls),
> accessing btrfs information (`btrfs filesystem`, `btrfs subvolume`), or
> accessing the device (with `dd` or whatever), the filesystem gets
> magically unstucked and `md1_raid6` process released from its "live
> lock" (or whatever it is cycled in). Snapshots are then created as
> expected and all processes finish their job.
>
> Once in a week approximately, it takes tens of minutes to unstuck these
> processes. During that period, I try to access affected btrfs subvolumes
> in several shell sessions to wake it up.

Could be lock contention on the subvolume.


> However, there are some more "blocked" tasks, like `btrfs` and
> `btrfs-transaction` with call trace also included.
>
>
> Questions
> =========
>
> 1. What should be the cause of this problem?
> 2. What should I do to mitigate this issue?
> 3. Could it be a hardware problem? How can I track this?

Not sure  yet. Need more info.

dmesg
mdadm -E
mdadm -D
btrfs filesystem usage /mountpoint
btrfs device stats /mountpoint

> What I have done so far
> =======================
>
> - I keep the system up-to-date, with latest stable kernel provided by
>   Debian packages

5.5 is fairly recent and OK. It should be fine, except you're having a
problem, so...it could be a bug that's fixed already or a new bug. Or
it could be suboptimal configuration for the workload - which can be
difficult to figure out.

>
> - I run both `btrfs scrub` and `fsck.btrfs` to exclude btrfs filesystem
>   issue.
>
> - I have read all the physical disks (with dd command) and perform SMART
>   self tests to exclude disks issue (though read/write badblocks were
>   not checked yet).

I wouldn't worry too much about badblocks. More important is
https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

But you report using enterprise drives. They will invariably have an
SCT ERC time of ~70 deciseconds, which is well below that of the
kernel's SCSI command timer, ergo not a problem. But it's fine to
double check that.


> - I have also moved all the files out of the affected filesystem, create
>   a new btrfs filesystem (with recent btrfs-progs) and moved files
>   back. This issue, none the less, appeared again.

Exactly the same configuration? Anything different at all?


>
> - I have tried to attach strace to cycled md1 process, but
>   unsuccessfully (is it even possible to strace running kernel thread?)

You want to do 'cat /proc/<pid>/stack'


> Some detailed facts
> ===================
>
> OS
> --
>
> - Debian 10 buster (stable release)
> - Linux kernel 5.5 (from Debian backports)
> - btrfs-progs 5.2.1 (from Debian backports)

btrfs-progs 5.2.1 is ok, but I suggest something newer before using
'btrfs check --repair'. Just to be clear --repair is NOT indicated
right now.


> Hardware
> --------
>
> - 8 core/16 threads amd64 processor (AMD EPYC 7251)
> - 6 SATA HDD disks (Seagate Enterprise Capacity)
> - 2 SSD disks (Intel D3-S4610)

It's not related, but your workload might benefit from
'compress=zstd:1' mount option. Compress everything across the board.
Chances are these backups contain a lot of compressible data. This
isn't important to do right now. Fix the problem first. Optimize
later. But you have significant CPU capacity relative to the hardware.


> btrfs
> -----
> - Several subvolumes, tens of snapshots
> - Default mount options: rw,noatime,space_cache,subvolid=5,subvol=/
> - No compression, autodefrag or so
> - I have tried to use quotas in the past but they are disabled for
>   a long time

I don't think this is the only thing going on, but consider
space_cache=v2. You can mount with '-o clear_cache'  then umount and
then mount again with 'o space_cache=v2' to convert. And it will be
persistent (unless invalidated by a repair and then default v1 version
is used again). v2 will soon be the default.




>
> Usage
> -----
>
> - Affected RAID6 block device is directly formatted to btrfs
> - This filesystem is used to store backups
> - Backups are performed via rsnapshot
> - rsnapshot is configured to use btrfs snapshots for hourly and daily
>   backups and rsync to copy new backups

How many rsnapshot and rsync tasks are happening concurrently for a
subvolume at the time the  subvolume becomes unresponsive?




-- 
Chris Murphy
