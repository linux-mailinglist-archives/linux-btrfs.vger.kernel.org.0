Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1FE3D720F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhG0Jcj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 05:32:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:43247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235978AbhG0Jce (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 05:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627378351;
        bh=5ChLepqtLQS0rJkx5L6/fSUvF15uqtUtcIsqdAIHvF0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=c20Lvtm4mEPJg7a91TSo52H3pbad2xL420MCP++NCTGMXRbY2CeHIpAEuglxR3sVn
         xV5BHsIm2A8lK/23fZ12IuOO1rA3lNlJl5W1HICrExWlUejc0DZjrnSryGHM2XwUH8
         2/aE9LXkkSsMGUO57hvh1AZzT3+FXYwVBTujk/+g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sHy-1m3LNF0E7e-004xPD; Tue, 27
 Jul 2021 11:32:31 +0200
Subject: Re: [PATCH 08/10] btrfs: simplify data stripe calculation helpers
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <6e7fd9d9fe39f547eae063dac6e230f155980ba0.1627300614.git.dsterba@suse.com>
 <41a6c967-1f34-b48a-c24c-14cf226a5c67@gmx.com>
 <20210726150651.GF5047@twin.jikos.cz>
 <b1af7184-740c-457d-b8ac-daad094ce7cb@gmx.com>
 <20210727083951.GJ5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <adc1af46-a443-83df-7667-fe6af972a084@gmx.com>
Date:   Tue, 27 Jul 2021 17:32:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727083951.GJ5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PZNapg7I504he68eIUGNZK9PLIjeyqF5HCflF7WhCqp0iJAOHgg
 iL+cOrrfkQkbq1zikmLe9TXnnWtMAFnoFuxdfsmjT7s9f6K0vhvihtQ1yT5b5OLbq7WkMP9
 jOBVNOY91WX9sNikqO5tSf1M5TmZ/bZVIOCZWl7S+jDvCs46o51p2N6a/wJ+X76sovaC6lU
 3KzX9YeYzPpqS2SmAiULQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QwZwKoefbxc=:hFjWZbDQ8FcL+yC9+dKWao
 nYX+ROi+FwYKPvoXoJMvQ0bO+WLkOubYRcM3TnEM/dhckEeavrAAbWE7s7+ctm2U3013x78/A
 /N9IjwVPhkCxrcopamS9np8++VHzEcJ3jKm/IFojbSkICciAfA0toZvMHhFbJOCepO3FlOG2n
 jEaGMW6aVOLLA5+JdO4pAjaoz6/CmTMgTZs3axuoClcQAf54xjbfdcj9d9R0luL0GDs8VQaku
 ZCgKDGeI6jHm0M/8kER4twYkgUCAmIpXmL15mUSSQzulLtbMKP4BsiVdEvza75JFcCyjl8Eh6
 AU3l5s5E3jbz2RROtYApegXL8wLuyehb1mkZy2rUWo9Zrp+ez1QSTKw1ApUGtIaGHbrwWfj43
 oQ30wu2L8zJmdK9SjcnHib54MNSnrl2MO9mw6k6STWIWLotTFaRcs/d17zAmDOr9vnvct+rF7
 AgiILwxJT4v6tEkcXplI5d9uEXHOPj7upMsy4mCJUZqvBis1Ka/flbow8NVADEgMeUSIcgTQf
 yBuoAMeIdCrIFe8cNlrAa2WVo1gWLleWWQl443QxCSZLMyrlTA/3+uhnfx6ygdIB9YRF0lN6u
 u6QtSxU7ZzPZ4GhzEUlSlaHDvin6+19eDiu7KNsFy7r2Q//YX08+en1Uy+HmOQ/wfBjk54cAW
 ta2zTek0SWl4pSpETGuSpvmO6LVkNzNzuV7IQDXq73u8kP0PcctichuDZ2v62mun+IRaEdVIk
 NSCcvnpUJfrmu23b88e3ctZVNXDoIwmHnkYfpdu+y3M+Z3qP9AQl0BVuKk+HNjwCsoMXcSL5X
 wX/oQ20Jdg4X86So+9MhzuzaUH85E0VTkABB6dX4eFcqC1ZeX0QLisUfacknojRk7qSkmV+vD
 S9OLiwcRGelXE9DYeaylCDZcuIApWv7EwmCvvTILnlYzMeiw3SB8kKw2MUBPrhbh+a3gPxMLI
 ZBXklWVOEpqbd83zOOpfl9b6hSoWi3xAcio8/idu2mtBqHiezQlzJ2yIAAtETZKvINeFiWgob
 QT2vUll6ragw90mPkUYErUOk+yYC1q/iUq8Hu4ixyYUFDQK45rwxYJCZigcC0Ok9pDOxif19q
 J6TtxNtlThc0tgrswFxJh+4Or008M5vUyMWpAkW2Ps3p9AhS0djDxQ/lg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/27 =E4=B8=8B=E5=8D=884:39, David Sterba wrote:
> On Tue, Jul 27, 2021 at 06:23:03AM +0800, Qu Wenruo wrote:
>>>>> --- a/fs/btrfs/volumes.c
>>>>> +++ b/fs/btrfs/volumes.c
>>>>> @@ -3567,10 +3567,7 @@ static u64 calc_data_stripes(u64 type, int nu=
m_stripes)
>>>>>     	const int ncopies =3D btrfs_raid_array[index].ncopies;
>>>>>     	const int nparity =3D btrfs_raid_array[index].nparity;
>>>>>
>>>>> -	if (nparity)
>>>>> -		return num_stripes - nparity;
>>>>> -	else
>>>>> -		return num_stripes / ncopies;
>>>>
>>>> I would prefer an ASSERT() here to be extra sure.
>>>> But it's my personal taste (and love for tons of ASSERT()).
>>>
>>> Assert for what exactly? I had a thought about that too but was not su=
re
>>> what to put there.
>>>
>>
>> To ensure we have either non-zero nparity with 1 ncopy or zero nparity
>> with ncopies > 1.
>
> Yeah but that's statically defined in the raid table, it does not change
> so we don't have to verify it on each call. If anything, such
> constraints could be verified as _static_assert right after the table
> but IMO that's pointless and definitely not a runtime check.
>
OK, that makes sense.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
