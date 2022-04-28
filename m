Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229CA512A52
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 06:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbiD1EQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 00:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiD1EP7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 00:15:59 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57997237CC
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 21:12:46 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1njvWH-0005Yc-QN by authid <merlin>; Wed, 27 Apr 2022 21:12:45 -0700
Date:   Wed, 27 Apr 2022 21:12:45 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220428041245.GP29107@merlins.org>
References: <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
 <20220427225942.GX12542@merlins.org>
 <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
 <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
 <20220428001822.GZ12542@merlins.org>
 <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
 <20220428030002.GB12542@merlins.org>
 <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
 <20220428031131.GO29107@merlins.org>
 <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 12:03:29AM -0400, Josef Bacik wrote:
> Cool, we're pointing at the same block in different places in the same
> tree.  I should make tree-recover catch that and fix it, but since
> you're going to re-generate your csum tree anyway I've adjusted
> init-extent-tree to just clear the csum tree too, lets see how far we
> get with this.  Thanks,

inserting block group 15835070464000
inserting block group 15836144205824
inserting block group 15837217947648
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
processed 1634992128 of 1635549184 possible bytesFailed to find [3700677820416, 168, 53248]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x10000000060, key=key@entry=0x7fffffffd640, comp=comp@entry=0x55555559aed5 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd658) at common/rbtree-utils.c:48
48              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x10000000060, key=key@entry=0x7fffffffd640, comp=comp@entry=0x55555559aed5 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd658) at common/rbtree-utils.c:48
#1  0x000055555559b0d9 in search_cache_extent (tree=tree@entry=0x10000000060, start=start@entry=15645286318080)
    at common/extent-cache.c:179
#2  0x0000555555584c67 in set_extent_bits (tree=0x10000000060, start=15645286318080, end=15645286318079, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584e9a in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x000055555558587d in set_extent_buffer_dirty (eb=eb@entry=0x555560e15ef0) at kernel-shared/extent_io.c:976
#5  0x000055555557bc4b in btrfs_mark_buffer_dirty (eb=eb@entry=0x555560e15ef0) at kernel-shared/disk-io.c:2224
#6  0x000055555557ee74 in setup_inline_extent_backref (refs_to_add=1, offset=1835008, owner=1834097, root_objectid=93825185865744, 
    parent=0, iref=0xffffffffffffffe4, path=0x555560dfe010, root=<optimized out>) at kernel-shared/extent-tree.c:1085
#7  insert_inline_extent_backref (refs_to_add=1, offset=1835008, owner=1834097, root_objectid=93825185865744, parent=0, 
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x555560dfe010, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1197
#8  btrfs_inc_extent_ref (trans=trans@entry=0x555558b5c9a0, root=root@entry=0x555555af1ed0, bytenr=<optimized out>, 
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=11223, owner=1834097, offset=1835008)
    at kernel-shared/extent-tree.c:1262
#9  0x00005555555dfea9 in process_eb (trans=trans@entry=0x555558b5c9a0, root=root@entry=0x555555af1ed0, eb=eb@entry=0x555560e0ddf0, 
    current=current@entry=0x7fffffffdae8) at cmds/rescue-init-extent-tree.c:659
#10 0x00005555555e0002 in process_eb (trans=trans@entry=0x555558b5c9a0, root=root@entry=0x555555af1ed0, eb=eb@entry=0x55555a1be9a0, 
    current=current@entry=0x7fffffffdae8) at cmds/rescue-init-extent-tree.c:734
#11 0x00005555555e0002 in process_eb (trans=trans@entry=0x555558b5c9a0, root=root@entry=0x555555af1ed0, eb=0x555559ce9020, 
    current=current@entry=0x7fffffffdae8) at cmds/rescue-init-extent-tree.c:734
#12 0x00005555555e026d in record_root (root=root@entry=0x555555af1ed0) at cmds/rescue-init-extent-tree.c:805
#13 0x00005555555e10f9 in record_roots (fs_info=0x55555564cbc0) at cmds/rescue-init-extent-tree.c:860
#14 btrfs_init_extent_tree (path=path@entry=0x7fffffffe1cd "/dev/mapper/dshelf1") at cmds/rescue-init-extent-tree.c:944
#15 0x00005555555d7a43 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#16 0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555642d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#17 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#18 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555643cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#19 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
