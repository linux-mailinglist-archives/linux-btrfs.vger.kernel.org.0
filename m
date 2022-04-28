Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A60513E80
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 00:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiD1WaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 18:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiD1WaW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 18:30:22 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C7BF319
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 15:27:05 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nkCbJ-0002vR-FM by authid <merlin>; Thu, 28 Apr 2022 15:27:05 -0700
Date:   Thu, 28 Apr 2022 15:27:05 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220428222705.GX29107@merlins.org>
References: <20220428041245.GP29107@merlins.org>
 <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
 <20220428162746.GR29107@merlins.org>
 <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
 <20220428202205.GT29107@merlins.org>
 <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
 <20220428205716.GU29107@merlins.org>
 <CAEzrpqduAKibaDJPJ6s7dCAfQHeynwG6zJwgVXVS_Uh=cQq2dw@mail.gmail.com>
 <20220428214241.GW29107@merlins.org>
 <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 05:54:46PM -0400, Josef Bacik wrote:
> Oooh I'm stupid, I thought the key it was printing out was the extent
> we needed to delete, but it's the extent in the extent tree.  You cut
> off the part I need, but that's because I'm printing the leaf when I
> don't need to.
> 
> I've fixed the output so it should print out something like
> 
> [number, 108, number] dumping paths
> 
> that's what you want to feed into btrfs-corrupt-block, that should
> delete the problematic item and then we can continue.  Thanks,

inserting block group 15835070464000
inserting block group 15836144205824
inserting block group 15837217947648
inserting block group 15838291689472
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
processed 1556480 of 0 possible bytes
processed 49152 of 0 possible bytesadding a bytenr that overlaps our
thing, dumping paths for [4088, 108, 0]
inode ref info failed???
elem_cnt 0 elem_missed 0 ret -2
doing an insert of the bytenr
doing an insert that overlaps our bytenr 3700677820416 262144
processed 1474560 of 0 possible bytes
Recording extents for root 4
processed 1032192 of 1064960 possible bytes
Recording extents for root 5
processed 10960896 of 10977280 possible bytes
Recording extents for root 7
processed 16384 of 16545742848 possible bytes
Recording extents for root 9
processed 16384 of 16384 possible bytes
Recording extents for root 11221
processed 16384 of 255983616 possible bytes
Recording extents for root 11222
processed 49479680 of 49479680 possible bytes
Ignoring transid failure
Recording extents for root 11223
processed 1634992128 of 1635549184 possible bytesWTF???? we think we
already inserted this bytenr?? [1834097, 108, 1835008] dumping paths
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/tps/lnx64/jre9.0.4/lib/modules
Failed to find [3700677820416, 168, 53248]
Segmentation fault

Isn't that root 11223 and
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "3700677820416,168,53248" -r 11223 /dev/mapper/dshelf1

why does it say root 11223 does not exists?
FS_INFO IS 0x558818fe3600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x558818fe3600
parent transid verify failed on 13576823668736 wanted 1619060 found
1619070
parent transid verify failed on 13576823668736 wanted 1619060 found
1619070
couldn't find root 11223


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
