Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA3520372
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 19:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiEIRX2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 13:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiEIRX0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 13:23:26 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C5024DC50
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 10:19:32 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58490 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1no72f-0004kH-Iv by authid <merlins.org> with srv_auth_plain; Mon, 09 May 2022 10:19:29 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1no72f-00G3Ed-Cn; Mon, 09 May 2022 10:19:29 -0700
Date:   Mon, 9 May 2022 10:19:29 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220509171929.GY12542@merlins.org>
References: <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
 <20220508205224.GQ12542@merlins.org>
 <20220508212050.GR12542@merlins.org>
 <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com>
 <20220508221444.GS12542@merlins.org>
 <CAEzrpqe=qUMdC-8UTeuSy7niO9i8PhFGa6auMmQk_ave30gKUw@mail.gmail.com>
 <20220509004635.GT12542@merlins.org>
 <CAEzrpqfYRkASd+7ac_2dO+bNtacYwE9ndcYDWsp9B4Esq9Hwug@mail.gmail.com>
 <20220509170054.GW12542@merlins.org>
 <CAEzrpqccXWAEELYsY0NQ+ZzecQygJFasipt3yE=0L1KA3GgzYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqccXWAEELYsY0NQ+ZzecQygJFasipt3yE=0L1KA3GgzYg@mail.gmail.com>
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

On Mon, May 09, 2022 at 01:09:37PM -0400, Josef Bacik wrote:
> Ugh shit, I had an off by one error, that's not great.  I've fixed
> that up and adjusted the debugging, lets see how that goes.  Thanks,

Looks better this time. Went pretty far, until here:
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 163298
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 163302
processed 966656 of 108691456 possible bytes, 0%
Recording extents for root 163303
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 163316
processed 933888 of 108691456 possible bytes, 0%
Recording extents for root 163318
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 163916
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 163920
processed 966656 of 108691456 possible bytes, 0%
Recording extents for root 163921
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 164620
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 164624
processed 98304 of 109445120 possible bytes, 0%
Recording extents for root 164633
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 165098
processed 1015808 of 108756992 possible bytes, 0%
Recording extents for root 165100
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 165198
processed 491520 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
misc/add0/new/file
Failed to find [10467695652864, 168, 8675328]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd540, comp=comp@entry=0x55555559af95 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd558) at common/rbtree-utils.c:55
55              struct rb_node *n = root->rb_node;
(gdb) bt 
#0  rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd540, comp=comp@entry=0x55555559af95 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd558) at common/rbtree-utils.c:55
#1  0x000055555559b199 in search_cache_extent (tree=tree@entry=0x100000060, start=start@entry=15645171073024)
    at common/extent-cache.c:179
#2  0x0000555555584d27 in set_extent_bits (tree=0x100000060, start=15645171073024, end=15645171073023, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584f5a in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x000055555558593d in set_extent_buffer_dirty (eb=eb@entry=0x55556ce60d60) at kernel-shared/extent_io.c:976
#5  0x000055555557bc2a in btrfs_mark_buffer_dirty (eb=eb@entry=0x55556ce60d60) at kernel-shared/disk-io.c:2224
#6  0x000055555557ef4c in setup_inline_extent_backref (refs_to_add=1, offset=0, owner=76300, root_objectid=93824992431962, parent=0, 
    iref=0xffffffffffffffe3, path=0x5555703388f0, root=<optimized out>) at kernel-shared/extent-tree.c:1085
#7  insert_inline_extent_backref (refs_to_add=1, offset=0, owner=76300, root_objectid=93824992431962, parent=0, 
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x5555703388f0, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1197
#8  btrfs_inc_extent_ref (trans=trans@entry=0x5555685c9d90, root=root@entry=0x5555563d6bf0, bytenr=<optimized out>, 
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=165198, owner=76300, offset=0)
    at kernel-shared/extent-tree.c:1262
#9  0x00005555555e086b in process_eb (trans=trans@entry=0x5555685c9d90, root=root@entry=0x5555563d6bf0, eb=eb@entry=0x555571271c40, 
    current=current@entry=0x7fffffffd9e8) at cmds/rescue-init-extent-tree.c:986
#10 0x00005555555e09d6 in process_eb (trans=trans@entry=0x5555685c9d90, root=root@entry=0x5555563d6bf0, eb=eb@entry=0x55557126dbc0, 
    current=current@entry=0x7fffffffd9e8) at cmds/rescue-init-extent-tree.c:1061
#11 0x00005555555e09d6 in process_eb (trans=trans@entry=0x5555685c9d90, root=root@entry=0x5555563d6bf0, eb=0x55555649b860, 
    current=current@entry=0x7fffffffd9e8) at cmds/rescue-init-extent-tree.c:1061
#12 0x00005555555e0c82 in record_root (root=0x5555563d6bf0) at cmds/rescue-init-extent-tree.c:1137
#13 0x00005555555dfd9f in foreach_root (fs_info=fs_info@entry=0x55555564dbc0, cb=cb@entry=0x5555555e0b7d <record_root>)
    at cmds/rescue-init-extent-tree.c:151
#14 0x00005555555e0ff4 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:1216
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
