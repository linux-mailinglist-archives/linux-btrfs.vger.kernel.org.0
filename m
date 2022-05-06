Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5951CF57
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 May 2022 05:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiEFDWz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 23:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388488AbiEFDWx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 23:22:53 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43095E77C
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 20:19:10 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58434 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nmoUo-0003wB-F1 by authid <merlins.org> with srv_auth_plain; Thu, 05 May 2022 20:19:10 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nmoUo-006qRu-9Q; Thu, 05 May 2022 20:19:10 -0700
Date:   Thu, 5 May 2022 20:19:10 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220506031910.GH12542@merlins.org>
References: <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org>
 <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
 <20220503040250.GW12542@merlins.org>
 <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
 <20220503045553.GY12542@merlins.org>
 <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
 <20220503172425.GA12542@merlins.org>
 <20220505150821.GB1020265@merlins.org>
 <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 05, 2022 at 11:27:32AM -0400, Josef Bacik wrote:
> Sorry Marc I was busy with the conference and completely misread what
> you did.  Cancel the btrfs check now, and then do
> 
> btrfs rescue tree-recover <device> // This should succeed without
> doing anything but just in case
> btrfs rescue init-extent-tree <device> // I'm hoping this will succeed
> this time, if not of course tell me
> btrfs check --repair <device>

Got it. Note that check --repair faile

./gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x55fbfe283bc0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55fbfe283bc0
Checking root 2 bytenr 29442048
Checking root 4 bytenr 15645196861440
Checking root 5 bytenr 13577660252160
Checking root 7 bytenr 15645018521600
Checking root 9 bytenr 15645878108160
Checking root 11221 bytenr 13577562996736
Checking root 11222 bytenr 15645261905920
Checking root 11223 bytenr 13576823635968
Checking root 11224 bytenr 13577126182912
Checking root 159785 bytenr 6781490577408
Checking root 159787 bytenr 15645908385792
Checking root 160494 bytenr 6781245882368
Checking root 160496 bytenr 11822309965824
Checking root 161197 bytenr 6781245865984
Checking root 161199 bytenr 13576850833408
Checking root 162628 bytenr 15645764812800
Checking root 162632 bytenr 6781245898752
Checking root 162645 bytenr 5809981095936
Checking root 163298 bytenr 15645124263936
Checking root 163302 bytenr 6781245915136
Checking root 163303 bytenr 15645018505216
Checking root 163316 bytenr 6781245931520
Checking root 163318 bytenr 15645980491776
Checking root 163916 bytenr 11822437826560
Checking root 163920 bytenr 11970640084992
Checking root 163921 bytenr 11971073802240
Checking root 164620 bytenr 15645434036224
Checking root 164624 bytenr 15645502210048
Checking root 164633 bytenr 15645526884352
Checking root 165098 bytenr 11970640101376
Checking root 165100 bytenr 11970733621248
Checking root 165198 bytenr 12511656394752
Checking root 165200 bytenr 12511677972480
Checking root 165294 bytenr 13576901328896
Checking root 165298 bytenr 13577133326336
Checking root 165299 bytenr 13577191505920
Checking root 18446744073709551607 bytenr 13576823717888
Tree recovery finished, you can run check now


The delete block bit should be automated somehow, it's quite slow and painful to do by hand (hours again here)

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
Recording extents for root 11223
processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819130,108,0 on root 11223
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0027_2020.1_0602_1208.xz

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819130,108,0" -r 11223 /dev/mapper/dshelf1 

Recording extents for root 11223
processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819131,108,0 on root 11223
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0026_2020.1_0602_1208.xz
cmds/rescue-init-extent-tree.c:654: process_eb: BUG_ON `1` triggered, value 1


gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819131,108,0" -r 11223 /dev/mapper/dshelf1 
FS_INFO IS 0x561c57fe8600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x561c57fe8600
parent transid verify failed on 13576823635968 wanted 1619857 found 1638917
parent transid verify failed on 13576823635968 wanted 1619857 found 1638917
parent transid verify failed on 13576823635968 wanted 1619857 found 1638917


processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819133,108,0 on root 11223
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0410_2020.1_0602_1208.xz
cmds/rescue-init-extent-tree.c:654: process_eb: BUG_ON `1` triggered, value 1


Ok, so it's the same problem as last time. My corrupt blocks have been lost/uncorrupted.
So I re-ran the same commands as last time:
./btrfs-corrupt-block -d "1819130,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "1819131,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "1819133,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "1819135,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "1819137,108,0" -r 11223 /dev/mapper/dshelf1

Ok, more still, new ones I didn't have to run last time, still all on this new file: rdi_0059_2020.1_0602_1208.xz
processed 1619902464 of 1635549184 possible bytesIgnoring transid failure
processed 1619918848 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819139,108,0 on root 11223
inode ref info failed???

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819139,108,0" -r 11223 /dev/mapper/dshelf1
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819142,108,0" -r 11223 /dev/mapper/dshelf1
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819143,108,0" -r 11223 /dev/mapper/dshelf1
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819144,108,0" -r 11223 /dev/mapper/dshelf1
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819150,108,0" -r 11223 /dev/mapper/dshelf1
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819153,108,0" -r 11223 /dev/mapper/dshelf1
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819154,108,0" -r 11223 /dev/mapper/dshelf1
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819160,108,16318464" -r 11223 /dev/mapper/dshelf1
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819161,108,0" -r 11223 /dev/mapper/dshelf1

ok, took hours and I ran out of time, more tomorrow
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819161,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819164,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819165,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819167,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819168,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819169,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819169,108,134217728" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819170,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819175,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819176,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819177,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819179,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819183,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819184,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819187,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819189,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819189,108,134217728" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819191,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819193,108,0" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819193,108,24248320" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 
./btrfs-corrupt-block -d "1819193,108,55640064" -r 11223 /dev/mapper/dshelf1
./btrfs rescue init-extent-tree /dev/mapper/dshelf1 


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
