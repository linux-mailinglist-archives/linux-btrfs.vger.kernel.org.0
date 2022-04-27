Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EC0512717
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 01:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiD0XFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 19:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241668AbiD0XEx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 19:04:53 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAD9B53F0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 15:59:43 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58290 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1njqdK-0004bD-Fq by authid <merlins.org> with srv_auth_plain; Wed, 27 Apr 2022 15:59:42 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1njqdK-006os5-9i; Wed, 27 Apr 2022 15:59:42 -0700
Date:   Wed, 27 Apr 2022 15:59:42 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220427225942.GX12542@merlins.org>
References: <20220427035451.GM29107@merlins.org>
 <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
 <20220427163423.GN29107@merlins.org>
 <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
 <20220427182440.GO12542@merlins.org>
 <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
 <20220427210246.GV12542@merlins.org>
 <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
 <20220427212023.GW12542@merlins.org>
 <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 05:27:44PM -0400, Josef Bacik wrote:
> Sigh, added another print_leaf.  Thanks,

doing an insert that overlaps our bytenr 7750833627136 262144
processed 1146880 of 0 possible bytes
processed 1163264 of 0 possible bytes
processed 1179648 of 0 possible bytes
processed 1196032 of 0 possible bytes
processed 1212416 of 0 possible bytes
processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr?? [5507, 108, 0] dumping paths
inode ref info failed???
leaf 15645023322112 items 123 free space 55 generation 1546750 owner ROOT_TREE
leaf 15645023322112 flags 0x1(WRITTEN) backref revision 1
fs uuid 96539b8c-ccc9-47bf-9e6c-29305890941e
chunk uuid 7257b24b-3702-41e5-8b61-6f6ea524255a
	item 0 key (5457 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1835008000
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 7000 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.690807153 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 1 key (5457 EXTENT_DATA 0) itemoff 16070 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12207705702400 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 2 key (5458 INODE_ITEM 0) itemoff 15910 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 46137344
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 176 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.690807153 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 3 key (5458 EXTENT_DATA 0) itemoff 15857 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12207791230976 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 4 key (5459 INODE_ITEM 0) itemoff 15697 itemsize 160
		generation 1482901 transid 1482901 size 262144 nbytes 74448896
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 284 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1603169214.790245505 (2020-10-19 21:46:54)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 5 key (5459 EXTENT_DATA 0) itemoff 15644 itemsize 53
		generation 1482901 type 1 (regular)
		extent data disk byte 7314895085568 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 6 key (5460 INODE_ITEM 0) itemoff 15484 itemsize 160
		generation 1439787 transid 1439787 size 262144 nbytes 398721024
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1521 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1591038874.596346316 (2020-06-01 12:14:34)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 7 key (5460 EXTENT_DATA 0) itemoff 15431 itemsize 53
		generation 1439787 type 1 (regular)
		extent data disk byte 12470912008192 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 8 key (5461 INODE_ITEM 0) itemoff 15271 itemsize 160
		generation 1482901 transid 1482901 size 262144 nbytes 25165824
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 96 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1603169214.790245505 (2020-10-19 21:46:54)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 9 key (5461 EXTENT_DATA 0) itemoff 15218 itemsize 53
		generation 1482901 type 1 (regular)
		extent data disk byte 7482517606400 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 10 key (5462 INODE_ITEM 0) itemoff 15058 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1549795328
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 5912 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.694807100 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 11 key (5462 EXTENT_DATA 0) itemoff 15005 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12207794606080 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 12 key (5463 INODE_ITEM 0) itemoff 14845 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 746848256
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 2849 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.694807100 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 13 key (5463 EXTENT_DATA 0) itemoff 14792 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12207801716736 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 14 key (5464 INODE_ITEM 0) itemoff 14632 itemsize 160
		generation 1482589 transid 1482589 size 262144 nbytes 686555136
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 2619 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1603031991.590888741 (2020-10-18 07:39:51)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 15 key (5464 EXTENT_DATA 0) itemoff 14579 itemsize 53
		generation 1482589 type 1 (regular)
		extent data disk byte 952344715264 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 16 key (5465 INODE_ITEM 0) itemoff 14419 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1620574208
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 6182 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.698807046 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 17 key (5465 EXTENT_DATA 0) itemoff 14366 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12207808765952 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 18 key (5466 INODE_ITEM 0) itemoff 14206 itemsize 160
		generation 1511028 transid 1511028 size 262144 nbytes 777256960
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 2965 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1610956842.625245815 (2021-01-18 00:00:42)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 19 key (5466 EXTENT_DATA 0) itemoff 14153 itemsize 53
		generation 1511028 type 1 (regular)
		extent data disk byte 12245962477568 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 20 key (5467 INODE_ITEM 0) itemoff 13993 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1741684736
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 6644 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.702806994 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 21 key (5467 EXTENT_DATA 0) itemoff 13940 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12207860899840 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 22 key (5468 INODE_ITEM 0) itemoff 13780 itemsize 160
		generation 1525970 transid 1525970 size 262144 nbytes 95944704
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 366 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615222802.713761123 (2021-03-08 09:00:02)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 23 key (5468 EXTENT_DATA 0) itemoff 13727 itemsize 53
		generation 1525970 type 1 (regular)
		extent data disk byte 7437273346048 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 24 key (5469 INODE_ITEM 0) itemoff 13567 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 3301703680
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 12595 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.702806994 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 25 key (5469 EXTENT_DATA 0) itemoff 13514 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12207862214656 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 26 key (5470 INODE_ITEM 0) itemoff 13354 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 2621440
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 10 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.706806940 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 27 key (5470 EXTENT_DATA 0) itemoff 13301 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12208843333632 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 28 key (5471 INODE_ITEM 0) itemoff 13141 itemsize 160
		generation 1482591 transid 1482591 size 262144 nbytes 992477184
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 3786 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1603032110.61310221 (2020-10-18 07:41:50)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 29 key (5471 EXTENT_DATA 0) itemoff 13088 itemsize 53
		generation 1482591 type 1 (regular)
		extent data disk byte 3184741777408 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 30 key (5472 INODE_ITEM 0) itemoff 12928 itemsize 160
		generation 1525968 transid 1525968 size 262144 nbytes 35389440
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 135 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615222730.746702497 (2021-03-08 08:58:50)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 31 key (5472 EXTENT_DATA 0) itemoff 12875 itemsize 53
		generation 1525968 type 1 (regular)
		extent data disk byte 8818662686720 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 32 key (5473 INODE_ITEM 0) itemoff 12715 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 2621440
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 10 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.706806940 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 33 key (5473 EXTENT_DATA 0) itemoff 12662 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12209607069696 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 34 key (5474 INODE_ITEM 0) itemoff 12502 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 521666560
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1990 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.710806887 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 35 key (5474 EXTENT_DATA 0) itemoff 12449 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12209981120512 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 36 key (5475 INODE_ITEM 0) itemoff 12289 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1441792000
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 5500 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.710806887 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 37 key (5475 EXTENT_DATA 0) itemoff 12236 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12210260660224 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 38 key (5476 INODE_ITEM 0) itemoff 12076 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1366556672
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 5213 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.710806887 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 39 key (5476 EXTENT_DATA 0) itemoff 12023 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12210686017536 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 40 key (5477 INODE_ITEM 0) itemoff 11863 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 7077888
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 27 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.714806834 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 41 key (5477 EXTENT_DATA 0) itemoff 11810 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12210843799552 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 42 key (5478 INODE_ITEM 0) itemoff 11650 itemsize 160
		generation 1482901 transid 1482901 size 262144 nbytes 2883584
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 11 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1603169214.794245452 (2020-10-19 21:46:54)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 43 key (5478 EXTENT_DATA 0) itemoff 11597 itemsize 53
		generation 1482901 type 1 (regular)
		extent data disk byte 7513535868928 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 44 key (5479 INODE_ITEM 0) itemoff 11437 itemsize 160
		generation 1509233 transid 1509233 size 262144 nbytes 201850880
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 770 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1610527033.221370143 (2021-01-13 00:37:13)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 45 key (5479 EXTENT_DATA 0) itemoff 11384 itemsize 53
		generation 1509233 type 1 (regular)
		extent data disk byte 11682327523328 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 46 key (5480 INODE_ITEM 0) itemoff 11224 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 968884224
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 3696 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.714806834 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 47 key (5480 EXTENT_DATA 0) itemoff 11171 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12210946199552 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 48 key (5481 INODE_ITEM 0) itemoff 11011 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1839464448
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 7017 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.718806781 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 49 key (5481 EXTENT_DATA 0) itemoff 10958 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12211111063552 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 50 key (5482 INODE_ITEM 0) itemoff 10798 itemsize 160
		generation 1525968 transid 1525968 size 262144 nbytes 1832124416
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 6989 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615222730.746702497 (2021-03-08 08:58:50)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 51 key (5482 EXTENT_DATA 0) itemoff 10745 itemsize 53
		generation 1525968 type 1 (regular)
		extent data disk byte 8818664521728 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 52 key (5483 INODE_ITEM 0) itemoff 10585 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 6291456
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 24 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.718806781 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 53 key (5483 EXTENT_DATA 0) itemoff 10532 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12211529863168 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 54 key (5484 INODE_ITEM 0) itemoff 10372 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 3145728
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 12 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.722806727 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 55 key (5484 EXTENT_DATA 0) itemoff 10319 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12228941504512 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 56 key (5485 INODE_ITEM 0) itemoff 10159 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 370933760
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1415 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.722806727 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 57 key (5485 EXTENT_DATA 0) itemoff 10106 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12231089319936 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 58 key (5486 INODE_ITEM 0) itemoff 9946 itemsize 160
		generation 1525967 transid 1525967 size 262144 nbytes 1185415168
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 4522 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615222694.723170138 (2021-03-08 08:58:14)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 59 key (5486 EXTENT_DATA 0) itemoff 9893 itemsize 53
		generation 1525967 type 1 (regular)
		extent data disk byte 9425865584640 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 60 key (5487 INODE_ITEM 0) itemoff 9733 itemsize 160
		generation 1501750 transid 1501750 size 262144 nbytes 1346895872
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 5138 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1609833640.497822971 (2021-01-05 00:00:40)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 61 key (5487 EXTENT_DATA 0) itemoff 9680 itemsize 53
		generation 1501750 type 1 (regular)
		extent data disk byte 7873777274880 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 62 key (5488 INODE_ITEM 0) itemoff 9520 itemsize 160
		generation 1530421 transid 1530421 size 262144 nbytes 1375207424
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 5246 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1617139918.873813209 (2021-03-30 14:31:58)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 63 key (5488 EXTENT_DATA 0) itemoff 9467 itemsize 53
		generation 1530421 type 1 (regular)
		extent data disk byte 7441055866880 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 64 key (5489 INODE_ITEM 0) itemoff 9307 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 2621440
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 10 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.726806674 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 65 key (5489 EXTENT_DATA 0) itemoff 9254 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12231929507840 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 66 key (5490 INODE_ITEM 0) itemoff 9094 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 3932160
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 15 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.730806621 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 67 key (5490 EXTENT_DATA 0) itemoff 9041 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12232045236224 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 68 key (5491 INODE_ITEM 0) itemoff 8881 itemsize 160
		generation 1482911 transid 1482911 size 262144 nbytes 17301504
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 66 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1603169591.357269745 (2020-10-19 21:53:11)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 69 key (5491 EXTENT_DATA 0) itemoff 8828 itemsize 53
		generation 1482911 type 1 (regular)
		extent data disk byte 10889918492672 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 70 key (5492 INODE_ITEM 0) itemoff 8668 itemsize 160
		generation 1482901 transid 1482901 size 262144 nbytes 26214400
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 100 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1603169214.794245452 (2020-10-19 21:46:54)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 71 key (5492 EXTENT_DATA 0) itemoff 8615 itemsize 53
		generation 1482901 type 1 (regular)
		extent data disk byte 7515684741120 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 72 key (5493 INODE_ITEM 0) itemoff 8455 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 18087936
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 69 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.730806621 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 73 key (5493 EXTENT_DATA 0) itemoff 8402 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233142820864 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 74 key (5494 INODE_ITEM 0) itemoff 8242 itemsize 160
		generation 1439787 transid 1439787 size 262144 nbytes 54263808
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 207 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1591038874.720343072 (2020-06-01 12:14:34)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 75 key (5494 EXTENT_DATA 0) itemoff 8189 itemsize 53
		generation 1439787 type 1 (regular)
		extent data disk byte 12473955663872 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 76 key (5495 INODE_ITEM 0) itemoff 8029 itemsize 160
		generation 1482908 transid 1482908 size 262144 nbytes 2883584
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 11 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1603169482.790704298 (2020-10-19 21:51:22)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 77 key (5495 EXTENT_DATA 0) itemoff 7976 itemsize 53
		generation 1482908 type 1 (regular)
		extent data disk byte 9382917087232 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 78 key (5496 INODE_ITEM 0) itemoff 7816 itemsize 160
		generation 1482593 transid 1482593 size 262144 nbytes 873725952
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 3333 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1603032208.635996917 (2020-10-18 07:43:28)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 79 key (5496 EXTENT_DATA 0) itemoff 7763 itemsize 53
		generation 1482593 type 1 (regular)
		extent data disk byte 4583295479808 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 80 key (5497 INODE_ITEM 0) itemoff 7603 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1531183104
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 5841 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.734806568 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 81 key (5497 EXTENT_DATA 0) itemoff 7550 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233145966592 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 82 key (5498 INODE_ITEM 0) itemoff 7390 itemsize 160
		generation 1439787 transid 1439787 size 262144 nbytes 18612224
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 71 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1591038874.724342967 (2020-06-01 12:14:34)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 83 key (5498 EXTENT_DATA 0) itemoff 7337 itemsize 53
		generation 1439787 type 1 (regular)
		extent data disk byte 12473955926016 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 84 key (5499 INODE_ITEM 0) itemoff 7177 itemsize 160
		generation 1525968 transid 1525968 size 262144 nbytes 432013312
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1648 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615222730.750702446 (2021-03-08 08:58:50)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 85 key (5499 EXTENT_DATA 0) itemoff 7124 itemsize 53
		generation 1525968 type 1 (regular)
		extent data disk byte 8818666881024 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 86 key (5500 INODE_ITEM 0) itemoff 6964 itemsize 160
		generation 1482593 transid 1482593 size 262144 nbytes 266600448
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1017 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1603032208.639996865 (2020-10-18 07:43:28)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 87 key (5500 EXTENT_DATA 0) itemoff 6911 itemsize 53
		generation 1482593 type 1 (regular)
		extent data disk byte 4654161346560 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 88 key (5501 INODE_ITEM 0) itemoff 6751 itemsize 160
		generation 1525961 transid 1525961 size 262144 nbytes 1067450368
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 4072 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615222478.881970135 (2021-03-08 08:54:38)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 89 key (5501 EXTENT_DATA 0) itemoff 6698 itemsize 53
		generation 1525961 type 1 (regular)
		extent data disk byte 7982222049280 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 90 key (5502 INODE_ITEM 0) itemoff 6538 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 562561024
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 2146 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.734806568 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 91 key (5502 EXTENT_DATA 0) itemoff 6485 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233186123776 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 92 key (5503 INODE_ITEM 0) itemoff 6325 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 3145728
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 12 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.734806568 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 93 key (5503 EXTENT_DATA 0) itemoff 6272 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233187991552 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 94 key (5504 INODE_ITEM 0) itemoff 6112 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1200095232
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 4578 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.738806514 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 95 key (5504 EXTENT_DATA 0) itemoff 6059 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233257922560 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 96 key (5505 INODE_ITEM 0) itemoff 5899 itemsize 160
		generation 1525961 transid 1525961 size 262144 nbytes 71827456
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 274 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615222478.885970083 (2021-03-08 08:54:38)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 97 key (5505 EXTENT_DATA 0) itemoff 5846 itemsize 53
		generation 1525961 type 1 (regular)
		extent data disk byte 8013364232192 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 98 key (5506 INODE_ITEM 0) itemoff 5686 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 4718592
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 18 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.738806514 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 99 key (5506 EXTENT_DATA 0) itemoff 5633 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233379401728 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 100 key (5507 INODE_ITEM 0) itemoff 5473 itemsize 160
		generation 1525959 transid 1525959 size 262144 nbytes 294649856
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1124 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615222403.234950654 (2021-03-08 08:53:23)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 101 key (5507 EXTENT_DATA 0) itemoff 5420 itemsize 53
		generation 1525959 type 1 (regular)
		extent data disk byte 7750833868800 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 102 key (5508 INODE_ITEM 0) itemoff 5260 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 362807296
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1384 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.742806462 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 103 key (5508 EXTENT_DATA 0) itemoff 5207 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233610690560 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 104 key (5509 INODE_ITEM 0) itemoff 5047 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 766246912
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 2923 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.742806462 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 105 key (5509 EXTENT_DATA 0) itemoff 4994 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233544069120 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 106 key (5510 INODE_ITEM 0) itemoff 4834 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1768685568
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 6747 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.746806408 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 107 key (5510 EXTENT_DATA 0) itemoff 4781 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233581916160 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 108 key (5511 INODE_ITEM 0) itemoff 4621 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 958398464
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 3656 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.746806408 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 109 key (5511 EXTENT_DATA 0) itemoff 4568 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233725329408 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 110 key (5512 INODE_ITEM 0) itemoff 4408 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 408420352
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1558 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.750806355 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 111 key (5512 EXTENT_DATA 0) itemoff 4355 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233793339392 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 112 key (5513 INODE_ITEM 0) itemoff 4195 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 1253834752
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 4783 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.750806355 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 113 key (5513 EXTENT_DATA 0) itemoff 4142 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233785352192 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 114 key (5514 INODE_ITEM 0) itemoff 3982 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 8126464
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 31 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.754806301 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 115 key (5514 EXTENT_DATA 0) itemoff 3929 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233813143552 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 116 key (5515 INODE_ITEM 0) itemoff 3769 itemsize 160
		generation 1439787 transid 1439787 size 262144 nbytes 44826624
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 171 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1591038874.816340561 (2020-06-01 12:14:34)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 117 key (5515 EXTENT_DATA 0) itemoff 3716 itemsize 53
		generation 1439787 type 1 (regular)
		extent data disk byte 12474011467776 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 118 key (5516 INODE_ITEM 0) itemoff 3556 itemsize 160
		generation 1546750 transid 1546750 size 262144 nbytes 2405433344
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 9176 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1621321238.520473625 (2021-05-18 00:00:38)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 119 key (5516 EXTENT_DATA 0) itemoff 3503 itemsize 53
		generation 1546750 type 1 (regular)
		extent data disk byte 12251618267136 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 120 key (5517 INODE_ITEM 0) itemoff 3343 itemsize 160
		generation 1526158 transid 1526158 size 262144 nbytes 40370176
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 154 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615276843.758806249 (2021-03-09 00:00:43)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
	item 121 key (5517 EXTENT_DATA 0) itemoff 3290 itemsize 53
		generation 1526158 type 1 (regular)
		extent data disk byte 12233872674816 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 122 key (5518 INODE_ITEM 0) itemoff 3130 itemsize 160
		generation 1525963 transid 1525963 size 262144 nbytes 57933824
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 221 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
		atime 0.0 (1969-12-31 16:00:00)
		ctime 1615222550.521041172 (2021-03-08 08:55:50)
		mtime 0.0 (1969-12-31 16:00:00)
		otime 0.0 (1969-12-31 16:00:00)
elem_cnt 0 elem_missed 0 ret -2
Failed to find [7750833868800, 168, 262144]
Segmentation fault


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
