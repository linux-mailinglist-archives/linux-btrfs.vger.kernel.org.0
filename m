Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8092A4F211D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 06:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiDECkb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 22:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiDECkT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 22:40:19 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7660C55BEB
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 18:43:00 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbYDj-0004XR-Jt by authid <merlin>; Mon, 04 Apr 2022 18:42:59 -0700
Date:   Mon, 4 Apr 2022 18:42:59 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405014259.GG5566@merlins.org>
References: <20220405001325.GB5566@merlins.org>
 <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
 <20220405001808.GC5566@merlins.org>
 <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
 <20220405002826.GD5566@merlins.org>
 <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
 <20220405005809.GE5566@merlins.org>
 <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
 <20220405011559.GF5566@merlins.org>
 <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
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

On Mon, Apr 04, 2022 at 09:22:26PM -0400, Josef Bacik wrote:
> Ok lets try again with -b 13577821667328, and if the owner doesn't say
> ROOT_TREE try 13577775284224 and then 13577814573056.  Thanks,

EXTENT_TREE, FS_TREE, and FS_TREE

And shit, I got distracted and sent the text output to
/dev/mapper/dshelf1a, so I clobbered about 30K of the device. 
I'm assuming there was probably something there?

Script started on Mon 04 Apr 2022 18:36:51 PDT
1;37mgargamel:/var/local/src/btrfs-progs-josefbacik#m ./btrfs-inspect-internal dump-tree -b 13577821667328 &>/dev/mapper/dshelf1a
btrfs inspect-internal dump-tree: not enough arguments: 0 but at least 1 expected
1;37mgargamel:/var/local/src/btrfs-progs-josefbacik#m K./btrfs inspect-internal dump-tree -b 13577821667328 /dev/mapper/dshelf1a
btrfs-progs v5.16.2
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
FS_INFO IS 0x55fe04c74870
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
Couldn't find the last root for 4
Couldn't setup device tree
FS_INFO AFTER IS 0x55fe04c74870
leaf 13577821667328 items 197 free space 4857 generation 1602242 owner EXTENT_TREE
leaf 13577821667328 flags 0x1(WRITTEN) backref revision 1
fs uuid 96539b8c-ccc9-47bf-9e6c-29305890941e
chunk uuid 7257b24b-3702-41e5-8b61-6f6ea524255a
	item 0 key (8733701406720 METADATA_ITEM 0) itemoff 16250 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 1 key (8733701423104 METADATA_ITEM 0) itemoff 16217 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 2 key (8733701439488 METADATA_ITEM 0) itemoff 16184 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 3 key (8733701455872 METADATA_ITEM 0) itemoff 16151 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 4 key (8733701472256 METADATA_ITEM 0) itemoff 16118 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 5 key (8733701488640 METADATA_ITEM 0) itemoff 16085 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 6 key (8733701505024 METADATA_ITEM 0) itemoff 16052 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 7 key (8733701521408 METADATA_ITEM 0) itemoff 16019 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 8 key (8733701537792 METADATA_ITEM 0) itemoff 15986 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 9 key (8733701554176 METADATA_ITEM 0) itemoff 15953 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 10 key (8733701570560 METADATA_ITEM 0) itemoff 15920 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 11 key (8733701586944 METADATA_ITEM 0) itemoff 15887 itemsize 33
		refs 1 gen 300259 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 12 key (8733701603328 METADATA_ITEM 0) itemoff 15854 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 13 key (8733701619712 METADATA_ITEM 0) itemoff 15821 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 14 key (8733701636096 METADATA_ITEM 0) itemoff 15788 itemsize 33
		refs 1 gen 300259 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 15 key (8733701652480 METADATA_ITEM 0) itemoff 15755 itemsize 33
		refs 1 gen 300259 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 16 key (8733701668864 METADATA_ITEM 0) itemoff 15722 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 17 key (8733701685248 METADATA_ITEM 0) itemoff 15689 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 18 key (8733701701632 METADATA_ITEM 0) itemoff 15656 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 19 key (8733701718016 METADATA_ITEM 0) itemoff 15623 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 20 key (8733701734400 METADATA_ITEM 0) itemoff 15590 itemsize 33
		refs 1 gen 300259 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 21 key (8733701750784 METADATA_ITEM 0) itemoff 15557 itemsize 33
		refs 1 gen 1584113 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root EXTENT_TREE
	item 22 key (8733701783552 METADATA_ITEM 0) itemoff 15524 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 23 key (8733701799936 METADATA_ITEM 0) itemoff 15491 itemsize 33
		refs 1 gen 300259 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 24 key (8733701816320 METADATA_ITEM 0) itemoff 15458 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 25 key (8733701832704 METADATA_ITEM 0) itemoff 15425 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 26 key (8733701865472 METADATA_ITEM 0) itemoff 15392 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 27 key (8733701881856 METADATA_ITEM 0) itemoff 15359 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 28 key (8733701898240 METADATA_ITEM 1) itemoff 15326 itemsize 33
		refs 1 gen 1474318 flags TREE_BLOCK
		tree block skinny level 1
		tree block backref root CSUM_TREE
	item 29 key (8733701914624 METADATA_ITEM 0) itemoff 15293 itemsize 33
		refs 1 gen 1474318 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 30 key (8733701931008 METADATA_ITEM 0) itemoff 15260 itemsize 33
		refs 1 gen 1480353 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 31 key (8733701947392 METADATA_ITEM 0) itemoff 15227 itemsize 33
		refs 1 gen 300259 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 32 key (8733701963776 METADATA_ITEM 0) itemoff 15194 itemsize 33
		refs 1 gen 1480353 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 33 key (8733701980160 METADATA_ITEM 0) itemoff 15161 itemsize 33
		refs 1 gen 300259 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 34 key (8733701996544 METADATA_ITEM 0) itemoff 15128 itemsize 33
		refs 1 gen 1581638 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 35 key (8733702012928 METADATA_ITEM 0) itemoff 15095 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 36 key (8733702029312 METADATA_ITEM 0) itemoff 15062 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 37 key (8733702045696 METADATA_ITEM 0) itemoff 15029 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 38 key (8733702062080 METADATA_ITEM 0) itemoff 14996 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 39 key (8733702078464 METADATA_ITEM 0) itemoff 14963 itemsize 33
		refs 1 gen 300259 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 40 key (8733702094848 METADATA_ITEM 0) itemoff 14930 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 41 key (8733702111232 METADATA_ITEM 0) itemoff 14897 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 42 key (8733702127616 METADATA_ITEM 0) itemoff 14864 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 43 key (8733702144000 METADATA_ITEM 0) itemoff 14831 itemsize 33
		refs 1 gen 1581638 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 44 key (8733702176768 METADATA_ITEM 0) itemoff 14798 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 45 key (8733702193152 METADATA_ITEM 0) itemoff 14765 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 46 key (8733702209536 METADATA_ITEM 0) itemoff 14732 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 47 key (8733702225920 METADATA_ITEM 0) itemoff 14699 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 48 key (8733702242304 METADATA_ITEM 0) itemoff 14666 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 49 key (8733702258688 METADATA_ITEM 0) itemoff 14633 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 50 key (8733702275072 METADATA_ITEM 0) itemoff 14600 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 51 key (8733702291456 METADATA_ITEM 0) itemoff 14567 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 52 key (8733702307840 METADATA_ITEM 0) itemoff 14534 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 53 key (8733702324224 METADATA_ITEM 0) itemoff 14501 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 54 key (8733702340608 METADATA_ITEM 0) itemoff 14468 itemsize 33
		refs 1 gen 1538313 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 55 key (8733702356992 METADATA_ITEM 0) itemoff 14435 itemsize 33
		refs 1 gen 1360804 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 56 key (8733702389760 METADATA_ITEM 0) itemoff 14402 itemsize 33
		refs 1 gen 1360804 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 57 key (8733702406144 METADATA_ITEM 0) itemoff 14369 itemsize 33
		refs 1 gen 1360804 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 58 key (8733702422528 METADATA_ITEM 0) itemoff 14336 itemsize 33
		refs 1 gen 838551 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 59 key (8733702438912 METADATA_ITEM 0) itemoff 14303 itemsize 33
		refs 1 gen 1360804 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 60 key (8733702455296 METADATA_ITEM 0) itemoff 14270 itemsize 33
		refs 1 gen 1360804 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 61 key (8733702504448 METADATA_ITEM 0) itemoff 14237 itemsize 33
		refs 1 gen 300521 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 62 key (8733702520832 METADATA_ITEM 0) itemoff 14204 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 63 key (8733702537216 METADATA_ITEM 0) itemoff 14171 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 64 key (8733702553600 METADATA_ITEM 0) itemoff 14138 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 65 key (8733702569984 METADATA_ITEM 0) itemoff 14105 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 66 key (8733702586368 METADATA_ITEM 0) itemoff 14072 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 67 key (8733702602752 METADATA_ITEM 0) itemoff 14039 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 68 key (8733702619136 METADATA_ITEM 0) itemoff 14006 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 69 key (8733702635520 METADATA_ITEM 0) itemoff 13973 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 70 key (8733702651904 METADATA_ITEM 0) itemoff 13940 itemsize 33
		refs 1 gen 1602171 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root EXTENT_TREE
	item 71 key (8733702668288 METADATA_ITEM 0) itemoff 13907 itemsize 33
		refs 1 gen 1538313 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 72 key (8733702684672 METADATA_ITEM 0) itemoff 13874 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 73 key (8733702701056 METADATA_ITEM 0) itemoff 13841 itemsize 33
		refs 1 gen 300259 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 74 key (8733702717440 METADATA_ITEM 0) itemoff 13808 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 75 key (8733702733824 METADATA_ITEM 0) itemoff 13775 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 76 key (8733702750208 METADATA_ITEM 0) itemoff 13742 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 77 key (8733702766592 METADATA_ITEM 0) itemoff 13709 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 78 key (8733702782976 METADATA_ITEM 0) itemoff 13676 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 79 key (8733702799360 METADATA_ITEM 0) itemoff 13643 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 80 key (8733702815744 METADATA_ITEM 0) itemoff 13610 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 81 key (8733702832128 METADATA_ITEM 0) itemoff 13577 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 82 key (8733702848512 METADATA_ITEM 0) itemoff 13544 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 83 key (8733702864896 METADATA_ITEM 0) itemoff 13511 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 84 key (8733702881280 METADATA_ITEM 0) itemoff 13478 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 85 key (8733702897664 METADATA_ITEM 0) itemoff 13445 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 86 key (8733702914048 METADATA_ITEM 0) itemoff 13412 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 87 key (8733702930432 METADATA_ITEM 0) itemoff 13379 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 88 key (8733702946816 METADATA_ITEM 0) itemoff 13346 itemsize 33
		refs 1 gen 1538313 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 89 key (8733702963200 METADATA_ITEM 0) itemoff 13313 itemsize 33
		refs 1 gen 3256 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 90 key (8733702979584 METADATA_ITEM 0) itemoff 13280 itemsize 33
		refs 1 gen 3256 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 91 key (8733702995968 METADATA_ITEM 0) itemoff 13247 itemsize 33
		refs 1 gen 3256 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 92 key (8733703012352 METADATA_ITEM 0) itemoff 13214 itemsize 33
		refs 1 gen 3256 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 93 key (8733703028736 METADATA_ITEM 0) itemoff 13181 itemsize 33
		refs 1 gen 3256 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 94 key (8733703045120 METADATA_ITEM 0) itemoff 13148 itemsize 33
		refs 1 gen 3256 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 95 key (8733703061504 METADATA_ITEM 0) itemoff 13115 itemsize 33
		refs 1 gen 3256 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 96 key (8733703077888 METADATA_ITEM 0) itemoff 13082 itemsize 33
		refs 1 gen 3256 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 97 key (8733703094272 METADATA_ITEM 0) itemoff 13049 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 98 key (8733703110656 METADATA_ITEM 0) itemoff 13016 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 99 key (8733703127040 METADATA_ITEM 0) itemoff 12983 itemsize 33
		refs 1 gen 3264 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 100 key (8733703143424 METADATA_ITEM 0) itemoff 12950 itemsize 33
		refs 1 gen 4166 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 101 key (8733703159808 METADATA_ITEM 0) itemoff 12917 itemsize 33
		refs 1 gen 1581638 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 102 key (8733703176192 METADATA_ITEM 0) itemoff 12884 itemsize 33
		refs 1 gen 1581638 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 103 key (8733703192576 METADATA_ITEM 0) itemoff 12851 itemsize 33
		refs 1 gen 1514029 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 104 key (8733703208960 METADATA_ITEM 0) itemoff 12818 itemsize 33
		refs 1 gen 4166 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 105 key (8733703225344 METADATA_ITEM 0) itemoff 12785 itemsize 33
		refs 1 gen 1514029 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 106 key (8733703241728 METADATA_ITEM 0) itemoff 12752 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 107 key (8733703258112 METADATA_ITEM 0) itemoff 12719 itemsize 33
		refs 1 gen 1581638 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 108 key (8733703274496 METADATA_ITEM 0) itemoff 12686 itemsize 33
		refs 1 gen 300521 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 109 key (8733703290880 METADATA_ITEM 0) itemoff 12653 itemsize 33
		refs 1 gen 1584112 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root EXTENT_TREE
	item 110 key (8733703323648 METADATA_ITEM 0) itemoff 12620 itemsize 33
		refs 1 gen 1602171 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root EXTENT_TREE
	item 111 key (8733703340032 METADATA_ITEM 0) itemoff 12587 itemsize 33
		refs 1 gen 1538313 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 112 key (8733703454720 METADATA_ITEM 0) itemoff 12554 itemsize 33
		refs 1 gen 1535773 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 113 key (8733703471104 METADATA_ITEM 0) itemoff 12521 itemsize 33
		refs 1 gen 1538313 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 114 key (8733703487488 METADATA_ITEM 0) itemoff 12488 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 115 key (8733703503872 METADATA_ITEM 0) itemoff 12455 itemsize 33
		refs 1 gen 519869 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 116 key (8733703520256 METADATA_ITEM 0) itemoff 12422 itemsize 33
		refs 1 gen 1538313 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 117 key (8733703536640 METADATA_ITEM 0) itemoff 12389 itemsize 33
		refs 1 gen 1538313 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 118 key (8733703553024 METADATA_ITEM 0) itemoff 12356 itemsize 33
		refs 1 gen 1538313 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 119 key (8733703569408 METADATA_ITEM 0) itemoff 12323 itemsize 33
		refs 1 gen 1602171 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root EXTENT_TREE
	item 120 key (8733703602176 METADATA_ITEM 0) itemoff 12290 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 121 key (8733703651328 METADATA_ITEM 0) itemoff 12257 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 122 key (8733703733248 METADATA_ITEM 0) itemoff 12224 itemsize 33
		refs 1 gen 1510262 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root EXTENT_TREE
	item 123 key (8733703749632 METADATA_ITEM 0) itemoff 12191 itemsize 33
		refs 1 gen 1601423 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root EXTENT_TREE
	item 124 key (8733703766016 METADATA_ITEM 0) itemoff 12158 itemsize 33
		refs 1 gen 1509558 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 125 key (8733703798784 METADATA_ITEM 0) itemoff 12125 itemsize 33
		refs 1 gen 1480353 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 126 key (8733703815168 METADATA_ITEM 0) itemoff 12092 itemsize 33
		refs 1 gen 1480353 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 127 key (8733703831552 METADATA_ITEM 0) itemoff 12059 itemsize 33
		refs 1 gen 3256 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 128 key (8733703847936 METADATA_ITEM 0) itemoff 12026 itemsize 33
		refs 1 gen 3256 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 129 key (8733703864320 METADATA_ITEM 0) itemoff 11993 itemsize 33
		refs 1 gen 3246 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 130 key (8733703880704 METADATA_ITEM 0) itemoff 11960 itemsize 33
		refs 1 gen 3246 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 131 key (8733703897088 METADATA_ITEM 0) itemoff 11927 itemsize 33
		refs 1 gen 1518676 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 132 key (8733703913472 METADATA_ITEM 0) itemoff 11894 itemsize 33
		refs 1 gen 3246 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 133 key (8733703929856 METADATA_ITEM 0) itemoff 11861 itemsize 33
		refs 1 gen 3246 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 134 key (8733703946240 METADATA_ITEM 0) itemoff 11828 itemsize 33
		refs 1 gen 1590258 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root 11223
	item 135 key (8733703979008 METADATA_ITEM 0) itemoff 11795 itemsize 33
		refs 1 gen 749275 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 136 key (8733704060928 METADATA_ITEM 0) itemoff 11762 itemsize 33
		refs 1 gen 1509163 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 137 key (8733704126464 METADATA_ITEM 0) itemoff 11729 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 138 key (8733704142848 METADATA_ITEM 0) itemoff 11696 itemsize 33
		refs 1 gen 1496691 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 139 key (8733704159232 METADATA_ITEM 0) itemoff 11663 itemsize 33
		refs 1 gen 1496691 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 140 key (8733704241152 METADATA_ITEM 0) itemoff 11630 itemsize 33
		refs 1 gen 441944 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 141 key (8733704257536 METADATA_ITEM 0) itemoff 11597 itemsize 33
		refs 1 gen 1514029 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 142 key (8733704273920 METADATA_ITEM 0) itemoff 11564 itemsize 33
		refs 1 gen 904814 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 143 key (8733704290304 METADATA_ITEM 0) itemoff 11531 itemsize 33
		refs 1 gen 904814 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 144 key (8733704306688 METADATA_ITEM 0) itemoff 11498 itemsize 33
		refs 1 gen 904814 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 145 key (8733704323072 METADATA_ITEM 0) itemoff 11465 itemsize 33
		refs 1 gen 904814 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 146 key (8733704355840 METADATA_ITEM 0) itemoff 11432 itemsize 33
		refs 1 gen 1526001 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 147 key (8733704404992 METADATA_ITEM 0) itemoff 11399 itemsize 33
		refs 1 gen 300521 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 148 key (8733704421376 METADATA_ITEM 0) itemoff 11366 itemsize 33
		refs 1 gen 441944 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 149 key (8733704437760 METADATA_ITEM 0) itemoff 11333 itemsize 33
		refs 1 gen 441944 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 150 key (8733704454144 METADATA_ITEM 0) itemoff 11300 itemsize 33
		refs 1 gen 441944 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 151 key (8733704470528 METADATA_ITEM 0) itemoff 11267 itemsize 33
		refs 1 gen 441944 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 152 key (8733704519680 METADATA_ITEM 0) itemoff 11234 itemsize 33
		refs 1 gen 1497583 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 153 key (8733704536064 METADATA_ITEM 0) itemoff 11201 itemsize 33
		refs 1 gen 441944 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 154 key (8733704617984 METADATA_ITEM 0) itemoff 11168 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 155 key (8733704667136 METADATA_ITEM 0) itemoff 11135 itemsize 33
		refs 1 gen 441944 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 156 key (8733704683520 METADATA_ITEM 0) itemoff 11102 itemsize 33
		refs 1 gen 300521 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 157 key (8733704716288 METADATA_ITEM 0) itemoff 11069 itemsize 33
		refs 1 gen 4166 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 158 key (8733704765440 METADATA_ITEM 0) itemoff 11036 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 159 key (8733704798208 METADATA_ITEM 0) itemoff 11003 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 160 key (8733704847360 METADATA_ITEM 0) itemoff 10970 itemsize 33
		refs 1 gen 115450 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 161 key (8733704863744 METADATA_ITEM 0) itemoff 10937 itemsize 33
		refs 1 gen 115450 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 162 key (8733704880128 METADATA_ITEM 0) itemoff 10904 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 163 key (8733704912896 METADATA_ITEM 0) itemoff 10871 itemsize 33
		refs 1 gen 115450 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 164 key (8733704945664 METADATA_ITEM 0) itemoff 10838 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 165 key (8733704962048 METADATA_ITEM 0) itemoff 10805 itemsize 33
		refs 1 gen 115450 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 166 key (8733704978432 METADATA_ITEM 0) itemoff 10772 itemsize 33
		refs 1 gen 736618 flags TREE_BLOCK
		tree block skinny level 0
		shared block backref parent 10679198629888
	item 167 key (8733705043968 METADATA_ITEM 0) itemoff 10739 itemsize 33
		refs 1 gen 1554576 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 168 key (8733705093120 METADATA_ITEM 0) itemoff 10706 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 169 key (8733705109504 METADATA_ITEM 0) itemoff 10673 itemsize 33
		refs 1 gen 1554576 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 170 key (8733705125888 METADATA_ITEM 0) itemoff 10640 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 171 key (8733705142272 METADATA_ITEM 0) itemoff 10607 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 172 key (8733705175040 METADATA_ITEM 0) itemoff 10574 itemsize 33
		refs 1 gen 3221 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 173 key (8733705191424 METADATA_ITEM 0) itemoff 10541 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 174 key (8733705207808 METADATA_ITEM 0) itemoff 10508 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 175 key (8733705224192 METADATA_ITEM 0) itemoff 10475 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 176 key (8733705240576 METADATA_ITEM 0) itemoff 10442 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 177 key (8733705256960 METADATA_ITEM 0) itemoff 10409 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 178 key (8733705273344 METADATA_ITEM 0) itemoff 10376 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 179 key (8733705289728 METADATA_ITEM 0) itemoff 10343 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 180 key (8733705306112 METADATA_ITEM 0) itemoff 10310 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 181 key (8733705322496 METADATA_ITEM 0) itemoff 10277 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 182 key (8733705338880 METADATA_ITEM 0) itemoff 10244 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 183 key (8733705453568 METADATA_ITEM 0) itemoff 10211 itemsize 33
		refs 1 gen 68949 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 184 key (8733705469952 METADATA_ITEM 0) itemoff 10178 itemsize 33
		refs 1 gen 904828 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 185 key (8733705502720 METADATA_ITEM 0) itemoff 10145 itemsize 33
		refs 1 gen 1530500 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 186 key (8733705535488 METADATA_ITEM 0) itemoff 10112 itemsize 33
		refs 1 gen 1602171 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root EXTENT_TREE
	item 187 key (8733705551872 METADATA_ITEM 0) itemoff 10079 itemsize 33
		refs 1 gen 904814 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 188 key (8733705568256 METADATA_ITEM 0) itemoff 10046 itemsize 33
		refs 1 gen 904814 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 189 key (8733705584640 METADATA_ITEM 0) itemoff 10013 itemsize 33
		refs 1 gen 1530500 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 190 key (8733705601024 METADATA_ITEM 0) itemoff 9980 itemsize 33
		refs 1 gen 1522822 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 191 key (8733705633792 METADATA_ITEM 0) itemoff 9947 itemsize 33
		refs 1 gen 3846 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 192 key (8733705650176 METADATA_ITEM 0) itemoff 9914 itemsize 33
		refs 1 gen 1522822 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 193 key (8733705666560 METADATA_ITEM 0) itemoff 9881 itemsize 33
		refs 1 gen 1522822 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 194 key (8733705682944 METADATA_ITEM 0) itemoff 9848 itemsize 33
		refs 1 gen 904828 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 195 key (8733705699328 METADATA_ITEM 0) itemoff 9815 itemsize 33
		refs 1 gen 1514029 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
	item 196 key (8733705715712 METADATA_ITEM 0) itemoff 9782 itemsize 33
		refs 1 gen 1522822 flags TREE_BLOCK
		tree block skinny level 0
		tree block backref root CSUM_TREE
1;37mgargamel:/var/local/src/btrfs-progs-josefbacik#m K.s./btrfsfinspect-internaludump-treeb-b 313577775284224 /dev/mapper/dshelf1a
btrfs-progs v5.16.2
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
FS_INFO IS 0x56312cc84870
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
Couldn't find the last root for 4
Couldn't setup device tree
FS_INFO AFTER IS 0x56312cc84870
leaf 13577775284224 items 102 free space 8215 generation 1602088 owner FS_TREE
leaf 13577775284224 flags 0x1(WRITTEN) backref revision 1
fs uuid 96539b8c-ccc9-47bf-9e6c-29305890941e
chunk uuid 7257b24b-3702-41e5-8b61-6f6ea524255a
	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 3 transid 1602088 size 4638 nbytes 16384
		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
		sequence 152572 flags 0x0(none)
		atime 1518920225.99299649 (2018-02-17 18:17:05)
		ctime 1648458062.674404554 (2022-03-28 02:01:02)
		mtime 1648458062.674404554 (2022-03-28 02:01:02)
		otime 1518411216.0 (2018-02-11 20:53:36)
	item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
		index 0 namelen 2 name: ..
	item 2 key (256 DIR_ITEM 35173225) itemoff 16055 itemsize 56
		location key (165295 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601935 data_len 0 name_len 26
		name: other_ro.20220327_00:24:58
	item 3 key (256 DIR_ITEM 37377682) itemoff 15995 itemsize 60
		location key (165387 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602062 data_len 0 name_len 30
		name: other_hourly.20220327_22:01:01
	item 4 key (256 DIR_ITEM 65985264) itemoff 15939 itemsize 56
		location key (164623 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601065 data_len 0 name_len 26
		name: Sound_ro.20220320_00:39:38
	item 5 key (256 DIR_ITEM 121085187) itemoff 15885 itemsize 54
		location key (164633 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601080 data_len 0 name_len 24
		name: Win_ro.20220320_01:12:38
	item 6 key (256 DIR_ITEM 122346812) itemoff 15829 itemsize 56
		location key (163920 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599635 data_len 0 name_len 26
		name: Video_ro.20220313_00:38:01
	item 7 key (256 DIR_ITEM 167852107) itemoff 15769 itemsize 60
		location key (159786 ROOT_ITEM 18446744073709551615) type DIR
		transid 1591390 data_len 0 name_len 30
		name: Sound_weekly.20220130_02:03:01
	item 8 key (256 DIR_ITEM 185979643) itemoff 15714 itemsize 55
		location key (164622 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601062 data_len 0 name_len 25
		name: Soft_ro.20220320_00:35:42
	item 9 key (256 DIR_ITEM 188444463) itemoff 15655 itemsize 59
		location key (165400 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602080 data_len 0 name_len 29
		name: Video_daily.20220328_01:02:01
	item 10 key (256 DIR_ITEM 222467894) itemoff 15596 itemsize 59
		location key (165100 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601682 data_len 0 name_len 29
		name: media_daily.20220325_01:02:01
	item 11 key (256 DIR_ITEM 276733595) itemoff 15537 itemsize 59
		location key (165307 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601959 data_len 0 name_len 29
		name: other_daily.20220327_01:02:01
	item 12 key (256 DIR_ITEM 341062093) itemoff 15481 itemsize 56
		location key (163917 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599627 data_len 0 name_len 26
		name: other_ro.20220313_00:26:11
	item 13 key (256 DIR_ITEM 350762628) itemoff 15425 itemsize 56
		location key (162632 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596353 data_len 0 name_len 26
		name: Video_ro.20220227_00:46:32
	item 14 key (256 DIR_ITEM 367443219) itemoff 15365 itemsize 60
		location key (165399 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602078 data_len 0 name_len 30
		name: other_hourly.20220328_01:01:01
	item 15 key (256 DIR_ITEM 392444674) itemoff 15326 itemsize 39
		location key (103481 ROOT_ITEM 18446744073709551615) type DIR
		transid 1455725 data_len 0 name_len 9
		name: .beeshome
	item 16 key (256 DIR_ITEM 597156124) itemoff 15266 itemsize 60
		location key (165398 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602077 data_len 0 name_len 30
		name: media_hourly.20220328_01:01:01
	item 17 key (256 DIR_ITEM 640492716) itemoff 15206 itemsize 60
		location key (165396 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602075 data_len 0 name_len 30
		name: Video_hourly.20220328_01:01:01
	item 18 key (256 DIR_ITEM 668082479) itemoff 15168 itemsize 38
		location key (1496 INODE_ITEM 0) type SYMLINK
		transid 1601950 data_len 0 name_len 8
		name: Win_last
	item 19 key (256 DIR_ITEM 713697142) itemoff 15108 itemsize 60
		location key (161198 ROOT_ITEM 18446744073709551615) type DIR
		transid 1594244 data_len 0 name_len 30
		name: Sound_weekly.20220213_02:03:01
	item 20 key (256 DIR_ITEM 725111845) itemoff 15053 itemsize 55
		location key (163918 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599629 data_len 0 name_len 25
		name: Soft_ro.20220313_00:33:42
	item 21 key (256 DIR_ITEM 769653260) itemoff 14994 itemsize 59
		location key (165403 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602083 data_len 0 name_len 29
		name: other_daily.20220328_01:02:01
	item 22 key (256 DIR_ITEM 916065208) itemoff 14935 itemsize 59
		location key (165304 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601956 data_len 0 name_len 29
		name: Video_daily.20220327_01:02:01
	item 23 key (256 DIR_ITEM 971435966) itemoff 14879 itemsize 56
		location key (163916 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599626 data_len 0 name_len 26
		name: media_ro.20220313_00:24:44
	item 24 key (256 DIR_ITEM 981009741) itemoff 14846 itemsize 33
		location key (11224 ROOT_ITEM 18446744073709551615) type DIR
		transid 4062 data_len 0 name_len 3
		name: Win
	item 25 key (256 DIR_ITEM 1200370785) itemoff 14786 itemsize 60
		location key (165405 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602086 data_len 0 name_len 30
		name: Sound_hourly.20220328_02:01:01
	item 26 key (256 DIR_ITEM 1268043220) itemoff 14726 itemsize 60
		location key (165394 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602072 data_len 0 name_len 30
		name: media_hourly.20220328_00:01:01
	item 27 key (256 DIR_ITEM 1288340042) itemoff 14691 itemsize 35
		location key (11222 ROOT_ITEM 18446744073709551615) type DIR
		transid 4058 data_len 0 name_len 5
		name: media
	item 28 key (256 DIR_ITEM 1311639652) itemoff 14631 itemsize 60
		location key (165392 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602070 data_len 0 name_len 30
		name: Video_hourly.20220328_00:01:01
	item 29 key (256 DIR_ITEM 1388422445) itemoff 14575 itemsize 56
		location key (162628 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596345 data_len 0 name_len 26
		name: media_ro.20220227_00:24:39
	item 30 key (256 DIR_ITEM 1431596328) itemoff 14516 itemsize 59
		location key (165200 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601811 data_len 0 name_len 29
		name: media_daily.20220326_01:02:01
	item 31 key (256 DIR_ITEM 1438703253) itemoff 14456 itemsize 60
		location key (160495 ROOT_ITEM 18446744073709551615) type DIR
		transid 1592683 data_len 0 name_len 30
		name: Sound_weekly.20220206_02:03:01
	item 32 key (256 DIR_ITEM 1440530326) itemoff 14423 itemsize 33
		location key (1003 INODE_ITEM 0) type FILE
		transid 1448943 data_len 0 name_len 3
		name: DS1
	item 33 key (256 DIR_ITEM 1476660117) itemoff 14364 itemsize 59
		location key (165401 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602081 data_len 0 name_len 29
		name: Sound_daily.20220328_01:02:01
	item 34 key (256 DIR_ITEM 1509090277) itemoff 14304 itemsize 60
		location key (165388 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602064 data_len 0 name_len 30
		name: Video_hourly.20220327_23:01:01
	item 35 key (256 DIR_ITEM 1516701308) itemoff 14250 itemsize 54
		location key (165299 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601947 data_len 0 name_len 24
		name: Win_ro.20220327_00:37:15
	item 36 key (256 DIR_ITEM 1548232277) itemoff 14190 itemsize 60
		location key (165390 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602066 data_len 0 name_len 30
		name: media_hourly.20220327_23:01:01
	item 37 key (256 DIR_ITEM 1578913405) itemoff 14155 itemsize 35
		location key (11322 ROOT_ITEM 18446744073709551615) type DIR
		transid 4223 data_len 0 name_len 5
		name: Sound
	item 38 key (256 DIR_ITEM 1597000160) itemoff 14115 itemsize 40
		location key (1494 INODE_ITEM 0) type SYMLINK
		transid 1601944 data_len 0 name_len 10
		name: Sound_last
	item 39 key (256 DIR_ITEM 1689324197) itemoff 14055 itemsize 60
		location key (163317 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597264 data_len 0 name_len 30
		name: Sound_weekly.20220306_02:03:01
	item 40 key (256 DIR_ITEM 1705340674) itemoff 13996 itemsize 59
		location key (165305 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601957 data_len 0 name_len 29
		name: Sound_daily.20220327_01:02:01
	item 41 key (256 DIR_ITEM 1731806220) itemoff 13940 itemsize 56
		location key (165298 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601944 data_len 0 name_len 26
		name: Video_ro.20220327_00:35:50
	item 42 key (256 DIR_ITEM 1782151770) itemoff 13880 itemsize 60
		location key (165391 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602067 data_len 0 name_len 30
		name: other_hourly.20220327_23:01:01
	item 43 key (256 DIR_ITEM 1808375180) itemoff 13824 itemsize 56
		location key (163301 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597239 data_len 0 name_len 26
		name: Sound_ro.20220306_00:45:46
	item 44 key (256 DIR_ITEM 1925286825) itemoff 13768 itemsize 56
		location key (164621 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601060 data_len 0 name_len 26
		name: other_ro.20220320_00:25:35
	item 45 key (256 DIR_ITEM 2030955372) itemoff 13712 itemsize 56
		location key (163919 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599632 data_len 0 name_len 26
		name: Sound_ro.20220313_00:37:25
	item 46 key (256 DIR_ITEM 2112197083) itemoff 13652 itemsize 60
		location key (165395 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602073 data_len 0 name_len 30
		name: other_hourly.20220328_00:01:01
	item 47 key (256 DIR_ITEM 2127973047) itemoff 13617 itemsize 35
		location key (11221 ROOT_ITEM 18446744073709551615) type DIR
		transid 4042 data_len 0 name_len 5
		name: other
	item 48 key (256 DIR_ITEM 2146234148) itemoff 13583 itemsize 34
		location key (11223 ROOT_ITEM 18446744073709551615) type DIR
		transid 4061 data_len 0 name_len 4
		name: Soft
	item 49 key (256 DIR_ITEM 2153154160) itemoff 13523 itemsize 60
		location key (165389 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602065 data_len 0 name_len 30
		name: Sound_hourly.20220327_23:01:01
	item 50 key (256 DIR_ITEM 2201886496) itemoff 13464 itemsize 59
		location key (165101 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601683 data_len 0 name_len 29
		name: other_daily.20220325_01:02:01
	item 51 key (256 DIR_ITEM 2279840979) itemoff 13408 itemsize 56
		location key (162629 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596346 data_len 0 name_len 26
		name: other_ro.20220227_00:25:38
	item 52 key (256 DIR_ITEM 2313060016) itemoff 13348 itemsize 60
		location key (160496 ROOT_ITEM 18446744073709551615) type DIR
		transid 1592684 data_len 0 name_len 30
		name: media_weekly.20220206_02:03:01
	item 53 key (256 DIR_ITEM 2354277240) itemoff 13308 itemsize 40
		location key (1492 INODE_ITEM 0) type SYMLINK
		transid 1601938 data_len 0 name_len 10
		name: other_last
	item 54 key (256 DIR_ITEM 2355411712) itemoff 13248 itemsize 60
		location key (160494 ROOT_ITEM 18446744073709551615) type DIR
		transid 1592682 data_len 0 name_len 30
		name: Video_weekly.20220206_02:03:01
	item 55 key (256 DIR_ITEM 2377365299) itemoff 13192 itemsize 56
		location key (165297 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601941 data_len 0 name_len 26
		name: Sound_ro.20220327_00:35:22
	item 56 key (256 DIR_ITEM 2396976783) itemoff 13132 itemsize 60
		location key (163319 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597266 data_len 0 name_len 30
		name: other_weekly.20220306_02:03:01
	item 57 key (256 DIR_ITEM 2456187574) itemoff 13076 itemsize 56
		location key (163298 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597234 data_len 0 name_len 26
		name: media_ro.20220306_00:24:43
	item 58 key (256 DIR_ITEM 2467975514) itemoff 13021 itemsize 55
		location key (163300 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597237 data_len 0 name_len 25
		name: Soft_ro.20220306_00:33:55
	item 59 key (256 DIR_ITEM 2542431729) itemoff 12961 itemsize 60
		location key (165393 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602071 data_len 0 name_len 30
		name: Sound_hourly.20220328_00:01:01
	item 60 key (256 DIR_ITEM 2610074692) itemoff 12901 itemsize 60
		location key (165406 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602087 data_len 0 name_len 30
		name: media_hourly.20220328_02:01:01
	item 61 key (256 DIR_ITEM 2650936973) itemoff 12842 itemsize 59
		location key (165306 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601958 data_len 0 name_len 29
		name: media_daily.20220327_01:02:01
	item 62 key (256 DIR_ITEM 2653442548) itemoff 12782 itemsize 60
		location key (165404 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602085 data_len 0 name_len 30
		name: Video_hourly.20220328_02:01:01
	item 63 key (256 DIR_ITEM 2717852207) itemoff 12728 itemsize 54
		location key (163921 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599637 data_len 0 name_len 24
		name: Win_ro.20220313_00:38:28
	item 64 key (256 DIR_ITEM 2745397786) itemoff 12669 itemsize 59
		location key (165402 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602082 data_len 0 name_len 29
		name: media_daily.20220328_01:02:01
	item 65 key (256 DIR_ITEM 2782562819) itemoff 12610 itemsize 59
		location key (165098 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601680 data_len 0 name_len 29
		name: Video_daily.20220325_01:02:01
	item 66 key (256 DIR_ITEM 2793356223) itemoff 12554 itemsize 56
		location key (163299 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597235 data_len 0 name_len 26
		name: other_ro.20220306_00:25:40
	item 67 key (256 DIR_ITEM 2811536125) itemoff 12519 itemsize 35
		location key (11288 ROOT_ITEM 18446744073709551615) type DIR
		transid 4174 data_len 0 name_len 5
		name: Video
	item 68 key (256 DIR_ITEM 2827986674) itemoff 12485 itemsize 34
		location key (1010 INODE_ITEM 0) type FILE
		transid 1455723 data_len 0 name_len 4
		name: copy
	item 69 key (256 DIR_ITEM 2917386315) itemoff 12425 itemsize 60
		location key (165407 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602088 data_len 0 name_len 30
		name: other_hourly.20220328_02:01:01
	item 70 key (256 DIR_ITEM 2935166119) itemoff 12366 itemsize 59
		location key (165199 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601810 data_len 0 name_len 29
		name: Sound_daily.20220326_01:02:01
	item 71 key (256 DIR_ITEM 2935255735) itemoff 12311 itemsize 55
		location key (165296 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601938 data_len 0 name_len 25
		name: Soft_ro.20220327_00:32:46
	item 72 key (256 DIR_ITEM 3098520192) itemoff 12251 itemsize 60
		location key (163318 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597265 data_len 0 name_len 30
		name: media_weekly.20220306_02:03:01
	item 73 key (256 DIR_ITEM 3170169652) itemoff 12195 itemsize 56
		location key (164624 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601068 data_len 0 name_len 26
		name: Video_ro.20220320_00:40:27
	item 74 key (256 DIR_ITEM 3172298544) itemoff 12135 itemsize 60
		location key (163316 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597263 data_len 0 name_len 30
		name: Video_weekly.20220306_02:03:01
	item 75 key (256 DIR_ITEM 3215925951) itemoff 12075 itemsize 60
		location key (160497 ROOT_ITEM 18446744073709551615) type DIR
		transid 1592685 data_len 0 name_len 30
		name: other_weekly.20220206_02:03:01
	item 76 key (256 DIR_ITEM 3236289372) itemoff 12015 itemsize 60
		location key (161200 ROOT_ITEM 18446744073709551615) type DIR
		transid 1594246 data_len 0 name_len 30
		name: other_weekly.20220213_02:03:01
	item 77 key (256 DIR_ITEM 3290748772) itemoff 11959 itemsize 56
		location key (163302 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597242 data_len 0 name_len 26
		name: Video_ro.20220306_00:46:14
	item 78 key (256 DIR_ITEM 3360445642) itemoff 11903 itemsize 56
		location key (162631 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596351 data_len 0 name_len 26
		name: Sound_ro.20220227_00:40:41
	item 79 key (256 DIR_ITEM 3470690534) itemoff 11847 itemsize 56
		location key (164620 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601059 data_len 0 name_len 26
		name: media_ro.20220320_00:24:47
	item 80 key (256 DIR_ITEM 3550830046) itemoff 11787 itemsize 60
		location key (159785 ROOT_ITEM 18446744073709551615) type DIR
		transid 1591389 data_len 0 name_len 30
		name: Video_weekly.20220130_02:03:01
	item 81 key (256 DIR_ITEM 3592394862) itemoff 11727 itemsize 60
		location key (159787 ROOT_ITEM 18446744073709551615) type DIR
		transid 1591391 data_len 0 name_len 30
		name: media_weekly.20220130_02:03:01
	item 82 key (256 DIR_ITEM 3676890430) itemoff 11668 itemsize 59
		location key (165201 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601812 data_len 0 name_len 29
		name: other_daily.20220326_01:02:01
	item 83 key (256 DIR_ITEM 3765355617) itemoff 11608 itemsize 60
		location key (159788 ROOT_ITEM 18446744073709551615) type DIR
		transid 1591392 data_len 0 name_len 30
		name: other_weekly.20220130_02:03:01
	item 84 key (256 DIR_ITEM 3787964139) itemoff 11554 itemsize 54
		location key (163303 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597244 data_len 0 name_len 24
		name: Win_ro.20220306_00:47:32
	item 85 key (256 DIR_ITEM 3799902853) itemoff 11514 itemsize 40
		location key (1491 INODE_ITEM 0) type SYMLINK
		transid 1601935 data_len 0 name_len 10
		name: media_last
	item 86 key (256 DIR_ITEM 3872736471) itemoff 11460 itemsize 54
		location key (162645 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596372 data_len 0 name_len 24
		name: Win_ro.20220227_02:10:25
	item 87 key (256 DIR_ITEM 3951915213) itemoff 11420 itemsize 40
		location key (1495 INODE_ITEM 0) type SYMLINK
		transid 1601947 data_len 0 name_len 10
		name: Video_last
	item 88 key (256 DIR_ITEM 4079895267) itemoff 11360 itemsize 60
		location key (161197 ROOT_ITEM 18446744073709551615) type DIR
		transid 1594243 data_len 0 name_len 30
		name: Video_weekly.20220213_02:03:01
	item 89 key (256 DIR_ITEM 4084751325) itemoff 11321 itemsize 39
		location key (1493 INODE_ITEM 0) type SYMLINK
		transid 1601941 data_len 0 name_len 9
		name: Soft_last
	item 90 key (256 DIR_ITEM 4136929107) itemoff 11261 itemsize 60
		location key (161199 ROOT_ITEM 18446744073709551615) type DIR
		transid 1594245 data_len 0 name_len 30
		name: media_weekly.20220213_02:03:01
	item 91 key (256 DIR_ITEM 4142263993) itemoff 11202 itemsize 59
		location key (165099 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601681 data_len 0 name_len 29
		name: Sound_daily.20220325_01:02:01
	item 92 key (256 DIR_ITEM 4156034002) itemoff 11147 itemsize 55
		location key (162630 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596348 data_len 0 name_len 25
		name: Soft_ro.20220227_00:34:48
	item 93 key (256 DIR_ITEM 4198095398) itemoff 11091 itemsize 56
		location key (165294 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601934 data_len 0 name_len 26
		name: media_ro.20220327_00:24:32
	item 94 key (256 DIR_ITEM 4258033693) itemoff 11032 itemsize 59
		location key (165198 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601809 data_len 0 name_len 29
		name: Video_daily.20220326_01:02:01
	item 95 key (256 DIR_ITEM 4287185209) itemoff 10972 itemsize 60
		location key (165397 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602076 data_len 0 name_len 30
		name: Sound_hourly.20220328_01:01:01
	item 96 key (256 DIR_INDEX 8) itemoff 10937 itemsize 35
		location key (11221 ROOT_ITEM 18446744073709551615) type DIR
		transid 4042 data_len 0 name_len 5
		name: other
	item 97 key (256 DIR_INDEX 9) itemoff 10902 itemsize 35
		location key (11222 ROOT_ITEM 18446744073709551615) type DIR
		transid 4058 data_len 0 name_len 5
		name: media
	item 98 key (256 DIR_INDEX 10) itemoff 10868 itemsize 34
		location key (11223 ROOT_ITEM 18446744073709551615) type DIR
		transid 4061 data_len 0 name_len 4
		name: Soft
	item 99 key (256 DIR_INDEX 11) itemoff 10835 itemsize 33
		location key (11224 ROOT_ITEM 18446744073709551615) type DIR
		transid 4062 data_len 0 name_len 3
		name: Win
	item 100 key (256 DIR_INDEX 17) itemoff 10800 itemsize 35
		location key (11288 ROOT_ITEM 18446744073709551615) type DIR
		transid 4174 data_len 0 name_len 5
		name: Video
	item 101 key (256 DIR_INDEX 51) itemoff 10765 itemsize 35
		location key (11322 ROOT_ITEM 18446744073709551615) type DIR
		transid 4223 data_len 0 name_len 5
		name: Sound
1;37mgargamel:/var/local/src/btrfs-progs-josefbacik#m K.s./btrfsfinspect-internaludump-tree -b 313577775284224 /dev/mapper/dshelf1a
btrfs-progs v5.16.2
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
FS_INFO IS 0x55fb3b29e870
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
Couldn't find the last root for 4
Couldn't setup device tree
FS_INFO AFTER IS 0x55fb3b29e870
leaf 13577775284224 items 102 free space 8215 generation 1602088 owner FS_TREE
leaf 13577775284224 flags 0x1(WRITTEN) backref revision 1
fs uuid 96539b8c-ccc9-47bf-9e6c-29305890941e
chunk uuid 7257b24b-3702-41e5-8b61-6f6ea524255a
	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 3 transid 1602088 size 4638 nbytes 16384
		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
		sequence 152572 flags 0x0(none)
		atime 1518920225.99299649 (2018-02-17 18:17:05)
		ctime 1648458062.674404554 (2022-03-28 02:01:02)
		mtime 1648458062.674404554 (2022-03-28 02:01:02)
		otime 1518411216.0 (2018-02-11 20:53:36)
	item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
		index 0 namelen 2 name: ..
	item 2 key (256 DIR_ITEM 35173225) itemoff 16055 itemsize 56
		location key (165295 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601935 data_len 0 name_len 26
		name: other_ro.20220327_00:24:58
	item 3 key (256 DIR_ITEM 37377682) itemoff 15995 itemsize 60
		location key (165387 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602062 data_len 0 name_len 30
		name: other_hourly.20220327_22:01:01
	item 4 key (256 DIR_ITEM 65985264) itemoff 15939 itemsize 56
		location key (164623 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601065 data_len 0 name_len 26
		name: Sound_ro.20220320_00:39:38
	item 5 key (256 DIR_ITEM 121085187) itemoff 15885 itemsize 54
		location key (164633 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601080 data_len 0 name_len 24
		name: Win_ro.20220320_01:12:38
	item 6 key (256 DIR_ITEM 122346812) itemoff 15829 itemsize 56
		location key (163920 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599635 data_len 0 name_len 26
		name: Video_ro.20220313_00:38:01
	item 7 key (256 DIR_ITEM 167852107) itemoff 15769 itemsize 60
		location key (159786 ROOT_ITEM 18446744073709551615) type DIR
		transid 1591390 data_len 0 name_len 30
		name: Sound_weekly.20220130_02:03:01
	item 8 key (256 DIR_ITEM 185979643) itemoff 15714 itemsize 55
		location key (164622 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601062 data_len 0 name_len 25
		name: Soft_ro.20220320_00:35:42
	item 9 key (256 DIR_ITEM 188444463) itemoff 15655 itemsize 59
		location key (165400 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602080 data_len 0 name_len 29
		name: Video_daily.20220328_01:02:01
	item 10 key (256 DIR_ITEM 222467894) itemoff 15596 itemsize 59
		location key (165100 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601682 data_len 0 name_len 29
		name: media_daily.20220325_01:02:01
	item 11 key (256 DIR_ITEM 276733595) itemoff 15537 itemsize 59
		location key (165307 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601959 data_len 0 name_len 29
		name: other_daily.20220327_01:02:01
	item 12 key (256 DIR_ITEM 341062093) itemoff 15481 itemsize 56
		location key (163917 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599627 data_len 0 name_len 26
		name: other_ro.20220313_00:26:11
	item 13 key (256 DIR_ITEM 350762628) itemoff 15425 itemsize 56
		location key (162632 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596353 data_len 0 name_len 26
		name: Video_ro.20220227_00:46:32
	item 14 key (256 DIR_ITEM 367443219) itemoff 15365 itemsize 60
		location key (165399 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602078 data_len 0 name_len 30
		name: other_hourly.20220328_01:01:01
	item 15 key (256 DIR_ITEM 392444674) itemoff 15326 itemsize 39
		location key (103481 ROOT_ITEM 18446744073709551615) type DIR
		transid 1455725 data_len 0 name_len 9
		name: .beeshome
	item 16 key (256 DIR_ITEM 597156124) itemoff 15266 itemsize 60
		location key (165398 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602077 data_len 0 name_len 30
		name: media_hourly.20220328_01:01:01
	item 17 key (256 DIR_ITEM 640492716) itemoff 15206 itemsize 60
		location key (165396 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602075 data_len 0 name_len 30
		name: Video_hourly.20220328_01:01:01
	item 18 key (256 DIR_ITEM 668082479) itemoff 15168 itemsize 38
		location key (1496 INODE_ITEM 0) type SYMLINK
		transid 1601950 data_len 0 name_len 8
		name: Win_last
	item 19 key (256 DIR_ITEM 713697142) itemoff 15108 itemsize 60
		location key (161198 ROOT_ITEM 18446744073709551615) type DIR
		transid 1594244 data_len 0 name_len 30
		name: Sound_weekly.20220213_02:03:01
	item 20 key (256 DIR_ITEM 725111845) itemoff 15053 itemsize 55
		location key (163918 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599629 data_len 0 name_len 25
		name: Soft_ro.20220313_00:33:42
	item 21 key (256 DIR_ITEM 769653260) itemoff 14994 itemsize 59
		location key (165403 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602083 data_len 0 name_len 29
		name: other_daily.20220328_01:02:01
	item 22 key (256 DIR_ITEM 916065208) itemoff 14935 itemsize 59
		location key (165304 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601956 data_len 0 name_len 29
		name: Video_daily.20220327_01:02:01
	item 23 key (256 DIR_ITEM 971435966) itemoff 14879 itemsize 56
		location key (163916 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599626 data_len 0 name_len 26
		name: media_ro.20220313_00:24:44
	item 24 key (256 DIR_ITEM 981009741) itemoff 14846 itemsize 33
		location key (11224 ROOT_ITEM 18446744073709551615) type DIR
		transid 4062 data_len 0 name_len 3
		name: Win
	item 25 key (256 DIR_ITEM 1200370785) itemoff 14786 itemsize 60
		location key (165405 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602086 data_len 0 name_len 30
		name: Sound_hourly.20220328_02:01:01
	item 26 key (256 DIR_ITEM 1268043220) itemoff 14726 itemsize 60
		location key (165394 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602072 data_len 0 name_len 30
		name: media_hourly.20220328_00:01:01
	item 27 key (256 DIR_ITEM 1288340042) itemoff 14691 itemsize 35
		location key (11222 ROOT_ITEM 18446744073709551615) type DIR
		transid 4058 data_len 0 name_len 5
		name: media
	item 28 key (256 DIR_ITEM 1311639652) itemoff 14631 itemsize 60
		location key (165392 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602070 data_len 0 name_len 30
		name: Video_hourly.20220328_00:01:01
	item 29 key (256 DIR_ITEM 1388422445) itemoff 14575 itemsize 56
		location key (162628 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596345 data_len 0 name_len 26
		name: media_ro.20220227_00:24:39
	item 30 key (256 DIR_ITEM 1431596328) itemoff 14516 itemsize 59
		location key (165200 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601811 data_len 0 name_len 29
		name: media_daily.20220326_01:02:01
	item 31 key (256 DIR_ITEM 1438703253) itemoff 14456 itemsize 60
		location key (160495 ROOT_ITEM 18446744073709551615) type DIR
		transid 1592683 data_len 0 name_len 30
		name: Sound_weekly.20220206_02:03:01
	item 32 key (256 DIR_ITEM 1440530326) itemoff 14423 itemsize 33
		location key (1003 INODE_ITEM 0) type FILE
		transid 1448943 data_len 0 name_len 3
		name: DS1
	item 33 key (256 DIR_ITEM 1476660117) itemoff 14364 itemsize 59
		location key (165401 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602081 data_len 0 name_len 29
		name: Sound_daily.20220328_01:02:01
	item 34 key (256 DIR_ITEM 1509090277) itemoff 14304 itemsize 60
		location key (165388 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602064 data_len 0 name_len 30
		name: Video_hourly.20220327_23:01:01
	item 35 key (256 DIR_ITEM 1516701308) itemoff 14250 itemsize 54
		location key (165299 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601947 data_len 0 name_len 24
		name: Win_ro.20220327_00:37:15
	item 36 key (256 DIR_ITEM 1548232277) itemoff 14190 itemsize 60
		location key (165390 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602066 data_len 0 name_len 30
		name: media_hourly.20220327_23:01:01
	item 37 key (256 DIR_ITEM 1578913405) itemoff 14155 itemsize 35
		location key (11322 ROOT_ITEM 18446744073709551615) type DIR
		transid 4223 data_len 0 name_len 5
		name: Sound
	item 38 key (256 DIR_ITEM 1597000160) itemoff 14115 itemsize 40
		location key (1494 INODE_ITEM 0) type SYMLINK
		transid 1601944 data_len 0 name_len 10
		name: Sound_last
	item 39 key (256 DIR_ITEM 1689324197) itemoff 14055 itemsize 60
		location key (163317 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597264 data_len 0 name_len 30
		name: Sound_weekly.20220306_02:03:01
	item 40 key (256 DIR_ITEM 1705340674) itemoff 13996 itemsize 59
		location key (165305 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601957 data_len 0 name_len 29
		name: Sound_daily.20220327_01:02:01
	item 41 key (256 DIR_ITEM 1731806220) itemoff 13940 itemsize 56
		location key (165298 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601944 data_len 0 name_len 26
		name: Video_ro.20220327_00:35:50
	item 42 key (256 DIR_ITEM 1782151770) itemoff 13880 itemsize 60
		location key (165391 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602067 data_len 0 name_len 30
		name: other_hourly.20220327_23:01:01
	item 43 key (256 DIR_ITEM 1808375180) itemoff 13824 itemsize 56
		location key (163301 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597239 data_len 0 name_len 26
		name: Sound_ro.20220306_00:45:46
	item 44 key (256 DIR_ITEM 1925286825) itemoff 13768 itemsize 56
		location key (164621 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601060 data_len 0 name_len 26
		name: other_ro.20220320_00:25:35
	item 45 key (256 DIR_ITEM 2030955372) itemoff 13712 itemsize 56
		location key (163919 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599632 data_len 0 name_len 26
		name: Sound_ro.20220313_00:37:25
	item 46 key (256 DIR_ITEM 2112197083) itemoff 13652 itemsize 60
		location key (165395 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602073 data_len 0 name_len 30
		name: other_hourly.20220328_00:01:01
	item 47 key (256 DIR_ITEM 2127973047) itemoff 13617 itemsize 35
		location key (11221 ROOT_ITEM 18446744073709551615) type DIR
		transid 4042 data_len 0 name_len 5
		name: other
	item 48 key (256 DIR_ITEM 2146234148) itemoff 13583 itemsize 34
		location key (11223 ROOT_ITEM 18446744073709551615) type DIR
		transid 4061 data_len 0 name_len 4
		name: Soft
	item 49 key (256 DIR_ITEM 2153154160) itemoff 13523 itemsize 60
		location key (165389 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602065 data_len 0 name_len 30
		name: Sound_hourly.20220327_23:01:01
	item 50 key (256 DIR_ITEM 2201886496) itemoff 13464 itemsize 59
		location key (165101 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601683 data_len 0 name_len 29
		name: other_daily.20220325_01:02:01
	item 51 key (256 DIR_ITEM 2279840979) itemoff 13408 itemsize 56
		location key (162629 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596346 data_len 0 name_len 26
		name: other_ro.20220227_00:25:38
	item 52 key (256 DIR_ITEM 2313060016) itemoff 13348 itemsize 60
		location key (160496 ROOT_ITEM 18446744073709551615) type DIR
		transid 1592684 data_len 0 name_len 30
		name: media_weekly.20220206_02:03:01
	item 53 key (256 DIR_ITEM 2354277240) itemoff 13308 itemsize 40
		location key (1492 INODE_ITEM 0) type SYMLINK
		transid 1601938 data_len 0 name_len 10
		name: other_last
	item 54 key (256 DIR_ITEM 2355411712) itemoff 13248 itemsize 60
		location key (160494 ROOT_ITEM 18446744073709551615) type DIR
		transid 1592682 data_len 0 name_len 30
		name: Video_weekly.20220206_02:03:01
	item 55 key (256 DIR_ITEM 2377365299) itemoff 13192 itemsize 56
		location key (165297 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601941 data_len 0 name_len 26
		name: Sound_ro.20220327_00:35:22
	item 56 key (256 DIR_ITEM 2396976783) itemoff 13132 itemsize 60
		location key (163319 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597266 data_len 0 name_len 30
		name: other_weekly.20220306_02:03:01
	item 57 key (256 DIR_ITEM 2456187574) itemoff 13076 itemsize 56
		location key (163298 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597234 data_len 0 name_len 26
		name: media_ro.20220306_00:24:43
	item 58 key (256 DIR_ITEM 2467975514) itemoff 13021 itemsize 55
		location key (163300 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597237 data_len 0 name_len 25
		name: Soft_ro.20220306_00:33:55
	item 59 key (256 DIR_ITEM 2542431729) itemoff 12961 itemsize 60
		location key (165393 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602071 data_len 0 name_len 30
		name: Sound_hourly.20220328_00:01:01
	item 60 key (256 DIR_ITEM 2610074692) itemoff 12901 itemsize 60
		location key (165406 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602087 data_len 0 name_len 30
		name: media_hourly.20220328_02:01:01
	item 61 key (256 DIR_ITEM 2650936973) itemoff 12842 itemsize 59
		location key (165306 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601958 data_len 0 name_len 29
		name: media_daily.20220327_01:02:01
	item 62 key (256 DIR_ITEM 2653442548) itemoff 12782 itemsize 60
		location key (165404 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602085 data_len 0 name_len 30
		name: Video_hourly.20220328_02:01:01
	item 63 key (256 DIR_ITEM 2717852207) itemoff 12728 itemsize 54
		location key (163921 ROOT_ITEM 18446744073709551615) type DIR
		transid 1599637 data_len 0 name_len 24
		name: Win_ro.20220313_00:38:28
	item 64 key (256 DIR_ITEM 2745397786) itemoff 12669 itemsize 59
		location key (165402 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602082 data_len 0 name_len 29
		name: media_daily.20220328_01:02:01
	item 65 key (256 DIR_ITEM 2782562819) itemoff 12610 itemsize 59
		location key (165098 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601680 data_len 0 name_len 29
		name: Video_daily.20220325_01:02:01
	item 66 key (256 DIR_ITEM 2793356223) itemoff 12554 itemsize 56
		location key (163299 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597235 data_len 0 name_len 26
		name: other_ro.20220306_00:25:40
	item 67 key (256 DIR_ITEM 2811536125) itemoff 12519 itemsize 35
		location key (11288 ROOT_ITEM 18446744073709551615) type DIR
		transid 4174 data_len 0 name_len 5
		name: Video
	item 68 key (256 DIR_ITEM 2827986674) itemoff 12485 itemsize 34
		location key (1010 INODE_ITEM 0) type FILE
		transid 1455723 data_len 0 name_len 4
		name: copy
	item 69 key (256 DIR_ITEM 2917386315) itemoff 12425 itemsize 60
		location key (165407 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602088 data_len 0 name_len 30
		name: other_hourly.20220328_02:01:01
	item 70 key (256 DIR_ITEM 2935166119) itemoff 12366 itemsize 59
		location key (165199 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601810 data_len 0 name_len 29
		name: Sound_daily.20220326_01:02:01
	item 71 key (256 DIR_ITEM 2935255735) itemoff 12311 itemsize 55
		location key (165296 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601938 data_len 0 name_len 25
		name: Soft_ro.20220327_00:32:46
	item 72 key (256 DIR_ITEM 3098520192) itemoff 12251 itemsize 60
		location key (163318 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597265 data_len 0 name_len 30
		name: media_weekly.20220306_02:03:01
	item 73 key (256 DIR_ITEM 3170169652) itemoff 12195 itemsize 56
		location key (164624 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601068 data_len 0 name_len 26
		name: Video_ro.20220320_00:40:27
	item 74 key (256 DIR_ITEM 3172298544) itemoff 12135 itemsize 60
		location key (163316 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597263 data_len 0 name_len 30
		name: Video_weekly.20220306_02:03:01
	item 75 key (256 DIR_ITEM 3215925951) itemoff 12075 itemsize 60
		location key (160497 ROOT_ITEM 18446744073709551615) type DIR
		transid 1592685 data_len 0 name_len 30
		name: other_weekly.20220206_02:03:01
	item 76 key (256 DIR_ITEM 3236289372) itemoff 12015 itemsize 60
		location key (161200 ROOT_ITEM 18446744073709551615) type DIR
		transid 1594246 data_len 0 name_len 30
		name: other_weekly.20220213_02:03:01
	item 77 key (256 DIR_ITEM 3290748772) itemoff 11959 itemsize 56
		location key (163302 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597242 data_len 0 name_len 26
		name: Video_ro.20220306_00:46:14
	item 78 key (256 DIR_ITEM 3360445642) itemoff 11903 itemsize 56
		location key (162631 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596351 data_len 0 name_len 26
		name: Sound_ro.20220227_00:40:41
	item 79 key (256 DIR_ITEM 3470690534) itemoff 11847 itemsize 56
		location key (164620 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601059 data_len 0 name_len 26
		name: media_ro.20220320_00:24:47
	item 80 key (256 DIR_ITEM 3550830046) itemoff 11787 itemsize 60
		location key (159785 ROOT_ITEM 18446744073709551615) type DIR
		transid 1591389 data_len 0 name_len 30
		name: Video_weekly.20220130_02:03:01
	item 81 key (256 DIR_ITEM 3592394862) itemoff 11727 itemsize 60
		location key (159787 ROOT_ITEM 18446744073709551615) type DIR
		transid 1591391 data_len 0 name_len 30
		name: media_weekly.20220130_02:03:01
	item 82 key (256 DIR_ITEM 3676890430) itemoff 11668 itemsize 59
		location key (165201 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601812 data_len 0 name_len 29
		name: other_daily.20220326_01:02:01
	item 83 key (256 DIR_ITEM 3765355617) itemoff 11608 itemsize 60
		location key (159788 ROOT_ITEM 18446744073709551615) type DIR
		transid 1591392 data_len 0 name_len 30
		name: other_weekly.20220130_02:03:01
	item 84 key (256 DIR_ITEM 3787964139) itemoff 11554 itemsize 54
		location key (163303 ROOT_ITEM 18446744073709551615) type DIR
		transid 1597244 data_len 0 name_len 24
		name: Win_ro.20220306_00:47:32
	item 85 key (256 DIR_ITEM 3799902853) itemoff 11514 itemsize 40
		location key (1491 INODE_ITEM 0) type SYMLINK
		transid 1601935 data_len 0 name_len 10
		name: media_last
	item 86 key (256 DIR_ITEM 3872736471) itemoff 11460 itemsize 54
		location key (162645 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596372 data_len 0 name_len 24
		name: Win_ro.20220227_02:10:25
	item 87 key (256 DIR_ITEM 3951915213) itemoff 11420 itemsize 40
		location key (1495 INODE_ITEM 0) type SYMLINK
		transid 1601947 data_len 0 name_len 10
		name: Video_last
	item 88 key (256 DIR_ITEM 4079895267) itemoff 11360 itemsize 60
		location key (161197 ROOT_ITEM 18446744073709551615) type DIR
		transid 1594243 data_len 0 name_len 30
		name: Video_weekly.20220213_02:03:01
	item 89 key (256 DIR_ITEM 4084751325) itemoff 11321 itemsize 39
		location key (1493 INODE_ITEM 0) type SYMLINK
		transid 1601941 data_len 0 name_len 9
		name: Soft_last
	item 90 key (256 DIR_ITEM 4136929107) itemoff 11261 itemsize 60
		location key (161199 ROOT_ITEM 18446744073709551615) type DIR
		transid 1594245 data_len 0 name_len 30
		name: media_weekly.20220213_02:03:01
	item 91 key (256 DIR_ITEM 4142263993) itemoff 11202 itemsize 59
		location key (165099 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601681 data_len 0 name_len 29
		name: Sound_daily.20220325_01:02:01
	item 92 key (256 DIR_ITEM 4156034002) itemoff 11147 itemsize 55
		location key (162630 ROOT_ITEM 18446744073709551615) type DIR
		transid 1596348 data_len 0 name_len 25
		name: Soft_ro.20220227_00:34:48
	item 93 key (256 DIR_ITEM 4198095398) itemoff 11091 itemsize 56
		location key (165294 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601934 data_len 0 name_len 26
		name: media_ro.20220327_00:24:32
	item 94 key (256 DIR_ITEM 4258033693) itemoff 11032 itemsize 59
		location key (165198 ROOT_ITEM 18446744073709551615) type DIR
		transid 1601809 data_len 0 name_len 29
		name: Video_daily.20220326_01:02:01
	item 95 key (256 DIR_ITEM 4287185209) itemoff 10972 itemsize 60
		location key (165397 ROOT_ITEM 18446744073709551615) type DIR
		transid 1602076 data_len 0 name_len 30
		name: Sound_hourly.20220328_01:01:01
	item 96 key (256 DIR_INDEX 8) itemoff 10937 itemsize 35
		location key (11221 ROOT_ITEM 18446744073709551615) type DIR
		transid 4042 data_len 0 name_len 5
		name: other
	item 97 key (256 DIR_INDEX 9) itemoff 10902 itemsize 35
		location key (11222 ROOT_ITEM 18446744073709551615) type DIR
		transid 4058 data_len 0 name_len 5
		name: media
	item 98 key (256 DIR_INDEX 10) itemoff 10868 itemsize 34
		location key (11223 ROOT_ITEM 18446744073709551615) type DIR
		transid 4061 data_len 0 name_len 4
		name: Soft
	item 99 key (256 DIR_INDEX 11) itemoff 10835 itemsize 33
		location key (11224 ROOT_ITEM 18446744073709551615) type DIR
		transid 4062 data_len 0 name_len 3
		name: Win
	item 100 key (256 DIR_INDEX 17) itemoff 10800 itemsize 35
		location key (11288 ROOT_ITEM 18446744073709551615) type DIR
		transid 4174 data_len 0 name_len 5
		name: Video
	item 101 key (256 DIR_INDEX 51) itemoff 10765 itemsize 35
		location key (11322 ROOT_ITEM 18446744073709551615) type DIR
		transid 4223 data_len 0 name_len 5
		name: Sound
1;37mgargamel:/var/local/src/btrfs-progs-josefbacik#m Kexit

Script done on Mon 04 Apr 2022 18:38:35 PDT
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/
