Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776704025DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245118AbhIGJBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 05:01:47 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:48580 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245210AbhIGJBp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 05:01:45 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 583009B817; Tue,  7 Sep 2021 10:00:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631005238;
        bh=D+Iohv9/ZSq0fAuEffjtfumcaOP/I9p7uHjS6ma9AEg=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=N8L/wK+5IWoO/BZ9JHqHPU+JnsTgjcm6hkVbzLr0x80Ij8jo8z+lqSONbW3Ayr949
         cesfM9UJgE1BXEZ7bGMLfQCPUK7pRIQ8Rj4dRFSX9bSZu98eUgkSlt/KMlzvTUKHSt
         5POBNEp0NYXfKNRPIixzcJeRNUXndWCpVVdD7uBFL08z2O+UiJFVEGX/KzO2wdzxtC
         QYHOxsiJkqUQmYIoeQbqpgl8a5SH8OwI3YBlmqyBFjer52/bPKO7v1cuuUo85/sm1a
         NTQM1Q+dBPeaWuRpK0Wo7OL+kSIT7i4rKQFlPf2LltC1lcjWB+9bUg3/YtffX6vnvP
         4kQJ+sL+BMqcg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-7.2 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 8E5BC9B804;
        Tue,  7 Sep 2021 10:00:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631005200;
        bh=D+Iohv9/ZSq0fAuEffjtfumcaOP/I9p7uHjS6ma9AEg=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=uhZc07Um+cQwyiycIp3uD2d2WpbeBDVv6daPgUQVXabxBb5ybCSoSZa30ZQj42IwX
         fE/0nXITNzLGvLnVwqFPcmDhnXBtN5J476ESnMwHT5F8Sv6SweoaqeYy6M2ahj8+c/
         CtkCloGB+Ftym7UfcYK4A65XXglc/cZfes9AGNzB9mPzRsVpxp7qOQDD+y4KF2HWQu
         2h22qR8ruvUd+U5Y4UlAiV6xvV1dm5bx/ck7Iqs86jDyKS5kmsfiTLBoIZmX+lZFua
         pbWd/0NIWRr0hgOUUH3jPQ87BHNnGavhFp7T2o4SqCquucXfffDbG7AG7PJGQdATjR
         67nfWPrTJ4jMw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 1D756293504;
        Tue,  7 Sep 2021 09:59:59 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <c5930e90-ca5b-4089-6f2e-830af6576baa@gmx.com>
 <7c4ecbc6-41a7-5375-42cc-9bf87ff35507@suse.com>
 <5030bc35-fdda-b297-94e4-d484f8aee444@gmx.com>
 <4da2f41d-c1e0-1da9-e4c9-bfe87067a6af@suse.com>
 <b5dba5a6-256b-ee5c-57f2-84e9875e6c0a@gmx.com>
 <757eb738-a9f0-0c6b-a713-dc89122eb5f6@cobb.uk.net>
 <4c46ff5f-24c2-a6f0-3204-2682afd3c014@suse.com>
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
Message-ID: <8c81e1b1-9d07-43f8-90da-e770e3c60bb8@cobb.uk.net>
Date:   Tue, 7 Sep 2021 09:59:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4c46ff5f-24c2-a6f0-3204-2682afd3c014@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 07/09/2021 07:03, Nikolay Borisov wrote:
> 
> 
> On 6.09.21 г. 19:47, g.btrfs@cobb.uk.net wrote:
>>
>> On 02/09/2021 13:17, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/9/2 下午6:59, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 2.09.21 г. 13:46, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/9/2 下午6:41, Nikolay Borisov wrote:
>>>>>>
>>>>>>
>>>>>> On 2.09.21 г. 13:27, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2021/9/2 下午6:06, Nikolay Borisov wrote:
>>>>>>>> Currently when a device is missing for a mounted 
>>>>>>>> filesystem the output that is produced is unhelpful:
>>>>>>>>
>>>>>>>> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2 
>>>>>>>> Total devices 2 FS bytes used 128.00KiB devid    1 size 
>>>>>>>> 5.00GiB used 1.26GiB path /dev/loop0 *** Some devices 
>>>>>>>> missing
>>>>>>>>
>>>>>>>> While the context which prints this is perfectly capable
>>>>>>>>  of showing which device exactly is missing, like so:
>>>>>>>>
>>>>>>>> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b 
>>>>>>>> Total devices 2 FS bytes used 128.00KiB devid    1 size 
>>>>>>>> 5.00GiB used 1.26GiB path /dev/loop0 devid    2 size 0 
>>>>>>>> used 0 path /dev/loop1 ***MISSING***
>>>>>>>>
>>>>>>>> This is a lot more usable output as it presents the user
>>>>>>>>  with the id of the missing device and its path.
>>>>>>>
>>>>>>> The idea is pretty awesome.
>>>>>>>
>>>>>>> Just one question, if one device is missing, how could we 
>>>>>>> know its path? Thus does the device path output make any 
>>>>>>> sense?
>>>>>>
>>>>>> The path is not canonicalized but otherwise the paths comes 
>>>>>> from btrfs_ioctl_dev_info_args which is filled by a call to 
>>>>>> get_fs_info where we call get_device_info for every device in
>>>>>> the fs_info.
>>>>>>
>>>>>> So the path is really dev->name from kernel space or if we 
>>>>>> don't have a dev->name it will be 0. In either case it's 
>>>>>> useful that we get the devid so that the user can do :
>>>>>>
>>>>>> btrfs device remove 2 (if we take the above example), 
>>>>>> alternatively the path would be a NULL-terminated string 
>>>>>> which aka empty. I guess that's still better than simply 
>>>>>> saying *some devices are missing*
>>>>>
>>>>> Definitely the devid output is way better than the existing 
>>>>> output.
>>>>>
>>>>> I just wonder can we skip the path completely since it's 
>>>>> missing (and under most case its NULL anyway).
>>>>>
>>>>> Despite that, I'm completely fine with the patch.
>>>>
>>>> As you can see form the test I have added this was tested rather 
>>>> synthetically by simply moving a loop device, in this case the 
>>>> device's record was still in the fs_devices and had the name, 
>>>> though the name itself couldn't be acted on. So omitting the path
>>>> entirely is definitely something we could do, but I'd rather try
>>>> and be a bit cleverer, simply checking if the name is null or not
>>>> and if not just print it?
>>>
>>> Oh, I forgot the case where the stall path may still be there.
>>>
>>> In that case your existing one should be enough to handle it.
>>
>> I realise this comment might be too late so feel free to ignore it
>> if so. Could this path name potentially conflict with a (new) device
>>  using the same name? For example, could someone have created a new 
>> /dev/loop1? Or could a USB disk /dev/sdf1 (say) have been removed and
>> a different disk inserted and acquired the /dev/sdf1 name? Or would
>> that be prevented in the case where "the device's record was still in
>> the fs_devices"?
>>
>> If so, I think this could be very confusing to the user trying to 
>> work out what has happened. Maybe the output needs to change to 
>> something like:
>>
>> devid    2 size 0 used 0 last seen as /dev/loop1 ***MISSING***
>>
>> "last seen as" could just be "previously". Or, to make it even 
>> clearer that this is just a hint to help the user understand which 
>> device is missing, maybe something like "(last mounted as 
>> /dev/loop1)".
> 
> Actually in the case of mounted file systems this cannot happen because
> the missing bit is printed *only* if the device's path cannot be opened,
> i.e it's indeed missing:
> 
> 
> /* Add check for missing devices even mounted */
>      9                 fd = open((char *)tmp_dev_info->path, O_RDONLY);
>      8                 if (fd < 0) {
>      7                         printf("\tdevid %4llu size 0 used 0 path
> %s *MISSING*\n",
>      6                                tmp_dev_info->devid,
> canonical_path);
>      5                         continue;
>      4                 }

Thanks Nikolay. That makes sense. So to see the MISSING message with a
device name, it must have been present when the fs was mounted, got
included in the fs when it was mounted, but have gone missing later such
that a subsequent "open" fails. Is that correct?

Presumably btrfs is still holding the original fd used at mount time
open so the device name (if it can be opened at all) cannot now refer to
something else.

Graham
