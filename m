Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FABF511DEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 20:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbiD0Qho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243084AbiD0Qhi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 12:37:38 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5765FF23
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 09:34:24 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1njkcR-0003Kx-ME by authid <merlin>; Wed, 27 Apr 2022 09:34:23 -0700
Date:   Wed, 27 Apr 2022 09:34:23 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220427163423.GN29107@merlins.org>
References: <20220424231446.GF29107@merlins.org>
 <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
 <20220425002415.GG29107@merlins.org>
 <CAEzrpqcQkiMJt1B4Bx9NrCcRys1MD+_5Y3riActXYC6RQrkakw@mail.gmail.com>
 <20220426002804.GI29107@merlins.org>
 <20220426204326.GK12542@merlins.org>
 <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
 <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com>
 <20220427035451.GM29107@merlins.org>
 <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 10:44:26AM -0400, Josef Bacik wrote:
> On Tue, Apr 26, 2022 at 11:54 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Tue, Apr 26, 2022 at 05:36:28PM -0400, Josef Bacik wrote:
> > > On Tue, Apr 26, 2022 at 5:20 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > >
> > > > On Tue, Apr 26, 2022 at 4:43 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > >
> > > > > Generally would you say we're still on the right path and helping your
> > > > > recovery tools getting better, or is it getting close or to the time
> > > > > where I should restore from backups?
> > > > >
> > > >
> > > > Yup sorry for the radio silence, loads of meetings today, but good
> > > > news is I've reproduced your problem locally, so I'm trying to hammer
> > > > it out.  I hope to have something useful for you today.  Thanks,
> > >
> > > Sigh I'm dumb as fuck, can you pull and re-run tree-recover just to
> > > make sure any stupidity I've caused is undone, and then run rescue
> > > init-extent-tree and then we can go from there?  Thanks,
> 
> Ok back to this problem again, I've added some debugging.
> Unfortunately the real bytenr is getting lost, so the new debugging
> will print the actual bytenr we're trying to add, and then I can add
> more targeted debugging to figure out whats going on.  Thanks,

Small typo:
  409 |  prinf("doing insert of %llu\n", key->objectid);
        |  ^~~~~
	|  printf

Result:
doing insert of 12233379401728
Failed to find [7750833868800, 168, 262144]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x10000000060, key=key@entry=0x7fffffffdd00, comp=comp@entry=0x55555559aea8 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffdd18) at common/rbtree-utils.c:48
48              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x10000000060, key=key@entry=0x7fffffffdd00, comp=comp@entry=0x55555559aea8 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffdd18) at common/rbtree-utils.c:48
#1  0x000055555559b0ac in search_cache_extent (tree=tree@entry=0x10000000060, start=start@entry=100564992)
    at common/extent-cache.c:179
#2  0x0000555555584c3a in set_extent_bits (tree=0x10000000060, start=100564992, end=100564991, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584e6d in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x0000555555585850 in set_extent_buffer_dirty (eb=eb@entry=0x555555729660) at kernel-shared/extent_io.c:976
#5  0x000055555557bc1e in btrfs_mark_buffer_dirty (eb=eb@entry=0x555555729660) at kernel-shared/disk-io.c:2224
#6  0x000055555557ee47 in setup_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824992434256, parent=0, 
    iref=0xffffffffffffffe4, path=0x555555b8cda0, root=<optimized out>) at kernel-shared/extent-tree.c:1085
#7  insert_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824992434256, parent=0, 
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x555555b8cda0, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1197
#8  btrfs_inc_extent_ref (trans=trans@entry=0x555558a8d760, root=root@entry=0x55555564cde0, bytenr=<optimized out>, 
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=1, owner=5507, offset=0)
    at kernel-shared/extent-tree.c:1262
#9  0x00005555555dfba4 in process_eb (trans=trans@entry=0x555558a8d760, root=root@entry=0x55555564cde0, eb=eb@entry=0x555559d00cc0, 
    current=current@entry=0x7fffffffe098) at cmds/rescue-init-extent-tree.c:503
#10 0x00005555555dfcb3 in process_eb (trans=trans@entry=0x555558a8d760, root=root@entry=0x55555564cde0, eb=0x555555944100, 
    current=current@entry=0x7fffffffe098) at cmds/rescue-init-extent-tree.c:578
#11 0x00005555555dff1b in record_root (root=0x55555564cde0) at cmds/rescue-init-extent-tree.c:649
#12 0x00005555555e0225 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe6c5 "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:785
#13 0x00005555555d7a16 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#14 0x000055555556c17b in cmd_execute (argv=0x7fffffffe3c8, argc=2, cmd=0x555555642d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#15 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffe3c8) at btrfs.c:152
#16 0x000055555556c275 in cmd_execute (argv=0x7fffffffe

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
