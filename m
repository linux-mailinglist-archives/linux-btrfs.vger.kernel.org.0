Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60712517CBE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 07:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiECE71 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 00:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiECE7Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 00:59:25 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8DF23168
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 21:55:53 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58398 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nlkZl-0004KR-Dq by authid <merlins.org> with srv_auth_plain; Mon, 02 May 2022 21:55:53 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nlkZl-000Tyx-8O; Mon, 02 May 2022 21:55:53 -0700
Date:   Mon, 2 May 2022 21:55:53 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220503045553.GY12542@merlins.org>
References: <20220502200848.GR12542@merlins.org>
 <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
 <20220502214916.GB29107@merlins.org>
 <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
 <20220502234135.GC29107@merlins.org>
 <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org>
 <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
 <20220503040250.GW12542@merlins.org>
 <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
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

On Tue, May 03, 2022 at 12:13:16AM -0400, Josef Bacik wrote:
> Ok I fixed the debugging to not be so noisy so I can see what's going
> on, lets give that a try,

(...)
inserting block group 13570381185024
inserting block group 13571454926848
inserting block group 13572528668672
inserting block group 13573602410496
inserting block group 13574676152320
inserting block group 13575749894144
inserting block group 13576823635968
inserting block group 13577897377792
inserting block group 13585413570560
(...)
inserting block group 15768498470912
inserting block group 15769572212736
inserting block group 15770645954560
inserting block group 15771719696384
inserting block group 15778162147328
inserting block group 15779235889152
inserting block group 15780309630976
inserting block group 15781383372800
inserting block group 15782457114624
inserting block group 15783530856448
inserting block group 15784604598272
inserting block group 15785678340096
inserting block group 15786752081920
inserting block group 15787825823744
inserting block group 15788899565568
inserting block group 15789973307392
inserting block group 15791047049216
inserting block group 15792120791040
inserting block group 15793194532864
inserting block group 15794268274688
inserting block group 15795342016512
inserting block group 15796415758336
inserting block group 15797489500160
inserting block group 15798563241984
inserting block group 15799636983808
inserting block group 15800710725632
inserting block group 15801784467456
inserting block group 15802858209280
inserting block group 15803931951104
inserting block group 15809300660224
inserting block group 15810374402048
inserting block group 15811448143872
inserting block group 15812521885696
inserting block group 15813595627520
inserting block group 15814669369344
inserting block group 15815743111168
inserting block group 15816816852992
inserting block group 15817890594816
inserting block group 15818964336640
inserting block group 15820038078464
inserting block group 15821111820288
inserting block group 15822185562112
inserting block group 15823259303936
inserting block group 15824333045760
inserting block group 15825406787584
inserting block group 15826480529408
inserting block group 15827554271232
inserting block group 15828628013056
inserting block group 15829701754880
inserting block group 15830775496704
inserting block group 15831849238528
inserting block group 15832922980352
inserting block group 15833996722176
inserting block group 15835070464000
inserting block group 15836144205824
inserting block group 15837217947648
inserting block group 15838291689472
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
processed 1556480 of 0 possible bytes
processed 1474560 of 0 possible bytes
doing roots
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
processed 1619902464 of 1635549184 possible bytesIgnoring transid failure
failed to find block number 13576823652352
kernel-shared/extent-tree.c:1432: btrfs_set_block_flags: BUG_ON `1` triggered, value 1

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
