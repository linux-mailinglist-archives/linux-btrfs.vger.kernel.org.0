Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2497DFD61
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 00:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjKBX5q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 19:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKBX5p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 19:57:45 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E95134
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202212; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rUvnavA5vx61zNidyVW4mr8DKlzgupAQJDogcKjmWhY=; b=CG3GlxN6/XCBV9v9vi0LCK+ZUz
        cYJaeOfhNYCv91zuJZ1ZWIaaG9p5sz/7aeE9wscaYIanpji4BaAL8gb1DbuhouwROvvUitUhaADmc
        Puqc1+W0oia/bLSenQzHxpZ9DRb3UKtxfJovaxie+6+zOnfqLBrPC5zh1r0pJUrk/pvahNPTCQuHX
        hDtX3TXS/ovl0pZzBwHHastB4OI20CimscnvGYBCzfeYkx8yBGz+oDVcERUOy88G2yY+RBCXeZiPg
        YBiz7RCYYl79wBACTjfF9FnvSJsVtwggGMhJPAJ54CVEpLaIuSp7d56RwDgap15MZ5XSIhbzvyRw8
        J4B8XpoQ==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:34141 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1qyhZB-00Aer4-5L;
        Fri, 03 Nov 2023 00:57:37 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Balance on 5-disk RAID1 put all data on 2 disks, leaving the rest
 empty
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Paul Jones <paul@pauljones.id.au>
Cc:     Pedro Macedo <pmacedo@pmacedo.com>,
        Anand Jain <anand.jain@oracle.com>,
        Roman Mamedov <rm@romanrm.net>,
        Remi Gauvin <remi@georgianit.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <erRZVkhSqirieFSNm0d1BF5BemFMyUSCjGKT73prpKS7KDydKhqAvNqA7Eham7bQXmmh0CCx0rep6EAKKi_0itDlOf94KZ1zRRZfip_My4M=@protonmail.com>
 <16acffd1-9704-9681-c2d4-4f5b8280ade0@georgianit.com>
 <20231026021551.55802873@nvm>
 <de06dca2-9611-4fde-a884-0f4789f7b48c@oracle.com>
 <21245ede-7ef3-40ad-828f-91f6845e9273@pmacedo.com>
 <ZUMFvRDAragUzhlY@hungrycats.org>
 <SYCPR01MB4685B23E1FA74D65A3859BDE9EA6A@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <ZUOpHtII/SQZt1w7@hungrycats.org>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <c67331b6-9eb5-4bcb-11bc-fab5b1199cf6@dirtcellar.net>
Date:   Fri, 3 Nov 2023 00:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.17.1
MIME-Version: 1.0
In-Reply-To: <ZUOpHtII/SQZt1w7@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo Blaxell wrote:
> On Thu, Nov 02, 2023 at 05:11:00AM +0000, Paul Jones wrote:
>>> -----Original Message-----
>>> From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
>>> Sent: Thursday, November 2, 2023 1:13 PM
>>> To: Pedro Macedo <pmacedo@pmacedo.com>
>>> Cc: Anand Jain <anand.jain@oracle.com>; Roman Mamedov
>>> <rm@romanrm.net>; Remi Gauvin <remi@georgianit.com>; linux-
>>> btrfs@vger.kernel.org
>>> Subject: Re: Balance on 5-disk RAID1 put all data on 2 disks, leaving the rest
>>> empty
>>>
>>> On Wed, Nov 01, 2023 at 08:20:56PM +0100, Pedro Macedo wrote:
>>>>
>>>> On 27.10.23 06:21, Anand Jain wrote:
>>>>> On 10/26/23 05:15, Roman Mamedov wrote:
>>>>>> On Wed, 25 Oct 2023 17:08:08 -0400 Remi Gauvin
>>>>>> <remi@georgianit.com> wrote:
>>>>>>
>>>>>>> On 2023-10-25 4:29 p.m., Peter Wedder wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> I had a RAID1 array on top of 4x4TB drives. Recently I removed
>>>>>>>> one 4TB drive and added two 16TB drives to it. After running a
>>>>>>>> full, unfiltered balance on the array, I am left in a
>>>>>>>> situation where all the 4TB drives are completely empty, and
>>>>>>>> all the data and metadata is on the 16TB drives.
>>>>>>>> Is this normal? I was expecting to have at least some data on
>>>>>>>> the smaller drives.
>>>>>>>>
>>>>>>>
>>>>>>> Yes, this is normal.  The BTRFS allocates space in drives with
>>>>>>> the the most available free space.  The idea is to balance the
>>> 'unallocated'
>>>>>>> space on each drive, so they can be filled evenly.  The 4TB
>>>>>>> drives will be used when the 16TB dives have less than 4TB
>>> unallocated.
>>>>>>
>>>>>
>>>>> Correct. That's the only allocation method we have at the moment. Do
>>>>> you have any feedback on whether there are any other allocation
>>>>> methods that make sense?
>>>>
>>>>
>>>> IMHO, based on the frequency of this question appearing here/on
>>>> reddit/other sites, perhaps allocation by absolute space used?  It
>>>> should fit the expectations of most folks that if you have free space
>>>> on a disk it will be utilised, plus has potential performance
>>>> implications by always using as many devices as possible to write to as long
>>> as they have any space left.
>>>
>>> That is how allocation works with striped profiles:  chunks are allocated using
>>> space from all non-full drives, in order to use space and iops optimally.
>>>
>>> For a non-striped profile like raid1, it's not possible to use all the space
>>> without filling the larger devices first.  As the large devices fill up, their free
>>> space becomes equal in size to the smaller devices, and it's always possible to
>>> completely fill a raid1 array of equal-sized devices.  If raid1 distributed data
>>> across the small devices at the same time as the large devices, it would run
>>> out of space on small devices before running out of space on the large ones,
>>> so significant space on some devices would be wasted.
>>
>> I was always under the impression that space was allocated from the
>> emptiest drive(s) on a percentage basis. Was that ever the case and
>> has since changed? That seems like the most optimal way to do it.
> 
> The current behavior was introduced in 2011, and hasn't changed since
> except for regressions in 2015, 2022, and 2023 (now fixed).  Support for
> zoned devices was added in 2020, but it doesn't affect regular device
> behavior.
> 
> btrfs finds the largest contiguous free space block >= 1 GiB on each
> device (using the lowest offset to break ties), then creates a chunk
> using up to 1 GiB from each of the top N devices with the largest free
> byte count (using devid to break ties), where N is the maximum number
> of devices supported by the profile.
> 
> You could replace "largest free byte count" with "largest proportion
> of free space" in the above, but that would only make sense if the
> filesystem had never had drives added or replaced.  e.g. in cases where
> you had already filled some devices, then replaced them with larger ones,
> the space available on a device would not be correlated to its size
> at all.
> 
>>
>> Paul.

I am surprised that nobody mentioned RAID10 to Peter. It will try to 
fill up all devices first and "degrade" to RAID1 when it has to. So in 
rough terms it works in reverse of RAID1 as far as filling up devices 
goes. And BTRFS' version of RAID10 does not offer better redundancy than 
RAID1 anyway.

Also kind of off topic, but kind of related.I feel like mentioning 
something I have talked about before. With the new raid stripe tree (and 
extent v2 tree?) in the pipeline it is perhaps worth bringing up my old 
idea of assigning storage devices to groups where one could do more 
advanced stuff like assigning weight to certain devices, allocation / 
redundancy policies, and/or assignment of subvolumes to them etc...
I believe the case mentioned here is something that could have been 
solved with such an ability. Albeit it might create more complexity than 
it solves if too advanced. (sorry for getting carried away).
