Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C153AC79
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 20:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356151AbiFASI3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 14:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiFASI2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 14:08:28 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD86C562
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 11:08:27 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwSld-0001Ul-La by authid <merlin>; Wed, 01 Jun 2022 11:08:25 -0700
Date:   Wed, 1 Jun 2022 11:08:25 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220601180824.GF22722@merlins.org>
References: <20220531224951.GC22722@merlins.org>
 <CAEzrpqcui3A42ogkas9pQfMqX0qE+MApPuiUw12uwpqhNq2RHg@mail.gmail.com>
 <20220601002552.GD22722@merlins.org>
 <CAEzrpqfkrD4aYA3vMToi+vfYeoyj=h4JAx+xnGQj836FP+pbjg@mail.gmail.com>
 <20220601012919.GE22722@merlins.org>
 <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
 <20220601031536.GD1745079@merlins.org>
 <CAEzrpqfw85GnLUq8=vywej1Gb6vjcgKUYucLw9DgoSaWEbyZbg@mail.gmail.com>
 <20220601163924.GE1745079@merlins.org>
 <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
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

On Wed, Jun 01, 2022 at 02:00:43PM -0400, Josef Bacik wrote:
> Ok perfect, now try btrfs rescue recover-chunks <device>, thanks,

(gdb) run rescue recover-chunks /dev/mapper/dshelf1
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue recover-chunks /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x55555564fbc0
Invalid mapping for 15645202989056-15645203005440, got 15664345513984-15665419255808
Couldn't map the block 15645202989056
Couldn't map the block 15645202989056
bad tree block 15645202989056, bytenr mismatch, want=15645202989056, have=0
Couldn't read tree root
FS_INFO AFTER IS 0x55555564fbc0
Walking all our trees and pinning down the currently accessible blocks

Program received signal SIGSEGV, Segmentation fault.
traverse_tree_blocks (tree=tree@entry=0x55555565a130, eb=0x0, tree_root=tree_root@entry=1) at common/repair.c:95
95              struct btrfs_fs_info *fs_info = eb->fs_info;
(gdb) bt
#0  traverse_tree_blocks (tree=tree@entry=0x55555565a130, eb=0x0, tree_root=tree_root@entry=1) at common/repair.c:95
#1  0x000055555559f6d4 in btrfs_mark_used_tree_blocks (fs_info=fs_info@entry=0x55555564fbc0, tree=tree@entry=0x55555565a130)
    at common/repair.c:188
#2  0x00005555555e2e18 in btrfs_find_recover_chunks (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1")
    at cmds/rescue-recover-chunks.c:262
#3  0x00005555555d7e81 in cmd_rescue_recover_chunks (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:65
#4  0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555645d40 <cmd_struct_rescue_recover_chunks>)
    at cmds/commands.h:125
#5  handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#6  0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555646cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#7  main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
