Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C32518AFE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 19:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbiECR2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 13:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbiECR2H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 13:28:07 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80523D487
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 10:24:33 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58404 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nlwG9-000206-Tj by authid <merlins.org> with srv_auth_plain; Tue, 03 May 2022 10:24:26 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nlwG9-001gYZ-Lq; Tue, 03 May 2022 10:24:25 -0700
Date:   Tue, 3 May 2022 10:24:25 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220503172425.GA12542@merlins.org>
References: <20220502214916.GB29107@merlins.org>
 <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
 <20220502234135.GC29107@merlins.org>
 <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org>
 <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
 <20220503040250.GW12542@merlins.org>
 <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
 <20220503045553.GY12542@merlins.org>
 <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
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

On Tue, May 03, 2022 at 12:00:56PM -0400, Josef Bacik wrote:
> > Recording extents for root 11223
> > processed 1619902464 of 1635549184 possible bytesIgnoring transid failure
> > failed to find block number 13576823652352
> > kernel-shared/extent-tree.c:1432: btrfs_set_block_flags: BUG_ON `1` triggered, value 1
> 
> Fucking hell, do the tree-recover again and then the init-extent-tree.
> Once I'm done with this conference I'll work out why this keeps
> happening.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x561ce6c0cbc0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x561ce6c0cbc0
Checking root 2 bytenr 15645018603520
Checking root 4 bytenr 15645196861440
Checking root 5 bytenr 13577660252160
Checking root 7 bytenr 15645018521600
Checking root 9 bytenr 15645878108160
Checking root 11221 bytenr 13577562996736
Checking root 11222 bytenr 15645261905920
Checking root 11223 bytenr 13576823635968
Repairing root 11223 bad_blocks 1 update 1
Repairing root 163303 bad_blocks 1 update 0
updating slot 11 in block 15645018505216
updating slot 11 in block 15645018505216
updating slot 11 in block 15645018505216
updating slot 11 in block 15645018505216
updating slot 11 in block 15645018505216
updating slot 11 in block 15645018505216
updating slot 11 in block 15645018505216
deleting slot 11 in block 15645018505216
Checking root 163316 bytenr 6781245931520
Checking root 163318 bytenr 15645980491776
Checking root 163916 bytenr 11822437826560
Checking root 163920 bytenr 11970640084992
Checking root 163921 bytenr 11971073802240
Checking root 164620 bytenr 15645434036224
Checking root 164624 bytenr 15645018161152
Repairing root 164624 bad_blocks 1 update 1
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
updating slot 24 in block 15645502210048
deleting slot 24 in block 15645502210048
Checking root 164633 bytenr 15645526884352
Checking root 165098 bytenr 11970640101376
Repairing root 165098 bad_blocks 1 update 0
updating slot 425 in block 11821926875136
Checking root 165100 bytenr 11970733621248
Checking root 165198 bytenr 12511369756672
Repairing root 165198 bad_blocks 1 update 1
updating slot 425 in block 11822225473536
Checking root 165200 bytenr 12511677972480
Checking root 165294 bytenr 13576901328896
Checking root 165298 bytenr 13576823635968
Repairing root 165298 bad_blocks 0 update 1
Checking root 165299 bytenr 13577191505920
Checking root 18446744073709551607 bytenr 29540352
Tree recovery finished, you can run check now



gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x55ec18f10bc0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55ec18f10bc0
Checking root 2 bytenr 15645018603520
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
Checking root 18446744073709551607 bytenr 29540352
Tree recovery finished, you can run check now

Good, now running repair

gargamel:/var/local/src/btrfs-progs-josefbacik# .//btrfs check --repair /dev/mapper/dshelf1
enabling repair mode
WARNING:

        Do not use --repair unless you are advised to do so by a developer
        or an experienced user, and then only after having accepted that no
        fsck can successfully repair all types of filesystem corruption. Eg.
        some software or hardware bugs can fatally damage a volume.
        The operation will start in 10 seconds.
        Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
FS_INFO IS 0x5584836fafd0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x5584836fafd0
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
[1/7] checking root items
Error: could not find extent items for root 11223
ERROR: failed to repair root items: No such file or directory


doing the longer one, will report back
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --repair --init-extent-tree /dev/mapper/dshelf1

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
