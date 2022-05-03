Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075FF517C53
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 06:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiECEGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 00:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiECEGW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 00:06:22 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C583CA55
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 21:02:51 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58394 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nljkQ-0006Yv-UE by authid <merlins.org> with srv_auth_plain; Mon, 02 May 2022 21:02:50 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nljkQ-000P4U-O6; Mon, 02 May 2022 21:02:50 -0700
Date:   Mon, 2 May 2022 21:02:50 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220503040250.GW12542@merlins.org>
References: <20220502173459.GP12542@merlins.org>
 <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
 <20220502200848.GR12542@merlins.org>
 <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
 <20220502214916.GB29107@merlins.org>
 <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
 <20220502234135.GC29107@merlins.org>
 <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org>
 <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
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

On Mon, May 02, 2022 at 10:38:03PM -0400, Josef Bacik wrote:
> Ugh IDK why that happens every once and a while.  I pushed a fix for
> btrfs-corrupt-block, it should work now.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819133,108,0" -r 11223 /dev/mapper/dshelf1
FS_INFO IS 0x562d920a7600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x562d920a7600
parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
FS_INFO IS 0x5649e173dbc0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x5649e173dbc0
Walking all our trees and pinning down the currently accessible blocks
(..,)

doing roots
Recording extents for root 4
processed 1032192 of 1064960 possible bytes
Recording extents for root 5
processed 10960896 of 10977280 possible bytes
Recording extents for root 7
processed 16384 of 16545742848 possible bytes
Recording extents for root 9
processed 16384 of 16384 possible bytes
Recording extents for root 11221
processed 16384 of 255983616 possible bytes
Recording extents for root 11222
processed 49479680 of 49479680 possible bytes
Ignoring transid failure
Recording extents for root 11223
processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819133,108,134217728 on root 11223
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0410_2020.1_0602_1208.xz
cmds/rescue-init-extent-tree.c:654: process_eb: BUG_ON `1` triggered, value 1

Ignoring transid failure
Recording extents for root 11223
processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819135,108,0 on root 11223
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/ise_0007_2020.1_0602_1208.xz
cmds/rescue-init-extent-tree.c:654: process_eb: BUG_ON `1` triggered, value 1

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819135,108,0" -r 11223 /dev/mapper/dshelf1 

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819137,108,0" -r 11223 /dev/mapper/dshelf1 

Ok, now we're down to another one:
(...)
        item 143 key (13577065349120 METADATA_ITEM 0) itemoff 11801 itemsize 33
                refs 1 gen 1451459 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 144 key (13577069330432 METADATA_ITEM 0) itemoff 11768 itemsize 33
                refs 1 gen 1538467 flags TREE_BLOCK|FULL_BACKREF
                tree block skinny level 0
                shared block backref parent 15645094871040
        item 145 key (13577073082368 METADATA_ITEM 0) itemoff 11735 itemsize 33
                refs 1 gen 1451996 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 146 key (13577075130368 METADATA_ITEM 0) itemoff 11702 itemsize 33
                refs 1 gen 1452003 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 147 key (13577080455168 METADATA_ITEM 0) itemoff 11669 itemsize 33
                refs 1 gen 1452018 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 148 key (13577081552896 METADATA_ITEM 0) itemoff 11636 itemsize 33
                refs 1 gen 1452010 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 149 key (13577082077184 METADATA_ITEM 0) itemoff 11603 itemsize 33
                refs 1 gen 1538321 flags TREE_BLOCK|FULL_BACKREF
                tree block skinny level 0
                shared block backref parent 15645094871040
        item 150 key (13577082208256 METADATA_ITEM 0) itemoff 11570 itemsize 33
                refs 1 gen 1538467 flags TREE_BLOCK|FULL_BACKREF
                tree block skinny level 0
                shared block backref parent 15645094871040
        item 151 key (13577082552320 METADATA_ITEM 0) itemoff 11537 itemsize 33
                refs 1 gen 1452024 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 152 key (13577085927424 METADATA_ITEM 0) itemoff 11504 itemsize 33
                refs 1 gen 1452031 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 153 key (13577088073728 METADATA_ITEM 0) itemoff 11471 itemsize 33
                refs 1 gen 1443442 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root DEV_TREE
        item 154 key (13577088696320 METADATA_ITEM 0) itemoff 11438 itemsize 33
                refs 1 gen 1452038 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 155 key (13577090547712 METADATA_ITEM 0) itemoff 11405 itemsize 33
                refs 1 gen 1590216 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root 11223
        item 156 key (13577090596864 METADATA_ITEM 0) itemoff 11372 itemsize 33
                refs 1 gen 1590216 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root 11223
        item 157 key (13577091399680 METADATA_ITEM 0) itemoff 11339 itemsize 33
                refs 1 gen 1538745 flags TREE_BLOCK|FULL_BACKREF
                tree block skinny level 0
                shared block backref parent 15645094871040
        item 158 key (13577093103616 METADATA_ITEM 0) itemoff 11306 itemsize 33
                refs 1 gen 1452046 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 159 key (13577095495680 METADATA_ITEM 0) itemoff 11273 itemsize 33
                refs 1 gen 1452053 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
        item 160 key (13577095544832 METADATA_ITEM 0) itemoff 11240 itemsize 33
                refs 1 gen 1538650 flags TREE_BLOCK|FULL_BACKREF
                tree block skinny level 0
                shared block backref parent 15645094871040
        item 161 key (13577099837440 METADATA_ITEM 0) itemoff 11207 itemsize 33
                refs 1 gen 1452063 flags TREE_BLOCK
                tree block skinny level 0
                tree block backref root FS_TREE
failed to find block number 13576823652352
kernel-shared/extent-tree.c:1432: btrfs_set_block_flags: BUG_ON `1` triggered, value 1
./btrfs(+0x297a4)[0x56509942c7a4]
./btrfs(+0x297f4)[0x56509942c7f4]
./btrfs(btrfs_set_block_flags+0x1fb)[0x56509942f623]
./btrfs(+0x8be0e)[0x56509948ee0e]
./btrfs(+0x8c22d)[0x56509948f22d]
./btrfs(+0x8c22d)[0x56509948f22d]
./btrfs(+0x8c49b)[0x56509948f49b]
./btrfs(btrfs_init_extent_tree+0xe03)[0x56509949037b]
./btrfs(+0x83b7d)[0x565099486b7d]
./btrfs(handle_command_group+0x49)[0x56509941b17b]
./btrfs(main+0x94)[0x56509941b275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7feced8517fd]
./btrfs(_start+0x2a)[0x56509941ae1a]
Aborted


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
