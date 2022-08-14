Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9953591E23
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Aug 2022 06:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiHNEqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Aug 2022 00:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiHNEqt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Aug 2022 00:46:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5B5186FD
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660452400;
        bh=0+WQWjWSpaN2Vaw2H1JWImjfzz5m/yXYolO+/BDt6kw=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=VAneZ8/+Gn96diBi7Z5r0u8lL83YmGDcdOSh5TcQBYZqmeowa3M+7WFbo+qvAh6cA
         spcE/ZBq6NUMOBNwKFDoxi+74AbedZ58upYcvYbE4qzrC6Tu83LOfw4SkZIuJ4Dizw
         hbRLeibgSYgPdLNivTL1oNZD9LVvqA5lE7rfepvg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybGX-1nR6iQ0w85-00z1BN; Sun, 14
 Aug 2022 06:46:40 +0200
Message-ID: <a113ec67-18fe-276f-d065-307d2bb292b0@gmx.com>
Date:   Sun, 14 Aug 2022 12:46:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220814111026.25EF.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Uncorrectable error during multiple scrub (raid5 recovery).
In-Reply-To: <20220814111026.25EF.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wpo2QzP/jz9iJAB3YDjxjJCH2fN0Rp6vJwj0Jno0zpflFLxQcDt
 dIQV/5V4NfHeVJDmOjnpNazmdF4F7wkfi6QAis34FRlcN+86E+Ps6s1YF6mYpy2DTTCpn1U
 2DbYT6bnzlPK3mrHCZbFmDjSr+tepD75u5oetHeOfGWjEhR8T6B2f9aq7/nuEaWJf/aCWfp
 MG0nmbiwsezGMLhDVvEsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sus5hDvwlwk=:rzVY6iPZzrxaRx09s/joRW
 TZZJPUMZXzlZnearFQwBPgg/qZsSs2x1DbS5JMQgeVXH4YlumdO2cv6GnT5lWNn51Lq/ElDJr
 AJupopZyXZd7LXySln9xoS4ASZPRdR8oXOLQ3dzylF9kK0xDclakTH4BrWdgur9s8nIc+764J
 s6b1KpzR6IMOz9qZ01SoAabETdYq3e2wkzWkabJuHcH3r6U0X9mOcc6FIJ4BdWsH1qhkPYW2q
 O4R7bA4U83NGy2zvdCHfc3dFP8Bv1vGNzKEgH0Ao2sFSSYLdOgE8sSmGM9xBatEeYdhrgAy3w
 IEqnyHEwlnTCE/0dQNfhScdll2uyaKiSZJJ8tUOrAi/t65Dkk0Blcr1gf8O/oxNf20AagG9bS
 m+PY91EhUgCVUhKldwUe67VJmKCiAt4x1KA6ao4WgrAKfvHG3BgKePoeTr8qws5Fmvxtd9WsG
 5BchawfS+6dY/Ar5SZCQGupqZhWulbzKZFGWqMxk5I2GWxRnAV4rPS5tZMjgXTCmy5UKpIQzm
 AwPHSuvGLi5K9J6esJ8KAjmZ+OyKmdpktbEXm5A6M8/ohLFoWFDtJifXR0nCSgEqtZ5RZcaFe
 F1CkSVTtKCW9MOp7YKrHnJ+9QlIRm3VthNYOZilOFaGZ9JQL5lJ4mvKecw0xBLE/FA2yvD7dj
 3Vc+BvHFGXuQhzNm1hP6mseMaXzlCdDpo+q2rFg7D6xBr7kBOD+eGdfYqc2s+9/p1LHUBw50G
 zz4o+J0vnGtUWOM/o5GkIi6VK5sYRGie7yr6Cid7mNjle0obQc4HCnWSWEKWyx6HseK0NL0l8
 KsK1DIS+ulRP8eFeAIoTA9cNgltJvq0hXh4727mAyRWj7QQnAvRvqNPZe3L8s8mAmwFIJzI38
 atgGKNcgkuu8sLow+EH5fxyRni29XR35P1ccf8gO+XeZm6Dp3v2i1sbnYGo+J4K3NcHCEAftP
 LzSr+1ioRMwyFGyr5qyAjN0+M129ivX8gmUxmP6Dx0i/IOryNJhc1FeBJeCdF2K8iTCUhkJK8
 2jKHjgZB0Kcw8wU/IY4lENvtdmhWiirNaPgXZt/TZVC/KRcSLAuAp5ubWcxnnYTtPyPzDBQfw
 wIaFMKALdp9OXMreDTNKG0A3QIXGaGn3r1W4HwCWDY/Lu2GXjBNrWNSGg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/14 11:10, Wang Yugui wrote:
> Hi,
>
> Uncorrectable error during multiple scrub (raid5 recovery).
>
> This reproducer is based on some reproducer [1],
> but it seems a new problem, so I open a new thread.
>
> reproducer:
>
> mkfs.btrfs -f -draid5 -mraid1 ${SCRATCH_DEV_POOL}
> SCRATCH_DEV_ARRAY=3D($SCRATCH_DEV_POOL)
> mount ${SCRATCH_DEV_ARRAY[0]} $SCRATCH_MNT # -o compress=3Dzstd,noatime

Please remove unnecessary comments if it's not explaining anything.

It just makes the test case much harder to read.
>
> /bin/cp -a /usr/bin $SCRATCH_MNT/
> #(OK)dd if=3D/dev/urandom bs=3D1M count=3D1K of=3D$SCRATCH_MNT/1G.img
> du -sh $SCRATCH_MNT
>
> for((i=3D1;i<=3D15;++i)); do
>
> 	#(OK)umount $SCRATCH_MNT; mount ${SCRATCH_DEV_ARRAY[0]} $SCRATCH_MNT # =
-o compress=3Dzstd,noatime
> 	sync; sleep 5; sync; sleep 5; sync; sleep 25;

If you really want to provide a reproducer, either explain why this is
needed or it will just waste time of everyone who is trying this test.

>
> 	# change the device to discard in every loop
> 	j=3D$(( i % ${#SCRATCH_DEV_ARRAY[@]} ))
> 	/usr/sbin/blkdiscard -f ${SCRATCH_DEV_ARRAY[$j]} # --offset 2M
>
> 	btrfs scrub start -Bd $SCRATCH_MNT | grep 'summary\|Uncorrectable'
>
> done
>
> This problem will not happen if we change the test data to simpler one.
> # about 220M data of '/usr/bin' to single 1G file
>
> This problem will not happen if we clear cache with 'umount; mount'
> between multiple loop.
> # 'sync; sleep 5; ...' to  'umount; mount'
>
> so it seems that some info in memory is wrong after RAID5 recovery?
>
> [1]
> Subject: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350=
!
> during raid5 recovery
> https://lore.kernel.org/linux-btrfs/9dfb0b60-9178-7bbe-6ba1-10d056a7e84c=
@gmx.com/T/#t

That case is in fact not related to RAID56, and we already have the fix
for it:
https://lore.kernel.org/linux-btrfs/1d9b69af6ce0a79e54fbaafcc65ead8f71b54b=
60.1660377678.git.wqu@suse.com/

Thanks,
Qu

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/08/14
>
>
