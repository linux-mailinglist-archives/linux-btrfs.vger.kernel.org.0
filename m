Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37552AA199
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Nov 2020 00:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgKFX5I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 18:57:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:60609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFX5G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 18:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604707022;
        bh=rCfic00FO1U5P8E0WzD8ulxObG29NUWNIGsp+h0ZaIg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=S4jvWxjmU+j38EuPnq44IuZlN6BHcaPnl7X/00gg/fH6vXOoff88Er6BOzsVreQxi
         Y23yJTgLSPc3gf6nV3Aiw4Kw+iFYg9KmWhaE13XM0Os0j9ZEru0F4NKugAU9l7EVeS
         1dNF5wVRj3XUAJg0EPz1HxTR08XJ1oW8B1TYoDEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0NU-1jvE173uiu-00kL0v; Sat, 07
 Nov 2020 00:57:02 +0100
Subject: Re: [PATCH 17/32] btrfs: extent_io: don't allow tree block to cross
 page boundary for subpage support
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-18-wqu@suse.com>
 <bec6ae39-0a10-e4c4-8e4d-06577057e6f5@suse.com>
 <981350a6-77f9-6419-7a2e-22110364a55b@suse.com>
 <d45d198c-d7bd-a066-0fb6-686b77c8694e@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <1d0fbcb9-0a2e-24ef-1c3e-cca4620782f3@gmx.com>
Date:   Sat, 7 Nov 2020 07:56:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d45d198c-d7bd-a066-0fb6-686b77c8694e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SEZh3tHW03AMnbf79BxtOtHVYQ2T6Lh3tQ1F0HRBNqYovW6GaL5
 40tkKLoRbJ0ZIcN2vc8Xqv89JdllbaCkyB12RHaE7xXNwBob73F29/ZxkBS3nHVy094Daq9
 dS0+SzSyQv6Iy2K0VKXsiS2gwQZjx4OZsJNNf3ZMr39kxEPo8Hkr1NQLMTX2G9O1VpgHP3Z
 pFIEaYz+2lUKdRBAoWOGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xxU994pMFWE=:1rGMaCyzPgBBVGsJK+ncCW
 emsQXuJ0b++yQcCxW57cleAFz0XrFWGbTv7Se4EyEnDxsYmdPEYkBGTaFbEX3sI70P9OA3QJt
 kn2rxBOTNepwGI2Y2jd9wdr9TjdlqCcqV+XDaFkNZ4IbuFJwtAi9bvDE+R6rnEjbgLup0CrM2
 ly4bcXBJPIhLlfLrKGo9Y73//pNHOxbJejuHz8i4HVmjL1q1+XI/Hbkr1nsZE/PKO7aX5tngY
 /njxmiBgAkAiWD2wr3CSPbGkiQdcosyhU0tg21XqOpgslNQ1tSSIbutvDF/tMsgLJtdae+ZKL
 K6YcWSImEB4bT9aGVfXfC+JmBNytZd1vncXQAMo4sU4lj7bQX5pdgUNNYGpDGvOeUzuBeC1ml
 G8aWgZoC87XiHF0cICe9I/pySSlcmoCcCvlHSA/jo+7dlrCwyzcWCtFOMn+69mZ0QIZNmKv/R
 YXZo+OF8O6ZvM5DGsy2xOqQV1iotq/Di6272261JU21Grp2XKvcgGhMx2Ga1ECLFlxiU54TKw
 RCETImjSBrK3auGB21bpJYSiGrNw4/wSTQCwOvG+MGTYC4SlXWhIU37Q5UJV/i2DhQH+taVMA
 sspxikHyoWDxQC5mHVe53QJ15V0aSU6RetjNY1JOWbJyxHc6nofIljbajMf8JjR899ambCpCg
 Pi6yd+wfs3NAo4HH3Ge6hU8rg/M+gUXoj2cPH+Mg9ONxyA3IhXugh+yFt4+Se6JPcHV/0skxL
 1kzpWK1e7fAnGRdZNgxyhihJPdRO9ZVDq0lOIwQShNvzMNGNUhkl1Im2pwAl6MZXzFa5htMjb
 O3rUXb+Hz9T9nJlOBDe8cjUAt9zEli2ctwGvzo1Kppeb1tcAavVkO2csvxNuhzvSd9YCH2y0c
 uJ/DXRmrp4qeCgVQL86Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/6 =E4=B8=8B=E5=8D=8810:04, Nikolay Borisov wrote:
>
>
> On 6.11.20 =D0=B3. 15:25 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2020/11/6 =E4=B8=8B=E5=8D=887:54, Nikolay Borisov wrote:
>>>
>>>
>>> On 3.11.20 =D0=B3. 15:30 =D1=87., Qu Wenruo wrote:
>>>> As a preparation for subpage sector size support (allowing filesystem
>>>> with sector size smaller than page size to be mounted) if the sector
>>>> size is smaller than page size, we don't allow tree block to be read =
if
>>>> it crosses 64K(*) boundary.
>>>>
>>>> The 64K is selected because:
>>>> - We are only going to support 64K page size for subpage for now
>>>> - 64K is also the max node size btrfs supports
>>>>
>>>> This ensures that, tree blocks are always contained in one page for a
>>>> system with 64K page size, which can greatly simplify the handling.
>>>>
>>>> Or we need to do complex multi-page handling for tree blocks.
>>>>
>>>> Currently the only way to create such tree blocks crossing 64K bounda=
ry
>>>> is by btrfs-convert, which will get fixed soon and doesn't get
>>>> wide-spread usage.
>>>
>>> So filesystems with subpage blocksize which have been created as a
>>> result of a convert operation would eventually fail to read some block
>>> am I correct in my understanding? If that is the case then can't we
>>> simply land subpage support in userspace tools _after_ the convert has
>>> been fixed and turn this check into an assert?
>>
>> My bad, after I checked the convert code, at least from 2016 that all
>> free space convert can utilized is already 64K aligned.
>>
>> So there isn't much thing to be done in convert already.
>
> So remove the bit about convert and does that mean this code should
> really be turned into an assert?

I just want to be extra safe. ASSERT() can still crash the system or
ignore the important check and cause crash in other locations.

Thanks,
Qu
>
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  fs/btrfs/extent_io.c | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>> index 30768e49cf47..30bbaeaa129a 100644
>>>> --- a/fs/btrfs/extent_io.c
>>>> +++ b/fs/btrfs/extent_io.c
>>>> @@ -5261,6 +5261,13 @@ struct extent_buffer *alloc_extent_buffer(stru=
ct btrfs_fs_info *fs_info,
>>>>  		btrfs_err(fs_info, "bad tree block start %llu", start);
>>>>  		return ERR_PTR(-EINVAL);
>>>>  	}
>>>> +	if (btrfs_is_subpage(fs_info) && round_down(start, PAGE_SIZE) !=3D
>>>> +	    round_down(start + len - 1, PAGE_SIZE)) {
>>>> +		btrfs_err(fs_info,
>>>> +		"tree block crosses page boundary, start %llu nodesize %lu",
>>>> +			  start, len);
>>>> +		return ERR_PTR(-EINVAL);
>>>> +	}
>>>>
>>>>  	eb =3D find_extent_buffer(fs_info, start);
>>>>  	if (eb)
>>>>
>>>
>>
