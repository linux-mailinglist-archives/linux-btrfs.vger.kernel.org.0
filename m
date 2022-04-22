Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C850C151
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 00:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiDVV62 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 17:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiDVV52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 17:57:28 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE342B0E38
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 13:41:02 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:41094 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nhyKa-0006oc-Hu by authid <merlins.org> with srv_auth_plain; Fri, 22 Apr 2022 11:48:36 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nhyKo-002fPk-FC; Fri, 22 Apr 2022 11:48:50 -0700
Date:   Fri, 22 Apr 2022 11:48:50 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220422184850.GX13115@merlins.org>
References: <20220405195901.GC28707@merlins.org>
 <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org>
 <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org>
 <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org>
 <20220406040913.GE3307770@merlins.org>
 <Yk3W88Eyh0pSm9mQ@hungrycats.org>
 <20220406191317.GC14804@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406191317.GC14804@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Back on list, Josef made a lot of changes to btrfs-progs for me (thanks
Josef)

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x55c6d219bbc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55c6d219bbc0
Checking root 2
Checking root 4
Checking root 5
Checking root 7
Checking root 9
Checking root 11221
Checking root 11222
Checking root 11223

After that ./btrfs check --init-extent-tree /dev/mapper/dshelf1 has been
running more for than 48H now

Starting repair.
Opening filesystem to check...
checksum verify failed on 15645878108160 found 00000027 wanted 0000001B
checksum verify failed on 11821979287552 found 000000A9 wanted FFFFFFFB
checksum verify failed on 11822142046208 found 000000AC wanted FFFFFFC4
(...)
checksum verify failed on 13577821011968 wanted 0x9a29aff5 found 0x2cdff391
checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
Failed to find [13576823668736, 168, 16384]
btrfs unable to find ref byte nr 13577801809920 parent 0 root 1  owner 0 offset 0
path->slots[0]: 134 path->nodes[0]:
leaf 49709056 items 169 free space 7975 generation 1602090 owner EXTENT_TREE
leaf 49709056 flags 0x0() backref revision 1
fs uuid 96539b8c-ccc9-47bf-9e6c-29305890941e
chunk uuid 7257b24b-3702-41e5-8b61-6f6ea524255a
        item 0 key (13400696422400 BLOCK_GROUP_ITEM 1073741824) itemoff 16259 itemsize 24
                block group used 0 chunk_objectid 256 flags DATA|single
        item 1 key (13401770164224 BLOCK_GROUP_ITEM 1073741824) itemoff 16235 itemsize 24
                block group used 0 chunk_objectid 256 flags DATA|single
(...)
Chunk[256, 228, 15365845286912] stripe[1, 14785462665216] is not found in dev extent
Chunk[256, 228, 15366919028736] stripe[1, 14786536407040] is not found in dev extent
Device extent[1, 11503033909248, 1073741824] didn't find the relative chunk.
Device extent[1, 11595375706112, 1073741824] didn't find the relative chunk.
Device extent[1, 11596449447936, 1073741824] didn't find the relative chunk.
Device extent[1, 11597523189760, 1073741824] didn't find the relative chunk.
Device extent[1, 11598596931584, 1073741824] didn't find the relative chunk.
(...)
Device extent[1, 11422503272448, 1073741824] didn't find the relative chunk.
Device extent[1, 10616123162624, 1073741824] didn't find the relative chunk.
ref mismatch on [12582912 4096] extent item 0, found 1
data backref 12582912 root 11223 owner 260 offset 131072 num_refs 0 not found in extent tree
incorrect local backref count on 12582912 root 11223 owner 260 offset 131072 found 1 wanted 0 back 0x5604b40697a0
backpointer mismatch on [12582912 4096]
adding new data backref on 12582912 root 11223 owner 260 offset 131072 found 1
Repaired extent references for 12582912
ref mismatch on [12587008 4096] extent item 0, found 1
data backref 12587008 root 11223 owner 261 offset 20480 num_refs 0 not found in extent tree
incorrect local backref count on 12587008 root 11223 owner 261 offset 20480 found 1 wanted 0 back 0x5604b4069a00
backpointer mismatch on [12587008 4096]
adding new data backref on 12587008 root 11223 owner 261 offset 20480 found 1
Repaired extent references for 12587008
ref mismatch on [12591104 4096] extent item 0, found 1
(...)
incorrect local backref count on 20963328 parent 33718272 owner 0 offset 0 found 1 wanted 0 back 0x56043bdf6d80
backpointer mismatch on [20963328 4096]
adding new data backref on 20963328 parent 33718272 owner 0 offset 0 found 1
Repaired extent references for 20963328
ref mismatch on [20967424 4096] extent item 0, found 1
data backref 20967424 parent 33718272 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 20967424 parent 33718272 owner 0 offset 0 found 1 wanted 0 back 0x56043bdf6fe0
backpointer mismatch on [20967424 4096]
adding new data backref on 20967424 parent 33718272 owner 0 offset 0 found 1
Repaired extent references for 20967424
ref mismatch on [20971520 16384] extent item 0, found 1
tree backref 20971520 root 3 not found in extent tree
backpointer mismatch on [20971520 16384]
adding new tree backref on start 20971520 len 16384 parent 0 root 3
Repaired extent references for 20971520
ref mismatch on [20987904 16384] extent item 0, found 1
tree backref 20987904 root 3 not found in extent tree
backpointer mismatch on [20987904 16384]
adding new tree backref on start 20987904 len 16384 parent 0 root 3
Repaired extent references for 20987904
ref mismatch on [21004288 16384] extent item 0, found 1
tree backref 21004288 root 3 not found in extent tree
(..)
adding new tree backref on start 44531712 len 16384 parent 50872320 root 50872320
Repaired extent references for 44531712
ref mismatch on [44548096 16384] extent item 0, found 1
tree backref 44548096 parent 47398912 not found in extent tree
backpointer mismatch on [44548096 16384]
adding new tree backref on start 44548096 len 16384 parent 47398912 root 47398912
Repaired extent references for 44548096
ref mismatch on [44564480 16384] extent item 0, found 1
tree backref 44564480 root 7 not found in extent tree
backpointer mismatch on [44564480 16384]
adding new tree backref on start 44564480 len 16384 parent 0 root 7
Repaired extent references for 44564480
ref mismatch on [44580864 16384] extent item 0, found 1
tree backref 44580864 root 7 not found in extent tree
backpointer mismatch on [44580864 16384]
adding new tree backref on start 44580864 len 16384 parent 0 root 7
Repaired extent references for 44580864
ref mismatch on [44597248 16384] extent item 0, found 1
tree backref 44597248 root 7 not found in extent tree
backpointer mismatch on [44597248 16384]
adding new tree backref on start 44597248 len 16384 parent 0 root 7
Repaired extent references for 44597248
ref mismatch on [44613632 16384] extent item 0, found 1
tree backref 44613632 parent 47398912 not found in extent tree
backpointer mismatch on [44613632 16384]
adding new tree backref on start 44613632 len 16384 parent 47398912 root 47398912
Repaired extent references for 44613632
ref mismatch on [44630016 16384] extent item 0, found 1
tree backref 44630016 parent 47398912 not found in extent tree
backpointer mismatch on [44630016 16384]
adding new tree backref on start 44630016 len 16384 parent 47398912 root 47398912
(...)

gargamel:/var/local/src# grep -c 'adding new tree backref on start' checkrepair1 
9026

It's been running for close to 3 days, and I'm a bit confused that it's repairing so
many things when it wast just a minute's worth of potential corruption.

Do I keep running for many more days to see where this goes, or at this point 
73,860 lines of output is not a bad sign and I should look at restoring from backup?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
