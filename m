Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895D14EDF87
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiCaRVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 13:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiCaRVV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 13:21:21 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F7F8EE3
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 10:19:33 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:48674 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nZySG-0008Pk-KQ by authid <merlins.org> with srv_auth_plain; Thu, 31 Mar 2022 10:19:28 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nZySF-007zOS-UZ; Thu, 31 Mar 2022 10:19:27 -0700
Date:   Thu, 31 Mar 2022 10:19:27 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
Message-ID: <20220331171927.GL1314726@merlins.org>
References: <20220329171818.GD1314726@merlins.org>
 <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
 <20220330143944.GE14158@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330143944.GE14158@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm going to wait a few more days before I give up and restore from
backup and will consider whether if I should go back to ext4 which for
me has clearly been more resilient of disk misbehaviours like I get
sometimes (of course, nothing will recover from a real double risk
failure in raid5, but over the last 20 years, it's not been uncommon for
me to see more than one drive kicked out of an array due to SCSI or sata
issues, or a drive having a weird shutdown and being able to come back
after a power cycle with all data except the last blocks written to it).

If I go back with btrfs (despite it being non resilient to any problem
described above, btrfs send is great for backups of course), what are
today's best recommended practices?

Kernel will be 5.16. Filesystem will be 24TB and contain mostly bigger
files (100MB to 10GB).

1) mdadm --create /dev/md7 --level=5 --consistency-policy=ppl --raid-devices=5 /dev/sd[abdef]1 --chunk=256 --bitmap=internal
2) echo 0fb96f02-d8da-45ce-aba7-070a1a8420e3 >  /sys/block/bcache64/bcache/attach 
   gargamel:/dev# cat /sys/block/md7/bcache/cache_mode
   [writethrough] writeback writearound none
3) cryptsetup luksFormat --align-payload=2048 -s 256 -c aes-xts-plain64  /dev/bcache64
4) cryptsetup luksOpen /dev/bcache64 dshelf1
5) mkfs.btrfs -m dup -L dshelf1 /dev/mapper/dshelf1

Any other btrfs options I should set for format to improve reliability
first and performance second?
I'm told I should use space_cache=v2, is it default now with btrfs-progs 5.10.1-2 ?

Anything else you recommend given that I indeed I have layers in the
middle. I'm actually considering dropping bcache for this filesystem
given that it could be another cause for corruption that btrfs can't
deal with.

Thanks
Marc

> > > mdadm --assemble --run --force /dev/md7 /dev/sd[gijk]1
> > > cryptsetup luksOpen /dev/bcache3 dshelf1a
> > > btrfs device scan --all-devices
> > > mount /dev/mapper/dshelf1a /mnt/btrfs_pool1/
> > > 
> > > BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > > BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > > BTRFS error (device dm-17): failed to read chunk tree: -5
> > > BTRFS error (device dm-17): open_ctree failed
> 
> But clearly the drive that went offline during shutdown, must have
> caused some corruption, even if it all it did was just refuse all
> writes.
> That said, I was somehow hoping that btrfs could unwind the last writes
> that failed/were incomplete and get back to a proper state. I'm still
> saddened by how fragile btrfs seems compared to ext4 in those cases
> (I've had similar issues happen with ext4 in the past, and was always
> able to repair the filesystem even if I lost a few files in the process)

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
