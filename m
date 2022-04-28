Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708EA5139CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344833AbiD1QbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 12:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiD1QbD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 12:31:03 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0D4AAE11
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 09:27:48 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nk6za-0001om-Ni by authid <merlin>; Thu, 28 Apr 2022 09:27:46 -0700
Date:   Thu, 28 Apr 2022 09:27:46 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220428162746.GR29107@merlins.org>
References: <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
 <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
 <20220428001822.GZ12542@merlins.org>
 <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
 <20220428030002.GB12542@merlins.org>
 <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
 <20220428031131.GO29107@merlins.org>
 <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
 <20220428041245.GP29107@merlins.org>
 <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 11:30:35AM -0400, Josef Bacik wrote:
> Hell yes we're in the fs tree's now, in the home stretch hopefully.
> I've pushed new debugging, you may have another overlapping extent.
> I'm going to have to wire up a tool for that, but hopefully we can
> just target delete a few things and get you up and running.  Thanks,

Delete Xilinx_Unified_2020.1_0602_1208/tps/lnx64/jre9.0.4/lib/modules ?

        item 186 key (1834097 EXTENT_DATA 56098816) itemoff 5452 itemsize 53
                generation 1590259 type 1 (regular)
                extent data disk byte 7451680858112 nr 524288
                extent data offset 0 nr 524288 ram 524288
                extent compression 0 (none)
        item 187 key (1834097 EXTENT_DATA 56623104) itemoff 5399 itemsize 53
                generation 1590259 type 1 (regular)
                extent data disk byte 7451683733504 nr 524288
                extent data offset 0 nr 524288 ram 524288
                extent compression 0 (none)
        item 188 key (1834097 EXTENT_DATA 57147392) itemoff 5346 itemsize 53
                generation 1590259 type 1 (regular)
                extent data disk byte 7451684257792 nr 524288
                extent data offset 0 nr 524288 ram 524288
                extent compression 0 (none)
        item 189 key (1834097 EXTENT_DATA 57671680) itemoff 5293 itemsize 53
                generation 1590259 type 1 (regular)
                extent data disk byte 7451684782080 nr 524288
                extent data offset 0 nr 524288 ram 524288
                extent compression 0 (none)
        item 190 key (1834097 EXTENT_DATA 58195968) itemoff 5240 itemsize 53
                generation 1590259 type 1 (regular)
                extent data disk byte 7451685568512 nr 524288
                extent data offset 0 nr 524288 ram 524288
                extent compression 0 (none)
        item 191 key (1834097 EXTENT_DATA 58720256) itemoff 5187 itemsize 53
                generation 1590259 type 1 (regular)
                extent data disk byte 7457553899520 nr 524288
                extent data offset 0 nr 524288 ram 524288
                extent compression 0 (none)
        item 192 key (1834097 EXTENT_DATA 59244544) itemoff 5134 itemsize 53
                generation 1590259 type 1 (regular)
                extent data disk byte 7457554423808 nr 524288
                extent data offset 0 nr 524288 ram 524288
                extent compression 0 (none)
        item 193 key (1834097 EXTENT_DATA 59768832) itemoff 5081 itemsize 53
                generation 1590259 type 1 (regular)
                extent data disk byte 7457561710592 nr 524288
                extent data offset 0 nr 524288 ram 524288
                extent compression 0 (none)
        item 194 key (1834097 EXTENT_DATA 60293120) itemoff 5028 itemsize 53
                generation 1590259 type 1 (regular)
                extent data disk byte 7457563021312 nr 524288
                extent data offset 0 nr 524288 ram 524288
                extent compression 0 (none)
        item 195 key (1834097 EXTENT_DATA 60817408) itemoff 4975 itemsize 53
                generation 1590259 type 1 (regular)
                extent data disk byte 7457564856320 nr 524288
                extent data offset 0 nr 524288 ram 524288
                extent compression 0 (none)
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/tps/lnx64/jre9.0.4/lib/modules
Failed to find [3700677820416, 168, 53248]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd640, comp=comp@entry=0x55555559aed5 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd658) at common/rbtree-utils.c:48
48              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd640, comp=comp@entry=0x55555559aed5 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd658) at common/rbtree-utils.c:48
#1  0x000055555559b0d9 in search_cache_extent (tree=tree@entry=0x100000060, start=start@entry=15645157752832)
    at common/extent-cache.c:179
#2  0x0000555555584c67 in set_extent_bits (tree=0x100000060, start=15645157752832, end=15645157752831, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584e9a in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x000055555558587d in set_extent_buffer_dirty (eb=eb@entry=0x55555d2ba350) at kernel-shared/extent_io.c:976
#5  0x000055555557bc4b in btrfs_mark_buffer_dirty (eb=eb@entry=0x55555d2ba350) at kernel-shared/disk-io.c:2224
#6  0x000055555557ee74 in setup_inline_extent_backref (refs_to_add=1, offset=1835008, owner=1834097, root_objectid=93825123492528, 
    parent=0, iref=0xffffffffffffffe3, path=0x55555d2822b0, root=<optimized out>) at kernel-shared/extent-tree.c:1085
#7  insert_inline_extent_backref (refs_to_add=1, offset=1835008, owner=1834097, root_objectid=93825123492528, parent=0, 
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x55555d2822b0, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1197
#8  btrfs_inc_extent_ref (trans=trans@entry=0x555556dc2cd0, root=root@entry=0x555557a97ca0, bytenr=<optimized out>, 
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=11223, owner=1834097, offset=1835008)
    at kernel-shared/extent-tree.c:1262
#9  0x00005555555dfea9 in process_eb (trans=trans@entry=0x555556dc2cd0, root=root@entry=0x555557a97ca0, eb=eb@entry=0x55555d291e50, 
    current=current@entry=0x7fffffffdae8) at cmds/rescue-init-extent-tree.c:659
#10 0x00005555555e0002 in process_eb (trans=trans@entry=0x555556dc2cd0, root=root@entry=0x555557a97ca0, eb=eb@entry=0x5555564687c0, 
    current=current@entry=0x7fffffffdae8) at cmds/rescue-init-extent-tree.c:734
#11 0x00005555555e0002 in process_eb (trans=trans@entry=0x555556dc2cd0, root=root@entry=0x555557a97ca0, eb=0x555555f13e20, 
    current=current@entry=0x7fffffffdae8) at cmds/rescue-init-extent-tree.c:734
#12 0x00005555555e026d in record_root (root=root@entry=0x555557a97ca0) at cmds/rescue-init-extent-tree.c:805
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
