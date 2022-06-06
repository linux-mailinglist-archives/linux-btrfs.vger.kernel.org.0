Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6EF53F169
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 23:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiFFVJZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 17:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiFFVJE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 17:09:04 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17C318C
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 14:08:55 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyJy3-0006sx-71 by authid <merlin>; Mon, 06 Jun 2022 14:08:55 -0700
Date:   Mon, 6 Jun 2022 14:08:55 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220606210855.GL22722@merlins.org>
References: <20220605201112.GN1745079@merlins.org>
 <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
 <20220605212637.GO1745079@merlins.org>
 <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
 <20220605215036.GE22722@merlins.org>
 <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
 <20220606000548.GF22722@merlins.org>
 <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
 <20220606012204.GP1745079@merlins.org>
 <CAEzrpqeOb4XnGxbeMXNcDHn+wMNC7sBS7eFdsTbUj8c7BUgcuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqeOb4XnGxbeMXNcDHn+wMNC7sBS7eFdsTbUj8c7BUgcuA@mail.gmail.com>
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

On Mon, Jun 06, 2022 at 04:42:30PM -0400, Josef Bacik wrote:
> On Sun, Jun 5, 2022 at 9:22 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, Jun 05, 2022 at 09:11:28PM -0400, Josef Bacik wrote:
> > > On Sun, Jun 5, 2022 at 8:05 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > On Sun, Jun 05, 2022 at 07:03:31PM -0400, Josef Bacik wrote:
> > > > > I wonder if our delete thing is corrupting stuff.  Can you re-run
> > > > > tree-recover, and then once that's done run init-extent-tree?  I put
> > > > > some stuff to check block all the time to see if we're introducing the
> > > > > problem.  Thanks,
> > > >
> > > >
> > > >
> > > > gargamel:/var/local/src/btrfs-progs-josefbacik# gdb./btrfs rescue tree-recover /dev/mapper/dshelf1
> > >
> > > Ok more targeted debugging to figure out where the problem is coming
> > > from specifically, but hooray I was right.  Thanks,
> >
> > searching 164623 for bad extents
> > processed 311296 of 63193088 possible bytes, 0%
> > searching 164624 for bad extents
> >
> > Found an extent we don't have a block group for in the file
> > file
> > corrupt node: root=164624 root bytenr 15645019570176 commit bytenr 15645019602944 block=15645019586560 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> > corrupt node: root=164624 root bytenr 15645019570176 commit bytenr 15645019602944 block=15645019586560 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> > cmds/rescue-init-extent-tree.c:197: delete_item: BUG_ON `check_path(&path)` triggered, value -5
> 
> Cool, must be in balance, lets try this again.  Thanks,

Same?

inserting block group 15930633486336
inserting block group 15931707228160
inserting block group 15932780969984
inserting block group 15933854711808
ERROR: Error reading data reloc tree -2

ERROR: failed to reinit the data reloc root
searching 1 for bad extents
processed 999424 of 0 possible bytes, 0%
searching 4 for bad extents
processed 163840 of 1064960 possible bytes, 15%
searching 5 for bad extents
processed 65536 of 10960896 possible bytes, 0%
searching 7 for bad extents
processed 16384 of 16570974208 possible bytes, 0%
searching 9 for bad extents
processed 16384 of 16384 possible bytes, 100%
searching 161197 for bad extents
processed 131072 of 108986368 possible bytes, 0%
searching 161199 for bad extents
processed 196608 of 49479680 possible bytes, 0%
searching 161200 for bad extents
processed 180224 of 254214144 possible bytes, 0%
searching 161889 for bad extents
processed 229376 of 49446912 possible bytes, 0%
searching 162628 for bad extents
processed 49152 of 49463296 possible bytes, 0%
searching 162632 for bad extents
processed 147456 of 94633984 possible bytes, 0%
searching 163298 for bad extents
processed 49152 of 49463296 possible bytes, 0%
searching 163302 for bad extents
processed 147456 of 94633984 possible bytes, 0%
searching 163303 for bad extents
processed 131072 of 76333056 possible bytes, 0%
searching 163316 for bad extents
processed 147456 of 108544000 possible bytes, 0%
searching 163920 for bad extents
processed 16384 of 108691456 possible bytes, 0%
searching 164620 for bad extents
processed 49152 of 49463296 possible bytes, 0%
searching 164623 for bad extents
processed 311296 of 63193088 possible bytes, 0%
searching 164624 for bad extents

Found an extent we don't have a block group for in the file
file
corrupt node: root=164624 root bytenr 15645019684864 commit bytenr 15645019602944 block=15645019717632 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
kernel-shared/ctree.c:1100: balance_level: BUG_ON `check_path(path)` triggered, value -5
./btrfs(+0x1cf51)[0x564087a36f51]
./btrfs(btrfs_search_slot+0x11cd)[0x564087a3ca10]
./btrfs(+0x8caa5)[0x564087aa6aa5]
./btrfs(+0x8c7d4)[0x564087aa67d4]
./btrfs(+0x8c7d4)[0x564087aa67d4]
./btrfs(+0x8cdc3)[0x564087aa6dc3]
./btrfs(+0x8c5ce)[0x564087aa65ce]
./btrfs(btrfs_init_extent_tree+0xc83)[0x564087aa835b]
./btrfs(+0x8436d)[0x564087a9e36d]
./btrfs(handle_command_group+0x49)[0x564087a3217b]
./btrfs(main+0x94)[0x564087a32275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7fb85b01c7fd]
./btrfs(_start+0x2a)[0x564087a31e1a]
Aborted

gargamel:/var/local/src/btrfs-progs-josefbacik# git pull
Already up-to-date.

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
