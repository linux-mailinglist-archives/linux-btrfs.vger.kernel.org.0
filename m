Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B07C51214F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 20:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiD0So0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 14:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiD0Snu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 14:43:50 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6596306
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 11:24:42 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58270 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1njmLB-0002Wa-32 by authid <merlins.org> with srv_auth_plain; Wed, 27 Apr 2022 11:24:41 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1njmLA-006R0y-RY; Wed, 27 Apr 2022 11:24:40 -0700
Date:   Wed, 27 Apr 2022 11:24:40 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220427182440.GO12542@merlins.org>
References: <20220425002415.GG29107@merlins.org>
 <CAEzrpqcQkiMJt1B4Bx9NrCcRys1MD+_5Y3riActXYC6RQrkakw@mail.gmail.com>
 <20220426002804.GI29107@merlins.org>
 <20220426204326.GK12542@merlins.org>
 <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
 <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com>
 <20220427035451.GM29107@merlins.org>
 <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
 <20220427163423.GN29107@merlins.org>
 <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 01:49:46PM -0400, Josef Bacik wrote:
> > Result:
> > doing insert of 12233379401728
> > Failed to find [7750833868800, 168, 262144]
> 
> Oh it's data, interesting.  Pushed some more debugging.  Thanks,

inserting block group 15840439173120
inserting block group 15842586656768
processed 1556480 of 0 possible bytes
processed 1130496 of 0 possible bytesdoing an insert that overlaps our bytenr 7750833627136 262144
processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr??
Failed to find [7750833868800, 168, 262144]
processed 1245184 of 0 possible bytesIgnoring transid failure
kernel-shared/ctree.c:1940: leaf_space_used: Warning: assertion `data_len < 0` failed, value 1
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x1d13f)[0x55555557113f]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_leaf_free_space+0xd3)[0x555555573b36]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x1fbf3)[0x555555573bf3]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x2083b)[0x55555557483b]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_search_slot+0x11cd)[0x5555555767c9]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_insert_empty_items+0x76)[0x555555576e6b]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8b97d)[0x5555555df97d]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8bc04)[0x5555555dfc04]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8bcfb)[0x5555555dfcfb]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8bf59)[0x5555555dff59]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_init_extent_tree+0x22d)[0x5555555e0263]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x83a16)[0x5555555d7a16]
/var/local/src/btrfs-progs-josefbacik/btrfs(handle_command_group+0x49)[0x55555556c17b]
/var/local/src/btrfs-progs-josefbacik/btrfs(main+0x94)[0x55555556c275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7ffff78617fd]
/var/local/src/btrfs-progs-josefbacik/btrfs(_start+0x2a)[0x55555556be1a]
kernel-shared/ctree.c:1940: leaf_space_used: Warning: assertion `data_len < 0` failed, value 1
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x1d13f)[0x55555557113f]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_leaf_free_space+0xd3)[0x555555573b36]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x1fc38)[0x555555573c38]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x2083b)[0x55555557483b]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_search_slot+0x11cd)[0x5555555767c9]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_insert_empty_items+0x76)[0x555555576e6b]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8b97d)[0x5555555df97d]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8bc04)[0x5555555dfc04]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8bcfb)[0x5555555dfcfb]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8bf59)[0x5555555dff59]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_init_extent_tree+0x22d)[0x5555555e0263]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x83a16)[0x5555555d7a16]
/var/local/src/btrfs-progs-josefbacik/btrfs(handle_command_group+0x49)[0x55555556c17b]
/var/local/src/btrfs-progs-josefbacik/btrfs(main+0x94)[0x55555556c275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7ffff78617fd]
/var/local/src/btrfs-progs-josefbacik/btrfs(_start+0x2a)[0x55555556be1a]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x1000000000060, key=key@entry=0x7fffffffd8f0, comp=comp@entry=0x55555559aea8 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd908) at common/rbtree-utils.c:48
48              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x1000000000060, key=key@entry=0x7fffffffd8f0, 
    comp=comp@entry=0x55555559aea8 <cache_tree_comp_range>, next_ret=next_ret@entry=0x7fffffffd908) at common/rbtree-utils.c:48
#1  0x000055555559b0ac in search_cache_extent (tree=tree@entry=0x1000000000060, start=start@entry=1) at common/extent-cache.c:179
#2  0x0000555555584c3a in set_extent_bits (tree=0x1000000000060, start=1, end=0, bits=bits@entry=1) at kernel-shared/extent_io.c:380
#3  0x0000555555584e6d in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x0000555555585850 in set_extent_buffer_dirty (eb=0x555555708580) at kernel-shared/extent_io.c:976
#5  0x000055555557bc1e in btrfs_mark_buffer_dirty (eb=<optimized out>) at kernel-shared/disk-io.c:2224
#6  0x00005555555740c3 in push_leaf_right (trans=trans@entry=0x555558a8d700, root=root@entry=0x5555559547d0, 
    path=path@entry=0x7fffffffde40, data_size=data_size@entry=49, empty=empty@entry=0) at kernel-shared/ctree.c:2106
#7  0x000055555557483b in split_leaf (trans=trans@entry=0x555558a8d700, root=root@entry=0x5555559547d0, 
    ins_key=ins_key@entry=0x7fffffffdf60, path=path@entry=0x7fffffffde40, data_size=data_size@entry=49, extend=extend@entry=0)
    at kernel-shared/ctree.c:2385
#8  0x00005555555767c9 in btrfs_search_slot (trans=0x555558a8d700, root=root@entry=0x5555559547d0, key=key@entry=0x7fffffffdf60, 
    p=p@entry=0x7fffffffde40, ins_len=ins_len@entry=49, cow=cow@entry=1) at kernel-shared/ctree.c:1432
#9  0x0000555555576e6b in btrfs_insert_empty_items (trans=trans@entry=0x555558a8d700, root=root@entry=0x5555559547d0, 
    path=path@entry=0x7fffffffde40, cpu_key=cpu_key@entry=0x7fffffffdf60, data_size=data_size@entry=0x7fffffffde3c, nr=nr@entry=1)
    at kernel-shared/ctree.c:2820
#10 0x00005555555df97d in btrfs_insert_empty_item (data_size=<optimized out>, key=0x7fffffffdf60, path=0x7fffffffde40, 
    root=0x5555559547d0, trans=0x555558a8d700) at ./kernel-shared/ctree.h:2780
#11 insert_empty_extent (trans=trans@entry=0x555558a8d700, key=key@entry=0x7fffffffdf60, generation=generation@entry=1590260, 
    flags=flags@entry=1) at cmds/rescue-init-extent-tree.c:435
#12 0x00005555555dfc04 in process_eb (trans=trans@entry=0x555558a8d700, root=root@entry=0x55555564cde0, eb=eb@entry=0x555559d04fe0, 
    current=current@entry=0x7fffffffe098) at cmds/rescue-init-extent-tree.c:508
#13 0x00005555555dfcfb in process_eb (trans=trans@entry=0x555558a8d700, root=root@entry=0x55555564cde0, eb=0x555555944100, 
    current=current@entry=0x7fffffffe098) at cmds/rescue-init-extent-tree.c:594
#14 0x00005555555dff59 in record_root (root=0x55555564cde0) at cmds/rescue-init-extent-tree.c:665
#15 0x00005555555e0263 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe6c5 "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:801
#16 0x00005555555d7a16 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#17 0x000055555556c17b in cmd_execute (argv=0x7fffffffe3c8, argc=2, cmd=0x555555642d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#18 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffe3c8) at btrfs.c:152
#19 0x000055555556c275 in cmd_execute (argv=0x7fffffffe3c0, argc=3, cmd=0x555555643cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#20 main (argc=3, argv=0x7fffffffe3c0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
