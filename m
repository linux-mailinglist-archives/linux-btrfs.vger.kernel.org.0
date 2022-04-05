Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDE54F4781
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbiDEVMC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346705AbiDEUWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 16:22:07 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F021BB0AF
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 13:08:05 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbpTB-00057I-5t by authid <merlin>; Tue, 05 Apr 2022 13:08:05 -0700
Date:   Tue, 5 Apr 2022 13:08:05 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405200805.GD28707@merlins.org>
References: <CAEzrpqd6kePW6eiMB-R4DvMRvU=AK-jKpkBNUvSjttsSEsCwpA@mail.gmail.com>
 <20220405155311.GJ5566@merlins.org>
 <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
 <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
 <20220405181108.GA28707@merlins.org>
 <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org>
 <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org>
 <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
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

On Tue, Apr 05, 2022 at 04:05:05PM -0400, Josef Bacik wrote:
> Well it's still the same, and this thing is 20mib into your fs so IDK
> how it would be screwing up now.  Can you do
> 
> ./btrfs inspect-internal dump-tree -b 21069824
> 
> and see what that spits out?  IDK why it would suddenly start
> complaining about your chunk root.  Thanks,

Thanks for your patience and sticking with me
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-tree -b 21069824 /dev/mapper/dshelf1a >/dev/null
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
FS_INFO IS 0x557c43fde470
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
FS_INFO AFTER IS 0x557c43fde470
node 21069824 level 1 items 95 free space 398 generation 1600938 owner CHUNK_TREE
node 21069824 flags 0x1(WRITTEN) backref revision 1
fs uuid 96539b8c-ccc9-47bf-9e6c-29305890941e
chunk uuid 7257b24b-3702-41e5-8b61-6f6ea524255a
        key (DEV_ITEMS DEV_ITEM 1) block 21135360 gen 1600938
        key (FIRST_CHUNK_TREE CHUNK_ITEM 159480020992) block 21086208 gen 278
        key (FIRST_CHUNK_TREE CHUNK_ITEM 325910003712) block 21102592 gen 357
        key (FIRST_CHUNK_TREE CHUNK_ITEM 490729373696) block 21118976 gen 450
        key (FIRST_CHUNK_TREE CHUNK_ITEM 657159356416) block 21184512 gen 593
        key (FIRST_CHUNK_TREE CHUNK_ITEM 821978726400) block 21938176 gen 1453956
        key (FIRST_CHUNK_TREE CHUNK_ITEM 986798096384) block 21151744 gen 696
        key (FIRST_CHUNK_TREE CHUNK_ITEM 1153228079104) block 21020672 gen 773
        key (FIRST_CHUNK_TREE CHUNK_ITEM 1319658061824) block 21250048 gen 846
        key (FIRST_CHUNK_TREE CHUNK_ITEM 1484477431808) block 21266432 gen 921
        key (FIRST_CHUNK_TREE CHUNK_ITEM 1650907414528) block 21282816 gen 1027
        key (FIRST_CHUNK_TREE CHUNK_ITEM 1817337397248) block 21168128 gen 1106
        key (FIRST_CHUNK_TREE CHUNK_ITEM 1982156767232) block 21037056 gen 1170
        key (FIRST_CHUNK_TREE CHUNK_ITEM 2148586749952) block 21233664 gen 1231
        key (FIRST_CHUNK_TREE CHUNK_ITEM 2315016732672) block 20971520 gen 1293
        key (FIRST_CHUNK_TREE CHUNK_ITEM 2479836102656) block 21315584 gen 1346
        key (FIRST_CHUNK_TREE CHUNK_ITEM 2646266085376) block 21381120 gen 1394
        key (FIRST_CHUNK_TREE CHUNK_ITEM 2812696068096) block 20987904 gen 1443
        key (FIRST_CHUNK_TREE CHUNK_ITEM 2977515438080) block 21348352 gen 1502
        key (FIRST_CHUNK_TREE CHUNK_ITEM 3143945420800) block 21364736 gen 1557
        key (FIRST_CHUNK_TREE CHUNK_ITEM 3310375403520) block 21397504 gen 1608
        key (FIRST_CHUNK_TREE CHUNK_ITEM 3475194773504) block 21463040 gen 1649
        key (FIRST_CHUNK_TREE CHUNK_ITEM 3641624756224) block 21004288 gen 1692
        key (FIRST_CHUNK_TREE CHUNK_ITEM 3808054738944) block 21200896 gen 1732
        key (FIRST_CHUNK_TREE CHUNK_ITEM 3972874108928) block 21446656 gen 1774
        key (FIRST_CHUNK_TREE CHUNK_ITEM 4139304091648) block 21053440 gen 1822
        key (FIRST_CHUNK_TREE CHUNK_ITEM 4305734074368) block 21544960 gen 1868
        key (FIRST_CHUNK_TREE CHUNK_ITEM 4470553444352) block 21299200 gen 1597466
        key (FIRST_CHUNK_TREE CHUNK_ITEM 4636983427072) block 21577728 gen 1965
        key (FIRST_CHUNK_TREE CHUNK_ITEM 4803413409792) block 21413888 gen 2014
        key (FIRST_CHUNK_TREE CHUNK_ITEM 4968232779776) block 21528576 gen 2065
        key (FIRST_CHUNK_TREE CHUNK_ITEM 5134662762496) block 21626880 gen 2118
        key (FIRST_CHUNK_TREE CHUNK_ITEM 5301092745216) block 21561344 gen 2167
        key (FIRST_CHUNK_TREE CHUNK_ITEM 5465912115200) block 21594112 gen 2218
        key (FIRST_CHUNK_TREE CHUNK_ITEM 5632342097920) block 21430272 gen 2270
        key (FIRST_CHUNK_TREE CHUNK_ITEM 5798772080640) block 21692416 gen 2315
        key (FIRST_CHUNK_TREE CHUNK_ITEM 5963591450624) block 21643264 gen 2358
        key (FIRST_CHUNK_TREE CHUNK_ITEM 6130021433344) block 21659648 gen 2411
        key (FIRST_CHUNK_TREE CHUNK_ITEM 6294840803328) block 21676032 gen 2465
        key (FIRST_CHUNK_TREE CHUNK_ITEM 6461270786048) block 21757952 gen 2512
        key (FIRST_CHUNK_TREE CHUNK_ITEM 6627700768768) block 21495808 gen 2558
        key (FIRST_CHUNK_TREE CHUNK_ITEM 6792520138752) block 21708800 gen 2607
        key (FIRST_CHUNK_TREE CHUNK_ITEM 6958950121472) block 21807104 gen 2655
        key (FIRST_CHUNK_TREE CHUNK_ITEM 7125380104192) block 21725184 gen 2711
        key (FIRST_CHUNK_TREE CHUNK_ITEM 7290199474176) block 21512192 gen 2762
        key (FIRST_CHUNK_TREE CHUNK_ITEM 7456629456896) block 21774336 gen 2808
        key (FIRST_CHUNK_TREE CHUNK_ITEM 7623059439616) block 21872640 gen 1463345
        key (FIRST_CHUNK_TREE CHUNK_ITEM 7787878809600) block 21889024 gen 2907
        key (FIRST_CHUNK_TREE CHUNK_ITEM 7954308792320) block 21905408 gen 2956
        key (FIRST_CHUNK_TREE CHUNK_ITEM 8120738775040) block 21790720 gen 3004
        key (FIRST_CHUNK_TREE CHUNK_ITEM 8285558145024) block 21839872 gen 3057
        key (FIRST_CHUNK_TREE CHUNK_ITEM 8451988127744) block 21856256 gen 3107
        key (FIRST_CHUNK_TREE CHUNK_ITEM 8618418110464) block 21921792 gen 3156
        key (FIRST_CHUNK_TREE CHUNK_ITEM 8783237480448) block 21217280 gen 3205
        key (FIRST_CHUNK_TREE CHUNK_ITEM 8949667463168) block 22003712 gen 3253
        key (FIRST_CHUNK_TREE CHUNK_ITEM 9116097445888) block 21954560 gen 3304
        key (FIRST_CHUNK_TREE CHUNK_ITEM 9280916815872) block 22036480 gen 3357
        key (FIRST_CHUNK_TREE CHUNK_ITEM 9447346798592) block 22020096 gen 1463291
        key (FIRST_CHUNK_TREE CHUNK_ITEM 9613776781312) block 21987328 gen 3462
        key (FIRST_CHUNK_TREE CHUNK_ITEM 9778596151296) block 22413312 gen 1463210
        key (FIRST_CHUNK_TREE CHUNK_ITEM 9945026134016) block 22052864 gen 3565
        key (FIRST_CHUNK_TREE CHUNK_ITEM 10111456116736) block 22085632 gen 1463201
        key (FIRST_CHUNK_TREE CHUNK_ITEM 10276275486720) block 21823488 gen 1463183
        key (FIRST_CHUNK_TREE CHUNK_ITEM 10442705469440) block 21331968 gen 1463138
        key (FIRST_CHUNK_TREE CHUNK_ITEM 10609135452160) block 22118400 gen 3761
        key (FIRST_CHUNK_TREE CHUNK_ITEM 10773954822144) block 22315008 gen 1463057
        key (FIRST_CHUNK_TREE CHUNK_ITEM 10940384804864) block 22151168 gen 1463003
        key (FIRST_CHUNK_TREE CHUNK_ITEM 11106814787584) block 22495232 gen 1572124
        key (FIRST_CHUNK_TREE CHUNK_ITEM 11271634157568) block 22200320 gen 1462940
        key (FIRST_CHUNK_TREE CHUNK_ITEM 11438064140288) block 22282240 gen 1462904
        key (FIRST_CHUNK_TREE CHUNK_ITEM 11607715348480) block 22249472 gen 1462571
        key (FIRST_CHUNK_TREE CHUNK_ITEM 11770387234816) block 22265856 gen 1462454
        key (FIRST_CHUNK_TREE CHUNK_ITEM 11948091506688) block 22167552 gen 1462274
        key (FIRST_CHUNK_TREE CHUNK_ITEM 12136600305664) block 22183936 gen 1462103
        key (FIRST_CHUNK_TREE CHUNK_ITEM 12282629193728) block 22134784 gen 1461923
        key (FIRST_CHUNK_TREE CHUNK_ITEM 12451240214528) block 22347776 gen 1357546
        key (FIRST_CHUNK_TREE CHUNK_ITEM 12619817680896) block 22069248 gen 504747
        key (FIRST_CHUNK_TREE CHUNK_ITEM 12794871152640) block 22364160 gen 1404175
        key (FIRST_CHUNK_TREE CHUNK_ITEM 12961301135360) block 22298624 gen 1423748
        key (FIRST_CHUNK_TREE CHUNK_ITEM 13176183717888) block 21741568 gen 1234369
        key (FIRST_CHUNK_TREE CHUNK_ITEM 13357713195008) block 22380544 gen 1332045
        key (FIRST_CHUNK_TREE CHUNK_ITEM 13560717508608) block 22396928 gen 1441271
        key (FIRST_CHUNK_TREE CHUNK_ITEM 13735838089216) block 22429696 gen 1423550
        key (FIRST_CHUNK_TREE CHUNK_ITEM 13904415555584) block 22102016 gen 1461914
        key (FIRST_CHUNK_TREE CHUNK_ITEM 14103091347456) block 21970944 gen 1461905
        key (FIRST_CHUNK_TREE CHUNK_ITEM 14271702368256) block 22462464 gen 1479229
        key (FIRST_CHUNK_TREE CHUNK_ITEM 14443501060096) block 22528000 gen 1572115
        key (FIRST_CHUNK_TREE CHUNK_ITEM 14648585748480) block 22233088 gen 1571944
        key (FIRST_CHUNK_TREE CHUNK_ITEM 14823605665792) block 22446080 gen 1571791
        key (FIRST_CHUNK_TREE CHUNK_ITEM 14990035648512) block 22544384 gen 1556078
        key (FIRST_CHUNK_TREE CHUNK_ITEM 15156465631232) block 22511616 gen 1555799
        key (FIRST_CHUNK_TREE CHUNK_ITEM 15322895613952) block 22577152 gen 1586277
        key (FIRST_CHUNK_TREE CHUNK_ITEM 15489325596672) block 22478848 gen 1561557
        key (FIRST_CHUNK_TREE CHUNK_ITEM 15664345513984) block 22593536 gen 1590219
        key (FIRST_CHUNK_TREE CHUNK_ITEM 15847955365888) block 22216704 gen 1600938
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
