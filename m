Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1586353F1A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 23:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiFFVXQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbiFFVXH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 17:23:07 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC7CC5E5E
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 14:23:02 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyKBh-0000Wu-VT by authid <merlin>; Mon, 06 Jun 2022 14:23:01 -0700
Date:   Mon, 6 Jun 2022 14:23:01 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220606212301.GM22722@merlins.org>
References: <20220605212637.GO1745079@merlins.org>
 <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
 <20220605215036.GE22722@merlins.org>
 <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
 <20220606000548.GF22722@merlins.org>
 <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
 <20220606012204.GP1745079@merlins.org>
 <CAEzrpqeOb4XnGxbeMXNcDHn+wMNC7sBS7eFdsTbUj8c7BUgcuA@mail.gmail.com>
 <20220606210855.GL22722@merlins.org>
 <CAEzrpqe1_vbZ=+3C5=YPDJOCJGLAX9e4cmO_a+F1P3sdg9ubwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqe1_vbZ=+3C5=YPDJOCJGLAX9e4cmO_a+F1P3sdg9ubwQ@mail.gmail.com>
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

On Mon, Jun 06, 2022 at 05:19:40PM -0400, Josef Bacik wrote:
> Nope different spot, I added some more printf's to narrow down which
> path is messing up the key order.  Thanks,

processed 49152 of 49463296 possible bytes, 0%
searching 164623 for bad extents
processed 311296 of 63193088 possible bytes, 0%
searching 164624 for bad extents

Found an extent we don't have a block group for in the file
Flying/Flying Wild Alaska/Flying Wild Alaska - 02x04  Era Alaska Rises Again - 624x352 - 1012kbps - xvid.avi
push node left from right mid nritems 48 right nritems 0
setting parent slot 0 to [256 1 0]
corrupt node: root=164624 root bytenr 15645019684864 commit bytenr 15645019602944 block=15645019717632 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
kernel-shared/ctree.c:1110: balance_level: BUG_ON `check_path(path)` triggered, value -5
./btrfs(+0x1cf51)[0x557391728f51]
./btrfs(btrfs_search_slot+0x12bc)[0x55739172eaff]
./btrfs(+0x8cb9c)[0x557391798b9c]
./btrfs(+0x8c8cb)[0x5573917988cb]
./btrfs(+0x8c8cb)[0x5573917988cb]
./btrfs(+0x8ceba)[0x557391798eba]
./btrfs(+0x8c6c5)[0x5573917986c5]
./btrfs(btrfs_init_extent_tree+0xc83)[0x55739179a452]
./btrfs(+0x84464)[0x557391790464]
./btrfs(handle_command_group+0x49)[0x55739172417b]
./btrfs(main+0x94)[0x557391724275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f669efba7fd]
./btrfs(_start+0x2a)[0x557391723e1a]
Aborted

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
