Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA200512435
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 23:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiD0VGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbiD0VGD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 17:06:03 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967764DF57
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 14:02:47 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58284 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1njooA-0006IK-St by authid <merlins.org> with srv_auth_plain; Wed, 27 Apr 2022 14:02:46 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1njooA-006ebA-MV; Wed, 27 Apr 2022 14:02:46 -0700
Date:   Wed, 27 Apr 2022 14:02:46 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220427210246.GV12542@merlins.org>
References: <20220426002804.GI29107@merlins.org>
 <20220426204326.GK12542@merlins.org>
 <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
 <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com>
 <20220427035451.GM29107@merlins.org>
 <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
 <20220427163423.GN29107@merlins.org>
 <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
 <20220427182440.GO12542@merlins.org>
 <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 04:21:31PM -0400, Josef Bacik wrote:
> On Wed, Apr 27, 2022 at 2:24 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Wed, Apr 27, 2022 at 01:49:46PM -0400, Josef Bacik wrote:
> > > > Result:
> > > > doing insert of 12233379401728
> > > > Failed to find [7750833868800, 168, 262144]
> > >
> > > Oh it's data, interesting.  Pushed some more debugging.  Thanks,
> >
> > inserting block group 15840439173120
> > inserting block group 15842586656768
> > processed 1556480 of 0 possible bytes
> > processed 1130496 of 0 possible bytesdoing an insert that overlaps our bytenr 7750833627136 262144
> > processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr??
> 
> Well crap, you have bytenrs that overlap.  I've adjusted
> init-extent-tree to dump the paths of the files that have overlapping
> extents, as well as the keys.  Run it again so we know what files are
> fucked. From there you need to tell me which one you don't care about
> and are willing to delete, and then I'll give you the command you need
> to remove that bad extent and then we can go again.  Thanks,

I see. 

Not sure if that helped. Should I have run it differently?


Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Apr 27 16:19:46 2022 -0400
    fix some things so dump path works

(gdb) run rescue init-extent-tree /dev/mapper/dshelf1                                                                                  
(...)
inserting block group 15838291689472
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
processed 1556480 of 0 possible bytes
processed 1130496 of 0 possible bytesadding a bytenr that overlaps our thing, dumping paths for [5064, 108, 0]
doing an insert that overlaps our bytenr 7750833627136 262144
processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr?? [5507, 108, 0] dumping paths
Failed to find [7750833868800, 168, 262144]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffdce0, comp=comp@entry=0x55555559ae9a <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffdcf8) at common/rbtree-utils.c:48
48              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffdce0, comp=comp@entry=0x55555559ae9a <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffdcf8) at common/rbtree-utils.c:48
#1  0x000055555559b09e in search_cache_extent (tree=tree@entry=0x100000060, start=start@entry=100564992) at common/extent-cache.c:179
#2  0x0000555555584c2c in set_extent_bits (tree=0x100000060, start=100564992, end=100564991, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584e5f in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x0000555555585842 in set_extent_buffer_dirty (eb=eb@entry=0x555555729660) at kernel-shared/extent_io.c:976
#5  0x000055555557bc10 in btrfs_mark_buffer_dirty (eb=eb@entry=0x555555729660) at kernel-shared/disk-io.c:2224
#6  0x000055555557ee39 in setup_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824998756304, parent=0, 
    iref=0xffffffffffffffe3, path=0x555555b8cfd0, root=<optimized out>) at kernel-shared/extent-tree.c:1085
#7  insert_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824998756304, parent=0, 
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x555555b8cfd0, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1197
#8  btrfs_inc_extent_ref (trans=trans@entry=0x555558a8d7c0, root=root@entry=0x55555564cde0, bytenr=<optimized out>, 
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=1, owner=5507, offset=0)
    at kernel-shared/extent-tree.c:1262
#9  0x00005555555dfcf4 in process_eb (trans=trans@entry=0x555558a8d7c0, root=root@entry=0x55555564cde0, eb=eb@entry=0x555559d00d20, 
    current=current@entry=0x7fffffffe098) at cmds/rescue-init-extent-tree.c:555
#10 0x00005555555dfe4d in process_eb (trans=trans@entry=0x555558a8d7c0, root=root@entry=0x55555564cde0, eb=0x555555944100, 
    current=current@entry=0x7fffffffe098) at cmds/rescue-init-extent-tree.c:630
#11 0x00005555555e00b8 in record_root (root=0x55555564cde0) at cmds/rescue-init-extent-tree.c:701
#12 0x00005555555e03c2 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe6c5 "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:837
#13 0x00005555555d7a08 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#14 0x000055555556c17b in cmd_execute (argv=0x7fffffffe3c8, argc=2, cmd=0x555555642d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#15 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffe3c8) at btrfs.c:152
#16 0x000055555556c275 in cmd_execute (argv=0x7fffffffe3c0, argc=3, cmd=0x555555643cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#17 main (argc=3, argv=0x7fffffffe3c0) at btrfs.c:405


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
