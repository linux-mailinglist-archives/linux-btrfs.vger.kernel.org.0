Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CD7401ED1
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhIFQ7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 12:59:21 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:35442 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243179AbhIFQ7L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 12:59:11 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Sep 2021 12:59:10 EDT
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id BA3709B736; Mon,  6 Sep 2021 17:48:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1630946885;
        bh=nD231NSVhcZWYXa3gSb/pm4jefdzOnSMrbtfSuXVxmg=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=KGxIpxqKl9I0OF027IMPRRAj8pL1a6HsBjpaoG89cY9WmV1/mJ1WJJq2HnUvdGozq
         0G37+tnj7DiS1rVFBijffysJ7uRShKBr7kZxm1L6E0p9VgStcq6fcSiLaJA3zcIs30
         shCvuGfDZmlXBy5lwAiEh8ituqv61wGTIyBqZ5J7QvnAvAy7c5AwYDCtDHZFCV7UKZ
         kgrXYE84oCLk8u9fj4Wtopp+agkmWi7xFNpVPN78Y5lIZsHHgkdH1CED3qJl9hOABA
         sRVLqwFaYPQJCIdx1Jf8TYO0MMvSl3/wzyL2k0i2VHywnJIvtKmyzDHMCn5fifnQer
         npc/gPnMcEUbQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-7.2 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id DFE6F9B6D5;
        Mon,  6 Sep 2021 17:47:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1630946855;
        bh=nD231NSVhcZWYXa3gSb/pm4jefdzOnSMrbtfSuXVxmg=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=au7KYelWAd1zCf8z+wiGjy4FyjpFXBMa9MaDsEFsnXxHkWmKFmdedJh2ifvmsOqRq
         Ii1vJjWWIEmVE14nJ2zKe3/ZOCeiux2753ACxGv2G13K18CIkUWHaMxpDZdD3K2yt5
         NV3DDTvmtulPEKN1DF3E2vJRDZ0kyTbi5ygfItG/S4jW5w792l11I5r6H9SX7wkLY7
         qqSpkePn8B/eNPBYlQEpg5dbC+31RjqhexeX6Q48hD9OdanjZ5YpEELzz9TWelsUiF
         tWKhXn1AUDRIX0r+yJjPseWVHT7CxuuFxSiQ5rJ+144efWGhdtz/ueFC+NYVBBZLkV
         GkACy8cMn20vQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id A36C7291C78;
        Mon,  6 Sep 2021 17:47:35 +0100 (BST)
From:   g.btrfs@cobb.uk.net
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <c5930e90-ca5b-4089-6f2e-830af6576baa@gmx.com>
 <7c4ecbc6-41a7-5375-42cc-9bf87ff35507@suse.com>
 <5030bc35-fdda-b297-94e4-d484f8aee444@gmx.com>
 <4da2f41d-c1e0-1da9-e4c9-bfe87067a6af@suse.com>
 <b5dba5a6-256b-ee5c-57f2-84e9875e6c0a@gmx.com>
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
Message-ID: <757eb738-a9f0-0c6b-a713-dc89122eb5f6@cobb.uk.net>
Date:   Mon, 6 Sep 2021 17:47:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b5dba5a6-256b-ee5c-57f2-84e9875e6c0a@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 02/09/2021 13:17, Qu Wenruo wrote:
> 
> 
> On 2021/9/2 下午6:59, Nikolay Borisov wrote:
>>
>>
>> On 2.09.21 г. 13:46, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/9/2 下午6:41, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 2.09.21 г. 13:27, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/9/2 下午6:06, Nikolay Borisov wrote:
>>>>>> Currently when a device is missing for a mounted filesystem the
>>>>>> output
>>>>>> that is produced is unhelpful:
>>>>>>
>>>>>> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>>>>>>       Total devices 2 FS bytes used 128.00KiB
>>>>>>       devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>>>>>       *** Some devices missing
>>>>>>
>>>>>> While the context which prints this is perfectly capable of showing
>>>>>> which device exactly is missing, like so:
>>>>>>
>>>>>> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>>>>>>       Total devices 2 FS bytes used 128.00KiB
>>>>>>       devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>>>>>       devid    2 size 0 used 0 path /dev/loop1 ***MISSING***
>>>>>>
>>>>>> This is a lot more usable output as it presents the user with the id
>>>>>> of the missing device and its path.
>>>>>
>>>>> The idea is pretty awesome.
>>>>>
>>>>> Just one question, if one device is missing, how could we know its
>>>>> path?
>>>>> Thus does the device path output make any sense?
>>>>
>>>> The path is not canonicalized but otherwise the paths comes from
>>>> btrfs_ioctl_dev_info_args which is filled by a call to get_fs_info
>>>> where
>>>> we call get_device_info for every device in the fs_info.
>>>>
>>>> So the path is really dev->name from kernel space or if we don't have a
>>>> dev->name it will be 0. In either case it's useful that we get the
>>>> devid
>>>> so that the user can do :
>>>>
>>>> btrfs device remove 2 (if we take the above example), alternatively the
>>>> path would be a NULL-terminated string which aka empty. I guess that's
>>>> still better than simply saying *some devices are missing*
>>>
>>> Definitely the devid output is way better than the existing output.
>>>
>>> I just wonder can we skip the path completely since it's missing (and
>>> under most case its NULL anyway).
>>>
>>> Despite that, I'm completely fine with the patch.
>>
>> As you can see form the test I have added this was tested rather
>> synthetically by simply moving a loop device, in this case the device's
>> record was still in the fs_devices and had the name, though the name
>> itself couldn't be acted on. So omitting the path entirely is definitely
>> something we could do, but I'd rather try and be a bit cleverer, simply
>> checking if the name is null or not and if not just print it?
> 
> Oh, I forgot the case where the stall path may still be there.
> 
> In that case your existing one should be enough to handle it.

I realise this comment might be too late so feel free to ignore it if
so. Could this path name potentially conflict with a (new) device using
the same name? For example, could someone have created a new /dev/loop1?
Or could a USB disk /dev/sdf1 (say) have been removed and a different
disk inserted and acquired the /dev/sdf1 name? Or would that be
prevented in the case where "the device's record was still in the
fs_devices"?

If so, I think this could be very confusing to the user trying to work
out what has happened. Maybe the output needs to change to something like:

devid    2 size 0 used 0 last seen as /dev/loop1 ***MISSING***

"last seen as" could just be "previously". Or, to make it even clearer
that this is just a hint to help the user understand which device is
missing, maybe something like "(last mounted as /dev/loop1)".

Graham
