Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7274752262D
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiEJVPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 17:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiEJVPO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 17:15:14 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD122944AE
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 14:15:08 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58516 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1noXCF-0000qw-OG by authid <merlins.org> with srv_auth_plain; Tue, 10 May 2022 14:15:07 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1noXCF-001ThG-Ia; Tue, 10 May 2022 14:15:07 -0700
Date:   Tue, 10 May 2022 14:15:07 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220510211507.GJ12542@merlins.org>
References: <CAEzrpqfePZhBvRy_G2kpo=oRPqoJx=F3Xmh7YF5m6pjMjGJ=Fg@mail.gmail.com>
 <20220510013201.GH29107@merlins.org>
 <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
 <20220510021916.GB12542@merlins.org>
 <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
 <20220510143739.GC12542@merlins.org>
 <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
 <20220510160600.GG12542@merlins.org>
 <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
 <20220510164448.GI12542@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510164448.GI12542@merlins.org>
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

I have
./btrfs check --repair /dev/mapper/dshelf1
on hold (^Z), waiting for your ok to proceed.

All good to continue?

On Tue, May 10, 2022 at 09:44:48AM -0700, Marc MERLIN wrote:
> On Tue, May 10, 2022 at 12:14:37PM -0400, Josef Bacik wrote:
> > Ah duh, we delete it the first time, but then we find another
> > overlapping extent and we try to delete it again and it's not there.
> > I've fixed this up, try again please.  Thanks,
> 
> good news, it worked! :)
> 
> I started a simple ./btrfs check --repair /dev/mapper/dshelf1
> did you want me to add options to it or run as is?
> 
> doing roots
> Recording extents for root 4
> processed 1032192 of 1064960 possible bytes, 96%
> Recording extents for root 5
> processed 10960896 of 10977280 possible bytes, 99%
> Recording extents for root 7
> processed 16384 of 16545742848 possible bytes, 0%
> Recording extents for root 9
> processed 16384 of 16384 possible bytes, 100%
> Recording extents for root 11221
> processed 16384 of 255983616 possible bytes, 0%
> Recording extents for root 11222
> processed 49479680 of 49479680 possible bytes, 100%
> Recording extents for root 11223
> processed 1619902464 of 1635549184 possible bytes, 99%Ignoring transid failure
> processed 1635319808 of 1635549184 possible bytes, 99%
> Recording extents for root 11224
> processed 75792384 of 75792384 possible bytes, 100%
> Recording extents for root 159785
> processed 108429312 of 108429312 possible bytes, 100%
> Recording extents for root 159787
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 160494
> processed 1425408 of 108560384 possible bytes, 1%
> Recording extents for root 160496
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 161197
> processed 770048 of 108544000 possible bytes, 0%
> Recording extents for root 161199
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 162628
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 162632
> processed 2441216 of 108691456 possible bytes, 2%
> Recording extents for root 162645
> processed 49152 of 75792384 possible bytes, 0%
> Recording extents for root 163298
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 163302
> processed 966656 of 108691456 possible bytes, 0%
> Recording extents for root 163303
> processed 49152 of 75792384 possible bytes, 0%
> Recording extents for root 163316
> processed 933888 of 108691456 possible bytes, 0%
> Recording extents for root 163318
> processed 16384 of 49479680 possible bytes, 0%
> Recording extents for root 163916
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 163920
> processed 966656 of 108691456 possible bytes, 0%
> Recording extents for root 163921
> processed 49152 of 75792384 possible bytes, 0%
> Recording extents for root 164620
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 164624
> processed 98304 of 109445120 possible bytes, 0%
> Recording extents for root 164633
> processed 49152 of 75792384 possible bytes, 0%
> Recording extents for root 165098
> processed 1015808 of 108756992 possible bytes, 0%
> Recording extents for root 165100
> processed 16384 of 49479680 possible bytes, 0%
> Recording extents for root 165198
> processed 491520 of 108756992 possible bytes, 0%adding a bytenr that overlaps our thing, dumping paths for [76300, 108, 0]
> misc/file
> doing an insert of the bytenr
> doing an insert that overlaps our bytenr 10467695652864 8675328
> processed 983040 of 108756992 possible bytes, 0%
> Recording extents for root 165200
> processed 16384 of 49479680 possible bytes, 0%
> Recording extents for root 165294
> processed 16384 of 49479680 possible bytes, 0%
> Recording extents for root 165298
> processed 524288 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
> misc/file
> processed 1015808 of 108756992 possible bytes, 0%
> doing block accounting
> doing close???
> Init extent tree finished, you can run check now
> 
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --repair /dev/mapper/dshelf1
> enabling repair mode
> WARNING:
> 
>         Do not use --repair unless you are advised to do so by a developer
>         or an experienced user, and then only after having accepted that no
>         fsck can successfully repair all types of filesystem corruption. Eg.
>         some software or hardware bugs can fatally damage a volume.
>         The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> FS_INFO IS 0x56119a61efd0
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x56119a61efd0
> Checking filesystem on /dev/mapper/dshelf1
> UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
> [1/7] checking root items
> checksum verify failed on 15645954129920 wanted 0x085fc24a found 0x941acdde
> checksum verify failed on 15645954195456 wanted 0x6c1c72a4 found 0xb06d5dd9
> checksum verify failed on 15645608116224 wanted 0x31706547 found 0x314fad1d
> checksum verify failed on 15645262413824 wanted 0x3affbd35 found 0x96d53d25
> checksum verify failed on 13577199878144 wanted 0x6e9e8bc6 found 0x61063457
> checksum verify failed on 13577399156736 wanted 0x2869b8c7 found 0xbb1119e1
> checksum verify failed on 12512437698560 wanted 0xca43b3f8 found 0xd7f6db69
> checksum verify failed on 13577503686656 wanted 0xd81b7702 found 0x95a3c9a6
> checksum verify failed on 15645781344256 wanted 0xb81e3df4 found 0xb5c70846
> checksum verify failed on 13577178939392 wanted 0x2cb83118 found 0x63f0b6bf
> checksum verify failed on 15645419667456 wanted 0xde0dab28 found 0x3ceddd16
> checksum verify failed on 13577821011968 wanted 0x9a29aff5 found 0x2cdff391
> checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
> Fixed 0 roots.
> [2/7] checking extents
> checksum verify failed on 364637798400 wanted 0xc3ba5144 found 0x30a5fff1
> checksum verify failed on 364637962240 wanted 0x91d33e8a found 0x00890be7
> checksum verify failed on 11970891186176 wanted 0x6b46adfb found 0xe40e4cbe
> checksum verify failed on 12511729680384 wanted 0x41be9fa6 found 0x01f06e9c
> checksum verify failed on 12512010420224 wanted 0x365027e7 found 0xba73f602
> checksum verify failed on 12512303677440 wanted 0xc08fc7a0 found 0x3cb30242
> checksum verify failed on 13576951021568 wanted 0x9511e976 found 0xd8fe35ea
> checksum verify failed on 13577013624832 wanted 0x76bbe220 found 0xdfabbbdb
> checksum verify failed on 13577013919744 wanted 0xafb37267 found 0x69504e0d
> (...)
> Device extent[1, 11231377227776, 1073741824] didn't find the relative chunk.
> Device extent[1, 11406397145088, 1073741824] didn't find the relative chunk.
> Device extent[1, 11416060821504, 1073741824] didn't find the relative chunk.
> Device extent[1, 11422503272448, 1073741824] didn't find the relative chunk.
> Device extent[1, 10616123162624, 1073741824] didn't find the relative chunk.
> data backref 385889992704 parent 11970901524480 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 385889992704 parent 11970901524480 owner 0 offset 0 found 1 wanted 0 back 0x5611a97a3110
> incorrect local backref count on 385889992704 root 11222 owner 54869 offset 0 found 0 wanted 1 back 0x5611a6e42180
> backref disk bytenr does not match extent record, bytenr=385889992704, ref bytenr=0
> backpointer mismatch on [385889992704 4096]
> repair deleting extent record: key [385889992704,168,4096]
> adding new data backref on 385889992704 parent 11970901524480 owner 0 offset 0 found 1
> Repaired extent references for 385889992704
> data backref 385900392448 parent 1429184937984 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 385900392448 parent 1429184937984 owner 0 offset 0 found 1 wanted 0 back 0x5611a659e210
> incorrect local backref count on 385900392448 root 11222 owner 55229 offset 524288 found 0 wanted 1 back 0x5611cd078e60
> backref disk bytenr does not match extent record, bytenr=385900392448, ref bytenr=0
> backpointer mismatch on [385900392448 4096]
> repair deleting extent record: key [385900392448,168,4096]
> adding new data backref on 385900392448 parent 1429184937984 owner 0 offset 0 found 1
> Repaired extent references for 385900392448
> data backref 385900478464 parent 11651792814080 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 385900478464 parent 11651792814080 owner 0 offset 0 found 1 wanted 0 back 0x5611baa7e720
> incorrect local backref count on 385900478464 root 11222 owner 55240 offset 0 found 0 wanted 1 back 0x5611cd079880
> backref disk bytenr does not match extent record, bytenr=385900478464, ref bytenr=0
> backpointer mismatch on [385900478464 4096]
> repair deleting extent record: key [385900478464,168,4096]
> adding new data backref on 385900478464 parent 11651792814080 owner 0 offset 0 found 1
> Repaired extent references for 385900478464
> data backref 385907994624 parent 13577102983168 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 385907994624 parent 13577102983168 owner 0 offset 0 found 1 wanted 0 back 0x5611a86e6ab0
> incorrect local backref count on 385907994624 root 11222 owner 55204 offset 131072 found 0 wanted 1 back 0x5611cd0d05c0
> backref disk bytenr does not match extent record, bytenr=385907994624, ref bytenr=0
> backpointer mismatch on [385907994624 4096]
> repair deleting extent record: key [385907994624,168,4096]
> adding new data backref on 385907994624 parent 13577102983168 owner 0 offset 0 found 1
> Repaired extent references for 385907994624
> data backref 385908449280 parent 13577747120128 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 385908449280 parent 13577747120128 owner 0 offset 0 found 1 wanted 0 back 0x5611c89a3690
> incorrect local backref count on 385908449280 root 11222 owner 55063 offset 524288 found 0 wanted 1 back 0x5611cd0d21d0
> backref disk bytenr does not match extent record, bytenr=385908449280, ref bytenr=0
> backpointer mismatch on [385908449280 8192]
> repair deleting extent record: key [385908449280,168,8192]
> adding new data backref on 385908449280 parent 13577747120128 owner 0 offset 0 found 1
> Repaired extent references for 385908449280
> data backref 385908580352 parent 13577747120128 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 385908580352 parent 13577747120128 owner 0 offset 0 found 1 wanted 0 back 0x5611c89a36f0
> incorrect local backref count on 385908580352 root 11222 owner 55063 offset 655360 found 0 wanted 1 back 0x5611cd0d2db0
> backref disk bytenr does not match extent record, bytenr=385908580352, ref bytenr=0
> backpointer mismatch on [385908580352 8192]
> repair deleting extent record: key [385908580352,168,8192]
> adding new data backref on 385908580352 parent 13577747120128 owner 0 offset 0 found 1
> Repaired extent references for 385908580352
> data backref 385909239808 parent 13577102983168 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 385909239808 parent 13577102983168 owner 0 offset 0 found 1 wanted 0 back 0x5611a86e6b10
> incorrect local backref count on 385909239808 root 11222 owner 55204 offset 262144 found 0 wanted 1 back 0x5611cd0c32f0
> backref disk bytenr does not match extent record, bytenr=385909239808, ref bytenr=0
> backpointer mismatch on [385909239808 4096]
> repair deleting extent record: key [385909239808,168,4096]
> adding new data backref on 385909239808 parent 13577102983168 owner 0 offset 0 found 1
> Repaired extent references for 385909239808
> data backref 385913561088 parent 13577747120128 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 385913561088 parent 13577747120128 owner 0 offset 0 found 1 wanted 0 back 0x5611c89a3750
> incorrect local backref count on 385913561088 root 11222 owner 55063 offset 786432 found 0 wanted 1 back 0x5611cd1196b0
> backref disk bytenr does not match extent record, bytenr=385913561088, ref bytenr=0
> backpointer mismatch on [385913561088 8192]
> repair deleting extent record: key [385913561088,168,8192]
> adding new data backref on 385913561088 parent 13577747120128 owner 0 offset 0 found 1
> Repaired extent references for 385913561088
> data backref 385913696256 parent 11651792814080 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 385913696256 parent 11651792814080 owner 0 offset 0 found 1 wanted 0 back 0x5611baa7e780
> incorrect local backref count on 385913696256 root 11222 owner 55240 offset 131072 found 0 wanted 1 back 0x5611cd11a3d0
> backref disk bytenr does not match extent record, bytenr=385913696256, ref bytenr=0
> backpointer mismatch on [385913696256 4096]
> repair deleting extent record: key [385913696256,168,4096]
> adding new data backref on 385913696256 parent 11651792814080 owner 0 offset 0 found 1
> Repaired extent references for 385913696256
> data backref 385914368000 parent 13577102983168 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 385914368000 parent 13577102983168 owner 0 offset 0 found 1 wanted 0 back 0x5611a86e6a50
> incorrect local backref count on 385914368000 root 11222 owner 55204 offset 0 found 0 wanted 1 back 0x5611cd11d660
> backref disk bytenr does not match extent record, bytenr=385914368000, ref bytenr=0
> backpointer mismatch on [385914368000 8192]
> repair deleting extent record: key [385914368000,168,8192]
> adding new data backref on 385914368000 parent 13577102983168 owner 0 offset 0 found 1
> 
> 
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
