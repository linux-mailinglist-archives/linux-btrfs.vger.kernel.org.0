Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79CC810318A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 03:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKTC1p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 21:27:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:55639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfKTC1p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 21:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574216799;
        bh=ALTwPHRyLNgDjGA0FJzKZ0WvF7Vbssyoya8xWZd905Y=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ibEkhfFEwitx3fkZTeS9IkXer+QLxlkYw8ElisHnV6ozig707CUYRo+5uZErUc1hZ
         k5D+0p8lHIMccfK4Y/0pjHpe+yt4+48VvG23Rg8tXWUgErMUuCVftIUKRsu9rAzUq2
         VKjMbWW3kSZH7jgAr7Kcf0T8DAHmRxQbaMiDNgdc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.170] ([34.92.246.95]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1hp9VW0Fm4-00zk8u; Wed, 20
 Nov 2019 03:26:39 +0100
Subject: Re: [PATCH] btrfs: block group: do not exclude bytenr adjacent to
 block group
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191118055603.10011-1-Damenly_Su@gmx.com>
 <24721dc8-8bda-a086-ff1a-31a0b21a02b4@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <cc86698f-f0d0-f831-480f-92db61b48140@gmx.com>
Date:   Wed, 20 Nov 2019 10:26:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <24721dc8-8bda-a086-ff1a-31a0b21a02b4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7pB411ZFKd77xAqrIyXTdVPc6mnaqWZn+P51dVXWhaTQlW0Jv8V
 IPMjSPFqVmzlwB6ovQiwkRK/9juziQnqx8JBqOP8RWhHAOBuPjKkpxUqUUMDbGemyYyiWDk
 eWJHBtrPMqD5nf2BKWBlT9MnY/9D7EnDoaviszHgHl5dvNA5Bg3ThEo6SCH0AH50OcByOhI
 SC7E/JUeDfX9PVyqsgyVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6HJ3jjPphz4=:sjae7r3tfrBuu9o4jpcLB0
 gkmh7XyL3skYmg1n5XzK18fNUSVUkEqG3bylkzXTjLVSY7N5vuZ75ayOrl95OSNK2SCYy3uIz
 w9NudeMUUlv2HJzU6ujjtb5YoXlWZM2GO2d0VXLBRt9ihNLV2sgOXYV2zVynd3F7/Cjue3ri6
 hS7e2eaZZBhGlOuKedFye4RV549CjZ+L9AkX+JtmI54HZjYjE1eEB8p/s/q0lJeIkCp6ZOhbr
 6mBkxu1MzhS9Kb+8h9l1qvQQwhron2rwJc9xwwscjPmcjPowKPKQs1hc1qxKRmG3BmLyg2tti
 itgOOkaIIp3axjnQBGrLUcx98s8kyV8qrimqIsCkFQFY4jE4iGJusw5SAUBLo760gCtEHAJkR
 y5R2zIx7tWJHuV+UcHtV0fP4beBPUc8od6JEqSpXJmY1f7XYM/LwaEiqAzh85yjKhkuH8Bd+K
 WS+2/N0IRd5t85CyBfOttn65kv5yo2jWuoANLNRu0JfiLSEt8s4govbxZvVkXxH074g/Wlnx0
 qiKO0NBptcAarmdbxKD+wwhL4BF28Dn5qPodpcLOhhkLZh8fCLYvO6hHmC6xCW3gyAGZZl6Ie
 E2jXTyBaa3vFzrb9Cn32Sr+MVCPVPOyfuuHmFbcez2zD5Gurx/8wBPHQENh0VWBazaalIElYx
 64Qtq2LJerIewzKDSqgP+iT3GcjNLwlHXN6vCYNGAnGn/JcX031bGh4gftozjizgZV941pKC0
 jfuRrCuB187gWIxWjXtRGc0fvr6jF/k6iQB8FefVWKrxSddBWsNHkNio6PRIBEjh2q7FxA624
 o+BODRSV0E27/ldIauJewHpNCmQYWl1PQfVDvxXM0sOwN7X2iWFILt+OW7HfiUCYAzTpvE7Y5
 tQ7BGAekQSY6lzxhKXcAbzqOtCRX4bNx7CAKJ2BshF0NCePf/MkQQfUMT61muedhj/AMhsAt8
 sLloHINs7meQN+ZNjDjcnh1hzmDfQGNBFlGb16zVOOob71vuHSyEK8D41T3zbvaz8AWXkRS/p
 twqoPJrvElRy0GxqGbE1y31HNre+7g+maU1aGf4vc+HY1MowUcf5+dW5vFajGfTrOVUoiMPM6
 U254spVNmYuNOQwa3Yro9iPN7EWerpF8r+MyXyWEQ28ksUOZIvMQlwK2OyWZyJryUQ4Gw1JHP
 vAWH5/cg8THKixJKRtcHQNlwQ4ypB6TTxL1ErTQXYY73IWJE/tjXst/c8gdGHqYhP25SfPz2q
 KRNwdq/m/s6K1dIXhydEPhCwQG0PDqJLAdYGs/XdDv3T5mHaE7tCezG4IBzE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/18 5:56 PM, Nikolay Borisov wrote:
>
>
> On 18.11.19 =D0=B3. 7:56 =D1=87., damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> while excluding super stripes from one block group, the logical bytenr
>> should not be excluded if the block group's start + length equals the
>> bytenr since the bytenr is not belong to the block group.
>>
>> This is insipred by same bugous code of btrfs-progs.
>> The fuzz image is rejected to be mounted by tree-checker, but not
>> bad to enhance the check in practice.
>>
>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>> ---
>>   fs/btrfs/block-group.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 1e521db3ef56..54f970f459f5 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -1539,7 +1539,7 @@ static int exclude_super_stripes(struct btrfs_blo=
ck_group_cache *cache)
>>   		while (nr--) {
>>   			u64 start, len;
>>
>> -			if (logical[nr] > cache->start + cache->length)
>> +			if (logical[nr] >=3D cache->start + cache->length)
>>   				continue;
>>
>>   			if (logical[nr] + stripe_len <=3D cache->start)
>>
>
> Is this check necessary at all, since btrfs_rmap_block already contains
> a check which ensures the physical address passed is withing the range
> of the given chunk, which in turn means all logical addresses derived in
> btrfs_rmap_block with:
>
>                 bytenr =3D chunk_start + stripe_nr * rmap_len;
>
> will be within this block group?
>

Yes, you're right. Drop this bad patch.

Got sick, sorry for the late reply.
