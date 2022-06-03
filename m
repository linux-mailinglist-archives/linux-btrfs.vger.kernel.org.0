Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1542E53D1A8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 20:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346988AbiFCSkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347584AbiFCSjb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 14:39:31 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C479580
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 11:39:29 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nxCCm-00032y-BE by authid <merlin>; Fri, 03 Jun 2022 11:39:28 -0700
Date:   Fri, 3 Jun 2022 11:39:27 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220603183927.GZ22722@merlins.org>
References: <CAEzrpqciXfV0NZMTJoMjX_E_TzQ-j5sEpsACnEhnJdAXzbVOEg@mail.gmail.com>
 <20220602195623.GU22722@merlins.org>
 <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
 <20220602203224.GV22722@merlins.org>
 <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
 <20220603144732.GG1745079@merlins.org>
 <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
 <20220603164252.GH1745079@merlins.org>
 <20220603170700.GX22722@merlins.org>
 <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com>
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

On Fri, Jun 03, 2022 at 02:34:37PM -0400, Josef Bacik wrote:
> Hmm tree-recover is supposed to catch this, can you re-run
> tree-recover and see if it finds this block and gets rid of it?
> Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x55eaff09dbc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55eaff09dbc0
Checking root 2 bytenr 15645019570176
Checking root 4 bytenr 15645019078656h
Checking root 5 bytenr 15645018161152
Checking root 7 bytenr 15645018275840
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
Checking root 164624 bytenr 15645019176960
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
scanning, best has 0 found 0 bad
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
checking block 15645502210048 generation 1601068 fs info generation 2588154
Invalid mapping for 5809703075840-5809703092224, got 11106814787584-11107888529408
Couldn't map the block 5809703075840
Couldn't map the block 5809703075840
Invalid mapping for 4867246325760-4867246342144, got 11106814787584-11107888529408
Couldn't map the block 4867246325760
Couldn't map the block 4867246325760
Invalid mapping for 13577676587008-13577676603392, got 14271702368256-14272776110080
Couldn't map the block 13577676587008
Couldn't map the block 13577676587008
Invalid mapping for 9715195920384-9715195936768, got 11106814787584-11107888529408
Couldn't map the block 9715195920384
Couldn't map the block 9715195920384
Invalid mapping for 9715198033920-9715198050304, got 11106814787584-11107888529408
Couldn't map the block 9715198033920
Couldn't map the block 9715198033920
(...)
Invalid mapping for 13577212362752-13577212379136, got 14271702368256-14272776110080
Couldn't map the block 13577212362752
Couldn't map the block 13577212362752
deleting slot 14 in block 15646005067776
Invalid mapping for 13577154658304-13577154674688, got 14271702368256-14272776110080
Couldn't map the block 13577154658304
Couldn't map the block 13577154658304
deleting slot 14 in block 15646005067776
Invalid mapping for 12512115081216-12512115097600, got 14271702368256-14272776110080
Couldn't map the block 12512115081216
Couldn't map the block 12512115081216
deleting slot 14 in block 15646005067776
Invalid mapping for 11651757277184-11651757293568, got 14271702368256-14272776110080
Couldn't map the block 11651757277184
Couldn't map the block 11651757277184
deleting slot 14 in block 15646005067776
Invalid mapping for 11651852124160-11651852140544, got 14271702368256-14272776110080
Couldn't map the block 11651852124160
Couldn't map the block 11651852124160
deleting slot 15 in block 15646005067776
Invalid mapping for 12511596118016-12511596134400, got 14271702368256-14272776110080
Couldn't map the block 12511596118016
Couldn't map the block 12511596118016
deleting slot 15 in block 15646005067776
Invalid mapping for 10678933913600-10678933929984, got 11106814787584-11107888529408
Couldn't map the block 10678933913600
Couldn't map the block 10678933913600
deleting slot 15 in block 15646005067776
Invalid mapping for 11651771924480-11651771940864, got 14271702368256-14272776110080
Couldn't map the block 11651771924480
Couldn't map the block 11651771924480
deleting slot 15 in block 15646005067776
Invalid mapping for 10194218582016-10194218598400, got 11106814787584-11107888529408
Couldn't map the block 10194218582016
Couldn't map the block 10194218582016
deleting slot 15 in block 15646005067776
Invalid mapping for 13577142059008-13577142075392, got 14271702368256-14272776110080
Couldn't map the block 13577142059008
Couldn't map the block 13577142059008
deleting slot 8 in block 15645502210048
Checking root 164629 bytenr 15645485137920
Checking root 164631 bytenr 15645496983552
Checking root 164633 bytenr 15645526884352
Checking root 164823 bytenr 15645999005696
Tree recovery finished, you can run check now

However I still get:
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1

inserting block group 15929559744512
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
Deleting [260, 108, 0] root 15645019684864 path top 15645019684864 top slot 0 leaf 15645019734016 slot 114

searching 164624 for bad extents

Found an extent we don't have a block group for in the file
file
corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
Deleting [260, 108, 58146816] root 15645018718208 path top 15645018718208 top slot 0 leaf 15645019553792 slot 114

searching 164624 for bad extents

Found an extent we don't have a block group for in the file
corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
Couldn't find any paths for this inode
corrupt node: root=164624 block=15645019684864 physical=15054973386752 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
ERROR: error searching for key?? -1

wtf
it failed?? -1
ERROR: failed to clear bad extents
doing close???
ERROR: attempt to start transaction over already running one
WARNING: reserved space leaked, flag=0x4 bytes_reserved=32768
extent buffer leak: start 15645019504640 len 16384
extent buffer leak: start 15645019504640 len 16384
WARNING: dirty eb leak (aborted trans): start 15645019504640 len 16384
extent buffer leak: start 15645019684864 len 16384
extent buffer leak: start 15645019684864 len 16384
WARNING: dirty eb leak (aborted trans): start 15645019684864 len 16384
Init extent tree failed


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
