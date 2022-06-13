Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FCC54A2ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 01:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiFMXwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 19:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiFMXwp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 19:52:45 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B49BE07
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 16:52:42 -0700 (PDT)
Received: from [76.132.34.178] (port=59304 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o0t91-0007yG-6i by authid <merlins.org> with srv_auth_plain; Mon, 13 Jun 2022 16:52:42 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o0trO-00CkmG-81; Mon, 13 Jun 2022 16:52:42 -0700
Date:   Mon, 13 Jun 2022 16:52:42 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220613235242.GR1664812@merlins.org>
References: <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org>
 <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220613204647.GO22722@merlins.org>
 <CAEzrpqdRiG9_O=JTy2LOtp4m470hMj1Ev-bk6RE_ArdRKauLGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdRiG9_O=JTy2LOtp4m470hMj1Ev-bk6RE_ArdRKauLGQ@mail.gmail.com>
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

On Mon, Jun 13, 2022 at 06:19:05PM -0400, Josef Bacik wrote:
> Hmm that's not good, I've pushed a patch to see if what I think is
> happening is actually happening.  Thanks,

Same?

(gdb) run rescue init-csum-tree /dev/mapper/dshelf1
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-csum-tree /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x555555652bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x555555652bc0
processed 0 of 21907435520 possible data bytes, 0%
Program received signal SIGSEGV, Segmentation fault.
record_csums_eb (eb=0x5555556f1890, processed=processed@entry=0x7fffffffdbe8) at ./kernel-shared/ctree.h:1762
1762    BTRFS_SETGET_FUNCS(inode_flags, struct btrfs_inode_item, flags, 64);
(gdb) bt
#0  record_csums_eb (eb=0x5555556f1890, processed=processed@entry=0x7fffffffdbe8) at ./kernel-shared/ctree.h:1762
#1  0x00005555555e394b in record_csums (root=root@entry=0x5555556f15d0, processed=processed@entry=0x7fffffffdbe8) at cmds/rescue-init-csum-tree.c:299
#2  0x00005555555e3f54 in foreach_root (cb=0x5555555e393f <record_csums>, fs_info=0x555555652bc0) at cmds/rescue-init-csum-tree.c:345
#3  btrfs_init_csum_tree (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1") at cmds/rescue-init-csum-tree.c:415
#4  0x00005555555d88b1 in cmd_rescue_init_csum_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>) at cmds/rescue.c:102
#5  0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555648ce0 <cmd_struct_rescue_init_csum_tree>) at cmds/commands.h:125
#6  handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#7  0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555649cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#8  main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405
(gdb) quit
A debugging session is active.

        Inferior 1 [process 30169] will be killed.

Quit anyway? (y or n) y
gargamel:/var/local/src/btrfs-progs-josefbacik# git pull
Current branch for-marc is up to date.

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
