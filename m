Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6421F510FB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 05:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbiD0D6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 23:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbiD0D6D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 23:58:03 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F254B1D5
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 20:54:53 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1njYlP-0005nh-Go by authid <merlin>; Tue, 26 Apr 2022 20:54:51 -0700
Date:   Tue, 26 Apr 2022 20:54:51 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220427035451.GM29107@merlins.org>
References: <20220424223819.GE29107@merlins.org>
 <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
 <20220424231446.GF29107@merlins.org>
 <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
 <20220425002415.GG29107@merlins.org>
 <CAEzrpqcQkiMJt1B4Bx9NrCcRys1MD+_5Y3riActXYC6RQrkakw@mail.gmail.com>
 <20220426002804.GI29107@merlins.org>
 <20220426204326.GK12542@merlins.org>
 <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
 <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com>
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

On Tue, Apr 26, 2022 at 05:36:28PM -0400, Josef Bacik wrote:
> On Tue, Apr 26, 2022 at 5:20 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 4:43 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > Generally would you say we're still on the right path and helping your
> > > recovery tools getting better, or is it getting close or to the time
> > > where I should restore from backups?
> > >
> >
> > Yup sorry for the radio silence, loads of meetings today, but good
> > news is I've reproduced your problem locally, so I'm trying to hammer
> > it out.  I hope to have something useful for you today.  Thanks,
> 
> Sigh I'm dumb as fuck, can you pull and re-run tree-recover just to
> make sure any stupidity I've caused is undone, and then run rescue
> init-extent-tree and then we can go from there?  Thanks,

FS_INFO IS 0x55555564cbc0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55555564cbc0
Checking root 2 bytenr 67387392
Checking root 4 bytenr 15645196861440
Checking root 5 bytenr 13577660252160
Checking root 7 bytenr 13577819963392
Checking root 9 bytenr 15645878108160
Checking root 11221 bytenr 13577562996736
Checking root 11222 bytenr 15645261905920
Checking root 11223 bytenr 13576862547968
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
Checking root 18446744073709551607 bytenr 13576823685120
Tree recovery finished, you can run check now
[Inferior 1 (process 28238) exited normally]


(gdb) run rescue init-extent-tree /dev/mapper/dshelf1
FS_INFO IS 0x55555564cbc0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55555564cbc0
Checking root 2 bytenr 67387392
Checking root 4 bytenr 15645196861440
Checking root 5 bytenr 13577660252160
Checking root 7 bytenr 13577819963392
Checking root 9 bytenr 15645878108160
Checking root 11221 bytenr 13577562996736
Checking root 11222 bytenr 15645261905920
Checking root 11223 bytenr 13576862547968
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
Checking root 18446744073709551607 bytenr 13576823685120
Tree recovery finished, you can run check now
[Inferior 1 (process 28238) exited normally]
(gdb) 
        item 210 key (517572919296 BLOCK_GROUP_ITEM 1073741824) itemoff 11219 itemsize 24
                block group used 0 chunk_objectid 256 flags DATA|single
        item 211 key (518646661120 BLOCK_GROUP_ITEM 1073741824) itemoff 11195 itemsize 24
                block group used 0 chunk_objectid 256 flags DATA|single
        item 212 key (519720402944 BLOCK_GROUP_ITEM 1073741824) itemoff 11171 itemsize 24
                block group used 0 chunk_objectid 256 flags DATA|single
        item 214 key (521867886592 BLOCK_GROUP_ITEM 1073741824) itemoff 11123 itemsize 24
                block group used 0 chunk_objectid 256 flags DATA|single
        item 215 key (522941628416 BLOCK_GROUP_ITEM 1073741824) itemoff 11099 itemsize 24
inserting block group 15731991248896
inserting block group 15840439173120
inserting block group 15842586656768
processed 1556480 of 0 possible bytes
processed 1228800 of 0 possible bytesFailed to find [7750833868800, 168, 262144]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x10000000060, key=key@entry=0x7fffffffdd00, comp=comp@entry=0x55555559ae9e <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffdd18) at common/rbtree-utils.c:48
48              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x10000000060, key=key@entry=0x7fffffffdd00, comp=comp@entry=0x55555559ae9e <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffdd18) at common/rbtree-utils.c:48
#1  0x000055555559b0a2 in search_cache_extent (tree=tree@entry=0x10000000060, start=start@entry=99713024)
    at common/extent-cache.c:179
#2  0x0000555555584c30 in set_extent_bits (tree=0x10000000060, start=99713024, end=99713023, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584e63 in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x0000555555585846 in set_extent_buffer_dirty (eb=eb@entry=0x555555729660) at kernel-shared/extent_io.c:976
#5  0x000055555557bc1e in btrfs_mark_buffer_dirty (eb=eb@entry=0x555555729660) at kernel-shared/disk-io.c:2224
#6  0x000055555557ee3d in setup_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824992434246, parent=0, 
    iref=0xffffffffffffffe4, path=0x555555b92bd0, root=<optimized out>) at kernel-shared/extent-tree.c:1084
#7  insert_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824992434246, parent=0, 
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x555555b92bd0, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1196
#8  btrfs_inc_extent_ref (trans=trans@entry=0x555558a89620, root=root@entry=0x55555564cde0, bytenr=<optimized out>, 
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=1, owner=5507, offset=0)
    at kernel-shared/extent-tree.c:1261
#9  0x00005555555dfb81 in process_eb (trans=trans@entry=0x555558a89620, root=root@entry=0x55555564cde0, eb=eb@entry=0x555559cfce80, 
    current=current@entry=0x7fffffffe098) at cmds/rescue-init-extent-tree.c:502
#10 0x00005555555dfc90 in process_eb (trans=trans@entry=0x555558a89620, root=root@entry=0x55555564cde0, eb=0x555555944100, 
    current=current@entry=0x7fffffffe098) at cmds/rescue-init-extent-tree.c:577
#11 0x00005555555dfef8 in record_root (root=0x55555564cde0) at cmds/rescue-init-extent-tree.c:648
#12 0x00005555555e0202 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe6c5 "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:784
#13 0x00005555555d7a0c in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#14 0x000055555556c17b in cmd_execute (argv=0x7fffffffe3c8, argc=2, cmd=0x555555642d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#15 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffe3c8) at btrfs.c:152
#16 0x000055555556c275 in cmd_execute (argv=0x7fffffffe3c0, argc=3, cmd=0x555555643cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#17 main (argc=3, argv=0x7fffffffe3c0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
