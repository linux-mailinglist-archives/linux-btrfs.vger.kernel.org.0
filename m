Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F553DE64
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jun 2022 23:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347782AbiFEV0u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jun 2022 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbiFEV0r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jun 2022 17:26:47 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBF34D601
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jun 2022 14:26:46 -0700 (PDT)
Received: from [76.132.34.178] (port=59200 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nxx3G-0007sW-LQ by authid <merlins.org> with srv_auth_plain; Sun, 05 Jun 2022 14:26:44 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nxxld-00FrOI-FX; Sun, 05 Jun 2022 14:26:37 -0700
Date:   Sun, 5 Jun 2022 14:26:37 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220605212637.GO1745079@merlins.org>
References: <20220603170700.GX22722@merlins.org>
 <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com>
 <20220603183927.GZ22722@merlins.org>
 <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
 <20220604134823.GB22722@merlins.org>
 <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
 <20220605001349.GJ1745079@merlins.org>
 <CAEzrpqfjDL=GtAn9cHQ2cOPMVZeNnuaQBLq6K-X-tGaipaAouA@mail.gmail.com>
 <20220605201112.GN1745079@merlins.org>
 <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 76.132.34.178
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 05, 2022 at 04:58:15PM -0400, Josef Bacik wrote:
> 
> Sigh try again please.  Thanks,

Same

FS_INFO IS 0x555555650bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x555555650bc0
Walking all our trees and pinning down the currently accessible blocks

Program received signal SIGSEGV, Segmentation fault.
generic_err (buf=buf@entry=0x5555557a3bb0, slot=slot@entry=38, 
    fmt=fmt@entry=0x55555560be80 "bad key order, current (%llu %u %llu) next (%llu %u %llu)") at kernel-shared/ctree.c:605
605                             start = root->node ? root->node->start : 0;
(gdb) bt
#0  generic_err (buf=buf@entry=0x5555557a3bb0, slot=slot@entry=38, 
    fmt=fmt@entry=0x55555560be80 "bad key order, current (%llu %u %llu) next (%llu %u %llu)") at kernel-shared/ctree.c:605
#1  0x0000555555573065 in btrfs_check_node (fs_info=fs_info@entry=0x555555650bc0, parent_key=parent_key@entry=0x0, 
    node=node@entry=0x5555557a3bb0) at kernel-shared/ctree.c:673
#2  0x000055555557c102 in read_tree_block (fs_info=fs_info@entry=0x555555650bc0, bytenr=<optimized out>, 
    parent_transid=parent_transid@entry=0) at kernel-shared/disk-io.c:403
#3  0x000055555559f575 in traverse_tree_blocks (tree=tree@entry=0x555555701690, eb=eb@entry=0x55555579fb30, 
    tree_root=tree_root@entry=0) at common/repair.c:166
#4  0x000055555559f4f1 in traverse_tree_blocks (tree=tree@entry=0x555555701690, eb=eb@entry=0x5555557938f0, 
    tree_root=tree_root@entry=1) at common/repair.c:146
#5  0x000055555559f5dc in traverse_tree_blocks (tree=tree@entry=0x555555701690, eb=0x5555556a2be0, tree_root=tree_root@entry=1)
    at common/repair.c:171
#6  0x000055555559f80c in btrfs_mark_used_tree_blocks (fs_info=fs_info@entry=0x555555650bc0, tree=tree@entry=0x555555701690, 
    chunk_only=chunk_only@entry=false) at common/repair.c:189
#7  0x00005555555e1214 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1")
    at cmds/rescue-init-extent-tree.c:1211
#8  0x00005555555d7edb in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
    at cmds/rescue.c:139
#9  0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555646c80 <cmd_struct_rescue_init_extent_tree>)
    at cmds/commands.h:125
#10 handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#11 0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555647cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#12 main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
