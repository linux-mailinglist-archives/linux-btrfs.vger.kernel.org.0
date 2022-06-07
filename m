Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F387154258A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbiFHBUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 21:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390016AbiFHAgY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 20:36:24 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CA01F185F
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 13:44:53 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyg3a-0005xD-LA by authid <merlin>; Tue, 07 Jun 2022 13:44:06 -0700
Date:   Tue, 7 Jun 2022 13:44:06 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220607204406.GX22722@merlins.org>
References: <20220607032240.GS22722@merlins.org>
 <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
 <20220607151829.GQ1745079@merlins.org>
 <CAEzrpqftCCPw1J-jA-MTgoBDG6fNVJ-bJoXCh7NAbCeDptiwag@mail.gmail.com>
 <20220607153257.GR1745079@merlins.org>
 <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
 <20220607182737.GU1745079@merlins.org>
 <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
 <20220607195744.GV22722@merlins.org>
 <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 04:10:02PM -0400, Josef Bacik wrote:
> Alright it looks like we've gotten everything we're going to get, go
> ahead and let init-extent-tree do its thing.  Thanks,

Argh, it ran for a while and then it crashed, but I didn't have it run under gdb.

searching 164624 for bad extents
processed 655360 of 109084672 possible bytes, 0%
Found an extent we don't have a block group for in the file 12283412910080
ref to path failed
Couldn't find any paths for this inode
Deleting [26761, 108, 34557952] root 15645018243072 path top 15645018243072 top slot 40 leaf 15645020192768 slot 3

searching 164624 for bad extents
processed 655360 of 109084672 possible bytes, 0%
Found an extent we don't have a block group for in the file 12283452309504
ref to path failed
Couldn't find any paths for this inode
Deleting [26761, 108, 43954176] root 15645019504640 path top 15645019504640 top slot 40 leaf 15645020028928 slot 3
Segmentation fault

re-running it thankfully crashed in the same place
processed 655360 of 109084672 possible bytes, 0%
Found an extent we don't have a block group for in the file 12283452309504
ref to path failed
Couldn't find any paths for this inode
Deleting [26761, 108, 43954176] root 15645019586560 path top 15645019586560 top slot 40 leaf 15645019602944 slot 3

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff78e1c8f in ?? () from /lib/x86_64-linux-gnu/libc.so.6
(gdb) bt
#0  0x00007ffff78e1c8f in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00005555555862f9 in memcpy (__len=17, __src=<optimized out>, __dest=0x7fffffffd5d0)
    at /usr/include/x86_64-linux-gnu/bits/string_fortified.h:29
#2  read_extent_buffer (eb=<optimized out>, dst=dst@entry=0x7fffffffd630, start=<optimized out>, len=len@entry=17)
    at kernel-shared/extent_io.c:1002
#3  0x00005555555735aa in btrfs_node_key (nr=<optimized out>, disk_key=0x7fffffffd630, eb=<optimized out>)
    at ./kernel-shared/ctree.h:2113
#4  btrfs_node_key_to_cpu (nr=<optimized out>, key=0x7fffffffd650, eb=<optimized out>) at ./kernel-shared/ctree.h:2113
#5  check_block (fs_info=0x555555651bc0, path=path@entry=0x7fffffffd760, level=level@entry=49) at kernel-shared/ctree.c:854
#6  0x0000555555577ecb in btrfs_del_items (trans=trans@entry=0x555555838ff0, root=root@entry=0x55555582c7b0, 
    path=path@entry=0x7fffffffd760, slot=40, nr=nr@entry=1) at kernel-shared/ctree.c:3163
#7  0x00005555555e18d1 in btrfs_del_item (path=0x7fffffffd760, root=0x55555582c7b0, trans=0x555555838ff0)
    at ./kernel-shared/ctree.h:2781
#8  delete_item (key=0x7fffffffd740, root=0x55555582c7b0) at cmds/rescue-init-extent-tree.c:208
#9  process_leaf_item (slot=<optimized out>, eb=0x0, root=0x55555582c7b0) at cmds/rescue-init-extent-tree.c:297
#10 look_for_bad_extents (root=root@entry=0x55555582c7b0, eb=eb@entry=0x555555834d90, current=current@entry=0x7fffffffda18)
    at cmds/rescue-init-extent-tree.c:338
#11 0x00005555555e1468 in look_for_bad_extents (root=root@entry=0x55555582c7b0, eb=0x5555557a4bb0, 
    current=current@entry=0x7fffffffda18) at cmds/rescue-init-extent-tree.c:331
#12 0x00005555555e1a66 in clear_bad_extents (root=0x55555582c7b0) at cmds/rescue-init-extent-tree.c:362
#13 0x00005555555e1262 in foreach_root (fs_info=fs_info@entry=0x555555651bc0, cb=cb@entry=0x5555555e1a21 <clear_bad_extents>)
    at cmds/rescue-init-extent-tree.c:152
#14 0x00005555555e2ffe in reinit_extent_tree (fs_info=0x555555651bc0) at cmds/rescue-init-extent-tree.c:873
#15 btrfs_init_extent_tree (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1") at cmds/rescue-init-extent-tree.c:1219
#16 0x00005555555d867e in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:139
#17 0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555647c80 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#18 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#19 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555648cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#20 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
