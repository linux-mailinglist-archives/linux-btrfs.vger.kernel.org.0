Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C2402699
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 11:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbhIGJ5x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 05:57:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:38653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242294AbhIGJ5x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Sep 2021 05:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631008605;
        bh=yfKGoFJZVGjhbp+e+HxZsC0AIGX8XtcVIe9RcJ4D0V4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AXYHUyLOgiMp+waoWiqmnQEzNXZGbatDqysTvpNye07aiqYmEXPFCChRSiLauuI7v
         S0seggabsYIA5KoUfEcMsMc+QLDhAVUHT67aPIYDeD8Opt2BYgW4k/wMZDxddkWw7e
         fKKIrzDbiSBQmUg6VC+5xll9omu+kGjkh6DdTPlg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wyy-1mI1Wq0adI-005bsi; Tue, 07
 Sep 2021 11:56:44 +0200
Subject: Re: [PATCH 2/3] btrfs: rename struct btrfs_io_bio to struct
 btrfs_logical_bio
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210907074242.103438-1-wqu@suse.com>
 <20210907074242.103438-3-wqu@suse.com>
 <95fd7c35-a100-6aca-64e2-c396420a8fda@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <026af2b0-f162-7131-f583-23187b40c272@gmx.com>
Date:   Tue, 7 Sep 2021 17:56:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <95fd7c35-a100-6aca-64e2-c396420a8fda@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WU/CzJ4IoS7Ta9WgE+l/f0oKtxEjPz+Wdvg7SkMRviiy/Eno7fy
 +fadisbKaRvcHmf1CR/sKE3Z3vv02b/qPSd3kxyXjHKAfUW5R9T1ObpdhvwY80NYH0k1SEx
 MdVbsRQBPYSmAX6fgD9/XQ5ZPHyT7y+ZGF7khqnhO0lAyVt2Q45HmbgWgml8JexsXT06CRV
 k+B8DzncjK/fJb/EFdf4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FRQJPo+aO8I=:aMNdT/5LNIwZQm61uWV4rg
 gDb+jVa3Dt2s+OadEU80WGVOG44l8eLSeRFANX5+C/5+x+2JSth0sNrGsqdbXMEwj4LFtShVA
 JILUWRjcFozY1UvfcJ1W1NeE1HJWiF2QXuraOY0SpH1PVEYbYqGihRO9PMFEroigjiCnyXhuQ
 OYCsNJaLthGKRgjLiU08adc+A2s9HsK23M5ayURCFlgvciOY5OAfTz9zXVpVbcQ2LN3/cxB3H
 2NV8t9/90eSefmYY7nDzpW8v5HKl/rwd7ItSJ4756ldKLu1tI5XOZRi+dJCpgs+mUOgjrRF2U
 HwBa9TLUQl0+Q4YlYjqtTqipZ7BB9DIkd5f1JbvnxXNSQibr5eBRCVZ5PsGJ2R+UnkDCn1cfW
 aYEYV6/ELDnkRvs++9iOwppLqszLzmjFbiN3aen6q2b43TatvK+JKA/V1WbK8vdHYBjv83xR7
 X3X25+4jaayMmTmrM2E8alREo1zzDb3+18UPdW40IM4AyntO3DVmvtPHgGWXvoHqF+Bu0G21k
 CKt/C9o2Dd7I3az8u20ff+2uLLEeTMuIb9s1Vwz7ee2YuQ+dEPD/LcZen6LT3CMEQEkIsfbYD
 Q3zZQLWE/hD6jHWMYJbbHJ+QeU51lDxDnj72xhMu81XEBBvWBv43iXeWyRgGb/F4mvol7R+Ip
 U8wD9uxUhP7wm9dXhpc0/MFpqgzkK/di3Zy1vpyV5rOw/9JMmpaxc0cHjvWQL4TuRxioLhyKP
 y4+DyDLYjpXie2TmvQIg8JeYBytccFHu20f+tLDlxAh8zg+fjyUHSn4IzyhCmyuNjHA3zTexr
 Rz+/ZCwcQ5SN0CMLPQyUwywhPiC82eznK/yC1agZi/MqkkNiEMREjY59xlLIyDuxkwle38+MA
 qVdtZRtPuSXGOVgJv48XbDbra0RMgYFnvLG/lrZpK14WPbrnhZbF17j0+EACn6t0l6qxAlR35
 FLP4RGD/YyinkP5CN6kSpmR6kWRbaVfmpVU/jIgWCD+G0axcnXA8BsjVyZdyeQgcd8bK9nQuR
 RsHivDoZPS4Ffk2qZY4ae9oN+FDZF1+DzFiDab86RCCJWZp4lUnufTqmo8q6BN0ry+N4mU87Y
 kgRqLeX3gEWcPjLqzdLe0ItL8TPO8RxY548PfMXZzJCOoZTnXoQI7ZTIg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/7 =E4=B8=8B=E5=8D=885:47, Nikolay Borisov wrote:
>
>
> On 7.09.21 =D0=B3. 10:42, Qu Wenruo wrote:
>> In btrfs there are at least 4 types of different bios currently:
>>
>> - btrfs_io_bio
>>    It's used to specify IO for logical bytenr
>
> Perhaps this structure needs to be turned into a btrfs_bio.

That makes sense, although I still want to keep the logical part to
indicate what the bytenr is for.
>
>>
>> - btrfs_bio
>>    It's real physical bio
>
> It's not even that, because btrfs_bio itself is not submitted at all,
> it's really some sort of a semaphore, which is used to signal all stripe
> bios i.e those bios which are submitted to the actual devices have
> completed. In that regard it's not even a bio per-se, more like an
> io_context.

Yep, although there is still some use-case where it integrate the
logical bio into it, thus it still has bio in it.

Or maybe we should separate the mapping part completely from the bio?

Thanks,
Qu

>
>>
>> - compressed_bio
>>    Only used for compressed read write.
>
> This should be compressed_io_ctx or some such.
>
>>
>> - btrfs_raid_bio
>>    Only used by RAID56
>>
>> The naming of btrfs_bio and btrfs_io_bio is just anti-human.
>>
>> Rename btrfs_io_bio to btrfs_logical_bio, and all involved helpers to
>> make clear at which layer the bio works.
>>
>> Since we're here, also add extra comments on critical members like
>> @mirror_num.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> <snip>
>
