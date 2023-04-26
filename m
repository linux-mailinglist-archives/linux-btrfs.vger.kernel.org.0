Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547406EEFFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbjDZILq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 04:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbjDZILi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 04:11:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13431706
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 01:11:35 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5rU-1peIaH3fiS-00M0nY; Wed, 26
 Apr 2023 10:11:30 +0200
Message-ID: <a0f6195f-e6d1-f633-9cd7-310fe5786546@gmx.com>
Date:   Wed, 26 Apr 2023 16:11:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     =?UTF-8?Q?Lauren=c8=9biu_Nicola?= <lnicola@dend.ro>,
        linux-btrfs@vger.kernel.org
References: <d2975210-6fd4-4bf2-b72f-ffba664bdcc0@betaapp.fastmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Corruption and error on Linux 6.2.8 in btrfs_commit_transaction
 -> btrfs_run_delayed_refs
In-Reply-To: <d2975210-6fd4-4bf2-b72f-ffba664bdcc0@betaapp.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OZtPTPtfw3Hkswd4rjh7b7IcjAG3D+QvuISfcL5577vBzX3j2G2
 rW6u2JG1s8u0AKdhUEqNSD3U6pC875ptyYy0g0yo+YIJBa9nHJdtUPBlrXkZGSn5SbxrGy+
 1Owjoa41gUKFkTISo/jHm44ImYfGhtBm9Oi4ONWNEr+Kv04vVgjwd16LiarwJ+8zNdXXSsX
 TcoF8kxPIFOu366Kb77hQ==
UI-OutboundReport: notjunk:1;M01:P0:E9v3AlzOG9I=;tif4BXaYtDeY3x01PXZQaeE5cM7
 KI4w1CVuFNS3fhl2KzSfLYYjyPH21lepbWxxjfaZ7ZQHeeu3KMS10dVuhCK1Y9HavJd/ry7YM
 wt8Z2+BVBj3cpPBMy0xZYs5mx22U33S9FeGvv//Rs1CIE7L/uEDHa2cKsweC+LY6XgdozrAuc
 ethk/9O0lZLgGUUa+MrmT1546H0w0PVsk4vc+8jCYhqwV4uPyQrUwci1nzg7YiiLLgwtGH8aP
 059M7tZ2LRURo3Mu85010BNGLyd99VxVIbRxYYrSceqXZRm9w+ao+R/4UExw7kbnVkZG+Zj7S
 rGHdZbsddkusp8llUUfyBHS0xuNTCMX/LSZ5M4YONZhSEwaUEQAVbkhKL+As4J+0J3W+x4w50
 GyfxtmaRgN40scx9QsQMYBSn9OdCpKUr4gMCaJJPUTuaTaGKLO7VkBfetMHkyXGbCeslLQ+OX
 SrrrI0p7RZCljh2tgc737QJSajyza/m1J3ifQET6GfXjTJwE9nuLxQPhkGSYCDRVNFtce2JGl
 CBcq+9NlzLXHw3/EaoCi0njRJK5Ob7GC9tdh5jZPrZeM3BfN3g6p6RR6wI20uucKMMyl/TLnX
 BYNmqVredIylO5fqIIg2mEHc5HYCSZVk/jYTYd2aaZPx2NGRbsW//XK36AyTKNWH+rtQOJTff
 UwJbrPYDqMTMy8v91/duzAoxVJ7r3O/l0SUxZtP0GaouzBETiZ4u8zEE7NO+AMat/s6TTm3Vi
 Mcvyw/sz1BaRVTq4qB+lbo+Ma4Ayj7oqXEFN/EToQmsxtU1JcovkLJXC4xmmBP1LVyHwZoVzn
 Cff+NHJopLmXDuzGX4NgGLtXcma1VjWF5twVA9LR2ciSi5zuoOZdkUhcDufFZPN+p2hMxRY2w
 w90ND38H9+yQtNvPB3SR1NkNWPIYZie7bjKX01Xnjq916uUhvhEvKZCvxMrRz9UNTvs9VVABL
 9NBWiFrUhU9qaIJmRVC9saMwuZ0=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/26 15:35, Laurențiu Nicola wrote:
> Hi,
> 
[...]
> 
> WARNING: tree block [693902610432, 693902626816) is not nodesize aligned, may cause problem for 64K page system

This is already werid as newerly converted btrfs shouldn't have such 
tree blocks.

> 
> , then:
> 
> ref mismatch on [634543001600 16384] extent item 0, found 1
> tree extent[634543001600, 16384] root 258 has no backref item in extent tree
> backpointer mismatch on [634543001600 16384]

Corrupted extent tree, missing a lot of backrefs.

[...]
> extent item 693637414912 has multiple extent items

And one very weird errors on that tree block too.

> ref mismatch on [693637414912 16384] extent item 0, found 2
> tree extent[693637414912, 16384] root 10 has no backref item in extent tree
> tree extent[693637414912, 16384] root 2 has no backref item in extent tree
> backpointer mismatch on [693637414912 16384]
> bad metadata [693637414912, 693637431296) crossing stripe boundary
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space tree
> there is no free space entry for 634543001600-634545426432
> cache appears valid but isn't 634260230144

I'm not sure if the free space tree problem is related, but definitely 
not a good thing.

> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p5
> UUID: ca0bd5c5-1e9b-4d7a-9e11-028ee4bfa22a
> found 176460701697 bytes used, error(s) found
> total csum bytes: 330310016
> total tree bytes: 7177601024
> total fs tree bytes: 4736794624
> total extent tree bytes: 2011512832
> btree space waste bytes: 1592634452
> file data blocks allocated: 230763827200
>   referenced 2489957961728
> 
> Notice the problematic 693637414912 showing up again at the the end of btrfs check.
> 
> btrfs --repair did some stuff, but it didn't make the partition unmountable.
> 
> This was my second broken btrfs file system (the first one failed after two months with a "parent transid verify failed" error, but I'm quite inclined to trust the hardware I'm running. Both of these volumes had block-group-tree enabled and were running with discard=async.
> 
> In addition, someone on IRC (also running Arch Linux) told today about a pretty similar issue, but block-group-tree was not involved there.
> 
> I no longer have the volume, but I can try to answer any follow-up questions, and still have the photos and full dmesg output.

Do you still have the initial RO flip kernel messages? That would be 
helpful.

Another thing is, I'd like to have memory tested on that machine.
Normally some obvious bitflip can be caught by tree-checker, but extent 
tree things are much harder to detect (as mostly of them needs cross 
checks).
Thus it may cause some problems.

The bg tree feature usage may be involved and interesting.
Have you ever tried without bg tree?
Bg tree feature only makes a difference for huge filesystem to reduce 
mount time, otherwise not that different.

Thanks,
Qu

> 
> Could this be some data corruption bug introduced around the 6.2 release?
> 
> Thanks,
> Laurentiu
