Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97515025FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 09:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350865AbiDOHGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 03:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDOHGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 03:06:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2233BB6E6B
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 00:04:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C35BE1F74D;
        Fri, 15 Apr 2022 07:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650006242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lUl15wnyNpALsREym4HoU2GI7WZsbEM+QrYzHVot/uA=;
        b=GBL39d7Jq+wPQ9YKA4TVOSYviKi9AfQ62f668e6GQP4HL+3zNG4yedA2URA+iKQJjltXbl
        QfpgT5Je5x5VJVf5r951ql3ZV0R4xWoTWBNqKLD5fKMTot1JeWsiYwlktDJIwsYTrnBI99
        ucg0hKtrOcaRIRu2yddUJLgqR0D4j3c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8635713A9B;
        Fri, 15 Apr 2022 07:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dfGhHeIYWWJrAQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 15 Apr 2022 07:04:02 +0000
Message-ID: <4daec659-c1d1-b100-89f7-8a2a2e3e1fc5@suse.com>
Date:   Fri, 15 Apr 2022 10:04:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: btrfs write time tree block corruption
Content-Language: en-US
To:     Maik <mail@ikherbers.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1443235259.231086.1649984361804@communicator.strato.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <1443235259.231086.1649984361804@communicator.strato.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.04.22 г. 3:59 ч., Maik wrote:
> Hello,
> 
> I just received a corrupt leaf error on my root filesystem:
> [29854.502499] BTRFS critical (device dm-0): corrupt leaf: root=2 block=579036020736 slot=86, unexpected item end, have 16789244 expect 12028

This suggests a memory bitflip

16789244 = 1000000000010111011111100
12028 =    ^          10111011111100

The good thing is the tree checker caught this before this corruption 
went on disk. I advise you do run memtest.

> [29854.502510] BTRFS info (device dm-0): leaf 579036020736 gen 835137 total ptrs 117 free space 7101 owner 2
> [29854.502512] 	item 0 key (8690860032 168 4096) itemoff 16230 itemsize 53
> [29854.502514] 		extent refs 1 gen 719917 flags 1
> [29854.502515] 		ref#0: extent data backref root 3669 objectid 1481372 offset 0 count 1
> [29854.502517] 	item 1 key (8690864128 168 4096) itemoff 16177 itemsize 53
> [29854.502519] 		extent refs 1 gen 719062 flags 1
> [29854.502520] 		ref#0: extent data backref root 3669 objectid 1480389 offset 0 count 1
> [29854.502521] 	item 2 key (8690868224 168 4096) itemoff 16124 itemsize 53
> [29854.502522] 		extent refs 1 gen 718960 flags 1
> [29854.502523] 		ref#0: extent data backref root 3669 objectid 1479977 offset 0 count 1
> [29854.502524] 	item 3 key (8690872320 168 4096) itemoff 16087 itemsize 37
> [29854.502525] 		extent refs 1 gen 722404 flags 1
> [29854.502525] 		ref#0: shared data backref parent 578024144896 count 1
> [29854.502527] 	item 4 key (8690876416 168 4096) itemoff 16034 itemsize 53
> [29854.502527] 		extent refs 1 gen 719650 flags 1
> [29854.502528] 		ref#0: extent data backref root 3669 objectid 1481274 offset 0 count 1
> [29854.502529] 	item 5 key (8690880512 168 8192) itemoff 15984 itemsize 50
> [29854.502530] 		extent refs 2 gen 718765 flags 1
> [29854.502531] 		ref#0: shared data backref parent 579228647424 count 1
> [29854.502533] 		ref#1: shared data backref parent 575892652032 count 1
> [29854.502534] 	item 6 key (8690888704 168 4096) itemoff 15947 itemsize 37
> [29854.502536] 		extent refs 1 gen 718889 flags 1
> [29854.502537] 		ref#0: shared data backref parent 579387949056 count 1
> [29854.502538] 	item 7 key (8690892800 168 4096) itemoff 15868 itemsize 79
> [29854.502539] 		extent refs 3 gen 713090 flags 1
> [29854.502540] 		ref#0: extent data backref root 3667 objectid 20709800 offset 0 count 1
> [29854.502541] 		ref#1: shared data backref parent 576328007680 count 1
> [29854.502542] 		ref#2: shared data backref parent 573623435264 count 1
> [29854.502543] 	item 8 key (8690896896 168 61440) itemoff 15776 itemsize 92
> [29854.502544] 		extent refs 4 gen 355411 flags 1
> [29854.502545] 		ref#0: extent data backref root 256 objectid 3594131 offset 0 count 1
> [29854.502546] 		ref#1: shared data backref parent 574217977856 count 1
> [29854.502547] 		ref#2: shared data backref parent 573457268736 count 1
> [29854.502548] 		ref#3: shared data backref parent 572747612160 count 1
> [29854.502549] 	item 9 key (8690958336 168 28672) itemoff 15739 itemsize 37
> [29854.502550] 		extent refs 1 gen 713792 flags 1
> [29854.502551] 		ref#0: shared data backref parent 574759993344 count 1
> [29854.502551] 	item 10 key (8690987008 168 4096) itemoff 15686 itemsize 53
> [29854.502553] 		extent refs 1 gen 713216 flags 1
> [29854.502553] 		ref#0: extent data backref root 3669 objectid 1476845 offset 0 count 1
> [29854.502554] 	item 11 key (8690991104 168 135168) itemoff 15649 itemsize 37
> [29854.502556] 		extent refs 1 gen 466527 flags 1
> [29854.502556] 		ref#0: shared data backref parent 578189508608 count 1
> [29854.502557] 	item 12 key (8691126272 168 8192) itemoff 15612 itemsize 37
> [29854.502558] 		extent refs 1 gen 466840 flags 1
> [29854.502559] 		ref#0: shared data backref parent 573831020544 count 1
> [29854.502560] 	item 13 key (8691134464 168 4096) itemoff 15559 itemsize 53
> [29854.502560] 		extent refs 1 gen 797706 flags 1
> [29854.502561] 		ref#0: extent data backref root 3669 objectid 1565311 offset 0 count 1
> [29854.502562] 	item 14 key (8691138560 168 4096) itemoff 15454 itemsize 105
> [29854.502563] 		extent refs 5 gen 281600 flags 1
> [29854.502564] 		ref#0: extent data backref root 3667 objectid 9374086 offset 0 count 1
> [29854.502565] 		ref#1: shared data backref parent 579615211520 count 1
> [29854.502566] 		ref#2: shared data backref parent 579231891456 count 1
> [29854.502567] 		ref#3: shared data backref parent 572049489920 count 1
> [29854.502568] 		ref#4: shared data backref parent 571511635968 count 1
> [29854.502569] 	item 15 key (8691142656 168 36864) itemoff 15417 itemsize 37
> [29854.502570] 		extent refs 1 gen 466840 flags 1
> [29854.502570] 		ref#0: shared data backref parent 575256018944 count 1
> [29854.502571] 	item 16 key (8691179520 168 8192) itemoff 15380 itemsize 37
> [29854.502572] 		extent refs 1 gen 466840 flags 1
> [29854.502573] 		ref#0: shared data backref parent 576205406208 count 1
> [29854.502574] 	item 17 key (8691187712 168 4096) itemoff 15327 itemsize 53
> [29854.502575] 		extent refs 1 gen 797706 flags 1
> [29854.502576] 		ref#0: extent data backref root 3669 objectid 1565312 offset 0 count 1
> [29854.502577] 	item 18 key (8691191808 168 8192) itemoff 15274 itemsize 53
> [29854.502578] 		extent refs 1 gen 720292 flags 1
> [29854.502578] 		ref#0: extent data backref root 3669 objectid 1481471 offset 0 count 1
> [29854.502579] 	item 19 key (8691200000 168 4096) itemoff 15221 itemsize 53
> [29854.502580] 		extent refs 1 gen 715096 flags 1
> [29854.502581] 		ref#0: extent data backref root 3669 objectid 1478745 offset 0 count 1
> [29854.502582] 	item 20 key (8691204096 168 32768) itemoff 15184 itemsize 37
> [29854.502583] 		extent refs 1 gen 717385 flags 1
> [29854.502584] 		ref#0: shared data backref parent 579264708608 count 1
> [29854.502585] 	item 21 key (8691236864 168 4096) itemoff 15131 itemsize 53
> [29854.502586] 		extent refs 1 gen 722612 flags 1
> [29854.502586] 		ref#0: extent data backref root 3669 objectid 1484759 offset 0 count 1
> [29854.502587] 	item 22 key (8691240960 168 4096) itemoff 15078 itemsize 53
> [29854.502588] 		extent refs 1 gen 722612 flags 1
> [29854.502589] 		ref#0: extent data backref root 3669 objectid 1484760 offset 0 count 1
> [29854.502590] 	item 23 key (8691245056 168 4096) itemoff 15025 itemsize 53
> [29854.502591] 		extent refs 1 gen 715140 flags 1
> [29854.502592] 		ref#0: extent data backref root 3669 objectid 1478773 offset 0 count 1
> [29854.502593] 	item 24 key (8691249152 168 4096) itemoff 14972 itemsize 53
> [29854.502594] 		extent refs 1 gen 715096 flags 1
> [29854.502594] 		ref#0: extent data backref root 3669 objectid 1478746 offset 0 count 1
> [29854.502595] 	item 25 key (8691253248 168 8192) itemoff 14935 itemsize 37
> [29854.502596] 		extent refs 1 gen 717385 flags 1
> [29854.502597] 		ref#0: shared data backref parent 579187752960 count 1
> [29854.502598] 	item 26 key (8691261440 168 8192) itemoff 14882 itemsize 53
> [29854.502599] 		extent refs 1 gen 720994 flags 1
> [29854.502599] 		ref#0: extent data backref root 3669 objectid 1483293 offset 0 count 1
> [29854.502601] 	item 27 key (8691269632 168 8192) itemoff 14845 itemsize 37
> [29854.502602] 		extent refs 1 gen 717385 flags 1
> [29854.502602] 		ref#0: shared data backref parent 579187752960 count 1
> [29854.502603] 	item 28 key (8691277824 168 4096) itemoff 14792 itemsize 53
> [29854.502604] 		extent refs 1 gen 715740 flags 1
> [29854.502605] 		ref#0: extent data backref root 3669 objectid 1479211 offset 0 count 1
> [29854.502606] 	item 29 key (8691281920 168 8192) itemoff 14739 itemsize 53
> [29854.502607] 		extent refs 1 gen 715096 flags 1
> [29854.502607] 		ref#0: extent data backref root 3669 objectid 1478744 offset 0 count 1
> [29854.502608] 	item 30 key (8691290112 168 4096) itemoff 14686 itemsize 53
> [29854.502609] 		extent refs 1 gen 715096 flags 1
> [29854.502610] 		ref#0: extent data backref root 3669 objectid 1478748 offset 0 count 1
> [29854.502611] 	item 31 key (8691294208 168 4096) itemoff 14633 itemsize 53
> [29854.502612] 		extent refs 1 gen 715140 flags 1
> [29854.502613] 		ref#0: extent data backref root 3669 objectid 1478774 offset 0 count 1
> [29854.502614] 	item 32 key (8691298304 168 8192) itemoff 14596 itemsize 37
> [29854.502615] 		extent refs 1 gen 717385 flags 1
> [29854.502616] 		ref#0: shared data backref parent 579187752960 count 1
> [29854.502616] 	item 33 key (8691306496 168 4096) itemoff 14543 itemsize 53
> [29854.502673] 		extent refs 1 gen 717463 flags 1
> [29854.502674] 		ref#0: extent data backref root 3669 objectid 1479631 offset 0 count 1
> [29854.502675] 	item 34 key (8691310592 168 4096) itemoff 14490 itemsize 53
> [29854.502676] 		extent refs 1 gen 715536 flags 1
> [29854.502677] 		ref#0: extent data backref root 3667 objectid 20783545 offset 0 count 1
> [29854.502678] 	item 35 key (8691314688 168 8192) itemoff 14453 itemsize 37
> [29854.502679] 		extent refs 1 gen 717385 flags 1
> [29854.502679] 		ref#0: shared data backref parent 579187752960 count 1
> [29854.502681] 	item 36 key (8691322880 168 8192) itemoff 14416 itemsize 37
> [29854.502681] 		extent refs 1 gen 717385 flags 1
> [29854.502682] 		ref#0: shared data backref parent 579187752960 count 1
> [29854.502683] 	item 37 key (8691331072 168 4096) itemoff 14363 itemsize 53
> [29854.502684] 		extent refs 1 gen 715374 flags 1
> [29854.502685] 		ref#0: extent data backref root 3669 objectid 1478892 offset 0 count 1
> [29854.502686] 	item 38 key (8691335168 168 4096) itemoff 14310 itemsize 53
> [29854.502687] 		extent refs 1 gen 715374 flags 1
> [29854.502687] 		ref#0: extent data backref root 3669 objectid 1478896 offset 0 count 1
> [29854.502688] 	item 39 key (8691339264 168 8192) itemoff 14257 itemsize 53
> [29854.502689] 		extent refs 1 gen 718766 flags 1
> [29854.502690] 		ref#0: extent data backref root 3669 objectid 1479899 offset 0 count 1
> [29854.502691] 	item 40 key (8691347456 168 8192) itemoff 14204 itemsize 53
> [29854.502692] 		extent refs 1 gen 715096 flags 1
> [29854.502693] 		ref#0: extent data backref root 3669 objectid 1478747 offset 0 count 1
> [29854.502694] 	item 41 key (8691355648 168 8192) itemoff 14151 itemsize 53
> [29854.502695] 		extent refs 1 gen 715096 flags 1
> [29854.502696] 		ref#0: extent data backref root 3669 objectid 1478749 offset 0 count 1
> [29854.502697] 	item 42 key (8691363840 168 4096) itemoff 14098 itemsize 53
> [29854.502698] 		extent refs 1 gen 715096 flags 1
> [29854.502698] 		ref#0: extent data backref root 3669 objectid 1478750 offset 0 count 1
> [29854.502699] 	item 43 key (8691367936 168 4096) itemoff 14045 itemsize 53
> [29854.502700] 		extent refs 1 gen 715096 flags 1
> [29854.502701] 		ref#0: extent data backref root 3669 objectid 1478751 offset 0 count 1
> [29854.502702] 	item 44 key (8691372032 168 4096) itemoff 13992 itemsize 53
> [29854.502703] 		extent refs 1 gen 715096 flags 1
> [29854.502704] 		ref#0: extent data backref root 3669 objectid 1478752 offset 0 count 1
> [29854.502705] 	item 45 key (8691376128 168 4096) itemoff 13939 itemsize 53
> [29854.502706] 		extent refs 1 gen 715096 flags 1
> [29854.502707] 		ref#0: extent data backref root 3669 objectid 1478753 offset 0 count 1
> [29854.502708] 	item 46 key (8691380224 168 4096) itemoff 13886 itemsize 53
> [29854.502709] 		extent refs 1 gen 715096 flags 1
> [29854.502709] 		ref#0: extent data backref root 3669 objectid 1478754 offset 0 count 1
> [29854.502711] 	item 47 key (8691384320 168 4096) itemoff 13833 itemsize 53
> [29854.502712] 		extent refs 1 gen 715096 flags 1
> [29854.502712] 		ref#0: extent data backref root 3669 objectid 1478755 offset 0 count 1
> [29854.502713] 	item 48 key (8691388416 168 24576) itemoff 13780 itemsize 53
> [29854.502714] 		extent refs 1 gen 713097 flags 1
> [29854.502715] 		ref#0: extent data backref root 3675 objectid 470060 offset 1048576 count 1
> [29854.502716] 	item 49 key (8691412992 168 16384) itemoff 13727 itemsize 53
> [29854.502717] 		extent refs 1 gen 713097 flags 1
> [29854.502718] 		ref#0: extent data backref root 3675 objectid 467678 offset 0 count 1
> [29854.502719] 	item 50 key (8691429376 168 20480) itemoff 13648 itemsize 79
> [29854.502720] 		extent refs 3 gen 713078 flags 1
> [29854.502721] 		ref#0: extent data backref root 3667 objectid 20709342 offset 9961472 count 1
> [29854.502722] 		ref#1: shared data backref parent 578715762688 count 1
> [29854.502723] 		ref#2: shared data backref parent 576394493952 count 1
> [29854.502724] 	item 51 key (8691449856 168 8192) itemoff 13598 itemsize 50
> [29854.502725] 		extent refs 2 gen 718766 flags 1
> [29854.502725] 		ref#0: shared data backref parent 579228647424 count 1
> [29854.502726] 		ref#1: shared data backref parent 575892652032 count 1
> [29854.502727] 	item 52 key (8691458048 168 8192) itemoff 13561 itemsize 37
> [29854.502728] 		extent refs 1 gen 723210 flags 1
> [29854.502729] 		ref#0: shared data backref parent 571456503808 count 1
> [29854.502730] 	item 53 key (8691466240 168 4096) itemoff 13456 itemsize 105
> [29854.502731] 		extent refs 5 gen 723212 flags 1
> [29854.502731] 		ref#0: extent data backref root 3667 objectid 20990590 offset 16384 count 1
> [29854.502733] 		ref#1: shared data backref parent 579196682240 count 1
> [29854.502734] 		ref#2: shared data backref parent 577116372992 count 1
> [29854.502735] 		ref#3: shared data backref parent 575296929792 count 1
> [29854.502735] 		ref#4: shared data backref parent 572725641216 count 1
> [29854.502736] 	item 54 key (8691470336 168 4096) itemoff 13419 itemsize 37
> [29854.502737] 		extent refs 1 gen 723182 flags 1
> [29854.502738] 		ref#0: shared data backref parent 579880517632 count 1
> [29854.502739] 	item 55 key (8691474432 168 4096) itemoff 13366 itemsize 53
> [29854.502740] 		extent refs 1 gen 722612 flags 1
> [29854.502740] 		ref#0: extent data backref root 3669 objectid 1484762 offset 0 count 1
> [29854.502742] 	item 56 key (8691478528 168 4096) itemoff 13313 itemsize 53
> [29854.502743] 		extent refs 1 gen 728459 flags 1
> [29854.502743] 		ref#0: extent data backref root 3669 objectid 1488672 offset 0 count 1
> [29854.502744] 	item 57 key (8691482624 168 4096) itemoff 13250 itemsize 63
> [29854.502745] 		extent refs 3 gen 722732 flags 1
> [29854.502746] 		ref#0: shared data backref parent 579263266816 count 1
> [29854.502747] 		ref#1: shared data backref parent 576717012992 count 1
> [29854.502748] 		ref#2: shared data backref parent 576122060800 count 1
> [29854.502749] 	item 58 key (8691486720 168 4096) itemoff 13197 itemsize 53
> [29854.502750] 		extent refs 1 gen 728155 flags 1
> [29854.502750] 		ref#0: extent data backref root 3669 objectid 1488543 offset 0 count 1
> [29854.502751] 	item 59 key (8691490816 168 36864) itemoff 13144 itemsize 53
> [29854.502753] 		extent refs 1 gen 645342 flags 1
> [29854.502753] 		ref#0: extent data backref root 256 objectid 5476888 offset 6291456 count 1
> [29854.502754] 	item 60 key (8691527680 168 4096) itemoff 13107 itemsize 37
> [29854.502755] 		extent refs 1 gen 154255 flags 1
> [29854.502756] 		ref#0: shared data backref parent 579775021056 count 1
> [29854.502757] 	item 61 key (8691531776 168 4096) itemoff 13070 itemsize 37
> [29854.502758] 		extent refs 1 gen 154255 flags 1
> [29854.502758] 		ref#0: shared data backref parent 579775021056 count 1
> [29854.502759] 	item 62 key (8691535872 168 4096) itemoff 13033 itemsize 37
> [29854.502760] 		extent refs 1 gen 154255 flags 1
> [29854.502761] 		ref#0: shared data backref parent 579775021056 count 1
> [29854.502762] 	item 63 key (8691539968 168 249856) itemoff 12996 itemsize 37
> [29854.502763] 		extent refs 1 gen 466415 flags 1
> [29854.502764] 		ref#0: shared data backref parent 579162750976 count 1
> [29854.502765] 	item 64 key (8691789824 168 36864) itemoff 12959 itemsize 37
> [29854.502766] 		extent refs 1 gen 466840 flags 1
> [29854.502766] 		ref#0: shared data backref parent 575256018944 count 1
> [29854.502767] 	item 65 key (8691826688 168 4096) itemoff 12906 itemsize 53
> [29854.502768] 		extent refs 1 gen 797706 flags 1
> [29854.502769] 		ref#0: extent data backref root 3669 objectid 1565313 offset 0 count 1
> [29854.502770] 	item 66 key (8691830784 168 4096) itemoff 12853 itemsize 53
> [29854.502771] 		extent refs 1 gen 827605 flags 1
> [29854.502772] 		ref#0: extent data backref root 7300 objectid 1259693 offset 0 count 1
> [29854.502773] 	item 67 key (8691834880 168 20480) itemoff 12816 itemsize 37
> [29854.502774] 		extent refs 1 gen 645268 flags 1
> [29854.502774] 		ref#0: shared data backref parent 577609629696 count 1
> [29854.502775] 	item 68 key (8691855360 168 4096) itemoff 12763 itemsize 53
> [29854.502776] 		extent refs 1 gen 797634 flags 1
> [29854.502777] 		ref#0: extent data backref root 3669 objectid 1565255 offset 0 count 1
> [29854.502778] 	item 69 key (8691859456 168 8192) itemoff 12710 itemsize 53
> [29854.502779] 		extent refs 1 gen 270813 flags 1
> [29854.502780] 		ref#0: extent data backref root 3669 objectid 924148 offset 0 count 1
> [29854.502781] 	item 70 key (8691867648 168 16384) itemoff 12673 itemsize 37
> [29854.502782] 		extent refs 1 gen 645268 flags 1
> [29854.502782] 		ref#0: shared data backref parent 577609629696 count 1
> [29854.502783] 	item 71 key (8691884032 168 8192) itemoff 12636 itemsize 37
> [29854.502784] 		extent refs 1 gen 154827 flags 1
> [29854.502785] 		ref#0: shared data backref parent 579800170496 count 1
> [29854.502786] 	item 72 key (8691892224 168 8192) itemoff 12599 itemsize 37
> [29854.502787] 		extent refs 1 gen 645270 flags 1
> [29854.502787] 		ref#0: shared data backref parent 577596555264 count 1
> [29854.502788] 	item 73 key (8691900416 168 28672) itemoff 12562 itemsize 37
> [29854.502789] 		extent refs 1 gen 466424 flags 1
> [29854.502790] 		ref#0: shared data backref parent 575865421824 count 1
> [29854.502791] 	item 74 key (8691929088 168 4096) itemoff 12483 itemsize 79
> [29854.502792] 		extent refs 3 gen 713090 flags 1
> [29854.502792] 		ref#0: extent data backref root 3667 objectid 20709815 offset 0 count 1
> [29854.502793] 		ref#1: shared data backref parent 576358547456 count 1
> [29854.502794] 		ref#2: shared data backref parent 573623451648 count 1
> [29854.502795] 	item 75 key (8691933184 168 69632) itemoff 12446 itemsize 37
> [29854.502796] 		extent refs 1 gen 466840 flags 1
> [29854.502797] 		ref#0: shared data backref parent 575256018944 count 1
> [29854.502798] 	item 76 key (8692002816 168 4096) itemoff 12393 itemsize 53
> [29854.502799] 		extent refs 1 gen 557211 flags 1
> [29854.502800] 		ref#0: extent data backref root 3669 objectid 1232302 offset 0 count 1
> [29854.502801] 	item 77 key (8692006912 168 8192) itemoff 12356 itemsize 37
> [29854.502802] 		extent refs 1 gen 645270 flags 1
> [29854.502803] 		ref#0: shared data backref parent 578078048256 count 1
> [29854.502804] 	item 78 key (8692015104 168 4096) itemoff 12319 itemsize 37
> [29854.502804] 		extent refs 1 gen 153143 flags 1
> [29854.502805] 		ref#0: shared data backref parent 577629880320 count 1
> [29854.502806] 	item 79 key (8692019200 168 8192) itemoff 12282 itemsize 37
> [29854.502807] 		extent refs 1 gen 645270 flags 1
> [29854.502808] 		ref#0: shared data backref parent 577596571648 count 1
> [29854.502809] 	item 80 key (8692027392 168 8192) itemoff 12245 itemsize 37
> [29854.502810] 		extent refs 1 gen 467719 flags 1
> [29854.502810] 		ref#0: shared data backref parent 574194991104 count 1
> [29854.502811] 	item 81 key (8692035584 168 4096) itemoff 12192 itemsize 53
> [29854.502812] 		extent refs 1 gen 797634 flags 1
> [29854.502813] 		ref#0: extent data backref root 3669 objectid 1565256 offset 0 count 1
> [29854.502814] 	item 82 key (8692039680 168 4096) itemoff 12155 itemsize 37
> [29854.502816] 		extent refs 1 gen 466552 flags 1
> [29854.502816] 		ref#0: shared data backref parent 571483865088 count 1
> [29854.502817] 	item 83 key (8692043776 168 4096) itemoff 12102 itemsize 53
> [29854.502818] 		extent refs 1 gen 797634 flags 1
> [29854.502819] 		ref#0: extent data backref root 3669 objectid 1565257 offset 0 count 1
> [29854.502820] 	item 84 key (8692047872 168 4096) itemoff 12065 itemsize 37
> [29854.502821] 		extent refs 1 gen 266859 flags 1
> [29854.502822] 		ref#0: shared data backref parent 577637695488 count 1
> [29854.502823] 	item 85 key (8692051968 168 8192) itemoff 12028 itemsize 37
> [29854.502824] 		extent refs 1 gen 645270 flags 1
> [29854.502824] 		ref#0: shared data backref parent 577596686336 count 1
> [29854.502825] 	item 86 key (8692060160 168 4096) itemoff 11991 itemsize 16777253
> [29854.502826] 		extent refs 1 gen 153143 flags 1
> [29854.502827] 		ref#0: shared data backref parent 577629880320 count 1
> [29854.502828] 		ref#1: (extent 579036020736 has INVALID ref type 1)
> [29854.502829] 	item 87 key (8692064256 168 20480) itemoff 11954 itemsize 37
> [29854.502830] 		extent refs 1 gen 645268 flags 1
> [29854.502831] 		ref#0: shared data backref parent 577609629696 count 1
> [29854.502832] 	item 88 key (8692084736 168 8192) itemoff 11917 itemsize 37
> [29854.502833] 		extent refs 1 gen 723210 flags 1
> [29854.502833] 		ref#0: shared data backref parent 571456503808 count 1
> [29854.502834] 	item 89 key (8692092928 168 8192) itemoff 11880 itemsize 37
> [29854.502835] 		extent refs 1 gen 723210 flags 1
> [29854.502836] 		ref#0: shared data backref parent 571456503808 count 1
> [29854.502837] 	item 90 key (8692101120 168 8192) itemoff 11843 itemsize 37
> [29854.502838] 		extent refs 1 gen 645270 flags 1
> [29854.502838] 		ref#0: shared data backref parent 578078048256 count 1
> [29854.502839] 	item 91 key (8692109312 168 4096) itemoff 11790 itemsize 53
> [29854.502840] 		extent refs 1 gen 267071 flags 1
> [29854.502841] 		ref#0: extent data backref root 3669 objectid 919872 offset 0 count 1
> [29854.502842] 	item 92 key (8692113408 168 4096) itemoff 11737 itemsize 53
> [29854.502843] 		extent refs 1 gen 797706 flags 1
> [29854.502844] 		ref#0: extent data backref root 3669 objectid 1565314 offset 0 count 1
> [29854.502845] 	item 93 key (8692117504 168 4096) itemoff 11255 itemsize 482
> [29854.502846] 		extent refs 34 gen 156311 flags 1
> [29854.502847] 		ref#0: extent data backref root 3667 objectid 1610151 offset 20480 count 1
> [29854.502848] 		ref#1: shared data backref parent 580038066176 count 1
> [29854.502849] 		ref#2: shared data backref parent 580017389568 count 1
> [29854.502850] 		ref#3: shared data backref parent 579580805120 count 1
> [29854.502851] 		ref#4: shared data backref parent 579257663488 count 1
> [29854.502852] 		ref#5: shared data backref parent 578824650752 count 1
> [29854.502853] 		ref#6: shared data backref parent 578792079360 count 1
> [29854.502854] 		ref#7: shared data backref parent 577932345344 count 1
> [29854.502855] 		ref#8: shared data backref parent 577752039424 count 1
> [29854.502856] 		ref#9: shared data backref parent 577638318080 count 1
> [29854.502857] 		ref#10: shared data backref parent 577067548672 count 1
> [29854.502858] 		ref#11: shared data backref parent 576617480192 count 1
> [29854.502859] 		ref#12: shared data backref parent 576585646080 count 1
> [29854.502860] 		ref#13: shared data backref parent 575853543424 count 1
> [29854.502861] 		ref#14: shared data backref parent 575258836992 count 1
> [29854.502862] 		ref#15: shared data backref parent 574833590272 count 1
> [29854.502863] 		ref#16: shared data backref parent 574811439104 count 1
> [29854.502864] 		ref#17: shared data backref parent 574701862912 count 1
> [29854.502865] 		ref#18: shared data backref parent 573863657472 count 1
> [29854.502866] 		ref#19: shared data backref parent 573668016128 count 1
> [29854.502867] 		ref#20: shared data backref parent 573509369856 count 1
> [29854.502868] 		ref#21: shared data backref parent 573501423616 count 1
> [29854.502869] 		ref#22: shared data backref parent 573409329152 count 1
> [29854.502870] 		ref#23: shared data backref parent 573408952320 count 1
> [29854.502870] 		ref#24: shared data backref parent 573114089472 count 1
> [29854.502872] 		ref#25: shared data backref parent 572675244032 count 1
> [29854.502872] 		ref#26: shared data backref parent 572589015040 count 1
> [29854.502873] 		ref#27: shared data backref parent 572219703296 count 1
> [29854.502874] 		ref#28: shared data backref parent 571861106688 count 1
> [29854.502876] 		ref#29: shared data backref parent 571833466880 count 1
> [29854.502877] 		ref#30: shared data backref parent 571541258240 count 1
> [29854.502878] 		ref#31: shared data backref parent 571541143552 count 1
> [29854.502879] 		ref#32: shared data backref parent 571516633088 count 1
> [29854.502880] 		ref#33: shared data backref parent 571463319552 count 1
> [29854.502881] 	item 94 key (8692121600 168 12288) itemoff 11218 itemsize 37
> [29854.502882] 		extent refs 1 gen 645268 flags 1
> [29854.502883] 		ref#0: shared data backref parent 577609629696 count 1
> [29854.502884] 	item 95 key (8692133888 168 4096) itemoff 11165 itemsize 53
> [29854.502885] 		extent refs 1 gen 153216 flags 1
> [29854.502885] 		ref#0: extent data backref root 3672 objectid 337702 offset 0 count 1
> [29854.502886] 	item 96 key (8692137984 168 16384) itemoff 11128 itemsize 37
> [29854.502887] 		extent refs 1 gen 645268 flags 1
> [29854.502888] 		ref#0: shared data backref parent 577609629696 count 1
> [29854.502889] 	item 97 key (8692154368 168 8192) itemoff 11075 itemsize 53
> [29854.502890] 		extent refs 1 gen 700816 flags 1
> [29854.502891] 		ref#0: extent data backref root 3669 objectid 1470925 offset 0 count 1
> [29854.502892] 	item 98 key (8692162560 168 4096) itemoff 11022 itemsize 53
> [29854.502893] 		extent refs 1 gen 667647 flags 1
> [29854.502893] 		ref#0: extent data backref root 3669 objectid 1452066 offset 0 count 1
> [29854.502895] 	item 99 key (8692166656 168 12288) itemoff 10985 itemsize 37
> [29854.502896] 		extent refs 1 gen 645268 flags 1
> [29854.502896] 		ref#0: shared data backref parent 577582661632 count 1
> [29854.502897] 	item 100 key (8692178944 168 4096) itemoff 10948 itemsize 37
> [29854.502898] 		extent refs 1 gen 153125 flags 1
> [29854.502899] 		ref#0: shared data backref parent 577629880320 count 1
> [29854.502900] 	item 101 key (8692183040 168 16384) itemoff 10911 itemsize 37
> [29854.502901] 		extent refs 1 gen 645268 flags 1
> [29854.502901] 		ref#0: shared data backref parent 577609629696 count 1
> [29854.502902] 	item 102 key (8692199424 168 12288) itemoff 10874 itemsize 37
> [29854.502903] 		extent refs 1 gen 645268 flags 1
> [29854.502904] 		ref#0: shared data backref parent 577609580544 count 1
> [29854.502905] 	item 103 key (8692211712 168 4096) itemoff 10837 itemsize 37
> [29854.502906] 		extent refs 1 gen 234325 flags 1
> [29854.502907] 		ref#0: shared data backref parent 575074910208 count 1
> [29854.502908] 	item 104 key (8692215808 168 8192) itemoff 10800 itemsize 37
> [29854.502909] 		extent refs 1 gen 723170 flags 1
> [29854.502909] 		ref#0: shared data backref parent 578660548608 count 1
> [29854.502910] 	item 105 key (8692224000 168 4096) itemoff 10721 itemsize 79
> [29854.502911] 		extent refs 3 gen 713090 flags 1
> [29854.502912] 		ref#0: extent data backref root 3667 objectid 20709858 offset 0 count 1
> [29854.502913] 		ref#1: shared data backref parent 576343162880 count 1
> [29854.502914] 		ref#2: shared data backref parent 573623517184 count 1
> [29854.502915] 	item 106 key (8692228096 168 40960) itemoff 10684 itemsize 37
> [29854.502916] 		extent refs 1 gen 466840 flags 1
> [29854.502917] 		ref#0: shared data backref parent 575256018944 count 1
> [29854.502918] 	item 107 key (8692269056 168 8192) itemoff 10647 itemsize 37
> [29854.502919] 		extent refs 1 gen 466840 flags 1
> [29854.502919] 		ref#0: shared data backref parent 573831020544 count 1
> [29854.502920] 	item 108 key (8692277248 168 8192) itemoff 10610 itemsize 37
> [29854.502921] 		extent refs 1 gen 466842 flags 1
> [29854.502922] 		ref#0: shared data backref parent 575256018944 count 1
> [29854.502923] 	item 109 key (8692285440 168 4096) itemoff 10573 itemsize 37
> [29854.502924] 		extent refs 1 gen 155859 flags 1
> [29854.502925] 		ref#0: shared data backref parent 579775725568 count 1
> [29854.502926] 	item 110 key (8692289536 168 4096) itemoff 10536 itemsize 37
> [29854.502927] 		extent refs 1 gen 713090 flags 1
> [29854.502927] 		ref#0: shared data backref parent 573623517184 count 1
> [29854.502928] 	item 111 key (8692293632 168 4096) itemoff 10275 itemsize 261
> [29854.502929] 		extent refs 17 gen 615081 flags 1
> [29854.502930] 		ref#0: extent data backref root 3667 objectid 18455629 offset 0 count 1
> [29854.502931] 		ref#1: shared data backref parent 579913367552 count 1
> [29854.502933] 		ref#2: shared data backref parent 579424059392 count 1
> [29854.502934] 		ref#3: shared data backref parent 579403235328 count 1
> [29854.502935] 		ref#4: shared data backref parent 578495332352 count 1
> [29854.502936] 		ref#5: shared data backref parent 577793376256 count 1
> [29854.502936] 		ref#6: shared data backref parent 575988121600 count 1
> [29854.502937] 		ref#7: shared data backref parent 575915884544 count 1
> [29854.502938] 		ref#8: shared data backref parent 575797379072 count 1
> [29854.502939] 		ref#9: shared data backref parent 575544098816 count 1
> [29854.502940] 		ref#10: shared data backref parent 575443288064 count 1
> [29854.502941] 		ref#11: shared data backref parent 575114149888 count 1
> [29854.502942] 		ref#12: shared data backref parent 574124113920 count 1
> [29854.502943] 		ref#13: shared data backref parent 574068391936 count 1
> [29854.502944] 		ref#14: shared data backref parent 573444292608 count 1
> [29854.502945] 		ref#15: shared data backref parent 571771404288 count 1
> [29854.502946] 		ref#16: shared data backref parent 571612102656 count 1
> [29854.502947] 	item 112 key (8692297728 168 4096) itemoff 10222 itemsize 53
> [29854.502948] 		extent refs 1 gen 797634 flags 1
> [29854.502949] 		ref#0: extent data backref root 3669 objectid 1565258 offset 0 count 1
> [29854.502950] 	item 113 key (8692301824 168 4096) itemoff 10185 itemsize 37
> [29854.502951] 		extent refs 1 gen 154522 flags 1
> [29854.502951] 		ref#0: shared data backref parent 579800170496 count 1
> [29854.502952] 	item 114 key (8692305920 168 4096) itemoff 10132 itemsize 53
> [29854.502953] 		extent refs 1 gen 827713 flags 1
> [29854.502954] 		ref#0: extent data backref root 3673 objectid 93335 offset 2838528 count 1
> [29854.502955] 	item 115 key (8692310016 168 4096) itemoff 10079 itemsize 53
> [29854.502973] 		extent refs 1 gen 726628 flags 1
> [29854.502973] 		ref#0: extent data backref root 3669 objectid 1488022 offset 0 count 1
> [29854.502974] 	item 116 key (8692314112 168 4096) itemoff 10026 itemsize 53
> [29854.502975] 		extent refs 1 gen 699783 flags 1
> [29854.502976] 		ref#0: extent data backref root 3672 objectid 1657408 offset 0 count 1
> [29854.502977] BTRFS error (device dm-0): block=579036020736 write time tree block corruption detected
> [29854.530019] BTRFS: error (device dm-0) in btrfs_commit_transaction:2403: errno=-5 IO failure (Error while writing out transaction)
> [29854.530025] BTRFS info (device dm-0): forced readonly
> [29854.530027] BTRFS warning (device dm-0): Skipping commit of aborted transaction.
> [29854.530032] BTRFS: error (device dm-0) in cleanup_transaction:1974: errno=-5 IO failure
> [29854.531007] BTRFS warning (device dm-0): Skipping commit of aborted transaction.
> [29854.531011] BTRFS: error (device dm-0) in cleanup_transaction:1974: errno=-5 IO failure
> [30578.928374] BTRFS info (device dm-0): scrub: started on devid 1
> [30578.928384] BTRFS info (device dm-0): scrub: not finished on devid 1 with status: -30
> [30601.134628] BTRFS info (device dm-0): scrub: started on devid 1
> [30601.134639] BTRFS info (device dm-0): scrub: not finished on devid 1 with status: -30
> 
> I run kernel 5.17.2-arch3-1, updated yesterday from 5.16.16-arch1-1. The filesystem is compressed with zstd and contains a swapfile which I used for hibernation. It is located on a SSD.
> 
> If there is any important missing information, let me know.
> I'd appreciated any advice.
> 
> Maik
> 
> 
