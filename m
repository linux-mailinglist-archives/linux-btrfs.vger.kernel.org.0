Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938B1534C5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 11:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiEZJNm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiEZJNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 05:13:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE2C6E4F
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653556413;
        bh=mMV4tqqRuUMyU5hb3tWDrrS4d8sdUDjdNlcTx1xLCgc=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=HapAVJ9L/qGYeWUWmW1Ze6bvIYE+SrzSNg9Mqn3cfMaYUyqVlVHCNaafEIykrRoS1
         xg5IlzbIzmxA/vor6emMfblnQnWQ0X4aFbdPaNSDrMZ0ropjM5uE/YDjsSKRE/6QiJ
         jpUY+zad5iUvzBHXodTD6/bATb1Yckkxvj1GRpRI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3DM-1o5DEK3WO0-00FTsd; Thu, 26
 May 2022 11:13:33 +0200
Message-ID: <13499702-2a49-4e4d-25fc-cd2910f503a0@gmx.com>
Date:   Thu, 26 May 2022 17:13:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220526073022.GA25511@lst.de>
 <bf92f4ee-811e-35c0-823d-9201f1bceb0e@gmx.com>
 <20220526074536.GA25911@lst.de>
 <aa251ce8-e97d-8b38-b9f5-421b95fa79a0@suse.com>
 <20220526080056.GA26064@lst.de>
 <0cbbc3aa-a104-3d5e-ad13-a585533c9bcb@suse.com>
 <20220526081757.GA26392@lst.de>
 <78c1fb7f-60b7-b8fd-6e3c-c207122863aa@gmx.com>
 <20220526082851.GA26556@lst.de>
 <f18c85ef-ff11-8308-4562-d68d4578d6f4@gmx.com>
 <20220526085402.GA26954@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
In-Reply-To: <20220526085402.GA26954@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:66C48akk/CvhbrAdoJDZSrT97yYNXTCnd7VCUrNdVxMvapJaBcY
 O9Gxllmw1y2Z/YYDogZGd0VXAWN1O9GEbRfCNasnAG++9N4poXmSeR1gpabjuo2kRizXWWS
 3xuDU1TEHAwTXW/Z8xuR5v9smoJAbZAVLIrRqMhiENnaA+cr3kY7qT1zBM7TTCpeoEcqY/l
 cISwrFe9GuDMnL7TwIBFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O2Tny5/WXxA=:whOnurVDf5Dp4E4ZV1/oo4
 DUzhYb1zKc63LMsu8LX36JkE42wqEqh+H4x6Ca4wkTfCq7PytyAzb8T+8TgCH1ymb+oyUounH
 we+cwrDSSx663HdwHMLXtajvsXOurxPH2H80ZnB0ZKI2f8lads0bTXLwojgtIHx06mmdlRlj9
 MmGzq2gOkaMNrQX67ubNmZj7Qajrdo/c+mhZtwHjelW8bHPrYdkyA/o5mGkQvbqMl4PKIFcOk
 qoTsxIq+qc8lvzqczIGl8uiWdgLXuzYywF0wV2qSRtfpA/oCFx2FyXVb5Ylp5tFIqM56aBuS4
 uv5qhlST0+TGyrizAQyNWqfz5nkzqd0WOWMKpRVTZeLjZ4++OXkwqND/JEs5SuoMLl5BiQpUg
 mH3WYf4ypHrXXauqq6FVHzJnI5Zq3u6PLm2OjiQQ2T5nkW+xzbFxbs652YPnXPzMVguO/N+h0
 Kn5LSVgUXtQ9WgbwYl7YXWS5ohf+exzwpSL1i08IFx+LhZyrH9EJxKbmzd3wPP/uA3EkaGRnv
 ulT6vx8FSw9lUxfHIVvP8ZaEGezaOVMATrpVBs7u1DWN+O/IJYg6DzIcdwND/qxlLGtzHTHXr
 7ijTP9MAlVU/TGWyn7iRqOwjOOv3I1Aky4yXudG1jkfhZWoa85QX97sa7emZbwPYwkzuHg+8b
 XQfviwVA+CrCzKwJbTz3G6Zu2Fx5GFEHAZmhs+2uQECfVK5E4nHq0+U+9X75bJ+hFQwNetlwm
 MWfBLW1Kz0QpRanVwUlDZerW1HGKiFzIJxIdLYDbei3J0a15yVxuXabfEfh+wz1IELqn/cS7G
 3ixq8/bYPGkiy3/8hfggA4JbLymOY3KP3SD+c4t/KNv0euNq4Raam0Pwo8zbYMORNUDxX7sj/
 P3KFrLPlQ5NTsl+q1ViMoEizOfIsLQTYg5UDvHy26FinWrLWXh++vKNXLFszqAe70WeIttQ5N
 eGjAA+hdaFzCpXDmVlSIFUmca2EmjjGPVOdyL19TFJHlCP5ZIdPGw0fDVpKWXqa+ZVHiJmvq1
 7HGyXIDaHl9qK2ujMI81GoolWZMiJglGGMrpUUQeE9TqQsH1xTGUwY05KGVMz9grxMj5K+vUr
 BljcEvn2+N0/xZKeKKW7PS6S7cxXFQpXQZFhPxaHCm8opwOZ/CT1B6Lew==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/26 16:54, Christoph Hellwig wrote:
> On Thu, May 26, 2022 at 04:49:15PM +0800, Qu Wenruo wrote:
>>>>> Because that really sucks for the case where the whole I/O fails.
>>>>> Which is the common failure scenario.
>>>>
>>>> But it's just a performance problem, which is not that critical.
>>>
>>> I'm officially lost now.
>>
>> Why? If you care so much about the code simplicity, sector-by-sector is
>> the best.
>> If you care so much about the performance, the latest bitmap is the
>> best, no matter if it's the worst checker patter or not.
>
> Because you tell me that handling the most common and important case
> in read repair is just a performance issue, which you keep arguing for
> micro-optimizing a corner case.

Because I'm fine either way, but not fine with the middle ground.

I purposed both versions, to fulfill the different requirements.
The tradeoff is not avoidable, we have to choose the poison.

If we want to go code simplicity, then my argument to support
sector-by-sector is, the repair is already a cold path (the same
argument you go on the checker pattern), thus overall the performance
drop is not that critical.

If we want to go the best perf (even corruption is already a corner
case), then there is the bitmap version, handling all cases, at the cost
of complex code.

If you can find a simpler version, and still handle the checker pattern
sanely (aka, without reading the same bad mirror again and again), sure,
I'm always fine to go that version.

Otherwise sector-by-sector or bitmap seems a more sane choice to do betwee=
n.

Thanks,
Qu

>  And not, for the case of failing a
> large bio (which arguably can only happen for buffered I/O at the
> moment, but that is another thing to look into) the bitmaps will only
> help you for up to 64 sectors.  Way better than just doing a single
> sector synchronous I/O but not exactly nice while still being a fair
> amount of code compared to just doing variable sized synchronous
> I/O.
