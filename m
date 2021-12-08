Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE57946C88B
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 01:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbhLHAQp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 19:16:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:43955 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233913AbhLHAQo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 19:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638922389;
        bh=wio5LphbQu9asijeuF58s8RMxVVDdhnANma0z0NYKHY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=FF0KHOfrB9uQdEwvOeWqFU8ZZHXMkxHjsPoe902tDKRdskMTEvUNAtH38YBoVIS/I
         VzVFPqZg8ZjDeGF9w0gPmBYsDE2WKBpY1KE/IQIE4oYhm2cvZdOVbN681Z8teKxh2m
         d54zIY0Yc5igiEngQIIRir+u703gLxizD90myNS4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbAcs-1mJCqC2tui-00berz; Wed, 08
 Dec 2021 01:13:09 +0100
Message-ID: <bebe6e86-ca0f-be45-cc9d-905b918b8e41@gmx.com>
Date:   Wed, 8 Dec 2021 08:13:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Question for information about the Extend Tree structure
Content-Language: en-US
To:     Maximilian Eichhorn <maximilian.eichhorn@fau.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <c2ecfb9c-5044-a370-2362-8f67b44ce53c@hogwarts.middle.earth>
 <d2b335a8-f615-6506-8b17-f4a1f61ee7a1@gmx.com>
 <d6054895-8fc8-953d-db3b-598dc5086355@gmx.com>
 <24397189-a7f2-e226-dbba-6b627294621e@hogwarts.middle.earth>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <24397189-a7f2-e226-dbba-6b627294621e@hogwarts.middle.earth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T9cyEIhH/CXOVoR0HiWtOdb6RSwex9gTXMVi6yV4qfZLevbEyPt
 Y3QyWN43p3t8hPfDLF6+nUZ5jjNcOIYCvloD/NzhdcOBt/CN+W6H7/HWrckt0IG2pRq8zCL
 G8yamy2rh6FXHZtREv/7spPqhZQAKvnjgOJB/iI0dV7AH5ADa4hAfZkvaYhCrpTDx2IO45H
 MAKUR3T9FtCreNp9AeiKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2tR2yRzTIv0=:p5qOQUv3gP6teIgCPhsOo7
 jVak9ISNSzq1Qrv5QHl3G8hkLKtlBogFCQcMptzkvqX2SpW4M/3NaJKK8CrGghAOHpsZBTvar
 zcz15IavszqVR+L7AQvUObjjdvlXUFKJQ8n7SNj772aU3swj05jTxavos7O0ey1d9QVPWaOeK
 IH53w1nqb3fsu4rgkUEhNCqXgAF2IYqFT5qYwWpJvl0IQw1xYxBonfDulg9n8RMka6xIPaXzC
 N76qqraJ5Hvz3xtR7ZF2zWO043Ayr2TYFHeTYSMABzBKjh3wCrCfOE7xLy2msElRj8g4JYh15
 cF7xC0DRKmMX+TYFpEIFapHtj+QKLlZJ00QYWSF4njh0Mgn7c/TrkjHPPtv7KGDMUte0V64wS
 HnN1pHXl+AZs5m5JZAISnRfzN7yOq+CQjlpmt3IjVMQDR8hMMqCdgErZsQSQV2IJH6cQCqKYd
 BHAy6ktcCfavx+8ZnBNSO3blJiZewGXou3cmJnq22iJocGKvVnIe3yaT5EkbSKpUPbaToPylG
 9ab3TS4vB5V2s8LDOSC8TlVm74y3OsFmUCDe+76zMDX/CZLq5Qo1nCnqlVhGNWzEFgcl28TuD
 99Ex21xSxQd8tXcgT8ZPoH1WyGM8BT3eDGBcS1NxUp5+OBaG2Jpg9T7H/wAXi7dEzWJSp/n4i
 xv+/L9VPSqWHVP8UwDzDLahnnd7vK2aX9R/0GwDCg/CvTbpW694ORXWxIlSrkVs8gEDfe3GLD
 J+HUrTQFDSAE9DJrSaL7NV3aQ237olOGtp0z4MheLYExzKyxBPIMdimnEnz2BK0P2a34BqyQU
 I29CKhq/0lG/UNYcL+otAwpZkLhnMu5kr5ETYCjlxj0KJi4oe2lykVyJuJSm/SeluU/SkveL5
 4rSJab2Gs4tr7N7wopjYBUBHy7EQX/336XLpGAijZ53itKQm5btfX8pjwn7GTOjQ31aAlepsX
 yy9EiXTZc97QjTUW+P56LoLIT6QUirBjuB18yYuq74eC3xlGbXckCt9LI851DjrcbOW8bvPf0
 E1jbZc1ANzSw8qlkqwsp4lG4jn+8OaB3QM/7iQOd5ktgqSLXNWPovrde6xem1r5INiPJPJYJ8
 uJyc5216JqFPRw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/7 23:13, Maximilian Eichhorn wrote:
> Thank you for your quick feedback and information. You have helped me a
> lot. Now I have already once a promising approach.
>
> Thank you very much.

Glad to provide some help.

Btrfs community always needs new blood, if still has something unclear,
feel free to ask in the mailing list.

Thanks,
Qu

>
> Thanks,
> Maximilian Eichhorn
>
> On 07/12/2021 15:15, Qu Wenruo wrote:
>>
>>
>> On 2021/12/7 22:09, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/12/7 21:53, Maximilian Eichhorn wrote:
>>>> Dear Sir or Madam,
>>>>
>>>> as part of a research project, I am working on the file system Btrfs
>>>> and
>>>> its structures.
>>>> More specifically, I am learning about the extend tree and marking
>>>> individual areas as allocated.
>>>>
>>>> In the course of this I also became aware of the wiki [1] and examine=
d
>>>> the information to be found there.
>>>
>>> I guess you mean this?
>>>
>>> https://btrfs.wiki.kernel.org/index.php/On-disk_Format
>>>
>>>> However, not all aspects of the
>>>> Extend Tree are clear to me yet. Therefore I turn to you with the
>>>> question and request for further information.
>>>>
>>>> In other file systems it is very easy to identify a certain
>>>> block/sector
>>>> as allocated or to manually mark it as allocated because of the
>>>> existing
>>>> structures. Unfortunately, I have not been able to do this with
>>>> Btrfs so
>>>> far.
>>>
>>> First thing first, other fses are mostly using bitmap to indicate whic=
h
>>> blocks are allocated, that's why they are easy.
>>>
>>> But that lacks a feature btrfs needs, to do backref lookup.
>>>
>>> That's to say, when we know a block is allocated, we also want to know
>>> which tree or inode owns it.
>>>
>>> That's why btrfs extent tree is that complex.
>>
>> Forgot to mention, for your traditional allocation bitmap, v2 space
>> cache (space cache tree) is your best equivalent, it only shows the fre=
e
>> space, without the hassle of full extent backrefs.
>>
>> Although unlike regular bitmap one, it goes a mix of bitmap and extent.
>>
>> But still way simpler than extent tree.
>>
>> Another thing is, extent tree and v2 cache are all at btrfs logical
>> address space.
>>
>> If you're going to check the free (unallocated) space for each device,
>> you need to go device tree, which is much simpler than extent tree.
>>
>> Thanks,
>> Qu
>>>
>>>
>>> But if your idea is just to get which blocks are in use, it's much
>>> easier.
>>>
>>> (<logical> EXTENT_ITEM <size>) is for all DATA and some old metadata
>>> backref. That indicates one range of bytes allocated.
>>>
>>> All data extent should have one such key. For non-skinny metadata fs
>>> (without skinny-metadata flag), all metadata should also have one
>>> such key.
>>>
>>> (<logical> METADATA_ITEM <level>) is for METADATA backref.
>>> With skinny metadata, all metadata should have either METADATA_ITEM or
>>> EXTENT_ITEM. (For newer fs, there should be no EXTENT_ITEM for metadat=
a,
>>> the co-exist behavior is just for backward compatibility)
>>>
>>> For METADATA_ITEM key, although we don't have the size in the key, sin=
ce
>>> btrfs uses fixed metadata size for the whole fs, the size is fixed to
>>> nodesize from btrfs_superblock.
>>>
>>>
>>> So just focusing on EXTENT_ITEM and METADATA_ITEM, you can get the
>>> allocation info from extent tree.
>>>
>>>
>>> Talking about the marking part, it's pretty hard, as although you can
>>> mark one range allocated, you also need to insert the proper backref f=
or
>>> it. But since you're not really allocating the space, the backref will
>>> not be valid and will trigger fsck error.
>>>
>>> For a proper EXTENT_ITEM/METADATA insert, I guess you have to jump int=
o
>>> the rabbit hole of btrfs code, btrfs-progs will be a good start point.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Thanks in advance for your help and efforts!
>>>>
>>>> Kind regards,
>>>> Maximilian Eichhorn
>>>>
