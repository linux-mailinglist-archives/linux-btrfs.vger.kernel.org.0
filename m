Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64977520B17
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 04:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiEJCXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 22:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiEJCXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 22:23:12 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF4D29ED1F
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 19:19:16 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58496 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1noFT2-0007T2-80 by authid <merlins.org> with srv_auth_plain; Mon, 09 May 2022 19:19:16 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1noFT2-00Hb7x-27; Mon, 09 May 2022 19:19:16 -0700
Date:   Mon, 9 May 2022 19:19:16 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220510021916.GB12542@merlins.org>
References: <20220509004635.GT12542@merlins.org>
 <CAEzrpqfYRkASd+7ac_2dO+bNtacYwE9ndcYDWsp9B4Esq9Hwug@mail.gmail.com>
 <20220509170054.GW12542@merlins.org>
 <CAEzrpqccXWAEELYsY0NQ+ZzecQygJFasipt3yE=0L1KA3GgzYg@mail.gmail.com>
 <20220509171929.GY12542@merlins.org>
 <CAEzrpqft5yq1cMFC_zdHDpOyHc0POQTNkKyW2rKhyHuoN+av6Q@mail.gmail.com>
 <20220510010826.GG29107@merlins.org>
 <CAEzrpqfePZhBvRy_G2kpo=oRPqoJx=F3Xmh7YF5m6pjMjGJ=Fg@mail.gmail.com>
 <20220510013201.GH29107@merlins.org>
 <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 09, 2022 at 10:03:27PM -0400, Josef Bacik wrote:
> On Mon, May 9, 2022 at 9:32 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Mon, May 09, 2022 at 09:18:32PM -0400, Josef Bacik wrote:
> > > On Mon, May 9, 2022 at 9:08 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > On Mon, May 09, 2022 at 09:04:36PM -0400, Josef Bacik wrote:
> > > > > On Mon, May 9, 2022 at 1:19 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > > >
> > > > > > On Mon, May 09, 2022 at 01:09:37PM -0400, Josef Bacik wrote:
> > > > > > > Ugh shit, I had an off by one error, that's not great.  I've fixed
> > > > > > > that up and adjusted the debugging, lets see how that goes.  Thanks,
> > > > > >
> > > > >
> > > > > Sorry my laptop battery died while I was at the dealership, and of
> > > > > course that took allllll day.  Anyway pushed some debugging, am
> > > > > confused, hopefully won't be confused long.  Thanks,
> > > >
> > > > Sorry :-/
> > > > Yeah, I bring my power supply in such cases :)
> > > >
> > > > Did you upload?
> > > > sauron:/var/local/src/btrfs-progs-josefbacik# git pull
> > > > Already up to date.
> > >
> > > Sorry, long day, try it again.  Thanks,
> >
> > processed 49152 of 75792384 possible bytes, 0%
> > Recording extents for root 165098
> > processed 1015808 of 108756992 possible bytes, 0%
> > Recording extents for root 165100
> > processed 16384 of 49479680 possible bytes, 0%
> > Recording extents for root 165198
> > processed 491520 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
> > misc/add0/new/file
> > Failed to find [10467695652864, 168, 8675328]
> 
> Ugh such a pain, lets try this again,


Looks the same?

gargamel:/var/local/src/btrfs-progs-josefbacik# git log | head -6
commit 8e14dcb48ad9fd60c595821fc4ebb5c6a1cfb13f
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon May 9 22:02:12 2022 -0400

    add bytes


processed 1015808 of 108756992 possible bytes, 0%
Recording extents for root 165100
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 165198
processed 491520 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
misc/file
Failed to find [10467695652864, 168, 8675328]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd540, comp=comp@entry=0x55555559af95 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd558) at common/rbtree-utils.c:55
55              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd540, comp=comp@entry=0x55555559af95 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd558) at common/rbtree-utils.c:55
#1  0x000055555559b199 in search_cache_extent (tree=tree@entry=0x100000060, start=start@entry=15645181853696)
    at common/extent-cache.c:179
#2  0x0000555555584d27 in set_extent_bits (tree=0x100000060, start=15645181853696, end=15645181853695, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584f5a in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x000055555558593d in set_extent_buffer_dirty (eb=eb@entry=0x55556fbb6da0) at kernel-shared/extent_io.c:976
#5  0x000055555557bc2a in btrfs_mark_buffer_dirty (eb=eb@entry=0x55556fbb6da0) at kernel-shared/disk-io.c:2224
#6  0x000055555557ef4c in setup_inline_extent_backref (refs_to_add=1, offset=0, owner=76300, root_objectid=93825437307456, parent=0, 
    iref=0xffffffffffffffe3, path=0x55556fdc9240, root=<optimized out>) at kernel-shared/extent-tree.c:1085
#7  insert_inline_extent_backref (refs_to_add=1, offset=0, owner=76300, root_objectid=93825437307456, parent=0, 
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x55556fdc9240, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1197
#8  btrfs_inc_extent_ref (trans=trans@entry=0x555570857380, root=root@entry=0x55555915f5d0, bytenr=<optimized out>, 
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=165198, owner=76300, offset=0)
    at kernel-shared/extent-tree.c:1262
#9  0x00005555555e087a in process_eb (trans=trans@entry=0x555570857380, root=root@entry=0x55555915f5d0, eb=eb@entry=0x5555741a4ff0, 
    current=current@entry=0x7fffffffd9e8) at cmds/rescue-init-extent-tree.c:987
#10 0x00005555555e09e5 in process_eb (trans=trans@entry=0x555570857380, root=root@entry=0x55555915f5d0, eb=eb@entry=0x5555741a0f70, 
    current=current@entry=0x7fffffffd9e8) at cmds/rescue-init-extent-tree.c:1062
#11 0x00005555555e09e5 in process_eb (trans=trans@entry=0x555570857380, root=root@entry=0x55555915f5d0, eb=0x555559223b80, 
    current=current@entry=0x7fffffffd9e8) at cmds/rescue-init-extent-tree.c:1062
#12 0x00005555555e0c95 in record_root (root=0x55555915f5d0) at cmds/rescue-init-extent-tree.c:1138
#13 0x00005555555dfda6 in foreach_root (fs_info=fs_info@entry=0x55555564dbc0, cb=cb@entry=0x5555555e0b90 <record_root>)
    at cmds/rescue-init-extent-tree.c:152
#14 0x00005555555e1007 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:1217
#15 0x00005555555d7b70 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#16 0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555643d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#17 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#18 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555644cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#19 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
