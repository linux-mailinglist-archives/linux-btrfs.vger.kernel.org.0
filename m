Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 520D3A1B34
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 15:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfH2NRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 09:17:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39558 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2NRu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 09:17:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id n2so2456463wmk.4
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DxbIY8jpP6KAgTYepMoOr7WtbxQKjRRW9eErODMOwys=;
        b=Lx+tsIKK2jbafbCAFLu23Z/eefzY5b6wF9HdfzXogSQD7RE2bZz6hELuqa4UuJfjoc
         oucnpkSEjoSQUbZNnQvrALq+/b6IK5MRe8jGz7FPsSQdy2e1aSBHHUbwCGbY27VI+Hg9
         4uoWLVY6myL8mddSxLSIJ/yQdxK+VFMEQHchfgzfbtNcN1HhRn7yq7qBhzonFYYCYVxC
         0oueyNeHWqDJqPtRWIwhBB3qDp3RH2A254boHeIZm08w2em5d2eaCRkzoXXLQ1mAsnxZ
         NaOa9oY2HdiuRVumu+jASwOGtU8gO/Hmfk1wzcYZ9kZTMwopH0gxLX2ms0VxgyeUrK60
         i8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DxbIY8jpP6KAgTYepMoOr7WtbxQKjRRW9eErODMOwys=;
        b=R1s8fMDj6OFNtN6rCxdXgDZDn14cvSQBBZlvC8SbuaRR1foCpCdMC3KNVl0kOw2Q+D
         n25zL85rMf10a9edfAmiPv7lu4OFS2PVPGiboFIbshPvyAWO83rnIiHtz5CgwgMFJOwn
         zTukUd9hfmfYuiCQz0jVpu7YGfhKThsBytZsbbusQqmAO/xFBW4JjSFOdIi+voFw97Mg
         6Xz87V6d/VqATIXaBsFUea0UegcGZuTRcX/G7oa5XsommwNy00qCJJT4DajipAqDkkmY
         OMEKAKt98hf2IoFNNXmFz9CzwKgwAly2kCtv+92ymeUQ9nMLFjOCEFjUlwPYkcZ4vKtX
         Cv0w==
X-Gm-Message-State: APjAAAWxRKnuWkhvaHjfqUq7JIvc5u494KhfBNAseFfHRCY6j8n8V3sK
        QEwQf+HJY9xfyHWOyscYj/tZBoEt8cA=
X-Google-Smtp-Source: APXvYqwuSsfWywYvzlhuWBxNM9mF9cE9cQDjtAip3y7uJgB4IVmowrr7gPRoUJgYko3kEvlIDAez7Q==
X-Received: by 2002:a05:600c:254c:: with SMTP id e12mr11144000wma.168.1567084667031;
        Thu, 29 Aug 2019 06:17:47 -0700 (PDT)
Received: from ?IPv6:2a01:5c0:e097:52b0:fd3f:afaf:148a:b588? ([2a01:5c0:e097:52b0:fd3f:afaf:148a:b588])
        by smtp.googlemail.com with ESMTPSA id d17sm3685243wrm.52.2019.08.29.06.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 06:17:46 -0700 (PDT)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Hans van Kranenburg <hans@knorrie.org>,
        =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org>
 <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
 <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org>
 <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
 <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
 <209fcd36-6748-99c5-7b6d-319571bdd11f@petaramesh.org>
 <6525d5cf-9203-0332-cad5-2abc5d3e541c@gmx.com>
 <317a6f8f-3810-4a6c-ba64-3825317de1e7@petaramesh.org>
 <c116d672-a212-f73f-ffdf-fd97aa958135@knorrie.org>
 <3fe4a6dd-942b-56b6-c5ca-fed5e801dc0e@googlemail.com>
 <d0a7ec7d-42c8-ebc4-7d54-28bda3d50e5f@gmx.com>
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=o.freyermuth@googlemail.com; prefer-encrypt=mutual; keydata=
 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
 KB7t2CoZv5xo0STm
Message-ID: <8f15294a-753f-1325-b46e-7a41824a9841@googlemail.com>
Date:   Thu, 29 Aug 2019 15:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d0a7ec7d-42c8-ebc4-7d54-28bda3d50e5f@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 29.08.19 um 15:11 schrieb Qu Wenruo:
> 
> 
> On 2019/8/29 下午8:46, Oliver Freyermuth wrote:
>> Am 27.08.19 um 14:40 schrieb Hans van Kranenburg:
>>> On 8/27/19 11:14 AM, Swâmi Petaramesh wrote:
>>>> On 8/27/19 8:52 AM, Qu Wenruo wrote:
>>>>>> or to use the V2 space
>>>>>> cache generally speaking, on any machine that I use (I had understood it
>>>>>> was useful only on multi-TB filesystems...)
>>>>> 10GiB is enough to create large enough block groups to utilize free
>>>>> space cache.
>>>>> So you can't really escape from free space cache.
>>>>
>>>> I meant that I had understood that the V2 space cache was preferable to
>>>> V1 only for multi-TB filesystems.
>>>>
>>>> So would you advise to use V2 space cache also for filesystems < 1 TB ?
>>>
>>> Yes.
>>>
>>
>> This makes me wonder if it should be the default?
> 
> It will be.
> 
> Just a spoiler, I believe features like no-holes and v2 space cache will
> be default in not so far future.
> 
>>
>> This thread made me check on my various BTRFS volumes and for almost all of them (in different machines), I find cases of
>>  failed to load free space cache for block group XXXX, rebuilding it now
>> at several points during the last months in my syslogs - and that's for machines without broken memory, for disks for which FUA should be working fine,
>> without any unsafe shutdowns over their lifetime, and with histories as short as only having seen 5.x kernels.
> 
> That's interesting. In theory that shouldn't happen, especially without
> unsafe shutdown.

I also forgot to add that in addition on the machines there is no mdraid / dm / LUKS in between (i.e. purely btrfs on the drives). 
The messages _seem_ to be more prominent for spinning disks, but after all, my statistics is just 5 devices in total. 
So it really "feels" like a bug crawling somewhere. However, the machines seem to not have not seen any actual corruption as consequence. 
I'm playing with "btrfs check --readonly" now to see if there's really everything still fine, but I'm already running kernel 5.2 with the new checks without issues. 

> But please also be aware that, there is no concrete proof that corrupted
> v1 space cache is causing all the problems.
> What I said is just, corrupted v1 space cache may cause problem, I need
> to at least craft an image to proof my assumption.

I see - that might be useful in any case to hopefully track down the issue. 

> 
>>
>> So if this may cause harmful side effects, happens without clear origin, and v2 is safer due to being CoW,
>> I guess I should switch all my nodes to v2 (or this should become the default in a future kernel?).
> 
> At least, your experience would definitely help the btrfs community.

Ok, then I will slowly switch the nodes one by one - in case I do not come and cry on the list, this means all is well (but I'm only a small datapoint with 5 disks in three machines) ;-). 

Cheers,
	Oliver

> 
> Thanks,
> Qu
> 
>>
>> Cheers,
>> 	Oliver
>>
