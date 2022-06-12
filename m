Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54E547C62
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jun 2022 23:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiFLVTe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jun 2022 17:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiFLVTH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jun 2022 17:19:07 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583332DE
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 14:19:06 -0700 (PDT)
Received: from [172.58.17.232] (port=35913 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o0UGo-0006jm-Pc by authid <merlins.org> with srv_auth_plain; Sun, 12 Jun 2022 14:19:06 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o0UzA-00AmDg-H1; Sun, 12 Jun 2022 14:19:04 -0700
Date:   Sun, 12 Jun 2022 14:19:04 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220612211904.GK1664812@merlins.org>
References: <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220611001404.GM22722@merlins.org>
 <CAEzrpqda3=rDV8eLPsSDHbvmbyTnceecNkQUNA6mfOMmik=xDw@mail.gmail.com>
 <20220612170605.GI1664812@merlins.org>
 <CAEzrpqf=i064fiZpnbnTL+R7TS5cGa0QO1HXs-9KbRji1buu+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqf=i064fiZpnbnTL+R7TS5cGa0QO1HXs-9KbRji1buu+A@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 172.58.17.232
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 12, 2022 at 04:05:22PM -0400, Josef Bacik wrote:
> Yeah I missed we were BUG_ON(ret), so my change does the right thing
> if we get a failure, but I needed to update the core code to return
> the error.  Should work this time, thanks,


(gdb) run rescue recover-chunks /dev/mapper/dshelf1
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue recover-chunks /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x555555652bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x555555652bc0
Walking all our trees and pinning down the currently accessible blocks
Found missing chunk in super block 20971520-29360128 type 34
adding bg for 20971520 8388608

Program received signal SIGSEGV, Segmentation fault.
setup_free_space (fs_info=0x555555652bc0) at cmds/rescue-recover-chunks.c:500
500                     bg->cached = 1;
(gdb) bt
#0  setup_free_space (fs_info=0x555555652bc0) at cmds/rescue-recover-chunks.c:500
#1  btrfs_find_recover_chunks (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1") at cmds/rescue-recover-chunks.c:581
#2  0x00005555555d87d5 in cmd_rescue_recover_chunks (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>) at cmds/rescue.c:65
#3  0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555648d40 <cmd_struct_rescue_recover_chunks>) at cmds/commands.h:125
#4  handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
#5  0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555649cc0 <cmd_struct_rescue>) at cmds/commands.h:125
#6  main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
