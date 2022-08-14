Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09C591E5D
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Aug 2022 07:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiHNFJH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Aug 2022 01:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiHNFJF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Aug 2022 01:09:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B821D0E9
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 22:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660453739;
        bh=hd7E2l9oqoarpognZLCkB1ZgCTBVtjTx0vOMAu/ejBo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GIEucaQtfmBeUlE5no1CBEsOov5I9UYBXkt+DbR1XxMNq9RbmB5RQb/qKQpQs6Vs8
         YMWbqH1L28K3D/e1fQ/QqXarupgEVdmxzq/qsbNuSq+3EiGVBvi4vIc7h0gtfH1hd9
         5LwtUOJdgb4Rpbi0t1vJ33UdeJjzkjDt7ZwOYFnc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbzyP-1nnUfN19xf-00dauE; Sun, 14
 Aug 2022 07:08:58 +0200
Message-ID: <f012291f-19a3-cd25-979c-974d0c35d4eb@gmx.com>
Date:   Sun, 14 Aug 2022 13:08:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Uncorrectable error during multiple scrub (raid5 recovery).
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220814111026.25EF.409509F4@e16-tech.com>
 <a113ec67-18fe-276f-d065-307d2bb292b0@gmx.com>
 <20220814125845.80E1.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220814125845.80E1.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I4AlxD8IkBionL5OGz8vgF3/IZRupqr66ddtE7CrzN9aoB/8YqR
 fNwvGSmRrx0g7iCHsLvainn/LEjw0ble7DRAGqm8pJzgL7gm4vsKlO1Km5kUZ2PROedBezo
 RxU6VG3a9++t7LJOyyQAfTmPYHKvcAhuPeO1L6UYj+pV94fhvZOyhde7Vw0mzh0DYsI288U
 LuEDMq/6NRSuWf6UqGLZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WCjzfnRpcqM=:OjvO3WRom0OQ6IxCzyh0Dw
 fPmJzk+0JRwecTfEDQAvPN08g2+QEs4xfltjLGVFhgr0Z4OneXEss9t29Hhoc9fqN663wGOhl
 3PudVGPgcqYR0LPZdV6CxBj4zyZAb4WuuzR5p2yiR1tDDMAcJP8/t5URpNUi8D3ZWJKFSCwgt
 Sp0vZCNT8NIWGjtTgHYD4ygftdoFNK6Dhk34f4bHpWnC4faE8RbrpwvkSXvDiSnrQyF1mlx08
 cAnx71OC6Xrx2BHaLT6RHOd9Rl/5tz+3ydUekvbswAX5CuPKUS8Nbz/GTLSct6f8dHvHp0w8I
 R2iNTdvgN/Kc7t3b01U7CuwQZiLajwzUJcYe9RnEWj3xNcz409kvDVTUsrnUbRIMaqW4e1wcz
 +G1YwGbe/Q2/DBdzS+0iFmtg38J+6UwrN/+PiWPJojkJGu7ZCpD2AAY94xdKQqa6RZF7l1Lon
 10wspYlGz0m8kFXu2o2VTxAkIEaDN3JHJpGpz+JUkkWG5DNja/FakxQBWUVUhpH7RveLNsHPz
 h/bI1/GRYs2HV6xdOzldDhlDfHfwBmAR38gtLpYbT5kvGPmhwKS8d09TlKQAdMMUgTRAdTQg3
 sKl+knYr2IIUb/XEh7FPJsLMLpb0ImJwK/v0HPjtIbRx2N0MlAgMQykN0TxlwORyizLa6IOT/
 JWyOn/GjOTBFvsdvUYXMlakxdxuOWLOP2YrkVPOpN1v6dl/Us2Z6c26ynISg9CBDEiIWoRXuG
 VIbFrAAi27GkLEsthmTrCEz8hSo9o00H+MeMOyqcldImzusx4LKrVkuamRqzQROXoUX62KQbI
 IXS37i6KzGyKI3MFRONCjJt0h1y/AopKm4h5PInBijcSa5tE41R6P5gO1TMVWFDZWIBGEQb3N
 7250TGDSRRMWkZDEYChp2nyacRCb8+9QUsBKrRk8aQ5L+9vxWFEJMKtigkRs4MuGQOhLi6bI2
 HUq9OHO5/9yWexaEQexnfuYLHwRzdo8Kim6wNE4y637wgh9D5ScUvsDM2xO3x4haPo1O7U4PX
 dakRFOvJH+VRPSU66ew9fcZUaKYPmFuPPxrl7RKw01GPEpjLwRMmCEzVznRGWOm4t+MZXvZ71
 5igqrpmbxOes3YRzhWyDInzjsMj0eaMRYDAk2bJPt9O7q+3j2XTsFgRAA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/14 12:58, Wang Yugui wrote:
> Hi,
>
>> On 2022/8/14 11:10, Wang Yugui wrote:
>>> Hi,
>>>
>>> Uncorrectable error during multiple scrub (raid5 recovery).
>>>
>>> This reproducer is based on some reproducer [1],
>>> but it seems a new problem, so I open a new thread.
>>>
>>> reproducer:
>>>
>>> mkfs.btrfs -f -draid5 -mraid1 ${SCRATCH_DEV_POOL}
>>> SCRATCH_DEV_ARRAY=3D($SCRATCH_DEV_POOL)
>>> mount ${SCRATCH_DEV_ARRAY[0]} $SCRATCH_MNT # -o compress=3Dzstd,noatim=
e
>>
>> Please remove unnecessary comments if it's not explaining anything.
>>
>> It just makes the test case much harder to read.
>>>
>>> /bin/cp -a /usr/bin $SCRATCH_MNT/
>>> #(OK)dd if=3D/dev/urandom bs=3D1M count=3D1K of=3D$SCRATCH_MNT/1G.img
>>> du -sh $SCRATCH_MNT
>>>
>>> for((i=3D1;i<=3D15;++i)); do
>>>
>>> 	#(OK)umount $SCRATCH_MNT; mount ${SCRATCH_DEV_ARRAY[0]} $SCRATCH_MNT =
# -o compress=3Dzstd,noatime
>>> 	sync; sleep 5; sync; sleep 5; sync; sleep 25;
>>
>> If you really want to provide a reproducer, either explain why this is
>> needed or it will just waste time of everyone who is trying this test.
>>
>>>
>>> 	# change the device to discard in every loop
>>> 	j=3D$(( i % ${#SCRATCH_DEV_ARRAY[@]} ))
>>> 	/usr/sbin/blkdiscard -f ${SCRATCH_DEV_ARRAY[$j]} # --offset 2M
>>>
>>> 	btrfs scrub start -Bd $SCRATCH_MNT | grep 'summary\|Uncorrectable'
>>>
>>> done
>>>
>>> This problem will not happen if we change the test data to simpler one=
.
>>> # about 220M data of '/usr/bin' to single 1G file
>>>
>>> This problem will not happen if we clear cache with 'umount; mount'
>>> between multiple loop.
>>> # 'sync; sleep 5; ...' to  'umount; mount'
>>>
>>> so it seems that some info in memory is wrong after RAID5 recovery?
>>>
>>> [1]
>>> Subject: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:23=
50!
>>> during raid5 recovery
>>> https://lore.kernel.org/linux-btrfs/9dfb0b60-9178-7bbe-6ba1-10d056a7e8=
4c@gmx.com/T/#t
>>
>> That case is in fact not related to RAID56, and we already have the fix
>> for it:
>> https://lore.kernel.org/linux-btrfs/1d9b69af6ce0a79e54fbaafcc65ead8f71b=
54b60.1660377678.git.wqu@suse.com/
>
> This problem still happen on  linux 5.20(20220812) with the flowing patc=
hes.

Then please provide a human readable reproducer.

The current one is not really clear which part is commented out.

>
> Subject: btrfs: scrub: properly report super block errors in system log
> Subject: btrfs: scrub: try to fix super block errors
> (v2)Subject: btrfs: don't merge pages into bio if their page offset is n=
ot
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/08/14
>
>
