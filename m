Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5915B546D0C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 21:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245376AbiFJTMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 15:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFJTMA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 15:12:00 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A6DF7
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 12:11:58 -0700 (PDT)
Received: from [76.132.34.178] (port=59252 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nzjKf-0005YO-8y by authid <merlins.org> with srv_auth_plain; Fri, 10 Jun 2022 12:11:56 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nzk32-007Lah-AH; Fri, 10 Jun 2022 12:11:56 -0700
Date:   Fri, 10 Jun 2022 12:11:56 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220610191156.GB1664812@merlins.org>
References: <20220608021245.GD22722@merlins.org>
 <CAEzrpqeFFiHjbQ+VQ7zy9ZbV1MgaMT-V4ovJhB9iOan8Ao-cXg@mail.gmail.com>
 <20220608213030.GG22722@merlins.org>
 <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org>
 <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 76.132.34.178
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 10, 2022 at 02:47:54PM -0400, Josef Bacik wrote:
> Sorry I keep going back and forth on how to deal with this.  I've
> pushed some code, you can run btrfs check --repair again and then try
> again.  Thanks,

Thanks, lots of output, not sure how much you want.

For one:
Device extent[1, 14803716276224, 1073741824] didn't find the relative chunk.
Device extent[1, 14804790018048, 1073741824] didn't find the relative chunk.
Device extent[1, 14805863759872, 1073741824] didn't find the relative chunk.
Device extent[1, 14806937501696, 1073741824] didn't find the relative chunk.
Device extent[1, 14808011243520, 1073741824] didn't find the relative chunk.
super bytes used 21916233728 mismatches actual used 21916332032
Block group[20971520, 8388608] (flags = 34) didn't find the relative chunk.
Dev extent's total-byte(1396938113024) is not equal to byte-used(14599692746752) in dev[1, 216, 1]
kernel-shared/extent-tree.c:2479: alloc_reserved_tree_block: Warning: assertion `1` failed, value 1
./btrfs(btrfs_run_delayed_refs+0x707)[0x5577947c927b]
./btrfs(btrfs_commit_transaction+0x3b)[0x5577947d7fb5]
./btrfs(repair_dev_item_bytes_used+0x6f)[0x5577948340d7]
./btrfs(+0x7d90b)[0x55779481690b]
./btrfs(+0x80193)[0x557794819193]
./btrfs(main+0x94)[0x5577947b1275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f51c74847fd]
./btrfs(_start+0x2a)[0x5577947b0e1a]
kernel-shared/extent-tree.c:2479: alloc_reserved_tree_block: Warning: assertion `1` failed, value 1
./btrfs(btrfs_run_delayed_refs+0x707)[0x5577947c927b]
./btrfs(btrfs_commit_transaction+0x3b)[0x5577947d7fb5]
./btrfs(repair_dev_item_bytes_used+0x6f)[0x5577948340d7]
./btrfs(+0x7d90b)[0x55779481690b]
./btrfs(+0x80193)[0x557794819193]
./btrfs(main+0x94)[0x5577947b1275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f51c74847fd]
./btrfs(_start+0x2a)[0x5577947b0e1a]
WARNING: reserved space leaked, transid=2608372 flag=0x2 bytes_reserved=32768
[3/7] checking free space cache
[4/7] checking fs roots
root 161199 inode 54987 errors 1000, some csum missing
WARNING: reserved space leaked, transid=2608373 flag=0x2 bytes_reserved=32768
root 161199 inode 54988 errors 1100, file extent discount, some csum missing
Found file extent holes:
        start: 0, len: 1572864
WARNING: reserved space leaked, transid=2608374 flag=0x2 bytes_reserved=32768
root 161199 inode 54989 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes:
        start: 16252928, len: 91824128
        unresolved ref dir 54974 index 16 namelen 18 name foo

(...)

Found file extent holes:
        start: 197263360, len: 399777792
root 164629 inode 73086 errors 1000, some csum missing
WARNING: reserved space leaked, transid=2608425 flag=0x2 bytes_reserved=32768
root 164629 inode 73094 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes:
        start: 0, len: 524288
        unresolved ref dir 74963 index 32 namelen 56 name file filetype 0 errors 3
, no dir item, no dir index
WARNING: reserved space leaked, transid=2608426 flag=0x2 bytes_reserved=32768
root 164629 inode 73097 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes:
        start: 0, len: 524288
        unresolved ref dir 74963 index 36 namelen 56 name file filetype 0 errors 3
, no dir item, no dir index
root 164629 inode 73099 errors 1000, some csum missing
root 164629 inode 73100 errors 1000, some csum missing
        unresolved ref dir 791 index 0 namelen 25 name file filetype 1 errors 6, no dir index, no inode ref
        unresolved ref dir 3676 index 0 namelen 62 name file filetype 1 erro
rs 6, no dir index, no inode ref
ERROR: errors found in fs roots
WARNING: reserved space leaked, flag=0x2 bytes_reserved=32768
nt


deleting dev extent
deleting dev extent
deleting dev extent
deleting dev extent
deleting dev extent
reset devid 1 bytes_used to 1396938113024
No device size related problem found
cache and super generation don't match, space cache will be invalidated
found 43832565760 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 17694720
total fs tree bytes: 13598720
total extent tree bytes: 1212416
btree space waste bytes: 5081349
file data blocks allocated: 73458024448
 referenced 73454837760

After that check without repair still reports the same errors and mount still fails

[4035459.256276] BTRFS info (device dm-1): disk space caching is enabled
[4035459.276458] BTRFS info (device dm-1): has skinny extents
[4035459.357797] BTRFS error (device dm-1): chunk 20971520 has missing dev extent, have 0 expect 2
[4035459.385928] BTRFS error (device dm-1): failed to verify dev extents against chunks: -117
[4035459.413170] BTRFS error (device dm-1): open_ctree failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
