Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EA252292B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 03:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiEKBsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 21:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbiEKBsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 21:48:30 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E826FD28
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 18:48:28 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58520 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nobSl-0007y1-7v by authid <merlins.org> with srv_auth_plain; Tue, 10 May 2022 18:48:27 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nobSl-001qK4-1P; Tue, 10 May 2022 18:48:27 -0700
Date:   Tue, 10 May 2022 18:48:27 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220511014827.GL12542@merlins.org>
References: <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
 <20220510143739.GC12542@merlins.org>
 <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
 <20220510160600.GG12542@merlins.org>
 <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
 <20220510164448.GI12542@merlins.org>
 <20220510211507.GJ12542@merlins.org>
 <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com>
 <20220511000815.GK12542@merlins.org>
 <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 10, 2022 at 08:28:09PM -0400, Josef Bacik wrote:
> Ok the csum errors I expect.  I've made some changes and pushed them,
> re-run the rescue init-extent-tree again.  Run check without --repair.
> If it complains about extent backrefs then I fucked up, I just need
> like 20ish lines of that output to see what I'm messing up.  If it
> only complains about csums then we won, we can run btrfs check
> --init-csum-tree, and then --repair.  Thanks,

searching 165298 for bad extents
processed 108756992 of 108756992 possible bytes, 100%
searching 165299 for bad extents
processed 75792384 of 75792384 possible bytes, 100%
searching 18446744073709551607 for bad extents
processed 16384 of 16384 possible bytes, 100%
Recording extents for root 3
processed 1556480 of 0 possible bytes, 0%
Recording extents for root 1
processed 1474560 of 0 possible bytes, 0%
doing roots
Recording extents for root 4
processed 1032192 of 1064960 possible bytes, 96%
Recording extents for root 5
processed 10960896 of 10977280 possible bytes, 99%
Recording extents for root 7
processed 16384 of 16545742848 possible bytes, 0%
Recording extents for root 9
processed 16384 of 16384 possible bytes, 100%
Recording extents for root 11221
processed 49152 of 256016384 possible bytes, 0%
Recording extents for root 11222
processed 49479680 of 49479680 possible bytes, 100%
Recording extents for root 11223
processed 1619902464 of 1635549184 possible bytes, 99%Ignoring transid failure
processed 1635319808 of 1635549184 possible bytes, 99%
Recording extents for root 11224
processed 75792384 of 75792384 possible bytes, 100%
Recording extents for root 159785
processed 108429312 of 108429312 possible bytes, 100%
Recording extents for root 159787
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 160494
processed 1425408 of 108560384 possible bytes, 1%
Recording extents for root 160496
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 161197
processed 770048 of 108544000 possible bytes, 0%
Recording extents for root 161199
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 162628
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 162632
processed 2441216 of 108691456 possible bytes, 2%
Recording extents for root 162645
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 163298
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 163302
processed 966656 of 108691456 possible bytes, 0%
Recording extents for root 163303
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 163316
processed 933888 of 108691456 possible bytes, 0%
Recording extents for root 163318
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 163916
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 163920
processed 966656 of 108691456 possible bytes, 0%
Recording extents for root 163921
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 164620
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 164624
processed 98304 of 109445120 possible bytes, 0%
Recording extents for root 164633
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 165098
processed 1015808 of 108756992 possible bytes, 0%
Recording extents for root 165100
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 165198
processed 491520 of 108756992 possible bytes, 0%adding a bytenr that overlaps our thing, dumping paths for [76300, 108, 0]
misc/file
doing an insert of the bytenr
doing an insert that overlaps our bytenr 10467695652864 8675328
processed 983040 of 108756992 possible bytes, 0%
Recording extents for root 165200
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 165294
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 165298
processed 524288 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
misc/file
processed 1015808 of 108756992 possible bytes, 0%
Recording extents for root 165299
processed 16384 of 75792384 possible bytes, 0%
Recording extents for root 18446744073709551607
processed 16384 of 16384 possible bytes, 100%
doing block accounting
doing close???
Init extent tree finished, you can run check now


gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check /dev/mapper/dshelf1
Opening filesystem to check...
FS_INFO IS 0x55611fc9ee50
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55611fc9ee50
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
[1/7] checking root items
checksum verify failed on 15645954129920 wanted 0x085fc24a found 0x941acdde
checksum verify failed on 15645954195456 wanted 0x6c1c72a4 found 0xb06d5dd9
checksum verify failed on 15645608116224 wanted 0x31706547 found 0x314fad1d
checksum verify failed on 15645262413824 wanted 0x3affbd35 found 0x96d53d25
checksum verify failed on 13577199878144 wanted 0x6e9e8bc6 found 0x61063457
checksum verify failed on 13577399156736 wanted 0x2869b8c7 found 0xbb1119e1
checksum verify failed on 12512437698560 wanted 0xca43b3f8 found 0xd7f6db69
checksum verify failed on 13577503686656 wanted 0xd81b7702 found 0x95a3c9a6
checksum verify failed on 15645781344256 wanted 0xb81e3df4 found 0xb5c70846
checksum verify failed on 13577178939392 wanted 0x2cb83118 found 0x63f0b6bf
checksum verify failed on 15645419667456 wanted 0xde0dab28 found 0x3ceddd16
checksum verify failed on 13577821011968 wanted 0x9a29aff5 found 0x2cdff391
checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
[2/7] checking extents
(...)
root 165299 inode 78934 errors 1000, some csum missing
root 165299 inode 78935 errors 1000, some csum missing
root 165299 inode 78936 errors 1000, some csum missing
root 165299 inode 78937 errors 1000, some csum missing
root 165299 inode 78938 errors 1000, some csum missing
root 165299 inode 78939 errors 1000, some csum missing
root 165299 inode 78940 errors 1000, some csum missing
root 165299 inode 78941 errors 1000, some csum missing
root 165299 inode 78942 errors 1000, some csum missing
root 165299 inode 78943 errors 1000, some csum missing
root 165299 inode 78945 errors 1, no inode item
root 165299 inode 78946 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 2 namelen 12 name screwloo.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78947 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 3 namelen 10 name fround.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78948 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 4 namelen 10 name ginkun.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78949 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 5 namelen 12 name cobracom.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78950 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 6 namelen 11 name wseries.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78951 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 7 namelen 9 name youma.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78952 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 8 namelen 11 name mswordu.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78953 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 9 namelen 12 name bijokkog.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78954 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 10 namelen 8 name kaos.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78955 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 11 namelen 10 name toggle.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78956 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 12 namelen 11 name jungler.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78957 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 13 namelen 10 name wallst.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78958 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 14 namelen 11 name bkrtmaq.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78959 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 15 namelen 12 name spcforce.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78960 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 16 namelen 10 name bstars.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78961 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 17 namelen 12 name bionicc2.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78962 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 18 namelen 10 name crater.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78963 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 19 namelen 12 name mjcamera.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78964 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 20 namelen 10 name aurail.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78965 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 21 namelen 12 name pc_radrc.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78966 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 22 namelen 11 name mgakuen.zip filetype 1 errors 3, no dir item, no dir index
root 165299 inode 78967 errors 3000, some csum missing, link count wrong
        unresolved ref dir 78945 index 23 namelen 12 name blueprnj.zip filetype 1 errors 3, no dir item, no dir index
(...)
root 165299 inode 95686 errors 1000, some csum missing
root 165299 inode 95687 errors 1000, some csum missing
root 165299 inode 95688 errors 1000, some csum missing
root 165299 inode 95689 errors 1000, some csum missing
root 165299 inode 95690 errors 1000, some csum missing
root 165299 inode 95692 errors 1000, some csum missing
root 165299 inode 95697 errors 1000, some csum missing
root 165299 inode 95698 errors 1000, some csum missing
root 165299 inode 95699 errors 3000, some csum missing, link count wrong
        unresolved ref dir 76854 index 28 namelen 23 name gmapsupp_micronesia.img filetype 1 errors 3, no dir item, no dir index
root 165299 inode 95700 errors 1000, some csum missing
root 165299 inode 95701 errors 3000, some csum missing, link count wrong
        unresolved ref dir 76854 index 30 namelen 24 name gmapsupp_osm_NZ_Topo.img filetype 1 errors 3, no dir item, no dir index
root 165299 inode 95702 errors 1000, some csum missing
root 165299 inode 95703 errors 3000, some csum missing, link count wrong
        unresolved ref dir 76854 index 32 namelen 19 name gmapsupp_osm_AK.img filetype 1 errors 3, no dir item, no dir index
root 165299 inode 95704 errors 1000, some csum missing
root 165299 inode 95705 errors 1000, some csum missing
ERROR: errors found in fs roots
Opening filesystem to check...
JOSEF: root 9
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
cache and super generation don't match, space cache will be invalidated
found 14180032393216 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 2083684352
total fs tree bytes: 1891270656
total extent tree bytes: 188301312
btree space waste bytes: 334181897
file data blocks allocated: 14814349185024
 referenced 14828266401792
gargamel:/var/local/src/btrfs-
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
