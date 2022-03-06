Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338BA4CE81D
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 02:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiCFBhs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 20:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiCFBhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 20:37:48 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB3CE5C36C
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 17:36:56 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 52874235F70; Sat,  5 Mar 2022 20:36:56 -0500 (EST)
Date:   Sat, 5 Mar 2022 20:36:56 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Carsten Grommel <c.grommel@profihost.ag>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: How to (attempt to) repair these btrfs errors
Message-ID: <YiQQOFQO7G4NZTKS@hungrycats.org>
References: <AM0PR08MB326504D6D0D7D3077A13C7DE8E019@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <AM0PR08MB3265280A4F4EF8151DA289F58E029@AM0PR08MB3265.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR08MB3265280A4F4EF8151DA289F58E029@AM0PR08MB3265.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 01, 2022 at 10:55:50AM +0000, Carsten Grommel wrote:
> Follow-up pastebin with the most recent errors in dmesg:
> 
> https://pastebin.com/4yJJdQPJ

This seems to have expired.

> ________________________________________
> Von: Carsten Grommel
> Gesendet: Montag, 28. Februar 2022 19:41
> An: linux-btrfs@vger.kernel.org
> Betreff: How to (attempt to) repair these btrfs errors
> 
> Hi,
> 
> short buildup: btrfs filesystem used for storing ceph rbd backups within subvolumes got corrupted.
> Underlying 3 RAID 6es, btrfs is mounted on Top as RAID 0 over these Raids for performance ( we have to store massive Data)
> 
> Linux cloud8-1550 5.10.93+2-ph #1 SMP Fri Jan 21 07:52:51 UTC 2022 x86_64 GNU/Linux
> 
> But it was Kernel 5.4.121 before
> 
> btrfs --version
> btrfs-progs v4.20.1
> 
> btrfs fi show
> Label: none  uuid: b634a011-28fa-41d7-8d6e-3f68ccb131d0
>                 Total devices 3 FS bytes used 56.74TiB
>                 devid    1 size 25.46TiB used 22.70TiB path /dev/sda1
>                 devid    2 size 25.46TiB used 22.69TiB path /dev/sdb1
>                 devid    3 size 25.46TiB used 22.70TiB path /dev/sdd1
> 
> btrfs fi df /vmbackup/
> Data, RAID0: total=66.62TiB, used=56.45TiB
> System, RAID1: total=8.00MiB, used=4.36MiB
> Metadata, RAID1: total=750.00GiB, used=294.90GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> Attached the dmesg.log, a few dmesg messages following regarding the different errors (some informations redacted):
> 
> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 errs: wr 0, rd 0, flush 0, corrupt 69074516, gen 184286
> 
> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 errs: wr 0, rd 0, flush 0, corrupt 69074517, gen 184286
> 
> [Mon Feb 28 18:54:23 2022] BTRFS error (device sda1): unable to fixup (regular) error at logical 776693776384 on dev /dev/sdd1
> 
> [Mon Feb 28 18:54:25 2022] scrub_handle_errored_block: 21812 callbacks suppressed
> 
> [Mon Feb 28 18:54:31 2022] BTRFS warning (device sda1): checksum error at logical 777752285184 on dev /dev/sdd1, physical 259607957504, root 108747, inode 257, offset 59804737536, length 4096, links 1 (path: cephstorX_vm-XXX-disk-X-base.img_1645337735)
> 
> I am able to mount the filesystem in read-write mode but accessing specific blocks seems to crash btrfs to remount into read-only
> I am currently running a scrub over the filesystem.
> 
> The system got rebooted and the fs got remounted 2-3 times. I made the experience that usually btrfs would and could fix these kinds of errors after a remount, not this time though.
> 
> Before I ran “btrfs check –repair” I would like some advice at how to tackle theses errors.

The corruption and generation event counts indicate sdd1 (or one of its
component devices) was offline for a long time or suffered corruption
on a large scale.

Data is raid0, so data repair is not possible.  Delete all the files
that contain corrupt data.

If you are using space_cache=v1, now is a good time to upgrade to
space_cache=v2.  v1 space cache is stored in the data profile, and it has
likely been corrupted.  btrfs will usually detect and repair corruption
in space_cache=v1, but there is no need to take any such risk here
when you can easily use v2 instead (or at least clear the v1 cache).

I don't see any errors in these logs that would indicate a metadata issue,
but huge numbers of messages are suppressed.  Perhaps a log closer
to the moment when the filesystem goes read-only will be more useful.

I would expect that if there are no problems on sda1 or sdb1 then it
should be possible to repair the metadata errors on sdd1 by scrubbing
that device.

> Kind regards
> Carsten Grommel
> 
