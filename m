Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1274F92D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 12:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiDHKYV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 06:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiDHKYQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 06:24:16 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828533464E
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 03:22:13 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nclkn-00017f-Vp by authid <merlin>; Fri, 08 Apr 2022 03:22:10 -0700
Date:   Fri, 8 Apr 2022 03:22:09 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220408102209.GG25669@merlins.org>
References: <11970220.O9o76ZdvQC@ananda>
 <20220407052022.GC25669@merlins.org>
 <20220407162951.GD25669@merlins.org>
 <CAEzrpqdeph1AM74habMeOg_VURv5AFvZZ-9aUM9ZVEkM+-3Xkg@mail.gmail.com>
 <CAEzrpqdjKE3ehKjEqWOuBHPuScpjDG+B7r81SP1Vd+G8RVK6rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdjKE3ehKjEqWOuBHPuScpjDG+B7r81SP1Vd+G8RVK6rA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 07, 2022 at 06:09:53PM -0400, Josef Bacik wrote:
> Just following up on this, I've got hungry kids, I'm about halfway
> through the new shit.  Depending on how much help kids need with
> homework I may have this done later tonight, or it'll be tomorrow
> morning.  Thanks,

It finished after more than 24H, but that didn't seem to be enough, quite.
Hopefully we're getting closer, though :)

Couldn't find a replacement block for slot 361
Couldn't find a replacement block for slot 363
fixed slot 372
Couldn't find a replacement block for slot 374
Couldn't find a replacement block for slot 375
Couldn't find a replacement block for slot 403
Couldn't find a replacement block for slot 404
Couldn't find a replacement block for slot 405
Couldn't find a replacement block for slot 406
Couldn't find a replacement block for slot 407
Couldn't find a replacement block for slot 408
Couldn't find a replacement block for slot 409
Couldn't find a replacement block for slot 413
Couldn't find a replacement block for slot 414
Couldn't find a replacement block for slot 415
Couldn't find a replacement block for slot 416
Couldn't find a replacement block for slot 417
Couldn't find a replacement block for slot 418
Couldn't find a replacement block for slot 419
Couldn't find a replacement block for slot 420
Couldn't find a replacement block for slot 421
Couldn't find a replacement block for slot 422
Couldn't find a replacement block for slot 423
Couldn't find a replacement block for slot 424
Couldn't find a replacement block for slot 427
Couldn't find a replacement block for slot 437
Couldn't find a replacement block for slot 438
Couldn't find a replacement block for slot 443
Couldn't find a replacement block for slot 444
Couldn't find a replacement block for slot 445
fixed slot 446
fixed slot 447
gargamel:/var/local/src/btrfs-progs-josefbacik# 


gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --init-extent-tree --repair /dev/mapper/dshelf1  
enabling repair mode
WARNING:

	Do not use --repair unless you are advised to do so by a developer
	or an experienced user, and then only after having accepted that no
	fsck can successfully repair all types of filesystem corruption. Eg.
	some software or hardware bugs can fatally damage a volume.
	The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x5641ceb95fd0
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
Couldn't find the last root for 8
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
FS_INFO AFTER IS 0x5641ceb95fd0
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
Creating a new extent tree
checksum verify failed on 15645248897024 wanted 0xce96f609 found 0x2d1b5ea6
checksum verify failed on 11651824091136 wanted 0x6d411825 found 0x3cf07c9d
checksum verify failed on 606126080 wanted 0x8e0fb704 found 0xfc183188
checksum verify failed on 15645807640576 wanted 0xe97841cd found 0x4fa14858
checksum verify failed on 364863324160 wanted 0x741855d8 found 0x5aec3f82
checksum verify failed on 364970688512 wanted 0x33a82891 found 0x154e33ed
checksum verify failed on 15645178052608 wanted 0x4bb259dd found 0x4668121c
checksum verify failed on 15645178363904 wanted 0xba219c04 found 0x86a9d7f0
checksum verify failed on 15645917708288 wanted 0x4dab2011 found 0xb6299718
checksum verify failed on 15645365747712 wanted 0x3bdf1829 found 0xdbfcbd25
checksum verify failed on 15645365747712 wanted 0x4f4dcd5c found 0xa1d136c1
checksum verify failed on 15645365747712 wanted 0x4f4dcd5c found 0xa1d136c1
bad tree block 15645365747712, bad level, 240 > 8
Error reading tree block owner 7
error pinning down used bytes
ERROR: commit_root already set when starting transaction
extent buffer leak: start 13577814573056 len 16384
gargamel:/var/local/src/btrfs-progs-josefbacik# 


gargamel:/var/local/src/btrfs-progs-josefbacik# mount -o ro /dev/mapper/dshelf1 /mnt/mnt
mount: /mnt/mnt: wrong fs type, bad option, bad superblock on /dev/mapper/dshelf1, missing codepage or helper program, or other error.
gargamel:/var/local/src/btrfs-progs-josefbacik# dmtail
[106691.309851] BTRFS info (device dm-1): disk space caching is enabled
[106691.363587] BTRFS info (device dm-1): has skinny extents
[106691.394712] verify_parent_transid: 4 callbacks suppressed
[106691.394716] BTRFS error (device dm-1): parent transid verify failed on 22216704 wanted 1600938 found 1602177
[106691.443339] BTRFS error (device dm-1): parent transid verify failed on 22216704 wanted 1600938 found 1602177
[106691.474616] BTRFS error (device dm-1): failed to read chunk tree: -5
[106691.501647] BTRFS error (device dm-1): open_ctree failed
[106691.519613] systemd-udevd[31783]: btrfs-19: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
