Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85C053DF4A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 03:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348949AbiFFBWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jun 2022 21:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348931AbiFFBWJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jun 2022 21:22:09 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D0FEA0
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jun 2022 18:22:06 -0700 (PDT)
Received: from [76.132.34.178] (port=59202 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1ny0j7-00023H-2x by authid <merlins.org> with srv_auth_plain; Sun, 05 Jun 2022 18:22:04 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1ny1RU-00GBAz-4c; Sun, 05 Jun 2022 18:22:04 -0700
Date:   Sun, 5 Jun 2022 18:22:04 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220606012204.GP1745079@merlins.org>
References: <20220605001349.GJ1745079@merlins.org>
 <CAEzrpqfjDL=GtAn9cHQ2cOPMVZeNnuaQBLq6K-X-tGaipaAouA@mail.gmail.com>
 <20220605201112.GN1745079@merlins.org>
 <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
 <20220605212637.GO1745079@merlins.org>
 <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
 <20220605215036.GE22722@merlins.org>
 <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
 <20220606000548.GF22722@merlins.org>
 <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
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

On Sun, Jun 05, 2022 at 09:11:28PM -0400, Josef Bacik wrote:
> On Sun, Jun 5, 2022 at 8:05 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, Jun 05, 2022 at 07:03:31PM -0400, Josef Bacik wrote:
> > > I wonder if our delete thing is corrupting stuff.  Can you re-run
> > > tree-recover, and then once that's done run init-extent-tree?  I put
> > > some stuff to check block all the time to see if we're introducing the
> > > problem.  Thanks,
> >
> >
> >
> > gargamel:/var/local/src/btrfs-progs-josefbacik# gdb./btrfs rescue tree-recover /dev/mapper/dshelf1
> 
> Ok more targeted debugging to figure out where the problem is coming
> from specifically, but hooray I was right.  Thanks,

searching 164623 for bad extents
processed 311296 of 63193088 possible bytes, 0%
searching 164624 for bad extents

Found an extent we don't have a block group for in the file
file
corrupt node: root=164624 root bytenr 15645019570176 commit bytenr 15645019602944 block=15645019586560 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 root bytenr 15645019570176 commit bytenr 15645019602944 block=15645019586560 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
cmds/rescue-init-extent-tree.c:197: delete_item: BUG_ON `check_path(&path)` triggered, value -5
./btrfs(+0x8cb28)[0x556144725b28]
./btrfs(+0x8c63d)[0x55614472563d]
./btrfs(+0x8c63d)[0x55614472563d]
./btrfs(+0x8cc2c)[0x556144725c2c]
./btrfs(+0x8c437)[0x556144725437]
./btrfs(btrfs_init_extent_tree+0xc83)[0x5561447271c4]
./btrfs(+0x841d6)[0x55614471d1d6]
./btrfs(handle_command_group+0x49)[0x5561446b117b]
./btrfs(main+0x94)[0x5561446b1275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7fea50bb37fd]
./btrfs(_start+0x2a)[0x5561446b0e1a]
Aborted

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
