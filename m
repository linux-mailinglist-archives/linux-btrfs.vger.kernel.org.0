Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D623D758CFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 07:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjGSFWP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 01:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGSFWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 01:22:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22021D2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 22:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689744129; x=1690348929; i=quwenruo.btrfs@gmx.com;
 bh=jvbyJBO23fn9k57BeplYmn9R469kz+bahRYUIfCuvw0=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=djJWaPAV3w2/K+98dTqupC74Zq4GdKUp4yRgdZQy/SlZmrXt8ZS3aATsHuE4xMDzxhO74+X
 qxAPqSzprho5K5NZomzCnDqQzasvUesuPnlbzDrnAfL/kfTt3w/g62TLHx/hiPXC+sLxdEDpu
 uEuTyxtLSgeNFOn0VGtSdbvRIxAQ77+UGTckorBycoTmzHHvjAsWoo5qe55ia71DW7LCSs0T+
 7L69sY73Qpo0sbalxO6TybolCuGP0w8Wowy1h3cuJuB/oZeBAfFyjk5FR8amfHt9BtlblcIp7
 /DO8+87KorYsxXR/rKBC7F7gYOdRb0m8i5ej+LoaBDpP6sosf1Dg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wKq-1qN6dQ09j2-003MNW; Wed, 19
 Jul 2023 07:22:08 +0200
Message-ID: <4f48e79c-93f7-b473-648d-4c995070c8ac@gmx.com>
Date:   Wed, 19 Jul 2023 13:22:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
 <20230718005924.GN20457@twin.jikos.cz>
 <6c9a9e34-365a-3392-0289-a911b34a9e4d@gmx.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: scrub: speed up on NVME devices
In-Reply-To: <6c9a9e34-365a-3392-0289-a911b34a9e4d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zmv3UGDdLDFUdTokX6TgpCQGH52dpvxfGAnvB5UEcXXL6C9iDj4
 5D4b4dVeDWCcXjPBV1s0eAIFr7FRxDHVAP/6Z/Qo3qUU3TLiUTKW++K3ECyqqQ3nFrz2hU9
 VyWTsdMK3FxF5vn6CMl2oJ0jxfeU29Ly+aJnHJQet6dRUmJkMluco66KCD67Z+jUxPyuWt2
 Z2is77R68ydUmrfkUaJFA==
UI-OutboundReport: notjunk:1;M01:P0:aqlJbRgDg+w=;+I6Alp2OzYTCLh7r383aCpKRWlW
 mRf6+YMgomBPoV6m3QxcdozGskx8pzW0KVmNWMPscdj4fLWyaKDKvCp8/K91vLwsvey9rkQE7
 n7QN1W64P2vrmFx18b8Ye5tlH125xuzx1DTF8qQHZBMYS1GWvRqC8DihKjFBFNvg1nRFB44DW
 Vtnu8zV9fL9b8YLvNQxZ/sA1dZB8vMXN2i/r3aDYd2VcF9gsMXbGwbTX068dbZ0HbP/QvT3EJ
 CDGvHYA1SsX1cyLbySKSFMKaMb1FvCdSryh90TeNxLDglvFS0qhTM0q+f1bJRhYIt1q8UxUuW
 RHm1z/UY0EyFLn4dTZckk/zkLDYMfZpQ7epfKPc2zP5BpAVaWiSxjcrYhxNNXL+KAzHRMNzKe
 1Nkq8jfsJXUS45UVrUbHaetJLigv25G7pmiemA+SUICP6fVbuDn+qlUvfqQ2lULfT8O7Yyt68
 2otVEezCeGiLH5N7FPxkbUnbJFDTezmGzDejRoa5msO7P6O9XcRBMXoPQY61EQpvr2THSoW5K
 +73RyRGEIvHzNj3Afw4CqLbgm+LJJXLNK3fF75hGUGRWvYy+LNiiuJfMTrPsmpziAEDk+KbLj
 ZyN4gRPkqpBbxfHRhwSAVl1DZqfMwSVGEEgG5JqqCPKaZmK42hkSwjycFxPPyrYkZ6nTtktpE
 pxLidr/X/76yLsvH2VocmBB6xNDrLkf3ElfqrXTAO1/ad3+plnaYDyqRFfMCs1WBvRMcaybbM
 XtRL9/BfqM4hmcwdTVtvGiI+DKQVMBhw1FSa8O3Cq0tmj4i48a8se/dOmyzadmN2BLwTgvgey
 3DRMKNjLyvS5YMT0lTjU2g+dqgwpnHyZpWrCAAt3aBeqz59Tt4PVtBvUMDNFOMlmVJmBDisw2
 CmHf8coeIiL8co9aN1TP44ZjanArjjXESZhy6XvDPEEsEx8HNqcFfTCZk0wCjMomBjpmroSPp
 zKwwHMZC4Wj4SiQ6j3ZYfaq68r4=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/18 09:41, Qu Wenruo wrote:
>
>
> On 2023/7/18 08:59, David Sterba wrote:
>> On Fri, Jul 14, 2023 at 06:26:40PM +0800, Qu Wenruo wrote:
>>> [REGRESSION]
>>> There are several regression reports about the scrub performance with
>>> v6.4 kernel.
>>>
>>> On a PCIE3.0 device, the old v6.3 kernel can go 3GB/s scrub speed, but
>>> v6.4 can only go 1GB/s, an obvious 66% performance drop.
>>>
>>> [CAUSE]
>>> Iostat shows a very different behavior between v6.3 and v6.4 kernel:
>>>
>>> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r/s=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rkB/s=C2=A0=C2=A0 rrqm/s=C2=A0 %rrqm r_await rareq-sz
>>> aqu-sz=C2=A0 %util
>>> nvme0n1p3=C2=A0 9731.00 3425544.00 17237.00=C2=A0 63.92=C2=A0=C2=A0=C2=
=A0 2.18=C2=A0=C2=A0 352.02=C2=A0 21.18
>>> 100.00
>>> nvme0n1p3 20853.00 1330288.00=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=
 0.00=C2=A0=C2=A0=C2=A0 0.08=C2=A0=C2=A0=C2=A0 63.79=C2=A0=C2=A0 1.60
>>> 100.00
>>>
>>> The upper one is v6.3 while the lower one is v6.4.
>>>
>>> There are several obvious differences:
>>>
>>> - Very few read merges
>>> =C2=A0=C2=A0 This turns out to be a behavior change that we no longer =
go bio
>>> =C2=A0=C2=A0 plug/unplug.
>>>
>>> - Very low aqu-sz
>>> =C2=A0=C2=A0 This is due to the submit-and-wait behavior of flush_scru=
b_stripes().
>>>
>>> Both behavior is not that obvious on SATA SSDs, as SATA SSDs has NCQ t=
o
>>> merge the reads, while SATA SSDs can not handle high queue depth well
>>> either.
>>>
>>> [FIX]
>>> For now this patch focus on the read speed fix. Dev-replace replace
>>> speed needs extra work.
>>>
>>> For the read part, we go two directions to fix the problems:
>>>
>>> - Re-introduce blk plug/unplug to merge read requests
>>> =C2=A0=C2=A0 This is pretty simple, and the behavior is pretty easy to=
 observe.
>>>
>>> =C2=A0=C2=A0 This would enlarge the average read request size to 512K.
>>>
>>> - Introduce multi-group reads and no longer waits for each group
>>> =C2=A0=C2=A0 Instead of the old behavior, which submit 8 stripes and w=
ait for
>>> =C2=A0=C2=A0 them, here we would enlarge the total stripes to 16 * 8.
>>> =C2=A0=C2=A0 Which is 8M per device, the same limits as the old scrub =
flying
>>> =C2=A0=C2=A0 bios size limit.
>>>
>>> =C2=A0=C2=A0 Now every time we fill a group (8 stripes), we submit the=
m and
>>> =C2=A0=C2=A0 continue to next stripes.
>>
>> Have you tried other values for the stripe count if this makes any
>> difference? Getting back to the previous value (8M) is closer to the
>> amount of data sent at once but the code around has chnaged, so it's
>> possible that increasing that could also improve it (or not).
>
> I tried smaller ones, like grounp number 8 (4M), with the plugging added
> back, it's not that good, around 1.6GB/s ~ 1.7GB/s.
> And larger number 32 (16M) doesn't increase much over the 16 (8M) value.
>
> The bottleneck on the queue depth seems to be the wait.
>
> Especially for zoned write back, we need to ensure the write into
> dev-replace target device ordered.
>
> This patch choose to wait for all existing stripes to finish their read,
> then submit all the writes, to ensure the write sequence.
>
> But this is still a read-and-wait behavior, thus leads to the low queue
> depth.

I tried making sctx->stripes[] a ring buffer, so that we would only wait
the current slot if it's still under scrub, no more dedicated waits at
the last slot.

The branch can be found at my github repo:
https://github.com/adam900710/linux/tree/scrub_testing


But unfortunately this brings no change to scrub performance at all, and
the average queue depth is still pretty shallow (slightly better, can
reach 1.8~2.0).

If needed, I can send out the patchset (still pretty small, +249/-246)
for review, but I don't think it worthy as no improvement at all...

For now, I'm afraid the latency introduced by plug is already enough to
reduce the throughput, thus we have to go back the original behavior, to
manually merge the read requests, other than rely on block layer plug...

Thanks,
Qu
