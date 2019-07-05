Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B14601F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfGEINz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 04:13:55 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:30146 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfGEINz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 04:13:55 -0400
Received: from 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa (unknown [IPv6:2a01:e34:eeaf:c5f0:21e:62ff:fe00:36])
        by smtp5-g21.free.fr (Postfix) with ESMTP id 055F95FFAD;
        Fri,  5 Jul 2019 10:13:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa (Postfix) with ESMTP id 880C3CF52;
        Fri,  5 Jul 2019 08:13:49 +0000 (UTC)
Received: from 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa ([IPv6:::1])
        by localhost (mail.couderc.eu [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id uPESJjUxs8hM; Fri,  5 Jul 2019 08:13:49 +0000 (UTC)
Received: from [192.168.163.11] (unknown [192.168.163.11])
        by 6.3.0.0.0.0.e.f.f.f.2.6.e.1.2.0.0.f.5.c.f.a.e.e.4.3.e.0.1.0.a.2.ip6.arpa (Postfix) with ESMTPSA id 35CD0CF4F;
        Fri,  5 Jul 2019 08:13:49 +0000 (UTC)
From:   Pierre Couderc <pierre@couderc.eu>
Subject: Re: What are the maintenance recommendation ?
To:     Zygo Blaxell <zblaxell@furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>
 <20190703043721.GJ11831@hungrycats.org>
Message-ID: <a40d406a-5112-8573-4a3e-7ded4ae972ea@couderc.eu>
Date:   Fri, 5 Jul 2019 10:13:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703043721.GJ11831@hungrycats.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/3/19 6:37 AM, Zygo Blaxell wrote:
> On Sat, Jun 29, 2019 at 08:50:03PM +0200, Pierre Couderc wrote:
>> 1- Is there a summary of btrfs recommendations for maintenance ?
>>
>> I have read somewhere that  a monthly  btrfs scrub is recommended.
> 1.  Scrub detects and (when using the DUP or RAID1/10/5/6 profiles)
> corrects errors introduced into the filesystem by failures in the
> underlying disks.  You can run scrub as much or as little as you want,
> but the longer you go between scrubs, the longer errors can accumulate
> undetected, and the greater the risk that you'll have uncorrected errors
> on multiple disks when one of your disks fails and needs to be replaced.
> In that event, you will lose data or even the entire filesystem.
>
> The ideal frequency for scrubs depends in part on how important your data
> is.  If it's very important that you detect storage failures immediately,
> you can run scrub once a day.  If the data is very unimportant--e.g. you
> have good backups, and you don't care about extended downtime to restore
> them--then you might not need to run scrub at all.
>
> I run alternating SMART long self-tests and btrfs scrubs every 15 days
> (i.e. SMART long self-tests every 30 days, btrfs scrub 15 days after
> every SMART long self-test).
>
> Note that after a power failure or unclean shutdown, you should run
> scrub as soon as possible after rebooting, regardless of the normal
> maintenance schedule.  This is especially important for RAID5/6 profiles
> to regenerate parity blocks that may have been damaged by the parity
> raid write hole issue.  A post-power-failure scrub can also detect some
> drive firmware bugs.
>
> Pay attention to the output of scrub, especially the per-device statistics
> (btrfs scrub status -d and btrfs dev stat).  Errors reported here will
> indicate which disks should be replaced in RAID arrays.
>
> 2.  Watch the amount of "unallocated" space on the filesystem.  If the
> "unallocated" space (shown in 'btrfs fi usage') drops below 1GB, you are
> at risk of running out of metadata space.  If you run out of metadata
> space, btrfs becomes read-only and it can be difficult to recover.
>
> To free some unused data space (convert it from "data" to "unallocated"):
>
> 	btrfs balance start -dlimit=5 /path/to/fs
>
> This usually doesn't need to be done more than once per day, but it
> depends on how busy your filesystem is.  If you have hundreds of GB of
> unallocated space then you won't need to do this at all.
>
> Never balance metadata (i.e. the -m option of btrfs balance) unless you
> are converting to a different RAID profile (e.g. -mconvert=raid1,soft).
> If there is sufficient metadata space allocated, then the filesystem
> can be filled with data without any problems.  Balancing metadata can
> reduce the amount of space allocated for metadata, then the filesystem
> will be at risk of going read-only if it fills up.
>
> Normally there will be some overallocation of metadata (roughly 3:2
> allocated:used ratio).  Leave it alone--if the filesystem allocated
> metadata space in the past, the filesystem may need it again in the
> future.
>
> Scrub and balancing are the main requirements.  Filesystems can operate
> with just those two maintenance actions for years (outlasting all of
> their original hardware), and recover from multiple disk failures (one
> at a time) along the way.
>
>
This is luminous.

I suggest  creating a "Guide for maintenance" on the wiki with this 
contents,

with a link in main page wiki in "Guides and usage information" section


>> 2- Is there a repair guide ? I see all these commands restore, scrub,
>> rescue. Is there a guide of what to do when a disk has some errors ? The man
>> does not say when use some command...
> A scrub can fix everything that btrfs kernel code can recover from, i.e.
> if a disk in a btrfs RAID array is 100% corrupted while online, scrub
> can restore all of the data, including superblocks, without interrupting
> application activity on the filesystem.  With RAID1/5/6/10 this includes
> all single-disk failures and non-malicious data corruption from disks
> (RAID6 does not have a corresponding 3-copy RAID1 profile for metadata
> yet, so RAID6 can't always survive 2 disk failures in practice).
>
> Scrub is very effective at repairing data damage caused by disk failures
> in RAID arrays, and with DUP metadata on single-disk filesystem scrub can
> often recover from a few random UNC sectors.  If something happens to the
> filesystem that scrub can't repair (e.g. damage caused by accidentally
> overwriting the btrfs partition with another filesystem, host RAM failures
> writing corrupted data to disks, hard drive firmware write caching bugs),
> the other tools usually can't repair it either.
>
> Always use DUP or RAID1 or RAID10 for metadata.  Do not use single, RAID0,
> RAID5, or RAID6--if there is a UNC sector error or data corruption in
> a metadata page, the filesystem will be broken, and data losses will be
> somewhere between "medium" and "severe".
>
> The other utilities like 'btrfs check --repair' are in an experimental
> state of development, and may make a damaged filesystem completely
> unreadable.  They should only be used as a last resort, with expert
> guidance, after all other data recovery options have been tried, if
> at all.  Often when a filesystem is damaged beyond the ability of scrub
> to recover, the only practical option is to mkfs and start over--but
> ask the mailing list first to be sure, doing so might help improve the
> tools so that this is no longer the case.
>
> Usually a damaged btrfs can still be mounted read-only and some data
> can be recovered.  Corrupted data blocks (with non-matching csums) are
> not allowed to be read through a mounted filesystem.  'btrfs restore'
> is required to read those.
>
> 'btrfs restore' can copy data from a damaged btrfs filesystem that is
> not mounted.  It is able to work in some cases where mounting fails.
> When 'btrfs restore' copies data it does not verify csums.  This can be
> used to recover corrupted data that would not be allowed to read through
> a mounted filesystem.  On the other hand, if you want to avoid copying
> data with known corruption, you should mount the filesystem read-only
> and read it that way.
>
> Use 'btrfs replace' to replace failed disks in a RAID1/RAID5/RAID6/RAID10
> array.  It can reconstruct data from other mirror disks quickly by
> simply copying the mirrored data without changing any of the filesystem
> structure that references the data.  If the replacement disk is smaller
> than the disk it is meant to replace, then use 'btrfs dev add' followed by
> 'btrfs dev remove', but this is much slower as the data has to be moved
> one extent at a time, and all references to the data must be updated
> across the array.
>
> There appear to be a few low-end hard drive firmwares in the field with
> severe write caching bugs.  The first sign that you have one of those is
> that btrfs gets an unrecoverable 'parent transid verify failure' event
> after a few power failures.  The only known fix for this is to turn off
> write caching on such drives (i.e. hdparm -W0), mkfs, and start over.
> If you think you have encountered one of these, please post to the
> mailing list with drive model and firmware revision.
>
> 'btrfs rescue' is useful for fixing bugs caused by old mkfs tools or
> kernel versions.  It is not likely you will ever need it if you mkfs a
> new btrfs today (though there's always the possibility of new bugs in
> the future...).

This is luminous.

I suggest  creating a "Emergency Repair guide" on the wiki with this 
contents,

with a link in main page wiki in "Guides and usage information" section


