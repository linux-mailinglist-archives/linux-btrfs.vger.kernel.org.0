Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1A6514128
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 06:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbiD2EGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 00:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiD2EGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 00:06:53 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC47762A28
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 21:03:36 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58306 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nkHqy-0006IT-6N by authid <merlins.org> with srv_auth_plain; Thu, 28 Apr 2022 21:03:36 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nkHqx-009DVR-Vj; Thu, 28 Apr 2022 21:03:35 -0700
Date:   Thu, 28 Apr 2022 21:03:35 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220429040335.GE12542@merlins.org>
References: <20220428205716.GU29107@merlins.org>
 <CAEzrpqduAKibaDJPJ6s7dCAfQHeynwG6zJwgVXVS_Uh=cQq2dw@mail.gmail.com>
 <20220428214241.GW29107@merlins.org>
 <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
 <20220428222705.GX29107@merlins.org>
 <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
 <20220429005624.GY29107@merlins.org>
 <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
 <20220429013409.GD12542@merlins.org>
 <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 09:38:05PM -0400, Josef Bacik wrote:
> I'm going to scream.  Somehow the root pointer for 11223 got messed up
> in all of this, do rescue tree-recover again so it can unfuck 11223,
> and then init-extent-tree.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x5588db830bc0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x5588db830bc0
Checking root 2 bytenr 15645018570752
Checking root 4 bytenr 15645196861440
Checking root 5 bytenr 13577660252160
Checking root 7 bytenr 15645018554368
Checking root 9 bytenr 15645878108160
Checking root 11221 bytenr 13577562996736
Checking root 11222 bytenr 15645261905920
Checking root 11223 bytenr 13576823668736
Repairing root 11223 bad_blocks 9 update 1
deleting slot 54 in block 11652138631168
deleting slot 54 in block 11652138631168
deleting slot 64 in block 11652138631168
deleting slot 86 in block 11652138631168
deleting slot 87 in block 11652138631168
deleting slot 87 in block 11652138631168
deleting slot 87 in block 11652138631168
deleting slot 87 in block 11652138631168
deleting slot 87 in block 11652138631168
Checking root 11224 bytenr 13577126182912
Checking root 159785 bytenr 6781490577408
Checking root 159787 bytenr 15645908385792
Checking root 160494 bytenr 6781491265536
Checking root 160496 bytenr 11822309965824
Checking root 161197 bytenr 6781492101120
Checking root 161199 bytenr 13576850833408
Checking root 162628 bytenr 15645764812800
Checking root 162632 bytenr 6781492756480
Checking root 162645 bytenr 5809981095936
Checking root 163298 bytenr 15645124263936
Checking root 163302 bytenr 6781495197696
Checking root 163303 bytenr 15645365993472
Checking root 163316 bytenr 6781496393728
Checking root 163318 bytenr 15645980491776
Checking root 163916 bytenr 11822437826560
Checking root 163920 bytenr 11971021275136
Checking root 163921 bytenr 11971073802240
Checking root 164620 bytenr 15645434036224
Checking root 164624 bytenr 15645502210048
Checking root 164633 bytenr 15645526884352
Checking root 165098 bytenr 11970667446272
Checking root 165100 bytenr 11970733621248
Checking root 165198 bytenr 12511656394752
Checking root 165200 bytenr 12511677972480
Checking root 165294 bytenr 13576901328896
Checking root 165298 bytenr 13577133326336
Checking root 165299 bytenr 13577191505920
Checking root 18446744073709551607 bytenr 13576823799808
Tree recovery finished, you can run check now


gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1
inserting block group 15838291689472
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
processed 1556480 of 0 possible bytes
processed 1474560 of 0 possible bytes
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
Recording extents for root 11223
processed 1634844672 of 1635549184 possible bytesadding a bytenr that overlaps our thing, dumping paths for [1834097, 108, 1835008]
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/tps/lnx64/jre9.0.4/lib/modules
doing an insert of the bytenr
doing an insert that overlaps our bytenr 3700677820416 53248
processed 1635319808 of 1635549184 possible bytes
Recording extents for root 11224
processed 75792384 of 75792384 possible bytes
Recording extents for root 159785
processed 108855296 of 108855296 possible bytes
Recording extents for root 159787
processed 49152 of 49479680 possible bytes
Recording extents for root 160494
processed 999424 of 109035520 possible bytesFailed to find [10467695652864, 168, 8675328]

Program received signal SIGSEGV, Segmentation fault.
0x000055555557bc5d in btrfs_buffer_uptodate (buf=buf@entry=0x555564fce1f0, parent_transid=parent_transid@entry=1619126)
    at kernel-shared/disk-io.c:2235
2235            ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,
(gdb) bt
#0  0x000055555557bc5d in btrfs_buffer_uptodate (buf=buf@entry=0x555564fce1f0, parent_transid=parent_transid@entry=1619126)
    at kernel-shared/disk-io.c:2235
#1  0x000055555557bebd in read_tree_block (fs_info=fs_info@entry=0x55555564cbc0, bytenr=<optimized out>, parent_transid=1619126)
    at kernel-shared/disk-io.c:378
#2  0x00005555555735f6 in read_node_slot (fs_info=fs_info@entry=0x55555564cbc0, root=root@entry=0x5555559547d0, 
    parent=0x555559e7e7b0, slot=240) at ./kernel-shared/ctree.h:1941
#3  0x00005555555769ff in btrfs_search_slot (trans=0x5555599539a0, root=root@entry=0x5555559547d0, key=key@entry=0x7fffffffd8a0, 
    p=p@entry=0x7fffffffd760, ins_len=ins_len@entry=49, cow=cow@entry=1) at kernel-shared/ctree.c:1429
#4  0x0000555555576e91 in btrfs_insert_empty_items (trans=trans@entry=0x5555599539a0, root=root@entry=0x5555559547d0, 
    path=path@entry=0x7fffffffd760, cpu_key=cpu_key@entry=0x7fffffffd8a0, data_size=data_size@entry=0x7fffffffd75c, nr=nr@entry=1)
    at kernel-shared/ctree.c:2824
#5  0x00005555555dfb9d in btrfs_insert_empty_item (data_size=<optimized out>, key=0x7fffffffd8a0, path=0x7fffffffd760, 
    root=0x5555559547d0, trans=0x5555599539a0) at ./kernel-shared/ctree.h:2780
#6  insert_empty_extent (trans=trans@entry=0x5555599539a0, key=key@entry=0x7fffffffd8a0, generation=generation@entry=1591667, 
    flags=flags@entry=1) at cmds/rescue-init-extent-tree.c:566
#7  0x00005555555dfe62 in process_eb (trans=trans@entry=0x5555599539a0, root=root@entry=0x555562939390, eb=eb@entry=0x555559092800, 
    current=current@entry=0x7fffffffdae8) at cmds/rescue-init-extent-tree.c:645
#8  0x00005555555dffed in process_eb (trans=trans@entry=0x5555599539a0, root=root@entry=0x555562939390, eb=eb@entry=0x5555590aaf80, 
    current=current@entry=0x7fffffffdae8) at cmds/rescue-init-extent-tree.c:734
#9  0x00005555555dffed in process_eb (trans=trans@entry=0x5555599539a0, root=root@entry=0x555562939390, eb=0x5555590822a0, 
    current=current@entry=0x7fffffffdae8) at cmds/rescue-init-extent-tree.c:734
#10 0x00005555555e0258 in record_root (root=root@entry=0x555562939390) at cmds/rescue-init-extent-tree.c:805
#11 0x00005555555e10e4 in record_roots (fs_info=0x55555564cbc0) at cmds/rescue-init-extent-tree.c:860
#12 btrfs_init_extent_tree (path=path@entry=0x7fffffffe1cd "/dev/mapper/dshelf1") at cmds/rescue-init-extent-tree.c:944
#13 0x00005555555d7a2e in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#14 0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555642d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#15 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#16 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555643cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#17 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
