Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3351F1B3
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 May 2022 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiEHU4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 May 2022 16:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiEHU4Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 May 2022 16:56:16 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A9FB84B
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 13:52:25 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58462 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nnntA-0008NP-SX by authid <merlins.org> with srv_auth_plain; Sun, 08 May 2022 13:52:24 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nnntA-00EW2S-Mm; Sun, 08 May 2022 13:52:24 -0700
Date:   Sun, 8 May 2022 13:52:24 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220508205224.GQ12542@merlins.org>
References: <20220505150821.GB1020265@merlins.org>
 <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com>
 <20220506031910.GH12542@merlins.org>
 <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
 <CAEzrpqdzdimQvXyhpDomvPgDXx5Dn9QCEKQMiXofTFb3WvWUJQ@mail.gmail.com>
 <20220507153921.GG1020265@merlins.org>
 <CAEzrpqcRT6CqJJPYqW5AH+x0XvUCMd-EMEq-=SwtTL-Fn4pcvQ@mail.gmail.com>
 <20220507193628.GO12542@merlins.org>
 <20220508194557.GP12542@merlins.org>
 <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
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

On Sun, May 08, 2022 at 03:55:01PM -0400, Josef Bacik wrote:
> > searching 165298 for bad extents
> > processed 108756992 of 108756992 possible bytes, 100%
> > searching 165299 for bad extents
> > processed 75792384 of 75792384 possible bytes, 100%
> > searching 18446744073709551607 for bad extents
> > processed 16384 of 16384 possible bytes, 100%
> > Recording extents for root 3
> > Floating point exception
> 
> Oops that's probably a divide by 0 for my fancy pct thing, I fixed it
> up and pushed.  Thanks,
> 
Mmmh, got worse? Failed on the first file to delete
processed 491520 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
inode ref info failed???
misc/add0/new/file
Failed to find [10467695652864, 168, 8675328]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd540, comp=comp@entry=0x55555559afa1 <cache_tree_comp_range>,
    next_ret=next_ret@entry=0x7fffffffd558) at common/rbtree-utils.c:48
48              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd540, comp=comp@entry=0x55555559afa1 <cache_tree_comp_range>,
    next_ret=next_ret@entry=0x7fffffffd558) at common/rbtree-utils.c:48
#1  0x000055555559b1a5 in search_cache_extent (tree=tree@entry=0x100000060, start=start@entry=15645169139712)
    at common/extent-cache.c:179
#2  0x0000555555584d33 in set_extent_bits (tree=0x100000060, start=15645169139712, end=15645169139711, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584f66 in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x0000555555585949 in set_extent_buffer_dirty (eb=eb@entry=0x55555ebf5bd0) at kernel-shared/extent_io.c:976
#5  0x000055555557bc36 in btrfs_mark_buffer_dirty (eb=eb@entry=0x55555ebf5bd0) at kernel-shared/disk-io.c:2224
#6  0x000055555557ef58 in setup_inline_extent_backref (refs_to_add=1, offset=0, owner=76300, root_objectid=93825108188384, parent=0,
    iref=0xffffffffffffffe3, path=0x55555c3e9ce0, root=<optimized out>) at kernel-shared/extent-tree.c:1085
#7  insert_inline_extent_backref (refs_to_add=1, offset=0, owner=76300, root_objectid=93825108188384, parent=0,
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x55555c3e9ce0, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1197
#8  btrfs_inc_extent_ref (trans=trans@entry=0x55555ca62310, root=root@entry=0x555555c50fa0, bytenr=<optimized out>,
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=165198, owner=76300, offset=0)
    at kernel-shared/extent-tree.c:1262
#9  0x00005555555e05e5 in process_eb (trans=trans@entry=0x55555ca62310, root=root@entry=0x555555c50fa0, eb=eb@entry=0x5555632213b0,
    current=current@entry=0x7fffffffd9e8) at cmds/rescue-init-extent-tree.c:869
#10 0x00005555555e0750 in process_eb (trans=trans@entry=0x55555ca62310, root=root@entry=0x555555c50fa0, eb=eb@entry=0x55556321d330,
    current=current@entry=0x7fffffffd9e8) at cmds/rescue-init-extent-tree.c:944
#11 0x00005555555e0750 in process_eb (trans=trans@entry=0x55555ca62310, root=root@entry=0x555555c50fa0, eb=0x555556497960,
    current=current@entry=0x7fffffffd9e8) at cmds/rescue-init-extent-tree.c:944
#12 0x00005555555e0a00 in record_root (root=0x555555c50fa0) at cmds/rescue-init-extent-tree.c:1020
#13 0x00005555555dfebf in foreach_root (fs_info=fs_info@entry=0x55555564dbc0, cb=cb@entry=0x5555555e08fb <record_root>)
    at cmds/rescue-init-extent-tree.c:87
#14 0x00005555555e0d5b in btrfs_init_extent_tree (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:1099
#15 0x00005555555d7b65 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#16 0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555643d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#17 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#18 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555644cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#19 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
