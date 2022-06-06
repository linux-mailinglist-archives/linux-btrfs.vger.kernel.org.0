Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A0253F1DF
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiFFVuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 17:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiFFVuP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 17:50:15 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0033E0FA
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 14:50:14 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyKc1-0000VO-Gz by authid <merlin>; Mon, 06 Jun 2022 14:50:13 -0700
Date:   Mon, 6 Jun 2022 14:50:13 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220606215013.GN22722@merlins.org>
References: <20220605215036.GE22722@merlins.org>
 <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
 <20220606000548.GF22722@merlins.org>
 <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
 <20220606012204.GP1745079@merlins.org>
 <CAEzrpqeOb4XnGxbeMXNcDHn+wMNC7sBS7eFdsTbUj8c7BUgcuA@mail.gmail.com>
 <20220606210855.GL22722@merlins.org>
 <CAEzrpqe1_vbZ=+3C5=YPDJOCJGLAX9e4cmO_a+F1P3sdg9ubwQ@mail.gmail.com>
 <20220606212301.GM22722@merlins.org>
 <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
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

On Mon, Jun 06, 2022 at 05:39:45PM -0400, Josef Bacik wrote:
> On Mon, Jun 6, 2022 at 5:23 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Mon, Jun 06, 2022 at 05:19:40PM -0400, Josef Bacik wrote:
> > > Nope different spot, I added some more printf's to narrow down which
> > > path is messing up the key order.  Thanks,
> >
> > processed 49152 of 49463296 possible bytes, 0%
> > searching 164623 for bad extents
> > processed 311296 of 63193088 possible bytes, 0%
> > searching 164624 for bad extents
> >
> > Found an extent we don't have a block group for in the file
> > file
> > push node left from right mid nritems 48 right nritems 0
> > setting parent slot 0 to [256 1 0]
> > corrupt node: root=164624 root bytenr 15645019684864 commit bytenr 15645019602944 block=15645019717632 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> 
> Hmm, this sounds like we're not adjusting nritems, but the code
> definitely is, so I'm sort of nervous about what's going to be
> uncovered here.  Added some more information,

processed 49152 of 49463296 possible bytes, 0%
searching 164623 for bad extents
processed 311296 of 63193088 possible bytes, 0%
searching 164624 for bad extents

Found an extent we don't have a block group for in the file
file
push node left from right mid nritems 48 right nritems 0 parent 15645019684864 parent nritems 7
parent nritems is now 6
corrupt node: root=164624 root bytenr 15645019684864 commit bytenr 15645019602944 block=15645019717632 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
kernel-shared/ctree.c:1042: balance_level: BUG_ON `check_path(path)` triggered, value -5
./btrfs(+0x1cf51)[0x557f0d136f51]
./btrfs(btrfs_search_slot+0x102a)[0x557f0d13c86d]
./btrfs(+0x8cc50)[0x557f0d1a6c50]
./btrfs(+0x8c97f)[0x557f0d1a697f]
./btrfs(+0x8c97f)[0x557f0d1a697f]
./btrfs(+0x8cf6e)[0x557f0d1a6f6e]
./btrfs(+0x8c779)[0x557f0d1a6779]
./btrfs(btrfs_init_extent_tree+0xc83)[0x557f0d1a8506]
./btrfs(+0x84518)[0x557f0d19e518]
./btrfs(handle_command_group+0x49)[0x557f0d13217b]
./btrfs(main+0x94)[0x557f0d132275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f54f44bb7fd]
./btrfs(_start+0x2a)[0x557f0d131e1a]
Aborted

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
