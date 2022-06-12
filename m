Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21144547B23
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jun 2022 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiFLRGM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jun 2022 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiFLRGL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jun 2022 13:06:11 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF953FBF6
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 10:06:09 -0700 (PDT)
Received: from [172.58.16.183] (port=43504 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o0QK0-0004bp-7K by authid <merlins.org> with srv_auth_plain; Sun, 12 Jun 2022 10:06:07 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o0R2L-00ASn1-MK; Sun, 12 Jun 2022 10:06:05 -0700
Date:   Sun, 12 Jun 2022 10:06:05 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220612170605.GI1664812@merlins.org>
References: <20220608213845.GH22722@merlins.org>
 <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220611001404.GM22722@merlins.org>
 <CAEzrpqda3=rDV8eLPsSDHbvmbyTnceecNkQUNA6mfOMmik=xDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqda3=rDV8eLPsSDHbvmbyTnceecNkQUNA6mfOMmik=xDw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 172.58.16.183
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 11, 2022 at 10:59:15AM -0400, Josef Bacik wrote:
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> > FS_INFO IS 0x559bd17b9bc0
> > Couldn't find the last root for 8
> > FS_INFO AFTER IS 0x559bd17b9bc0
> > Walking all our trees and pinning down the currently accessible blocks
> > Found missing chunk in super block 20971520-29360128 type 34
> > adding bg for 20971520 8388608
> > kernel-shared/extent-tree.c:2829: btrfs_add_block_group: BUG_ON `ret` triggered, value -17
> > ./btrfs(+0x29f27)[0x559bd01a8f27]
> > ./btrfs(btrfs_add_block_group+0x1e0)[0x559bd01ad700]
> > ./btrfs(btrfs_find_recover_chunks+0x4fe)[0x559bd020fc44]
> > ./btrfs(+0x848ce)[0x559bd02038ce]
> > ./btrfs(handle_command_group+0x49)[0x559bd019717b]
> > ./btrfs(main+0x94)[0x559bd0197275]
> > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7fe20f24a7fd]
> > ./btrfs(_start+0x2a)[0x559bd0196e1a]
> > Aborted
> 
> Oops, sorry about that, fixed it up.  My wife is travelling this week
> so I'm going to be a little slower than normal, but hopefully we're
> getting close to the end here.  Thanks,

No worries. Same?

gargamel:/var/local/src/btrfs-progs-josefbacik# git log | head -5
commit affc3bcd741ca350bbf340e757698281b149c9f3
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Sat Jun 11 10:58:21 2022 -0400

    deal with existing block groups
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
FS_INFO IS 0x561aa58a4bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x561aa58a4bc0
Walking all our trees and pinning down the currently accessible blocks
Found missing chunk in super block 20971520-29360128 type 34
adding bg for 20971520 8388608
kernel-shared/extent-tree.c:2829: btrfs_add_block_group: BUG_ON `ret` triggered, value -17
./btrfs(+0x29f27)[0x561aa569ef27]
./btrfs(btrfs_add_block_group+0x1e0)[0x561aa56a3700]
./btrfs(btrfs_find_recover_chunks+0x4fe)[0x561aa5705c44]
./btrfs(+0x848ce)[0x561aa56f98ce]
./btrfs(handle_command_group+0x49)[0x561aa568d17b]
./btrfs(main+0x94)[0x561aa568d275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f282855a7fd]
./btrfs(_start+0x2a)[0x561aa568ce1a]
Aborted
gargamel:/var/local/src/btrfs-progs-josefbacik# 
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
