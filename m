Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD82547072
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 02:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245496AbiFKAOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 20:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiFKAOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 20:14:09 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D4210E3
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 17:14:06 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nzolR-00006r-09 by authid <merlin>; Fri, 10 Jun 2022 17:14:05 -0700
Date:   Fri, 10 Jun 2022 17:14:04 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220611001404.GM22722@merlins.org>
References: <20220608213030.GG22722@merlins.org>
 <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org>
 <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
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

On Fri, Jun 10, 2022 at 03:55:09PM -0400, Josef Bacik wrote:
> Soooooo I've fixed my idiocy and moved the code around.  Unfortunately
> my last fix deleted the stripes from the sys array, so we need to get
> those back.  So once again run

Thanks for looking into this
 
> btrfs rescue recover-chunks <device>
> btrfs rescue init-extent-tree <device>
> btrfs check --repair <device>

Let's go for another round :)

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
FS_INFO IS 0x559bd17b9bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x559bd17b9bc0
Walking all our trees and pinning down the currently accessible blocks
Found missing chunk in super block 20971520-29360128 type 34
adding bg for 20971520 8388608
kernel-shared/extent-tree.c:2829: btrfs_add_block_group: BUG_ON `ret` triggered, value -17
./btrfs(+0x29f27)[0x559bd01a8f27]
./btrfs(btrfs_add_block_group+0x1e0)[0x559bd01ad700]
./btrfs(btrfs_find_recover_chunks+0x4fe)[0x559bd020fc44]
./btrfs(+0x848ce)[0x559bd02038ce]
./btrfs(handle_command_group+0x49)[0x559bd019717b]
./btrfs(main+0x94)[0x559bd0197275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7fe20f24a7fd]
./btrfs(_start+0x2a)[0x559bd0196e1a]
Aborted

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
