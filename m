Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4292A4B3434
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Feb 2022 11:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiBLK1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Feb 2022 05:27:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiBLK1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Feb 2022 05:27:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FDB22B15
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Feb 2022 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644661621;
        bh=uoKbXL0qg1gNip7IXCuCzROVjxdtYFNBgoHes2yNHSA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=F48myoMOSEt4df2Ec0Zjxq/mcNueOUoZiGstQO2eQakE4Wi/0malNFf/uP49AG7gx
         M75QP6bY2RlE/mg0RP24Y7UUyOgh5KDmZ1BH+SqaHB3godRFtZQaeauy0aE+/VbOEw
         5TprUTy0OBCYye/+kh7411czytHzpydrHt4jSWD0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1o2doq04ZV-00kbpT; Sat, 12
 Feb 2022 11:27:01 +0100
Message-ID: <59389840-d98e-c7cf-4f38-470c3689475e@gmx.com>
Date:   Sat, 12 Feb 2022 18:26:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs: qgroup: Remove outdated TODO comments
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20220211134829.4790-1-realwakka@gmail.com>
 <402c8a70-7589-4a29-6c1c-28e0b75e0716@gmx.com>
 <20220212101705.GB1181@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220212101705.GB1181@realwakka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UuQOG+L4NOvSdjRwlXu3d+d9Pxiwb7C4lWJ0WFDFHCoiuVmYnbo
 XX650toYREl4/5SD8V3Wrpo6JG734TfvbavoGohHMfs75O+94fsr7GQH+kolo+IiswOglmq
 rOjbwxJ7EubA1WjS5nTEy0N07qAZT1vVyv10RFJO5+IEzK5+S/enxHUkycwFW0fKyjeeFCl
 vjjiwD8ztFP/JJHy8Rr6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zqFSrEHSVbI=:Iw1ntwcuDortFDr+pXFSaN
 Me3kvfBT3nsqnak2kp4bqWKpTXS9FmbWuWbH0JQUsuTzV9/4yn7AjKzeu3OkmjO8eOcFl39uQ
 04/4le85IjivrcuQRVF12I6YEeFJK39xjazuF0bgMqk//h+solBJQD9sUfoxf9WxTbt8k6wGE
 RWTeB9JfQy0KA8Da62PmUslDMasHzh3allYo6CgnmjbsUAuPTvxO+yBUd3xSXmtVRM0haItcj
 5nrgzwOp14pqhPatQ0SD8voiizu17wHo9R3ePB7hUKjPU6iJKkf8FxpNPOH5IljCHeJau8i1F
 gzetYbQd6Qr3GJUzVz4nhU1WFz+7FLc+7KQKRrcihwqoVeOifx7IA4zid5PerWTNsCSUo7CM9
 PYqY4Psb7o+qFuIdvpeTX73Zq2HQMc32QDKYX21FTrfMjB2kgsl+7vxu90zHOLRnLAopINtkK
 bDNKX2JY1nTtDMk+hTPUz0l5KnDwev5xSeGlkaiCbGZgfvLJtw99w7jp8NHusOZe5Oe9JUxtC
 qevpSzu5oMyPFTtbGhMS0njp12sxfzaBTnYodbLIAXi2njaLy6sVSRibkGQUnojR1u5Rv3ssD
 tEwg6Et9+r22cWU1715UWccYGAzgxJz6+1+iL13blyebEQr+WLfprWncI2RIwzFL3HxhdyD41
 mUc+cpuw7OW3BiPR5RG6Q9p/7C6e4JsXQAJpXDsJFEu+a+vHOvc4qP4a0pC7iiaXSATrqbxqU
 geoSkfCGTQoq2stZHUBlLU8IbY8TVHxFvbuZxMPE+LzO4ZfzkgjcoFCP0CttbfyP8KBwLQNvk
 XSu6Z8DFClCDoQcpGOmPERr7/S8VqKxPRYuqHmBJ04TgaZV1GKgMoH9L8r9/CGzzrUeEqVxaI
 8OSGqyZJpWhnredHwMGa8jX0spvIeEI11oMqQuyhDlnnZIJj4+jblR+zMst6WtrskrUhCHQYd
 1RRDTI/R22L61ZBDBMtr9r9CgM1ksTRyNkGsD1FHVxH2WfSQakhshDgeDTk64UcBBmlugjz4T
 fjwYCEFj5eVvruKHn5zKmXLBQWCOUWztBEdTRTipC0yTaP6x2hXQzoUaAtv8/Y6gfo8Ya+3Nq
 TjqDIWgd9evgsI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/12 18:17, Sidong Yang wrote:
> On Sat, Feb 12, 2022 at 08:13:29AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/2/11 21:48, Sidong Yang wrote:
>>> These comments are too old and outdated. It seems that it doesn't help=
.
>>> So we can remove those.
>>>
>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>> ---
>>>    fs/btrfs/qgroup.c | 11 -----------
>>>    1 file changed, 11 deletions(-)
>>>
>>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>>> index bfd45d52b1f5..db527c277901 100644
>>> --- a/fs/btrfs/qgroup.c
>>> +++ b/fs/btrfs/qgroup.c
>>> @@ -25,17 +25,6 @@
>>>    #include "sysfs.h"
>>>    #include "tree-mod-log.h"
>>>
>>> -/* TODO XXX FIXME
>>> - *  - subvol delete -> delete when ref goes to 0? delete limits also?
>>
>> This is still under concern AFAIK.
>>
>> Currently if we delete a subvolume, its qgroup number will changed to 0
>> but not removed.
>
> This issue is in btrfs-progs github issue list (#366). It has detailed
> description in there. So, I think it's okay to delete this.

Oh, we have already migrated to a modern solution.

Then it looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Thanks,
> Sidong
>>
>> Thanks,
>> Qu
>>
>>> - *  - reorganize keys
>>> - *  - compressed
>>> - *  - sync
>>> - *  - limit
>>> - *  - caches for ulists
>>> - *  - performance benchmarks
>>> - *  - check all ioctl parameters
>>> - */
>>> -
>>>    /*
>>>     * Helpers to access qgroup reservation
>>>     *
