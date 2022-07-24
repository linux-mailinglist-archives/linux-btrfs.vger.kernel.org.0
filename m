Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6BF57F6C0
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGXT6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jul 2022 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXT6P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jul 2022 15:58:15 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6662DFD9
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 12:58:12 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id C2D104534BD; Sun, 24 Jul 2022 15:58:11 -0400 (EDT)
Date:   Sun, 24 Jul 2022 15:58:11 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: misc-next/for-next: bad key order during log replay
Message-ID: <Yt2kU0CEkX5DRFhN@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test case is running all of these at the same time in a loop:

	- rename log tree test from
	https://lore.kernel.org/linux-btrfs/YdDsAl0bx6DLZT+i@hungrycats.org/

	- continuous metadata balances to keep delayed ref queue full

	- 20x rsync writing to the filesystem to keep the page cache full

	- crash the VM after 30 minutes uptime

Repeat 2-4 crashes, until it goes splat.  The splat looks like this:

	[   30.714977] BTRFS info (device dm-3): using crc32c (crc32c-intel) checksum algorithm
	[   30.716100] BTRFS info (device dm-3): allowing degraded mounts
	[   30.716933] BTRFS info (device dm-3): enabling ssd optimizations
	[   30.717728] BTRFS info (device dm-3): use zstd compression, level 3
	[   30.718637] BTRFS info (device dm-3): enabling auto defrag
	[   30.719399] BTRFS info (device dm-3): using free space tree
	[   32.201601] BTRFS info (device dm-3): start tree-log replay
	[   33.190424] BTRFS critical (device dm-3): corrupt leaf: root=2191 block=66289664 slot=45, bad key order, prev (256 96 6596) current (256 96 5636)
	[   33.191981] BTRFS info (device dm-3): leaf 66289664 gen 6983 total ptrs 125 free space 7783 owner 2191
	[   33.193091] 	item 0 key (256 96 5190) itemoff 16240 itemsize 43
	[   33.193820] 	item 1 key (256 96 5227) itemoff 16197 itemsize 43
	[   33.194503] 	item 2 key (256 96 5253) itemoff 16154 itemsize 43
	[   33.195166] 	item 3 key (256 96 5257) itemoff 16111 itemsize 43
	[   33.195872] 	item 4 key (256 96 5385) itemoff 16068 itemsize 43
	[   33.198024] 	item 5 key (256 96 5392) itemoff 16025 itemsize 43
	[   33.198746] 	item 6 key (256 96 5401) itemoff 15982 itemsize 43
	[   33.199506] 	item 7 key (256 96 5442) itemoff 15939 itemsize 43
	[   33.200268] 	item 8 key (256 96 5446) itemoff 15896 itemsize 43
	[   33.201039] 	item 9 key (256 96 5453) itemoff 15853 itemsize 43
	[   33.201817] 	item 10 key (256 96 5465) itemoff 15810 itemsize 43
	[   33.202512] 	item 11 key (256 96 5470) itemoff 15767 itemsize 43
	[   33.203305] 	item 12 key (256 96 5499) itemoff 15724 itemsize 43
	[   33.204130] 	item 13 key (256 96 5503) itemoff 15681 itemsize 43
	[   33.204954] 	item 14 key (256 96 5508) itemoff 15638 itemsize 43
	[   33.205785] 	item 15 key (256 96 5513) itemoff 15595 itemsize 43
	[   33.206642] 	item 16 key (256 96 5551) itemoff 15552 itemsize 43
	[   33.207464] 	item 17 key (256 96 5552) itemoff 15509 itemsize 43
	[   33.208289] 	item 18 key (256 96 5572) itemoff 15466 itemsize 43
	[   33.209158] 	item 19 key (256 96 5584) itemoff 15423 itemsize 43
	[   33.210087] 	item 20 key (256 96 5613) itemoff 15380 itemsize 43
	[   33.211067] 	item 21 key (256 96 5620) itemoff 15337 itemsize 43
	[   33.211980] 	item 22 key (256 96 5627) itemoff 15294 itemsize 43
	[   33.212735] 	item 23 key (256 96 6044) itemoff 15251 itemsize 43
	[   33.213512] 	item 24 key (256 96 6183) itemoff 15208 itemsize 43
	[   33.214360] 	item 25 key (256 96 6242) itemoff 15165 itemsize 43
	[   33.215145] 	item 26 key (256 96 6425) itemoff 15122 itemsize 43
	[   33.215956] 	item 27 key (256 96 6427) itemoff 15079 itemsize 43
	[   33.216747] 	item 28 key (256 96 6443) itemoff 15036 itemsize 43
	[   33.217529] 	item 29 key (256 96 6487) itemoff 14993 itemsize 43
	[   33.218283] 	item 30 key (256 96 6499) itemoff 14950 itemsize 43
	[   33.219060] 	item 31 key (256 96 6541) itemoff 14907 itemsize 43
	[   33.219863] 	item 32 key (256 96 6562) itemoff 14864 itemsize 43
	[   33.220638] 	item 33 key (256 96 6568) itemoff 14821 itemsize 43
	[   33.221424] 	item 34 key (256 96 6570) itemoff 14778 itemsize 43
	[   33.222216] 	item 35 key (256 96 6574) itemoff 14735 itemsize 43
	[   33.223012] 	item 36 key (256 96 6576) itemoff 14692 itemsize 43
	[   33.223767] 	item 37 key (256 96 6583) itemoff 14649 itemsize 43
	[   33.224528] 	item 38 key (256 96 6585) itemoff 14606 itemsize 43
	[   33.225327] 	item 39 key (256 96 6587) itemoff 14563 itemsize 43
	[   33.226126] 	item 40 key (256 96 6588) itemoff 14520 itemsize 43
	[   33.226915] 	item 41 key (256 96 6590) itemoff 14477 itemsize 43
	[   33.227709] 	item 42 key (256 96 6592) itemoff 14434 itemsize 43
	[   33.228457] 	item 43 key (256 96 6595) itemoff 14391 itemsize 43
	[   33.229267] 	item 44 key (256 96 6596) itemoff 14348 itemsize 43
	[   33.230052] 	item 45 key (256 96 5636) itemoff 14305 itemsize 43
	[   33.230850] 	item 46 key (256 96 5666) itemoff 14262 itemsize 43
	[   33.231645] 	item 47 key (256 96 5692) itemoff 14219 itemsize 43
	[   33.232434] 	item 48 key (256 96 5697) itemoff 14176 itemsize 43
	[   33.233230] 	item 49 key (256 96 5710) itemoff 14133 itemsize 43
	[   33.233984] 	item 50 key (256 96 5753) itemoff 14090 itemsize 43
	[   33.234828] 	item 51 key (256 96 5756) itemoff 14047 itemsize 43
	[   33.236706] 	item 52 key (256 96 5769) itemoff 14004 itemsize 43
	[   33.237537] 	item 53 key (256 96 5777) itemoff 13961 itemsize 43
	[   33.239639] 	item 54 key (256 96 5778) itemoff 13918 itemsize 43
	[   33.240604] 	item 55 key (256 96 5788) itemoff 13875 itemsize 43
	[   33.241328] 	item 56 key (256 96 5793) itemoff 13832 itemsize 43
	[   33.242138] 	item 57 key (256 96 5802) itemoff 13789 itemsize 43
	[   33.243160] 	item 58 key (256 96 5803) itemoff 13746 itemsize 43
	[   33.244151] 	item 59 key (256 96 5807) itemoff 13703 itemsize 43
	[   33.244946] 	item 60 key (256 96 5815) itemoff 13660 itemsize 43
	[   33.245783] 	item 61 key (256 96 5816) itemoff 13617 itemsize 43
	[   33.246584] 	item 62 key (256 96 5836) itemoff 13574 itemsize 43
	[   33.247372] 	item 63 key (256 96 5842) itemoff 13531 itemsize 43
	[   33.248184] 	item 64 key (256 96 5865) itemoff 13488 itemsize 43
	[   33.249011] 	item 65 key (256 96 5866) itemoff 13445 itemsize 43
	[   33.249820] 	item 66 key (256 96 5880) itemoff 13402 itemsize 43
	[   33.250552] 	item 67 key (256 96 5882) itemoff 13359 itemsize 43
	[   33.251333] 	item 68 key (256 96 5893) itemoff 13316 itemsize 43
	[   33.252295] 	item 69 key (256 96 5902) itemoff 13273 itemsize 43
	[   33.253278] 	item 70 key (256 96 5909) itemoff 13230 itemsize 43
	[   33.254100] 	item 71 key (256 96 5917) itemoff 13187 itemsize 43
	[   33.254954] 	item 72 key (256 96 5919) itemoff 13144 itemsize 43
	[   33.255846] 	item 73 key (256 96 5942) itemoff 13101 itemsize 43
	[   33.256768] 	item 74 key (256 96 5945) itemoff 13058 itemsize 43
	[   33.257621] 	item 75 key (256 96 5947) itemoff 13015 itemsize 43
	[   33.258591] 	item 76 key (256 96 5954) itemoff 12972 itemsize 43
	[   33.259461] 	item 77 key (256 96 5962) itemoff 12929 itemsize 43
	[   33.260530] 	item 78 key (256 96 5965) itemoff 12886 itemsize 43
	[   33.261527] 	item 79 key (256 96 5979) itemoff 12843 itemsize 43
	[   33.262407] 	item 80 key (256 96 6010) itemoff 12800 itemsize 43
	[   33.263242] 	item 81 key (256 96 6030) itemoff 12757 itemsize 43
	[   33.264019] 	item 82 key (256 96 6034) itemoff 12714 itemsize 43
	[   33.264798] 	item 83 key (256 96 6041) itemoff 12671 itemsize 43
	[   33.265639] 	item 84 key (256 96 6054) itemoff 12628 itemsize 43
	[   33.266524] 	item 85 key (256 96 6067) itemoff 12585 itemsize 43
	[   33.267385] 	item 86 key (256 96 6073) itemoff 12542 itemsize 43
	[   33.268296] 	item 87 key (256 96 6076) itemoff 12499 itemsize 43
	[   33.269079] 	item 88 key (256 96 6077) itemoff 12456 itemsize 43
	[   33.270236] 	item 89 key (256 96 6090) itemoff 12413 itemsize 43
	[   33.271009] 	item 90 key (256 96 6094) itemoff 12370 itemsize 43
	[   33.271906] 	item 91 key (256 96 6110) itemoff 12327 itemsize 43
	[   33.272650] 	item 92 key (256 96 6124) itemoff 12284 itemsize 43
	[   33.273421] 	item 93 key (256 96 6127) itemoff 12241 itemsize 43
	[   33.274324] 	item 94 key (256 96 6133) itemoff 12198 itemsize 43
	[   33.275220] 	item 95 key (256 96 6149) itemoff 12155 itemsize 43
	[   33.276020] 	item 96 key (256 96 6155) itemoff 12112 itemsize 43
	[   33.276907] 	item 97 key (256 96 6161) itemoff 12069 itemsize 43
	[   33.277891] 	item 98 key (256 96 6169) itemoff 12026 itemsize 43
	[   33.278891] 	item 99 key (256 96 6170) itemoff 11983 itemsize 43
	[   33.279841] 	item 100 key (256 96 6173) itemoff 11940 itemsize 43
	[   33.280802] 	item 101 key (256 96 6178) itemoff 11897 itemsize 43
	[   33.281750] 	item 102 key (256 96 6189) itemoff 11854 itemsize 43
	[   33.282560] 	item 103 key (256 96 6194) itemoff 11811 itemsize 43
	[   33.283513] 	item 104 key (256 96 6195) itemoff 11768 itemsize 43
	[   33.284462] 	item 105 key (256 96 6199) itemoff 11725 itemsize 43
	[   33.285372] 	item 106 key (256 96 6202) itemoff 11682 itemsize 43
	[   33.286272] 	item 107 key (256 96 6208) itemoff 11639 itemsize 43
	[   33.287196] 	item 108 key (256 96 6214) itemoff 11596 itemsize 43
	[   33.288088] 	item 109 key (256 96 6219) itemoff 11553 itemsize 43
	[   33.288908] 	item 110 key (256 96 6221) itemoff 11510 itemsize 43
	[   33.289688] 	item 111 key (256 96 6222) itemoff 11467 itemsize 43
	[   33.290476] 	item 112 key (256 96 6229) itemoff 11424 itemsize 43
	[   33.291272] 	item 113 key (256 96 6240) itemoff 11381 itemsize 43
	[   33.292039] 	item 114 key (256 96 6250) itemoff 11338 itemsize 43
	[   33.292819] 	item 115 key (256 96 6265) itemoff 11295 itemsize 43
	[   33.293611] 	item 116 key (256 96 6267) itemoff 11252 itemsize 43
	[   33.294479] 	item 117 key (256 96 6271) itemoff 11209 itemsize 43
	[   33.295281] 	item 118 key (256 96 6272) itemoff 11166 itemsize 43
	[   33.296188] 	item 119 key (256 96 6273) itemoff 11123 itemsize 43
	[   33.297132] 	item 120 key (256 96 6275) itemoff 11080 itemsize 43
	[   33.298099] 	item 121 key (256 96 6280) itemoff 11037 itemsize 43
	[   33.298992] 	item 122 key (256 96 6286) itemoff 10994 itemsize 43
	[   33.300152] 	item 123 key (256 96 6287) itemoff 10951 itemsize 43
	[   33.301372] 	item 124 key (256 96 6292) itemoff 10908 itemsize 43
	[   33.302601] BTRFS error (device dm-3): block=66289664 write time tree block corruption detected
	[   33.307302] BTRFS critical (device dm-3): corrupt leaf: root=2191 block=70811648 slot=95, bad key order, prev (256 96 6681) current (256 96 6645)
	[   33.309913] BTRFS info (device dm-3): leaf 70811648 gen 6983 total ptrs 113 free space 6702 owner 2191
	[   33.311583] 	item 0 key (256 96 6296) itemoff 16240 itemsize 43
	[   33.312542] 	item 1 key (256 96 6302) itemoff 16197 itemsize 43
	[   33.313534] 	item 2 key (256 96 6308) itemoff 16154 itemsize 43
	[   33.314270] 	item 3 key (256 96 6310) itemoff 16111 itemsize 43
	[   33.315070] 	item 4 key (256 96 6311) itemoff 16068 itemsize 43
	[   33.315852] 	item 5 key (256 96 6312) itemoff 16025 itemsize 43
	[   33.317442] 	item 6 key (256 96 6313) itemoff 15982 itemsize 43
	[   33.318801] 	item 7 key (256 96 6321) itemoff 15939 itemsize 43
	[   33.320405] 	item 8 key (256 96 6330) itemoff 15896 itemsize 43
	[   33.321956] 	item 9 key (256 96 6338) itemoff 15853 itemsize 43
	[   33.322955] 	item 10 key (256 96 6341) itemoff 15810 itemsize 43
	[   33.323983] 	item 11 key (256 96 6344) itemoff 15767 itemsize 43
	[   33.324844] 	item 12 key (256 96 6351) itemoff 15724 itemsize 43
	[   33.325851] 	item 13 key (256 96 6353) itemoff 15681 itemsize 43
	[   33.326692] 	item 14 key (256 96 6357) itemoff 15638 itemsize 43
	[   33.327701] 	item 15 key (256 96 6361) itemoff 15595 itemsize 43
	[   33.328624] 	item 16 key (256 96 6367) itemoff 15552 itemsize 43
	[   33.329627] 	item 17 key (256 96 6368) itemoff 15509 itemsize 43
	[   33.330612] 	item 18 key (256 96 6370) itemoff 15466 itemsize 43
	[   33.331513] 	item 19 key (256 96 6377) itemoff 15423 itemsize 43
	[   33.332484] 	item 20 key (256 96 6382) itemoff 15380 itemsize 43
	[   33.333375] 	item 21 key (256 96 6384) itemoff 15337 itemsize 43
	[   33.334337] 	item 22 key (256 96 6387) itemoff 15294 itemsize 43
	[   33.335213] 	item 23 key (256 96 6388) itemoff 15251 itemsize 43
	[   33.336182] 	item 24 key (256 96 6392) itemoff 15208 itemsize 43
	[   33.337092] 	item 25 key (256 96 6398) itemoff 15165 itemsize 43
	[   33.338060] 	item 26 key (256 96 6399) itemoff 15122 itemsize 43
	[   33.339017] 	item 27 key (256 96 6405) itemoff 15079 itemsize 43
	[   33.339905] 	item 28 key (256 96 6406) itemoff 15036 itemsize 43
	[   33.340757] 	item 29 key (256 96 6408) itemoff 14993 itemsize 43
	[   33.341589] 	item 30 key (256 96 6409) itemoff 14950 itemsize 43
	[   33.342380] 	item 31 key (256 96 6413) itemoff 14907 itemsize 43
	[   33.343152] 	item 32 key (256 96 6429) itemoff 14864 itemsize 43
	[   33.343987] 	item 33 key (256 96 6430) itemoff 14821 itemsize 43
	[   33.344732] 	item 34 key (256 96 6431) itemoff 14778 itemsize 43
	[   33.345521] 	item 35 key (256 96 6433) itemoff 14735 itemsize 43
	[   33.346585] 	item 36 key (256 96 6434) itemoff 14692 itemsize 43
	[   33.347499] 	item 37 key (256 96 6438) itemoff 14649 itemsize 43
	[   33.348301] 	item 38 key (256 96 6444) itemoff 14606 itemsize 43
	[   33.349351] 	item 39 key (256 96 6445) itemoff 14563 itemsize 43
	[   33.350189] 	item 40 key (256 96 6447) itemoff 14520 itemsize 43
	[   33.351012] 	item 41 key (256 96 6448) itemoff 14477 itemsize 43
	[   33.352044] 	item 42 key (256 96 6454) itemoff 14434 itemsize 43
	[   33.352939] 	item 43 key (256 96 6456) itemoff 14391 itemsize 43
	[   33.353778] 	item 44 key (256 96 6460) itemoff 14348 itemsize 43
	[   33.354610] 	item 45 key (256 96 6470) itemoff 14305 itemsize 43
	[   33.355490] 	item 46 key (256 96 6471) itemoff 14262 itemsize 43
	[   33.356300] 	item 47 key (256 96 6478) itemoff 14219 itemsize 43
	[   33.357207] 	item 48 key (256 96 6482) itemoff 14176 itemsize 43
	[   33.358223] 	item 49 key (256 96 6483) itemoff 14133 itemsize 43
	[   33.359060] 	item 50 key (256 96 6485) itemoff 14090 itemsize 43
	[   33.359983] 	item 51 key (256 96 6492) itemoff 14047 itemsize 43
	[   33.360827] 	item 52 key (256 96 6494) itemoff 14004 itemsize 43
	[   33.361891] 	item 53 key (256 96 6495) itemoff 13961 itemsize 43
	[   33.362765] 	item 54 key (256 96 6496) itemoff 13918 itemsize 43
	[   33.363663] 	item 55 key (256 96 6498) itemoff 13875 itemsize 43
	[   33.364647] 	item 56 key (256 96 6500) itemoff 13832 itemsize 43
	[   33.365581] 	item 57 key (256 96 6501) itemoff 13789 itemsize 43
	[   33.366467] 	item 58 key (256 96 6505) itemoff 13746 itemsize 43
	[   33.367380] 	item 59 key (256 96 6507) itemoff 13703 itemsize 43
	[   33.368313] 	item 60 key (256 96 6512) itemoff 13660 itemsize 43
	[   33.369334] 	item 61 key (256 96 6513) itemoff 13617 itemsize 43
	[   33.370233] 	item 62 key (256 96 6522) itemoff 13574 itemsize 43
	[   33.371169] 	item 63 key (256 96 6527) itemoff 13531 itemsize 43
	[   33.372047] 	item 64 key (256 96 6529) itemoff 13488 itemsize 43
	[   33.373037] 	item 65 key (256 96 6531) itemoff 13445 itemsize 43
	[   33.374025] 	item 66 key (256 96 6533) itemoff 13402 itemsize 43
	[   33.375022] 	item 67 key (256 96 6534) itemoff 13359 itemsize 43
	[   33.375889] 	item 68 key (256 96 6537) itemoff 13316 itemsize 43
	[   33.376967] 	item 69 key (256 96 6538) itemoff 13273 itemsize 43
	[   33.377765] 	item 70 key (256 96 6539) itemoff 13230 itemsize 43
	[   33.378782] 	item 71 key (256 96 6545) itemoff 13187 itemsize 43
	[   33.379736] 	item 72 key (256 96 6546) itemoff 13144 itemsize 43
	[   33.380820] 	item 73 key (256 96 6548) itemoff 13101 itemsize 43
	[   33.381602] 	item 74 key (256 96 6550) itemoff 13058 itemsize 43
	[   33.382431] 	item 75 key (256 96 6553) itemoff 13015 itemsize 43
	[   33.383446] 	item 76 key (256 96 6555) itemoff 12972 itemsize 43
	[   33.384533] 	item 77 key (256 96 6556) itemoff 12929 itemsize 43
	[   33.385275] 	item 78 key (256 96 6557) itemoff 12886 itemsize 43
	[   33.386057] 	item 79 key (256 96 6558) itemoff 12843 itemsize 43
	[   33.386859] 	item 80 key (256 96 6561) itemoff 12800 itemsize 43
	[   33.387658] 	item 81 key (256 96 6565) itemoff 12757 itemsize 43
	[   33.388627] 	item 82 key (256 96 6566) itemoff 12714 itemsize 43
	[   33.389479] 	item 83 key (256 96 6641) itemoff 12671 itemsize 43
	[   33.390440] 	item 84 key (256 96 6644) itemoff 12624 itemsize 47
	[   33.391307] 	item 85 key (256 96 6650) itemoff 12581 itemsize 43
	[   33.392319] 	item 86 key (256 96 6651) itemoff 12534 itemsize 47
	[   33.393140] 	item 87 key (256 96 6654) itemoff 12487 itemsize 47
	[   33.394136] 	item 88 key (256 96 6666) itemoff 12440 itemsize 47
	[   33.395028] 	item 89 key (256 96 6669) itemoff 12393 itemsize 47
	[   33.396045] 	item 90 key (256 96 6672) itemoff 12346 itemsize 47
	[   33.397110] 	item 91 key (256 96 6676) itemoff 12299 itemsize 47
	[   33.397949] 	item 92 key (256 96 6677) itemoff 12252 itemsize 47
	[   33.398790] 	item 93 key (256 96 6678) itemoff 12205 itemsize 47
	[   33.399727] 	item 94 key (256 96 6681) itemoff 12158 itemsize 47
	[   33.400840] 	item 95 key (256 96 6645) itemoff 12115 itemsize 43
	[   33.402201] 	item 96 key (256 96 6646) itemoff 12072 itemsize 43
	[   33.403369] 	item 97 key (256 96 6647) itemoff 12029 itemsize 43
	[   33.404323] 	item 98 key (256 96 6648) itemoff 11986 itemsize 43
	[   33.405119] 	item 99 key (256 96 6656) itemoff 11943 itemsize 43
	[   33.406050] 	item 100 key (256 96 6657) itemoff 11900 itemsize 43
	[   33.406996] 	item 101 key (256 96 6659) itemoff 11857 itemsize 43
	[   33.407949] 	item 102 key (256 96 6661) itemoff 11814 itemsize 43
	[   33.408931] 	item 103 key (256 96 6663) itemoff 11771 itemsize 43
	[   33.409940] 	item 104 key (256 96 6662) itemoff 11728 itemsize 43
	[   33.410796] 	item 105 key (256 96 6664) itemoff 11685 itemsize 43
	[   33.411725] 	item 106 key (256 96 6665) itemoff 11642 itemsize 43
	[   33.412572] 	item 107 key (256 96 6667) itemoff 11599 itemsize 43
	[   33.413669] 	item 108 key (256 96 6668) itemoff 11556 itemsize 43
	[   33.414532] 	item 109 key (257 1 0) itemoff 11396 itemsize 160
	[   33.415550] 		inode generation 6982 size 0 mode 100644
	[   33.416258] 	item 110 key (257 12 256) itemoff 11379 itemsize 17
	[   33.417186] 	item 111 key (961 1 0) itemoff 11219 itemsize 160
	[   33.418150] 		inode generation 6982 size 3773 mode 100755
	[   33.418975] 	item 112 key (961 108 0) itemoff 9527 itemsize 1692
	[   33.419990] 		inline extent data size 3773
	[   33.420776] BTRFS error (device dm-3): block=70811648 write time tree block corruption detected
	[   33.593971] BTRFS: error (device dm-3) in btrfs_commit_transaction:2504: errno=-5 IO failure (Error while writing out transaction)
	[   33.596225] BTRFS warning (device dm-3: state E): Skipping commit of aborted transaction.
	[   33.597531] BTRFS debug (device dm-3: state EA): Transaction aborted (error -5)
	[   33.597575] BTRFS: error (device dm-3: state EA) in cleanup_transaction:2008: errno=-5 IO failure
	[   33.600786] BTRFS: error (device dm-3: state EA) in btrfs_replay_log:2479: errno=-5 IO failure (Failed to recover log tree)
	[   33.658058] BTRFS error (device dm-3: state EA): open_ctree failed

Other observations:

	- btrfs check usually reports no errors--though not always!
	In one run, the test filesystem was broken and had to be mkfs'ed.

	- A similar result occurs after reboot and attempt mount again.

	- From the same initial filesystem state (i.e. running a VM
	multiple times against the same disk image), different mount
	attempts complain about different tree items.

	- 'btrfs resc zero-log' drops the log tree and avoids the crash
	on mount.  The test can then run for a few more crash cycles
	before hitting the bug again.

	- The same test case led to the report for "btrfs: join running
	log transaction when logging new name", but that commit is in
	misc-next and this bug still happens, so that bug isn't this bug.

	- 5.18 and earlier kernels don't have this bug.  It started some
	time after 5.19-rc1. First observed in "4cd4aed63125 btrfs:
	fold repair_io_failure into btrfs_repair_eb_io_failure" from
	for-next on June 8th 2022.

	- 5.18.12 can mount the test filesystem and process its log tree
	without issue.	Only the -next kernels have a problem with the
	log tree.
