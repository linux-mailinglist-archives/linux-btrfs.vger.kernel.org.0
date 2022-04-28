Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB25127F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 02:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiD1AVj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 20:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiD1AVi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 20:21:38 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E47303
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 17:18:24 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58294 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1njrrT-0003yS-5N by authid <merlins.org> with srv_auth_plain; Wed, 27 Apr 2022 17:18:23 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1njrrS-006wDx-Vw; Wed, 27 Apr 2022 17:18:22 -0700
Date:   Wed, 27 Apr 2022 17:18:22 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220428001822.GZ12542@merlins.org>
References: <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
 <20220427182440.GO12542@merlins.org>
 <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
 <20220427210246.GV12542@merlins.org>
 <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
 <20220427212023.GW12542@merlins.org>
 <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
 <20220427225942.GX12542@merlins.org>
 <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
 <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 07:21:51PM -0400, Josef Bacik wrote:
> On Wed, Apr 27, 2022 at 7:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Wed, Apr 27, 2022 at 6:59 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Wed, Apr 27, 2022 at 05:27:44PM -0400, Josef Bacik wrote:
> > > > Sigh, added another print_leaf.  Thanks,
> > >
> > > doing an insert that overlaps our bytenr 7750833627136 262144
> > > processed 1146880 of 0 possible bytes
> > > processed 1163264 of 0 possible bytes
> > > processed 1179648 of 0 possible bytes
> > > processed 1196032 of 0 possible bytes
> > > processed 1212416 of 0 possible bytes
> > > processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr?? [5507, 108, 0] dumping paths
> > > inode ref info failed???
> > > leaf 15645023322112 items 123 free space 55 generation 1546750 owner ROOT_TREE
> >
> > Ooooh that explains it, it's the free space cache, that's perfect!
> > I'll get something wired up and let you know when it's ready.  Thanks,
> >
> 
> Ok, lets hope for better results this time.  Thanks,

        item 115 key (5514 EXTENT_DATA 0) itemoff 3929 itemsize 53
                generation 1526158 type 1 (regular)
                extent data disk byte 12233813143552 nr 262144
                extent data offset 0 nr 262144 ram 262144
                extent compression 0 (none)
        item 116 key (5515 INODE_ITEM 0) itemoff 3769 itemsize 160
                generation 1439787 transid 1439787 size 262144 nbytes 44826624
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                sequence 171 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
                atime 0.0 (1969-12-31 16:00:00)
                ctime 1591038874.816340561 (2020-06-01 12:14:34)
                mtime 0.0 (1969-12-31 16:00:00)
                otime 0.0 (1969-12-31 16:00:00)
        item 117 key (5515 EXTENT_DATA 0) itemoff 3716 itemsize 53
                generation 1439787 type 1 (regular)
                extent data disk byte 12474011467776 nr 262144
                extent data offset 0 nr 262144 ram 262144
                extent compression 0 (none)
        item 118 key (5516 INODE_ITEM 0) itemoff 3556 itemsize 160
                generation 1546750 transid 1546750 size 262144 nbytes 2405433344
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                sequence 9176 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
                atime 0.0 (1969-12-31 16:00:00)
                ctime 1621321238.520473625 (2021-05-18 00:00:38)
                mtime 0.0 (1969-12-31 16:00:00)
                otime 0.0 (1969-12-31 16:00:00)
        item 119 key (5516 EXTENT_DATA 0) itemoff 3503 itemsize 53
                generation 1546750 type 1 (regular)
                extent data disk byte 12251618267136 nr 262144
                extent data offset 0 nr 262144 ram 262144
                extent compression 0 (none)
        item 120 key (5517 INODE_ITEM 0) itemoff 3343 itemsize 160
                generation 1526158 transid 1526158 size 262144 nbytes 40370176
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                sequence 154 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
                atime 0.0 (1969-12-31 16:00:00)
                ctime 1615276843.758806249 (2021-03-09 00:00:43)
                mtime 0.0 (1969-12-31 16:00:00)
                otime 0.0 (1969-12-31 16:00:00)
        item 121 key (5517 EXTENT_DATA 0) itemoff 3290 itemsize 53
                generation 1526158 type 1 (regular)
                extent data disk byte 12233872674816 nr 262144
                extent data offset 0 nr 262144 ram 262144
                extent compression 0 (none)
        item 122 key (5518 INODE_ITEM 0) itemoff 3130 itemsize 160
                generation 1525963 transid 1525963 size 262144 nbytes 57933824
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                sequence 221 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
                atime 0.0 (1969-12-31 16:00:00)
                ctime 1615222550.521041172 (2021-03-08 08:55:50)
                mtime 0.0 (1969-12-31 16:00:00)
                otime 0.0 (1969-12-31 16:00:00)
elem_cnt 0 elem_missed 0 ret -2
Failed to find [7750833868800, 168, 262144]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd740, comp=comp@entry=0x55555559aed5 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd758) at common/rbtree-utils.c:48
48              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd740, comp=comp@entry=0x55555559aed5 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd758) at common/rbtree-utils.c:48
#1  0x000055555559b0d9 in search_cache_extent (tree=tree@entry=0x100000060, start=start@entry=13576826748928)
    at common/extent-cache.c:179
#2  0x0000555555584c67 in set_extent_bits (tree=0x100000060, start=13576826748928, end=13576826748927, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584e9a in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x000055555558587d in set_extent_buffer_dirty (eb=eb@entry=0x555555721210) at kernel-shared/extent_io.c:976
#5  0x000055555557bc4b in btrfs_mark_buffer_dirty (eb=eb@entry=0x555555721210) at kernel-shared/disk-io.c:2224
#6  0x000055555557ee74 in setup_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824998761968, parent=0, 
    iref=0xffffffffffffffe3, path=0x555555b8e5f0, root=<optimized out>) at kernel-shared/extent-tree.c:1085
#7  insert_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824998761968, parent=0, 
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x555555b8e5f0, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1197
#8  btrfs_inc_extent_ref (trans=trans@entry=0x555558a8d7c0, root=root@entry=0x55555564cde0, bytenr=<optimized out>, 
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=1, owner=5507, offset=0)
    at kernel-shared/extent-tree.c:1262
#9  0x00005555555dfd52 in process_eb (trans=trans@entry=0x555558a8d7c0, root=root@entry=0x55555564cde0, eb=eb@entry=0x555559d00d20, 
    current=current@entry=0x7fffffffdaf8) at cmds/rescue-init-extent-tree.c:615
#10 0x00005555555dfeab in process_eb (trans=trans@entry=0x555558a8d7c0, root=root@entry=0x55555564cde0, eb=0x555555944100, 
    current=current@entry=0x7fffffffdaf8) at cmds/rescue-init-extent-tree.c:690
#11 0x00005555555e0116 in record_root (root=0x55555564cde0) at cmds/rescue-init-extent-tree.c:761
#12 0x00005555555e0436 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe1cd "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:897
#13 0x00005555555d7a43 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#14 0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555642d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#15 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#16 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555643cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#17 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
