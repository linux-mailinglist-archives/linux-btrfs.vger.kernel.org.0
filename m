Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97B250D43B
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 20:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiDXSqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiDXSqZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 14:46:25 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0F7DA8A
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 11:43:22 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:41126 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nihCc-0006ii-DD by authid <merlins.org> with srv_auth_plain; Sun, 24 Apr 2022 11:43:22 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nihCv-006Qz3-Ge; Sun, 24 Apr 2022 11:43:41 -0700
Date:   Sun, 24 Apr 2022 11:43:41 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220424184341.GA1523521@merlins.org>
References: <Yk3W88Eyh0pSm9mQ@hungrycats.org>
 <20220406191317.GC14804@merlins.org>
 <20220422184850.GX13115@merlins.org>
 <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
 <20220422200115.GV11868@merlins.org>
 <20220423201225.GZ13115@merlins.org>
 <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
 <CAEzrpqdHAS2E1iuoSFVX-A-T-vsMoCo6CoW0ebw42vkCjqpMPw@mail.gmail.com>
 <20220424162450.GY11868@merlins.org>
 <CAEzrpqe6gwpF9k=Gj4=aCzkj-kW5GrZNueNnfoL8ZAAnMvwbng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqe6gwpF9k=Gj4=aCzkj-kW5GrZNueNnfoL8ZAAnMvwbng@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 01:09:45PM -0400, Josef Bacik wrote:
> Argh you still have bogus stuff for some reason, maybe it's because of
> cancelling the rescue.  Re-run btrfs rescue tree-recover, and do it a
> couple of times to make sure it's stopped complaining.  If it does
> complain after the first run please let me know, it really should fix
> everything the first go around.  If it's not then I need to try and
> reproduce that locally and figure out wtf it's doing.  Once
> tree-recover runs cleanly you can run btrfs rescue init-extent-tree,
> then hopefully you'll be good to go.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x555a360efbc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x555a360efbc0
Checking root 2
Checking root 4
Checking root 5
Checking root 7
Checking root 9
Checking root 11221
Checking root 11222
Checking root 11223
Checking root 11224
Checking root 159785
Checking root 159787
Checking root 160494
Checking root 160496
Checking root 161197
Checking root 161199
Checking root 162628
Checking root 162632
Checking root 162645
Checking root 163298
Checking root 163302
Checking root 163303
Checking root 163316
Checking root 163318
Checking root 163916
Checking root 163920
Checking root 163921
Checking root 164620
Checking root 164624
Checking root 164633
Checking root 165098
Checking root 165100
Checking root 165198
Checking root 165200
Checking root 165294
Checking root 165298
Checking root 165299
Checking root 18446744073709551607
Tree recovery finished, you can run check now
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1
FS_INFO IS 0x56080e544bc0
checksum verify failed on 15645878108160 wanted 0x1beaa67b found 0x27edb2c4
Couldn't find the last root for 8
FS_INFO AFTER IS 0x56080e544bc0
Walking all our trees and pinning down the currently accessible blocks
checksum verify failed on 11651824091136 wanted 0x6d411825 found 0x3cf07c9d
checksum verify failed on 606126080 wanted 0x8e0fb704 found 0xfc183188
checksum verify failed on 15645807640576 wanted 0xe97841cd found 0x4fa14858
checksum verify failed on 364863324160 wanted 0x741855d8 found 0x5aec3f82
checksum verify failed on 364970688512 wanted 0x33a82891 found 0x154e33ed
(...)
checksum verify failed on 13577810395136 wanted 0x4171ba0a found 0xda4963ab
checksum verify failed on 46576713728 wanted 0xbb1ee48e found 0x8809f6a6
checksum verify failed on 13577126330368 wanted 0xf7264639 found 0x8287ec94
checksum verify failed on 15645432397824 wanted 0xc706f8b6 found 0xf0425483
checksum verify failed on 15645954080768 wanted 0x3ff10ddf found 0x77ab2f14
checksum verify failed on 15645954129920 wanted 0x085fc24a found 0x941acdde
checksum verify failed on 15645954195456 wanted 0x6c1c72a4 found 0xb06d5dd9
checksum verify failed on 15645262348288 wanted 0x433325c8 found 0x81ea056f
checksum verify failed on 15645608116224 wanted 0x31706547 found 0x314fad1d
checksum verify failed on 15645262413824 wanted 0x3affbd35 found 0x96d53d25
checksum verify failed on 15646053974016 wanted 0x98bd62bc found 0xdaa7dd44
checksum verify failed on 15646006722560 wanted 0x760a06a0 found 0xb44fcd95
checksum verify failed on 15645980491776 wanted 0xe1e674a7 found 0x0fdfda2c
checksum verify failed on 15645526884352 wanted 0xc2d409c1 found 0xb3eee8d2
checksum verify failed on 12511656394752 wanted 0x607d7b9e found 0xec111bf5
checksum verify failed on 13577013936128 wanted 0x4ba00b03 found 0x64614751
checksum verify failed on 13577199878144 wanted 0x6e9e8bc6 found 0x61063457
checksum verify failed on 13577399156736 wanted 0x2869b8c7 found 0xbb1119e1
checksum verify failed on 12512437698560 wanted 0xca43b3f8 found 0xd7f6db69
checksum verify failed on 13577503686656 wanted 0xd81b7702 found 0x95a3c9a6
checksum verify failed on 15645781344256 wanted 0xb81e3df4 found 0xb5c70846
checksum verify failed on 13577178939392 wanted 0x2cb83118 found 0x63f0b6bf
checksum verify failed on 15645419667456 wanted 0xde0dab28 found 0x3ceddd16
checksum verify failed on 13577821011968 wanted 0x9a29aff5 found 0x2cdff391
checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
Clearing the extent root and re-init'ing the block groups
processed 1556480 of 0 possible bytes
processed 1228800 of 0 possible bytesFailed to find [7750833868800, 168, 262144]
Segmentation fault

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x10000000060, key=key@entry=0x7fffffffd7f0, comp=comp@entry=0x55555559add0 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd808) at common/rbtree-utils.c:48
48              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x10000000060, key=key@entry=0x7fffffffd7f0, comp=comp@entry=0x55555559add0 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd808) at common/rbtree-utils.c:48
#1  0x000055555559afd4 in search_cache_extent (tree=tree@entry=0x10000000060, start=start@entry=99696640)
    at common/extent-cache.c:179
#2  0x0000555555584b67 in set_extent_bits (tree=0x10000000060, start=99696640, end=99696639, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584d9a in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x000055555558577d in set_extent_buffer_dirty (eb=eb@entry=0x555555721210) at kernel-shared/extent_io.c:976
#5  0x000055555557bbaf in btrfs_mark_buffer_dirty (eb=eb@entry=0x555555721210) at kernel-shared/disk-io.c:2222
#6  0x000055555557ed74 in setup_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824992434045, parent=0, 
    iref=0xffffffffffffffe4, path=0x555555b82ed0, root=<optimized out>) at kernel-shared/extent-tree.c:1084
#7  insert_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824992434045, parent=0, 
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x555555b82ed0, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1196
#8  btrfs_inc_extent_ref (trans=trans@entry=0x555558a89680, root=root@entry=0x55555564cde0, bytenr=<optimized out>, 
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=1, owner=5507, offset=0)
    at kernel-shared/extent-tree.c:1261
#9  0x00005555555dfa18 in process_eb (trans=trans@entry=0x555558a89680, root=root@entry=0x55555564cde0, eb=eb@entry=0x555559cfcb20, 
    current=current@entry=0x7fffffffdb88) at cmds/rescue-init-extent-tree.c:499
#10 0x00005555555dfb27 in process_eb (trans=trans@entry=0x555558a89680, root=root@entry=0x55555564cde0, eb=0x55555566b790, 
    current=current@entry=0x7fffffffdb88) at cmds/rescue-init-extent-tree.c:574
#11 0x00005555555dfd8f in record_root (root=0x55555564cde0) at cmds/rescue-init-extent-tree.c:645
#12 0x00005555555e0092 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe1d0 "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:779
#13 0x00005555555d7931 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#14 0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555642d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#15 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#16 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555643cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#17 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
