Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433A9539A5A
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 02:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbiFAAZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 20:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiFAAZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 20:25:54 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF7A5BE63
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 17:25:52 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwCBM-0005sj-9Z by authid <merlin>; Tue, 31 May 2022 17:25:52 -0700
Date:   Tue, 31 May 2022 17:25:52 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220601002552.GD22722@merlins.org>
References: <20220529200415.GI24951@merlins.org>
 <CAEzrpqdpvnbzaH1gxWnvWLMWEKtOAdYsH25mBWhkF-urf7Zw3g@mail.gmail.com>
 <20220530003701.GJ24951@merlins.org>
 <CAEzrpqcPirk3AOi1vy+N_V3VY49mvUCiwYL4A_0XoT_jxjgOrg@mail.gmail.com>
 <20220530191834.GK24951@merlins.org>
 <CAEzrpqdRV8nYFshj85Cahj4VMQ+F0n6WOQ6Y8g7=Kq7X_1xMgw@mail.gmail.com>
 <20220531011224.GA1745079@merlins.org>
 <CAEzrpqco_RyUBK=dngrv54u8WE2uhSGrJaB9aRY5nUmKNzN32Q@mail.gmail.com>
 <20220531224951.GC22722@merlins.org>
 <CAEzrpqcui3A42ogkas9pQfMqX0qE+MApPuiUw12uwpqhNq2RHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcui3A42ogkas9pQfMqX0qE+MApPuiUw12uwpqhNq2RHg@mail.gmail.com>
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

On Tue, May 31, 2022 at 08:14:27PM -0400, Josef Bacik wrote:
> Wtf, we're clearly writing the chunk root properly because I have to
> re-open it to recover the tree root, and that's where it fails, but
> then the chunk restore can't open the root, despite it being correctly
> read in the tree recover.  I've pushed new code, try tree-recover and
> then recover-chunks again and capture the output please.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
Csum didn't match
ERROR: cannot read chunk root 21135360
WTF???
ERROR: open ctree failed, try btrfs rescue tree-recover
Recover chunks tree failed
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
WARNING: cannot read chunk root, continue anyway
none of our backups was sufficient, scanning for a root
scanning, best has 0 found 1 bad
ret is 0 offset 20971520 len 8388608
ret is -2 offset 20971520 len 8388608
checking block 22495232 generation 1572124 fs info generation 2582703
trying bytenr 22495232 got 1 blocks 0 bad
checking block 22462464 generation 1479229 fs info generation 2582703
trying bytenr 22462464 got 1 blocks 0 bad
checking block 22528000 generation 1572115 fs info generation 2582703
trying bytenr 22528000 got 1 blocks 0 bad
checking block 22446080 generation 1571791 fs info generation 2582703
trying bytenr 22446080 got 1 blocks 0 bad
checking block 22544384 generation 1556078 fs info generation 2582703
trying bytenr 22544384 got 1 blocks 0 bad
checking block 22511616 generation 1555799 fs info generation 2582703
trying bytenr 22511616 got 1 blocks 0 bad
checking block 22577152 generation 1586277 fs info generation 2582703
trying bytenr 22577152 got 1 blocks 0 bad
checking block 22478848 generation 1561557 fs info generation 2582703
trying bytenr 22478848 got 1 blocks 0 bad
checking block 22593536 generation 1590219 fs info generation 2582703
trying bytenr 22593536 got 1 blocks 0 bad
checking block 22609920 generation 1551635 fs info generation 2582703
trying bytenr 22609920 got 1 blocks 0 bad
checking block 22560768 generation 1590217 fs info generation 2582703
trying bytenr 22560768 got 1 blocks 0 bad
No mapping for 15645202989056-15645203005440
Couldn't map the block 15645202989056
Couldn't map the block 15645202989056
No mapping for 15645202907136-15645202923520
Couldn't map the block 15645202907136
Couldn't map the block 15645202907136
No mapping for 15645202989056-15645203005440
Couldn't map the block 15645202989056
Couldn't map the block 15645202989056
No mapping for 15645202989056-15645203005440
Couldn't map the block 15645202989056
Couldn't map the block 15645202989056
No mapping for 15645202907136-15645202923520
Couldn't map the block 15645202907136
Couldn't map the block 15645202907136
none of our backups was sufficient, scanning for a root
scanning, best has 0 found 1 bad
ERROR: Couldn't find a valid root block for 1, we're going to clear it and hope for the best
Tree recover failed
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
Csum didn't match
ERROR: cannot read chunk root 21135360
WTF???
ERROR: open ctree failed, try btrfs rescue tree-recover
Recover chunks tree failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
