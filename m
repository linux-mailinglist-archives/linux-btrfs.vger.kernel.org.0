Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6BA5129B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 05:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbiD1DDT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 23:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiD1DDS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 23:03:18 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6F715820
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 20:00:03 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58298 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1njuNu-0007lJ-BK by authid <merlins.org> with srv_auth_plain; Wed, 27 Apr 2022 20:00:02 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1njuNu-007AQa-5F; Wed, 27 Apr 2022 20:00:02 -0700
Date:   Wed, 27 Apr 2022 20:00:02 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220428030002.GB12542@merlins.org>
References: <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
 <20220427210246.GV12542@merlins.org>
 <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
 <20220427212023.GW12542@merlins.org>
 <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
 <20220427225942.GX12542@merlins.org>
 <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
 <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
 <20220428001822.GZ12542@merlins.org>
 <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 08:44:01PM -0400, Josef Bacik wrote:
> Ok it should work now.  Thanks,

Mmmh, it got worse, unfortunately

(gdb) run rescue init-extent-tree /dev/mapper/dshelf1 
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x55555564cbc0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55555564cbc0
Walking all our trees and pinning down the currently accessible blocks
Clearing the extent root and re-init'ing the block groups

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff78e1f46 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
(gdb) bt
#0  0x00007ffff78e1f46 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x0000555555585950 in memmove (__len=<optimized out>, __src=<optimized out>, __dest=<optimized out>)
    at /usr/include/x86_64-linux-gnu/bits/string_fortified.h:36
#2  memmove_extent_buffer (dst=dst@entry=0x555555b57f60, dst_offset=<optimized out>, src_offset=<optimized out>, len=<optimized out>)
    at kernel-shared/extent_io.c:1021
#3  0x000055555557753b in btrfs_del_items (trans=trans@entry=0x555558a8d460, root=root@entry=0x55555564cde0, 
    path=path@entry=0x7fffffffdc50, slot=slot@entry=36, nr=nr@entry=1) at ./kernel-shared/ctree.h:2387
#4  0x00005555555e0627 in clear_space_cache (block_group=<optimized out>, trans=0x555558a8d460) at cmds/rescue-init-extent-tree.c:116
#5  reset_block_groups (trans=0x555558a8d460) at cmds/rescue-init-extent-tree.c:307
#6  reinit_extent_tree (fs_info=0x7fffffffdc50) at cmds/rescue-init-extent-tree.c:451
#7  btrfs_init_extent_tree (path=path@entry=0x7fffffffe1cd "/dev/mapper/dshelf1") at cmds/rescue-init-extent-tree.c:922
#8  0x00005555555d7a43 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#9  0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555642d40 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#10 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#11 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555643cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#12 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
