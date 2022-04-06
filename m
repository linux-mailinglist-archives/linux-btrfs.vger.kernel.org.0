Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0564F6CAF
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 23:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiDFVbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 17:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiDFVbF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 17:31:05 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4960B2228D8
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 13:34:46 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1ncCMX-0001XO-Lv by authid <merlin>; Wed, 06 Apr 2022 13:34:45 -0700
Date:   Wed, 6 Apr 2022 13:34:45 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220406203445.GE14804@merlins.org>
References: <20220406003521.GM28707@merlins.org>
 <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
 <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
 <20220406031255.GO28707@merlins.org>
 <20220406033404.GQ28707@merlins.org>
 <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com>
 <20220406185431.GB14804@merlins.org>
 <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
 <20220406191636.GD14804@merlins.org>
 <CAEzrpqf0Vz=6nn-iMeyFsB0qLX+X48zO26Ero-3R6FLCqnzivg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqf0Vz=6nn-iMeyFsB0qLX+X48zO26Ero-3R6FLCqnzivg@mail.gmail.com>
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

On Wed, Apr 06, 2022 at 03:53:34PM -0400, Josef Bacik wrote:
> Alright so it's up to you, clearly my put the tree back together stuff
> takes forever, you can use --init-extent-tree with --lowmem if you'd
> like, I have no idea what the time on that is going to look like.  You
> still may run into problems with that if your subvols are screwed, but
> then I just have to do the work to put subvols back together.  I
> *think* the --init-extent-tree thing will be faster, but let me know
> what you want to do.  Thanks,

Thanks for sticking with me all this time.
So, it was pretty quick before it failed:

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --init-extent-tree --repair /dev/mapper/dshelf1a 
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
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x556ddb2fffc0
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
Couldn't find the last root for 8
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
FS_INFO AFTER IS 0x556ddb2fffc0
Checking filesystem on /dev/mapper/dshelf1a
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
Creating a new extent tree
checksum verify failed on 15645248897024 wanted 0xce96f609 found 0x2d1b5ea6
checksum verify failed on 15645099524096 wanted 0x84d38588 found 0xebe9c53b
checksum verify failed on 11651824091136 wanted 0x6d411825 found 0x3cf07c9d
checksum verify failed on 606126080 wanted 0x8e0fb704 found 0xfc183188
checksum verify failed on 15645807640576 wanted 0xe97841cd found 0x4fa14858
checksum verify failed on 364863324160 wanted 0x741855d8 found 0x5aec3f82
checksum verify failed on 364970688512 wanted 0x33a82891 found 0x154e33ed
checksum verify failed on 15645256777728 wanted 0x6f64534d found 0x8547f2a5
checksum verify failed on 15645178052608 wanted 0x4bb259dd found 0x4668121c
checksum verify failed on 15645277880320 wanted 0x94805cc2 found 0xb68a1cef
checksum verify failed on 15645849485312 wanted 0x7afc435f found 0x6977ed7c
checksum verify failed on 15645146660864 wanted 0xfa138a06 found 0x10cddfd6
checksum verify failed on 15645610672128 wanted 0x2ceeada6 found 0x2db846f5
checksum verify failed on 15645208985600 wanted 0xbaaa42be found 0x769e23f0
checksum verify failed on 11822142046208 wanted 0xc4cc3d0a found 0xace45394
checksum verify failed on 11822142177280 wanted 0x1ac605a6 found 0x17c9826e
checksum verify failed on 6294487416832 wanted 0xe2be154a found 0xff9fb6b0
checksum verify failed on 11971034955776 wanted 0xcab8f347 found 0xdc99be9f
checksum verify failed on 15646027497472 wanted 0xfe85f37e found 0x4e0364ef
checksum verify failed on 15645802315776 wanted 0xdb3aba28 found 0x747ed64e
checksum verify failed on 15645883285504 wanted 0x62bd1000 found 0x7f1300cc
checksum verify failed on 13577053175808 wanted 0x4cec1ad0 found 0xf847830e
checksum verify failed on 15646038179840 wanted 0xe040a9e4 found 0x31183a57
checksum verify failed on 15646040834048 wanted 0x39f56fc2 found 0x336aee8b
checksum verify failed on 15646040604672 wanted 0xa2ff0db7 found 0xff9b0719
checksum verify failed on 15645608050688 wanted 0xe1019329 found 0x835ef4b7
checksum verify failed on 15646038212608 wanted 0x06fb70d5 found 0x704233fa
checksum verify failed on 15645668425728 wanted 0x12b8b29d found 0x7e5aee23
checksum verify failed on 15645461397504 wanted 0xf186173b found 0xd3930df4
checksum verify failed on 15645684269056 wanted 0x6222cf99 found 0x50b7b0dd
checksum verify failed on 15645870178304 wanted 0xf8950821 found 0x1743580d
checksum verify failed on 15646019764224 wanted 0xd96815db found 0xa62eb220
checksum verify failed on 15645870358528 wanted 0x722138e3 found 0x9dbf8691
checksum verify failed on 15646016913408 wanted 0xfe1e83f4 found 0x664795e4
checksum verify failed on 10194600787968 wanted 0x37da9d7c found 0xf7d76f11
checksum verify failed on 15645949083648 wanted 0x14efeeac found 0x46344821
checksum verify failed on 13577202368512 wanted 0x4f5909be found 0x91649194
checksum verify failed on 15645136207872 wanted 0x4a16db57 found 0x042787a6
checksum verify failed on 13577220849664 wanted 0x31a222f0 found 0x98e6f9d5
checksum verify failed on 13577388523520 wanted 0x254b7048 found 0x90c5f781
checksum verify failed on 15645210001408 wanted 0xc64a49c0 found 0x8959550a
checksum verify failed on 13577220997120 wanted 0xc1cf4d40 found 0xb20065f3
checksum verify failed on 15645422108672 wanted 0x63b9fb01 found 0xef400164
checksum verify failed on 365093765120 wanted 0xef058d7b found 0x6d2e4388
checksum verify failed on 15645943742464 wanted 0xa84c7cdb found 0x7435ced6
checksum verify failed on 15645944037376 wanted 0x1ce3f544 found 0x4110ee5a
checksum verify failed on 15645943545856 wanted 0xb7391689 found 0x57835854
checksum verify failed on 15645943644160 wanted 0xd112805c found 0x65133906
checksum verify failed on 15645220012032 wanted 0xb4cb7eb3 found 0xe7134503
checksum verify failed on 11971032399872 wanted 0x1b1c1591 found 0x62f69873
checksum verify failed on 15645123133440 wanted 0xe29086d7 found 0x2bb17c15
checksum verify failed on 15645117890560 wanted 0xf94e5973 found 0xdf7eb70e
checksum verify failed on 15645445554176 wanted 0x9dae4aed found 0x1087f009
checksum verify failed on 15645133553664 wanted 0x5840e80b found 0xa0492d9e
checksum verify failed on 15645125804032 wanted 0xa71f19d7 found 0xd0d29066
checksum verify failed on 15645870292992 wanted 0x764a5b63 found 0x65f2d096
checksum verify failed on 15645209886720 wanted 0xdc6c9ccf found 0xfa3ec3d2
checksum verify failed on 15645167927296 wanted 0xa4d01cb6 found 0x44fb24c2
checksum verify failed on 15645786374144 wanted 0xb7242739 found 0x969cecbb
checksum verify failed on 11971140157440 wanted 0x89f0ba19 found 0x761f18b3
checksum verify failed on 15645076209664 wanted 0xb5e74fba found 0x18d2d38b
checksum verify failed on 15645214834688 wanted 0x81dcde00 found 0xc22cbcc7
checksum verify failed on 15645786636288 wanted 0x1edd6683 found 0xeeafe616
checksum verify failed on 15645217849344 wanted 0xf7574b63 found 0x00ba9085
checksum verify failed on 15645652893696 wanted 0x0fbc611c found 0x9539e808
checksum verify failed on 15645734240256 wanted 0x6ab0998e found 0xb51c5e0c
checksum verify failed on 15645733978112 wanted 0xff835175 found 0x8f517448
checksum verify failed on 15645734010880 wanted 0x5363464a found 0x2aec1941
checksum verify failed on 13577168486400 wanted 0x56b26cca found 0xeb90f5da
checksum verify failed on 13577616375808 wanted 0x190c00d0 found 0x18c748c3
checksum verify failed on 13577184264192 wanted 0x44d0fbb6 found 0x270072ce
checksum verify failed on 13577226272768 wanted 0x14900bf7 found 0x2d0d3658
checksum verify failed on 13577199779840 wanted 0x39a4976f found 0xec18a40c
checksum verify failed on 13577199730688 wanted 0x3e524f64 found 0xe82c5965
checksum verify failed on 13577225994240 wanted 0xc011d76f found 0x67bc3401
checksum verify failed on 15645260890112 wanted 0x0a7005a3 found 0xd182e084
checksum verify failed on 15645260890112 wanted 0x201bc700 found 0x462e9507
checksum verify failed on 15645260890112 wanted 0x201bc700 found 0x462e9507
bad tree block 15645260890112, bad level, 59 > 8
Error reading tree block
error pinning down used bytes
ERROR: commit_root already set when starting transaction
extent buffer leak: start 13577814573056 len 16384

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
