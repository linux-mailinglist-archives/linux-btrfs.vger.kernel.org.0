Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844F53DF0C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 02:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348731AbiFFAFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jun 2022 20:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348715AbiFFAFx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jun 2022 20:05:53 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40B64AE3C
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jun 2022 17:05:49 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1ny0Fg-0005Ud-NJ by authid <merlin>; Sun, 05 Jun 2022 17:05:48 -0700
Date:   Sun, 5 Jun 2022 17:05:48 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220606000548.GF22722@merlins.org>
References: <20220604134823.GB22722@merlins.org>
 <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
 <20220605001349.GJ1745079@merlins.org>
 <CAEzrpqfjDL=GtAn9cHQ2cOPMVZeNnuaQBLq6K-X-tGaipaAouA@mail.gmail.com>
 <20220605201112.GN1745079@merlins.org>
 <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
 <20220605212637.GO1745079@merlins.org>
 <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
 <20220605215036.GE22722@merlins.org>
 <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
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

On Sun, Jun 05, 2022 at 07:03:31PM -0400, Josef Bacik wrote:
> I wonder if our delete thing is corrupting stuff.  Can you re-run
> tree-recover, and then once that's done run init-extent-tree?  I put
> some stuff to check block all the time to see if we're introducing the
> problem.  Thanks,



gargamel:/var/local/src/btrfs-progs-josefbacik# gdb./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x5637d77f4bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x5637d77f4bc0
Checking root 2 bytenr 15645019471872
Checking root 4 bytenr 15645019078656
Checking root 5 bytenr 15645018161152
Checking root 7 bytenr 15645018587136
Checking root 9 bytenr 15645740367872
Checking root 161197 bytenr 15645018341376
Checking root 161199 bytenr 15645018652672
Checking root 161200 bytenr 15645018750976
Checking root 161889 bytenr 11160502124544
Checking root 162628 bytenr 15645018931200
Checking root 162632 bytenr 15645018210304
Checking root 163298 bytenr 15645019045888
Checking root 163302 bytenr 15645018685440
Checking root 163303 bytenr 15645019095040
Checking root 163316 bytenr 15645018996736
Checking root 163920 bytenr 15645019144192
Checking root 164620 bytenr 15645019275264
Checking root 164623 bytenr 15645019226112
Checking root 164624 bytenr 15645018226688
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15054972026880 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
scanning, best has 0 found 0 bad
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15054972026880 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
trying bytenr 15645018226688 got 96 blocks 1 bad 
checking block 15645502210048 generation 1601068 fs info generation 2588162
trying bytenr 15645502210048 got 146 blocks 0 bad 
checking block 15645018324992 generation 2588160 fs info generation 2588162
scan for best root 164624 wants to use 15645502210048 as the root bytenr
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15054972026880 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
Repairing root 164624 bad_blocks 0 update 1
setting root 164624 to bytenr 15645502210048
Checking root 164629 bytenr 15645485137920
Checking root 164631 bytenr 15645496983552
Checking root 164633 bytenr 15645526884352
Checking root 164823 bytenr 15645999005696
Tree recovery finished, you can run check now


gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
FS_INFO IS 0x55d4f966dbc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55d4f966dbc0
Walking all our trees and pinning down the currently accessible blocks
Clearing the extent root and re-init'ing the block groups
deleting space cache for 11106814787584
deleting space cache for 11108962271232
deleting space cache for 11110036013056 
deleting space cache for 11111109754880
deleting space cache for 11112183496704 
deleting space cache for 11113257238528
deleting space cache for 11114330980352
deleting space cache for 11115404722176
deleting space cache for 11116478464000
(...)
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
Deleting [260, 108, 0] root 15645019602944 path top 15645019602944 top slot 0 leaf 15645019701248 slot 114

searching 164624 for bad extents

Found an extent we don't have a block group for in the file
file
corrupt node: root=164624 root bytenr 15645018226688 commit bytenr 15645019602944 block=15645019176960 physical=15054972878848 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
Deleting [260, 108, 58146816] root 15645018226688 path top 15645018226688 top slot 0 leaf 15645019537408 slot 114
corrupt node: root=164624 root bytenr 15645018226688 commit bytenr 15645019602944 block=15645019176960 physical=15054972878848 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
kernel-shared/ctree.c:118: btrfs_release_path: BUG_ON `ret` triggered, value -5
./btrfs(btrfs_release_path+0x62)[0x55d4f7cd950d]
./btrfs(+0x8c751)[0x55d4f7d46751]
./btrfs(+0x8c3c1)[0x55d4f7d463c1]
./btrfs(+0x8c3c1)[0x55d4f7d463c1]
./btrfs(+0x8c8fc)[0x55d4f7d468fc]
./btrfs(+0x8c1cb)[0x55d4f7d461cb]
./btrfs(btrfs_init_extent_tree+0xc83)[0x55d4f7d47e94]
./btrfs(+0x83f6a)[0x55d4f7d3df6a]
./btrfs(handle_command_group+0x49)[0x55d4f7cd217b]
./btrfs(main+0x94)[0x55d4f7cd2275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f7d302a07fd]
./btrfs(_start+0x2a)[0x55d4f7cd1e1a]
Aborted



-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
