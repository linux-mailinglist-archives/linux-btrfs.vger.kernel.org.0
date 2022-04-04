Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181354F0D53
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 03:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbiDDBDD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Apr 2022 21:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbiDDBDC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Apr 2022 21:03:02 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7413BC1E
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Apr 2022 18:01:06 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:48684 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nbB5Z-0007Ru-Qq by authid <merlins.org> with srv_auth_plain; Sun, 03 Apr 2022 18:01:01 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nbB5Z-00Ax5W-IR; Sun, 03 Apr 2022 18:01:01 -0700
Date:   Sun, 3 Apr 2022 18:01:01 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220404010101.GQ1314726@merlins.org>
References: <20220329171818.GD1314726@merlins.org>
 <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
 <20220330143944.GE14158@merlins.org>
 <20220331171927.GL1314726@merlins.org>
 <Ykoux6Oczf6+hmGg@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykoux6Oczf6+hmGg@localhost.localdomain>
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

On Sun, Apr 03, 2022 at 07:33:27PM -0400, Josef Bacik wrote:
> Sorry shit went real wrong this week.  Can you do
> 
> btrfs inspect-internal dump-super -f /dev/whatever

Thanks for the answer.
 
superblock: bytenr=65536, device=/dev/mapper/dshelf1a
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xd3d00183 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    96539b8c-ccc9-47bf-9e6c-29305890941e
metadata_uuid           96539b8c-ccc9-47bf-9e6c-29305890941e
label                   dshelf1
generation              1602089
root                    13577814573056
sys_array_size          129
chunk_root_generation   1600938
root_level              1
chunk_root              21069824
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             24004156973056
bytes_used              15113376952320
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x169
                        ( MIXED_BACKREF |
                          COMPRESS_LZO |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        1602089
uuid_tree_generation    1602089
dev_item.uuid           8d4b0f25-0de9-47a6-a993-bdd301287f30
dev_item.fsid           96539b8c-ccc9-47bf-9e6c-29305890941e [match]
dev_item.type           0
dev_item.total_bytes    24004156973056
dev_item.bytes_used     15178439589888
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:   
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 20971520)
                length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 0
                        stripe 0 devid 1 offset 20971520
                        dev_uuid 8d4b0f25-0de9-47a6-a993-bdd301287f30
                        stripe 1 devid 1 offset 29360128
                        dev_uuid 8d4b0f25-0de9-47a6-a993-bdd301287f30
backup_roots[4]:
        backup 0:
                backup_tree_root:       13577814573056  gen: 1602089    level: 1
                backup_chunk_root:      21069824        gen: 1600938    level: 1
                backup_extent_root:     13577824387072  gen: 1602089    level: 2
                backup_fs_root:         13577799401472  gen: 1602089    level: 2
                backup_dev_root:        15645196861440  gen: 1600938    level: 1
                backup_csum_root:       13577868050432  gen: 1602089    level: 3
                backup_total_bytes:     24004156973056
                backup_bytes_used:      15113376952320
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       13577775284224  gen: 1602086    level: 1
                backup_chunk_root:      21069824        gen: 1600938    level: 1
                backup_extent_root:     13577801826304  gen: 1602086    level: 2
                backup_fs_root:         13577770450944  gen: 1602086    level: 2
                backup_dev_root:        15645196861440  gen: 1600938    level: 1
                backup_csum_root:       13577819963392  gen: 1602086    level: 3
                backup_total_bytes:     24004156973056
                backup_bytes_used:      15113376985088
                backup_num_devices:     1

        backup 2:
                backup_tree_root:       13577821667328  gen: 1602087    level: 1
                backup_chunk_root:      21069824        gen: 1600938    level: 1
                backup_extent_root:     13577825026048  gen: 1602087    level: 2
                backup_fs_root:         13577810673664  gen: 1602087    level: 2
                backup_dev_root:        15645196861440  gen: 1600938    level: 1
                backup_csum_root:       13577829089280  gen: 1602087    level: 3
                backup_total_bytes:     24004156973056
                backup_bytes_used:      15113377001472
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       13577779511296  gen: 1602088    level: 1
                backup_chunk_root:      21069824        gen: 1600938    level: 1
                backup_extent_root:     13577802170368  gen: 1602088    level: 2
                backup_fs_root:         13577773039616  gen: 1602088    level: 2
                backup_dev_root:        15645196861440  gen: 1600938    level: 1
                backup_csum_root:       13577819963392  gen: 1602088    level: 3
                backup_total_bytes:     24004156973056
                backup_bytes_used:      15113377017856
                backup_num_devices:     1


> This is going to spit out the backup roots for everything.  I was looking at the
> code and realized the backup root code doesn't actually work for the chunk root,
> since it's special.  Can you then do
> 
> btrfs check --chunk-root <bytenr> /dev/whatever
> from whatever the newest backup root is, and then keep rolling back until you
> find one that works.  If you find one that does work hooray, I can write
> something to swap out the chunk bytenr in your super block and we can carry on.
 
All four seem to be generation 1600938, backup_chunk_root:21069824

gargamel:/var/cache/apt# btrfs check --chunk-root 21069824 /dev/mapper/dshelf1a
Opening filesystem to check...
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
leaf parent key incorrect 13577821667328
ERROR: could not setup extent tree
ERROR: cannot open file system

> If not we can go with
> btrfs rescue chunk-recover /dev/whatever
> and see how that works out.  Thanks,

gargamel:~# btrfs rescue chunk-recover /dev/mapper/dshelf1a
Scanning: 1509736448 in dev0         

I'll let this run, looks like it might take a while.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
