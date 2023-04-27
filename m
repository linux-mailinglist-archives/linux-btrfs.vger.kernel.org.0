Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042F26F0718
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 16:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbjD0OQn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 10:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbjD0OQl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 10:16:41 -0400
Received: from out28-42.mail.aliyun.com (out28-42.mail.aliyun.com [115.124.28.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B7C449D
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 07:16:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00634413-8.65166e-05-0.993569;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.SSNPS5b_1682604988;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.SSNPS5b_1682604988)
          by smtp.aliyun-inc.com;
          Thu, 27 Apr 2023 22:16:28 +0800
Date:   Thu, 27 Apr 2023 22:16:30 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: fstests(generic/251) triggered a warn(bad key order, sibling blocks)
In-Reply-To: <20230423222213.5391.409509F4@e16-tech.com>
References: <20230423222213.5391.409509F4@e16-tech.com>
Message-Id: <20230427221629.289A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> Hi,
> 
> https://lore.kernel.org/linux-btrfs/20230421025046.4008499-17-tj@kernel.org/T/#u
> 
> fstests(generic/251) triggered a warn(bad key order, sibling blocks).
> 

we hit another error when try to reproduce  fstests(generic/251)
# on the same server with ECC memory.

251.full:

_check_btrfs_filesystem: filesystem on /dev/sdb2 is inconsistent
*** fsck.btrfs output ***
[1/7] checking root items
[2/7] checking extents
checksum verify failed on 615366656 wanted 0x00000000 found 0xd43aa532
checksum verify failed on 615366656 wanted 0x00000000 found 0xd43aa532
bad tree block 615366656, bytenr mismatch, want=615366656, have=0
owner ref check failed [615366656 16384]
ref mismatch on [1895432192 36864] extent item 1, found 0
data extent[1895432192, 36864] bytenr mimsmatch, extent item bytenr 1895432192 file item bytenr 0
data extent[1895432192, 36864] referencer count mismatch (root 5 owner 829608 offset 0) wanted 1 have 0
backpointer mismatch on [1895432192 36864]
owner ref check failed [1895432192 36864]
ref mismatch on [1895489536 36864] extent item 1, found 0
data extent[1895489536, 36864] bytenr mimsmatch, extent item bytenr 1895489536 file item bytenr 0
data extent[1895489536, 36864] referencer count mismatch (root 5 owner 829616 offset 0) wanted 1 have 0
backpointer mismatch on [1895489536 36864]
owner ref check failed [1895489536 36864]
ref mismatch on [1895677952 16384] extent item 1, found 0
data extent[1895677952, 16384] bytenr mimsmatch, extent item bytenr 1895677952 file item bytenr 0
data extent[1895677952, 16384] referencer count mismatch (root 5 owner 829654 offset 0) wanted 1 have 0
backpointer mismatch on [1895677952 16384]
owner ref check failed [1895677952 16384]
ref mismatch on [1895907328 45056] extent item 1, found 0
data extent[1895907328, 45056] bytenr mimsmatch, extent item bytenr 1895907328 file item bytenr 0
data extent[1895907328, 45056] referencer count mismatch (root 5 owner 829702 offset 0) wanted 1 have 0
backpointer mismatch on [1895907328 45056]
owner ref check failed [1895907328 45056]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space tree
[4/7] checking fs roots
checksum verify failed on 615366656 wanted 0x00000000 found 0xd43aa532
checksum verify failed on 615366656 wanted 0x00000000 found 0xd43aa532
bad tree block 615366656, bytenr mismatch, want=615366656, have=0
root 5 inode 829526 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 27 namelen 38 name 4a2138f09604e89e9b478e1dbb78436e03bb13 filetype 1 errors 4, no inode ref
root 5 inode 829535 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 28 namelen 38 name aec3a8926a8f19fb318d168cc03b80dd54524e filetype 1 errors 4, no inode ref
root 5 inode 829544 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 29 namelen 38 name e7ef03c65296e11cef549995bc209af41706b5 filetype 1 errors 4, no inode ref
root 5 inode 829553 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 30 namelen 38 name 98371d8f51e5ba0dbb7ff4bc25a41700bc7876 filetype 1 errors 4, no inode ref
root 5 inode 829561 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 31 namelen 38 name 84e832f2ae77497154654ac760154a46bb3135 filetype 1 errors 4, no inode ref
root 5 inode 829571 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 32 namelen 38 name c0529b0d009a1fe96d3379a57499ff3cfc012d filetype 1 errors 4, no inode ref
root 5 inode 829580 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 33 namelen 38 name c9cde7ff73868d8f1470cb2d9ee1a08310e5bd filetype 1 errors 4, no inode ref
root 5 inode 829589 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 34 namelen 38 name 6634b5a8c3759f84ffd35f9edd89a6a34022c1 filetype 1 errors 4, no inode ref
root 5 inode 829598 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 35 namelen 38 name f60232e3f9597699af2190770cafc5c3fbc1ef filetype 1 errors 4, no inode ref
root 5 inode 829608 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 36 namelen 38 name 9d8f1c507adf1cdeb4aa50c647e35767b984f3 filetype 1 errors 4, no inode ref
root 5 inode 829616 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 37 namelen 38 name d51661d637e8dbb6997388b41b75b3328139d2 filetype 1 errors 4, no inode ref
root 5 inode 829627 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 38 namelen 38 name 9ae4afbfe26d357f263fb6917aaee2abaadf43 filetype 1 errors 4, no inode ref
root 5 inode 829636 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 39 namelen 38 name 55d49dd4b0eb753231863fd8618de0afa670a5 filetype 1 errors 4, no inode ref
root 5 inode 829645 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 40 namelen 38 name 9f1e9978b00d783c1b76be7f145ab787b9d1b8 filetype 1 errors 4, no inode ref
root 5 inode 829654 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 41 namelen 38 name 4c287f115032fe07d8141267410ad10ce3a7f5 filetype 1 errors 4, no inode ref
root 5 inode 829663 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 42 namelen 38 name f74f49977588c6b0c810e0452d2dc03f0099d9 filetype 1 errors 4, no inode ref
root 5 inode 829672 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 43 namelen 38 name 2081c669e70248c5290bbeb168ce8e90afd9f2 filetype 1 errors 4, no inode ref
root 5 inode 829681 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 44 namelen 38 name 64186cf0cc4dabb3fa65c6bf25bcdf5d7a508d filetype 1 errors 4, no inode ref
root 5 inode 829691 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 45 namelen 38 name d70773aaadd9cbc47295f1b79028503cbdca9c filetype 1 errors 4, no inode ref
root 5 inode 829702 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 46 namelen 38 name 0f1d90ccba775c5fc52a0ac7579a6054e4c4c8 filetype 1 errors 4, no inode ref
root 5 inode 829712 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 47 namelen 38 name 40b51c823e976df979253877f5b12399950153 filetype 1 errors 4, no inode ref
root 5 inode 829718 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 48 namelen 38 name ac22dcb10ef26f25c3eae4987e426d0c29722d filetype 1 errors 4, no inode ref
root 5 inode 829724 errors 2001, no inode item, link count wrong
	unresolved ref dir 829283 index 49 namelen 38 name 430a0b754369b4892523a43527c1f346baaa9d filetype 1 errors 4, no inode ref
root 5 inode 829745 errors 2001, no inode item, link count wrong
	unresolved ref dir 765598 index 253 namelen 2 name 7e filetype 2 errors 4, no inode ref
root 5 inode 830097 errors 2001, no inode item, link count wrong
	unresolved ref dir 765598 index 254 namelen 2 name 48 filetype 2 errors 4, no inode ref
root 5 inode 830391 errors 2001, no inode item, link count wrong
	unresolved ref dir 765598 index 255 namelen 2 name 2b filetype 2 errors 4, no inode ref
root 5 inode 830891 errors 2001, no inode item, link count wrong
	unresolved ref dir 765598 index 256 namelen 2 name 3e filetype 2 errors 4, no inode ref
root 5 inode 831196 errors 2001, no inode item, link count wrong
	unresolved ref dir 765598 index 257 namelen 2 name d5 filetype 2 errors 4, no inode ref
root 5 inode 831520 errors 2001, no inode item, link count wrong
	unresolved ref dir 765598 index 258 namelen 2 name d3 filetype 2 errors 4, no inode ref
root 5 inode 831910 errors 2001, no inode item, link count wrong
	unresolved ref dir 765598 index 259 namelen 2 name 24 filetype 2 errors 4, no inode ref
root 5 inode 832249 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 4 namelen 11 name description filetype 1 errors 4, no inode ref
root 5 inode 832258 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 5 namelen 4 name refs filetype 2 errors 4, no inode ref
root 5 inode 832328 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 6 namelen 9 name ORIG_HEAD filetype 1 errors 4, no inode ref
root 5 inode 832336 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 7 namelen 5 name index filetype 1 errors 4, no inode ref
root 5 inode 832352 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 8 namelen 10 name FETCH_HEAD filetype 1 errors 4, no inode ref
root 5 inode 832361 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 9 namelen 11 name packed-refs filetype 1 errors 4, no inode ref
root 5 inode 832370 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 10 namelen 4 name logs filetype 2 errors 4, no inode ref
root 5 inode 832448 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 11 namelen 4 name HEAD filetype 1 errors 4, no inode ref
root 5 inode 832457 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 12 namelen 6 name config filetype 1 errors 4, no inode ref
root 5 inode 832466 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 13 namelen 8 name branches filetype 2 errors 4, no inode ref
root 5 inode 832476 errors 2001, no inode item, link count wrong
	unresolved ref dir 765589 index 14 namelen 5 name hooks filetype 2 errors 4, no inode ref
root 5 inode 832609 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 20 namelen 3 name ltp filetype 2 errors 4, no inode ref
root 5 inode 832785 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 21 namelen 10 name .gitignore filetype 1 errors 4, no inode ref
root 5 inode 832795 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 22 namelen 8 name Makefile filetype 1 errors 4, no inode ref
root 5 inode 832804 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 23 namelen 8 name Makepkgs filetype 1 errors 4, no inode ref
root 5 inode 832811 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 24 namelen 22 name README.config-sections filetype 1 errors 4, no inode ref
root 5 inode 832821 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 25 namelen 20 name README.device-mapper filetype 1 errors 4, no inode ref
root 5 inode 832828 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 26 namelen 11 name README.fuse filetype 1 errors 4, no inode ref
root 5 inode 832838 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 27 namelen 14 name README.overlay filetype 1 errors 4, no inode ref
root 5 inode 832846 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 28 namelen 15 name README.selftest filetype 1 errors 4, no inode ref
root 5 inode 832856 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 29 namelen 7 name VERSION filetype 1 errors 4, no inode ref
root 5 inode 832865 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 30 namelen 12 name acinclude.m4 filetype 1 errors 4, no inode ref
root 5 inode 832874 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 31 namelen 12 name configure.ac filetype 1 errors 4, no inode ref
root 5 inode 832883 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 32 namelen 5 name crash filetype 2 errors 4, no inode ref
root 5 inode 832918 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 33 namelen 3 name doc filetype 2 errors 4, no inode ref
root 5 inode 832967 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 34 namelen 20 name local.config.example filetype 1 errors 4, no inode ref
root 5 inode 832976 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 35 namelen 7 name lsqa.pl filetype 1 errors 4, no inode ref
root 5 inode 832984 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 36 namelen 2 name m4 filetype 2 errors 4, no inode ref
root 5 inode 833194 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 37 namelen 3 name new filetype 1 errors 4, no inode ref
root 5 inode 833203 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 38 namelen 13 name randomize.awk filetype 1 errors 4, no inode ref
root 5 inode 833211 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 39 namelen 10 name release.sh filetype 1 errors 4, no inode ref
root 5 inode 833219 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 40 namelen 5 name setup filetype 1 errors 4, no inode ref
root 5 inode 833227 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 41 namelen 4 name soak filetype 1 errors 4, no inode ref
root 5 inode 833235 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 42 namelen 8 name LICENSES filetype 2 errors 4, no inode ref
root 5 inode 833251 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 43 namelen 6 name common filetype 2 errors 4, no inode ref
root 5 inode 833662 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 44 namelen 7 name include filetype 2 errors 4, no inode ref
root 5 inode 833845 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 45 namelen 3 name src filetype 2 errors 4, no inode ref
root 5 inode 836984 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 46 namelen 14 name autom4te.cache filetype 2 errors 4, no inode ref
root 5 inode 837058 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 47 namelen 5 name build filetype 2 errors 4, no inode ref
root 5 inode 837129 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 48 namelen 7 name configs filetype 2 errors 4, no inode ref
root 5 inode 837156 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 49 namelen 3 name lib filetype 2 errors 4, no inode ref
root 5 inode 837686 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 50 namelen 5 name tests filetype 2 errors 4, no inode ref
root 5 inode 881143 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 51 namelen 5 name tools filetype 2 errors 4, no inode ref
root 5 inode 881304 errors 2001, no inode item, link count wrong
	unresolved ref dir 765513 index 52 namelen 7 name results filetype 2 errors 4, no inode ref
root 5 inode 1057163 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 71 namelen 1 name 2 filetype 2 errors 4, no inode ref
root 5 inode 1386510 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 90 namelen 1 name 3 filetype 2 errors 4, no inode ref
root 5 inode 1814171 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 120 namelen 1 name 4 filetype 2 errors 4, no inode ref
root 5 inode 2063136 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 134 namelen 1 name 5 filetype 2 errors 4, no inode ref
root 5 inode 2279877 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 142 namelen 1 name 6 filetype 2 errors 4, no inode ref
root 5 inode 2382051 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 156 namelen 1 name 7 filetype 2 errors 4, no inode ref
root 5 inode 2606408 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 169 namelen 1 name 8 filetype 2 errors 4, no inode ref
root 5 inode 2736066 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 172 namelen 1 name 9 filetype 2 errors 4, no inode ref
root 5 inode 2805482 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 179 namelen 2 name 10 filetype 2 errors 4, no inode ref
root 5 inode 2931749 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 184 namelen 2 name 11 filetype 2 errors 4, no inode ref
root 5 inode 2939090 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 185 namelen 2 name 12 filetype 2 errors 4, no inode ref
root 5 inode 2996849 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 190 namelen 2 name 13 filetype 2 errors 4, no inode ref
root 5 inode 3094507 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 193 namelen 2 name 14 filetype 2 errors 4, no inode ref
root 5 inode 3107506 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 194 namelen 2 name 15 filetype 2 errors 4, no inode ref
root 5 inode 3149172 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 196 namelen 2 name 16 filetype 2 errors 4, no inode ref
root 5 inode 3150858 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 198 namelen 2 name 17 filetype 2 errors 4, no inode ref
root 5 inode 3199556 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 199 namelen 2 name 18 filetype 2 errors 4, no inode ref
root 5 inode 3223712 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 200 namelen 2 name 19 filetype 2 errors 4, no inode ref
root 5 inode 3237036 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 201 namelen 2 name 20 filetype 2 errors 4, no inode ref
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/sdb2
UUID: d988270a-c8b6-4ea7-ba8f-941c28b7ea78
The following tree block(s) is corrupted in tree 5:
	tree block bytenr: 492945408, level: 1, node key: (829526, 1, 0)
found 9116647424 bytes used, error(s) found
total csum bytes: 8406160
total tree bytes: 508723200
total fs tree bytes: 486572032
total extent tree bytes: 10289152
btree space waste bytes: 182865192
file data blocks allocated: 8607772672
 referenced 8607772672
*** end fsck.btrfs output
*** mount output ***
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
devtmpfs on /dev type devtmpfs (rw,nosuid,size=4096k,nr_inodes=1048576,mode=755,inode64)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,inode64)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,size=39595128k,nr_inodes=819200,mode=755,inode64)
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
bpf on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
/dev/sda2 on / type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=762)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
nfsd on /proc/fs/nfsd type nfsd (rw,relatime)
fusectl on /sys/fs/fuse/connections type fusectl (rw,nosuid,nodev,noexec,relatime)
configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)
/dev/sda1 on /boot/efi type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=ascii,shortname=winnt,errors=remount-ro)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
tmpfs on /run/user/0 type tmpfs (rw,nosuid,nodev,relatime,size=19797560k,nr_inodes=4949390,mode=700,inode64)
T640:/ssd on /ssd type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,nconnect=8,max_connect=32,timeo=600,retrans=2,sec=sys,clientaddr=192.168.2.76,local_lock=none,addr=192.168.2.64)
T640:/ssd/bio-ref on /usr/bio-ref type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,nconnect=8,max_connect=32,timeo=600,retrans=2,sec=sys,clientaddr=192.168.2.76,local_lock=none,addr=192.168.2.64)
T640:/ssd/nodetmp/T7610 on /nodetmp type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,nconnect=8,max_connect=32,timeo=600,retrans=2,sec=sys,clientaddr=192.168.2.76,local_lock=none,addr=192.168.2.64)
T640:/ssd/hpc-bio on /ssd/hpc-bio type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,nconnect=8,max_connect=32,timeo=600,retrans=2,sec=sys,clientaddr=192.168.2.76,local_lock=none,addr=192.168.2.64)
*** end mount output

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/04/27


