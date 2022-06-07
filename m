Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA69F5401D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbiFGOxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244753AbiFGOxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 10:53:50 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B164BEA
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 07:53:48 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyaaZ-00076R-Sl by authid <merlin>; Tue, 07 Jun 2022 07:53:47 -0700
Date:   Tue, 7 Jun 2022 07:53:47 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220607145347.GU22722@merlins.org>
References: <20220606212301.GM22722@merlins.org>
 <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
 <20220606215013.GN22722@merlins.org>
 <CAEzrpqcn_BRL7p3gPmS5OVn5D-m8hMB-5JcAHwEHwKpxGxOMqw@mail.gmail.com>
 <20220606221755.GO22722@merlins.org>
 <CAEzrpqcr08tHCesiwS9ysxrRQaadAeHyjSTg3Qp+CorvGz6psQ@mail.gmail.com>
 <20220607023740.GQ22722@merlins.org>
 <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
 <20220607032240.GS22722@merlins.org>
 <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
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

On Tue, Jun 07, 2022 at 10:51:35AM -0400, Josef Bacik wrote:
> Hmm weird, I think I spotted it, give it a try again please.  Thanks,

scanning, best has 0 found 0 bad
checking block 15645485137920 generation 1601075 fs info generation 2588170
trying bytenr 15645485137920 got 99 blocks 1 bad
scan for best root 164629 wants to use 15645485137920 as the root bytenr
Repairing root 164629 bad_blocks 1 update 1
we're pointing at an empty node, delete slot 2 in block 15645485137920
kernel-shared/extent_io.c:664: free_extent_buffer_internal: BUG_ON `eb->refs < 0` triggered, value 1
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x311a0)[0x5555555851a0]
/var/local/src/btrfs-progs-josefbacik/btrfs(free_extent_buffer_nocache+0xe)[0x555555585a63]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8bb02)[0x5555555dfb02]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8c1ac)[0x5555555e01ac]
/var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_recover_trees+0x446)[0x5555555e0c4d]
/var/local/src/btrfs-progs-josefbacik/btrfs(+0x8475a)[0x5555555d875a]
/var/local/src/btrfs-progs-josefbacik/btrfs(handle_command_group+0x49)[0x55555556c17b]
/var/local/src/btrfs-progs-josefbacik/btrfs(main+0x94)[0x55555556c275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7ffff78617fd]
/var/local/src/btrfs-progs-josefbacik/btrfs(_start+0x2a)[0x55555556be1a]

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
