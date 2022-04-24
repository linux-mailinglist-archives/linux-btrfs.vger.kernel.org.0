Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E5550D4E5
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiDXTrr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 15:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiDXTrr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 15:47:47 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8D966203
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 12:44:45 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58208 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1niiA0-0002IK-TD by authid <merlins.org> with srv_auth_plain; Sun, 24 Apr 2022 12:44:44 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1niiA0-000950-N4; Sun, 24 Apr 2022 12:44:44 -0700
Date:   Sun, 24 Apr 2022 12:44:44 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220424194444.GA12542@merlins.org>
References: <20220422184850.GX13115@merlins.org>
 <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
 <20220422200115.GV11868@merlins.org>
 <20220423201225.GZ13115@merlins.org>
 <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
 <CAEzrpqdHAS2E1iuoSFVX-A-T-vsMoCo6CoW0ebw42vkCjqpMPw@mail.gmail.com>
 <20220424162450.GY11868@merlins.org>
 <CAEzrpqe6gwpF9k=Gj4=aCzkj-kW5GrZNueNnfoL8ZAAnMvwbng@mail.gmail.com>
 <20220424184341.GA1523521@merlins.org>
 <CAEzrpqeUJwtkMAUaxEd-qARe1aEZBx-v1-G_WY7vPr5MNL+3TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqeUJwtkMAUaxEd-qARe1aEZBx-v1-G_WY7vPr5MNL+3TQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 03:17:33PM -0400, Josef Bacik wrote:
> Ok this is sort of maddening, IDK how we'll trip over this broken
> block here, but not with tree-recover.  Can you repull, build, and
> then run init-extent-tree.  As soon as you see the JOSEF message you
> can kill it and send me the output, I need to figure out wtf is going
> on here.  Thanks,

Mmmh, not sure I got that far.

gargamel:/var/local/src/btrfs-progs-josefbacik# grep -r JOSEF *
Binary file btrfs matches
Binary file btrfsck matches
Binary file btrfs-convert matches
Binary file btrfs-corrupt-block matches
Binary file btrfs-find-root matches
Binary file btrfs-image matches
Binary file btrfs-map-logical matches
Binary file btrfs-select-super matches
Binary file btrfstune matches
kernel-shared/ctree.c:          printf("JOSEF: read node slot on root %llu\n", root->root_key.objectid);
Binary file kernel-shared/ctree.o matches
kernel-shared/disk-io.c:                printf("JOSEF: root %llu\n", root->root_key.objectid);
Binary file kernel-shared/disk-io.o matches
Binary file mkfs.btrfs matches


(gdb) run rescue init-extent-tree /dev/mapper/dshelf1
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x55555564cbc0
JOSEF: root 9
checksum verify failed on 15645878108160 wanted 0x1beaa67b found 0x27edb2c4
Couldn't find the last root for 8
checksum verify failed on 58720256 wanted 0x89f5cb13 found 0x04196d22
FS_INFO AFTER IS 0x55555564cbc0
Walking all our trees and pinning down the currently accessible blocks
checksum verify failed on 11651824091136 wanted 0x6d411825 found 0x3cf07c9d
checksum verify failed on 606126080 wanted 0x8e0fb704 found 0xfc183188
checksum verify failed on 15645807640576 wanted 0xe97841cd found 0x4fa14858
(...)
checksum verify failed on 13577821011968 wanted 0x9a29aff5 found 0x2cdff391
checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
Clearing the extent root and re-init'ing the block groups
processed 1556480 of 0 possible bytes
processed 1228800 of 0 possible bytesFailed to find [7750833868800, 168, 262144]

Program received signal SIGSEGV, Segmentation fault.
rb_search (root=root@entry=0x10000000060, key=key@entry=0x7fffffffd7f0, comp=comp@entry=0x55555559ae58 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd808) at common/rbtree-utils.c:48
48              struct rb_node *n = root->rb_node;
(gdb) bt
#0  rb_search (root=root@entry=0x10000000060, key=key@entry=0x7fffffffd7f0, comp=comp@entry=0x55555559ae58 <cache_tree_comp_range>, 
    next_ret=next_ret@entry=0x7fffffffd808) at common/rbtree-utils.c:48
#1  0x000055555559b05c in search_cache_extent (tree=tree@entry=0x10000000060, start=start@entry=99696640)
    at common/extent-cache.c:179
#2  0x0000555555584bea in set_extent_bits (tree=0x10000000060, start=99696640, end=99696639, bits=bits@entry=1)
    at kernel-shared/extent_io.c:380
#3  0x0000555555584e1d in set_extent_dirty (tree=<optimized out>, start=<optimized out>, end=<optimized out>)
    at kernel-shared/extent_io.c:486
#4  0x0000555555585800 in set_extent_buffer_dirty (eb=eb@entry=0x555555721210) at kernel-shared/extent_io.c:976
#5  0x000055555557bbf3 in btrfs_mark_buffer_dirty (eb=eb@entry=0x555555721210) at kernel-shared/disk-io.c:2224
#6  0x000055555557edf7 in setup_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824992434176, parent=0, 
    iref=0xffffffffffffffe4, path=0x555555b83090, root=<optimized out>) at kernel-shared/extent-tree.c:1084
#7  insert_inline_extent_backref (refs_to_add=1, offset=0, owner=5507, root_objectid=93824992434176, parent=0, 
    num_bytes=<optimized out>, bytenr=<optimized out>, path=0x555555b83090, root=<optimized out>, trans=<optimized out>)
    at kernel-shared/extent-tree.c:1196
#8  btrfs_inc_extent_ref (trans=trans@entry=0x555558a896e0, root=root@entry=0x55555564cde0, bytenr=<optimized out>, 
    num_bytes=<optimized out>, parent=parent@entry=0, root_objectid=root_objectid@entry=1, owner=5507, offset=0)
    at kernel-shared/extent-tree.c:1261
#9  0x00005555555dfaad in process_eb (trans=trans@entry=0x555558a896e0, root=root@entry=0x55555564cde0, eb=eb@entry=0x555559cfcfa0, 
    current=current@entry=0x7fffffffdb88) at cmds/rescue-init-extent-tree.c:499
#10 0x00005555555dfbbc in process_eb (trans=trans@entry=0x555558a896e0, root=root@entry=0x55555564cde0, eb=0x55555566b790, 
    current=current@entry=0x7fffffffdb88) at cmds/rescue-init-extent-tree.c:574
#11 0x00005555555dfe24 in record_root (root=0x55555564cde0) at cmds/rescue-init-extent-tree.c:645
#12 0x00005555555e0127 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe1d0 "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:779
#13 0x00005555555d79c6 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#14 0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555642d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#15 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#16 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555643cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#17 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
