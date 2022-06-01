Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1D553AD12
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 20:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiFASwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFASwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 14:52:25 -0400
X-Greylist: delayed 163 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 11:52:21 PDT
Received: from a4-3.smtp-out.eu-west-1.amazonses.com (a4-3.smtp-out.eu-west-1.amazonses.com [54.240.4.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0A313B2E7
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1654109376;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=dh4caCw22FkVYO0L2fuHX1G7GeySHKtdYAvZoYkZYqc=;
        b=fddLPWIsfJrcJAo9oR1Zsnk8pSvUN7lYlj96/3NEPlZCfSAJSdXsKGLIugYKCM0i
        sDuZRVLILlXLwIW6LCA8nVqJiS0yvkuL6gE2u0SwoLlEyigaxQ6H8ZWguemsGIwtuNK
        GpGHrlrig924APQhu8Bp+dOaJL0BgBz6O8SxOZyE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1654109376;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=dh4caCw22FkVYO0L2fuHX1G7GeySHKtdYAvZoYkZYqc=;
        b=kqcdQDv8+Otj1pOfnjzjtEp4hN3gDDgtAGT94hY0nD5wyMc7p7RSfcqpyOdjSRUy
        w8Tvr6jPhryebFEsF7N2m/ZJjYK+opHD/kbOnwYjZa9U0wLd4r21UVmOkAuZI8cBD+Z
        t78ApOttedNDfAkehsuk8WWWCporFcwbW60tPvh4=
Message-ID: <01020181209a0f8e-b97fa255-3146-4ced-b9c9-a6627a21d6e1-000000@eu-west-1.amazonses.com>
Date:   Wed, 1 Jun 2022 18:49:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Martin Raiber <martin@urbackup.org>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Paul Jones <paul@pauljones.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
 <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
 <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <6cbc718d-4afb-87e7-6f01-a1d06a74ab9e@gmx.com>
In-Reply-To: <6cbc718d-4afb-87e7-6f01-a1d06a74ab9e@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2022.06.01-54.240.4.3
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01.06.2022 12:12 Qu Wenruo wrote:
>
>
> On 2022/6/1 17:56, Paul Jones wrote:
>>
>>> -----Original Message-----
>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> Sent: Wednesday, 1 June 2022 7:27 PM
>>> To: Wang Yugui <wangyugui@e16-tech.com>
>>> Cc: linux-btrfs@vger.kernel.org
>>> Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
>>>
>>>
>>
>>>>>> If we save journal on every RAID56 HDD, it will always be very slow,
>>>>>> because journal data is in a different place than normal data, so
>>>>>> HDD seek is always happen?
>>>>>>
>>>>>> If we save journal on a device just like 'mke2fs -O journal_dev' or
>>>>>> 'mkfs.xfs -l logdev', then this device just works like NVDIMM?  We
>>>>>> may not need
>>>>>> RAID56/RAID1 for journal data.
>>>>>
>>>>> That device is the single point of failure. You lost that device,
>>>>> write hole come again.
>>>>
>>>> The HW RAID card have 'single point of failure'  too, such as the
>>>> NVDIMM inside HW RAID card.
>>>>
>>>> but  power-lost frequency > hdd failure frequency  > NVDIMM/ssd
>>>> failure frequency
>>>
>>> It's a completely different level.
>>>
>>> For btrfs RAID, we have no special treat for any disk.
>>> And our RAID is focusing on ensuring device tolerance.
>>>
>>> In your RAID card case, indeed the failure rate of the card is much lower.
>>> In journal device case, how do you ensure it's still true that the journal device
>>> missing possibility is way lower than all the other devices?
>>>
>>> So this doesn't make sense, unless you introduce the journal to something
>>> definitely not a regular disk.
>>>
>>> I don't believe this benefit most users.
>>> Just consider how many regular people use dedicated journal device for
>>> XFS/EXT4 upon md/dm RAID56.
>>
>> A good solid state drive should be far less error prone than spinning drives, so would be a good candidate. Not perfect, but better.
>>
>> As an end user I think focusing on stability and recovery tools is a better use of time than fixing the write hole, as I wouldn't even consider using Raid56 in it's current state. The write hole problem can be alleviated by a UPS and not using Raid56 for a busy write load. It's still good to brainstorm the issue though, as it will need solving eventually.
>
> In fact, since write hole is only a problem for power loss (and explicit
> degraded write), another solution is, only record if the fs is
> gracefully closed.
>
> If the fs is not gracefully closed (by a bit in superblock), then we
> just trigger a full scrub on all existing RAID56 block groups.
>
> This should solve the problem, with the extra cost of slow scrub for
> each unclean shutdown.
>
> To be extra safe, during that scrub run, we really want user to wait for
> the scrub to finish.
>
> But on the other hand, I totally understand user won't be happy to wait
> for 10+ hours just due to a unclean shutdown...
Would it be possible to put the stripe offsets/numbers into a journal/commit them before write? Then, during mount you could scrub only those after an unclean shutdown.
>
> Thanks,
> Qu
>
>>
>> Paul.


