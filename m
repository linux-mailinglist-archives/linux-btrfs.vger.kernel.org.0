Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AA5741C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 00:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfGXWyg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 18:54:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:53941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfGXWyf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 18:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564008866;
        bh=FODNZDUXCjf8AKMLSiCVryavuy5o5FIFd/JbBY/Pd44=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EEmxjDAB5t3knBapJ/Q8W/uGrgz012b4G3vB+/l5xaXK8RzHRDb8Ud5+IxM0S/SGz
         qPxqut1dHufnCT6LXVrFLW/A924qJdgrYAjWgmGsAtLDgIkuBL0d35gSg9DRgU/N89
         gF4okhc1cslrKxR3uj6RlMVBXilLlnv0xRHRG49I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MHokD-1hpbjw400j-003aGE; Thu, 25
 Jul 2019 00:54:26 +0200
Subject: Re: [PATCH 1/5] btrfs: extent_io: Do extra check for extent buffer
 read write functions
To:     dsterba@suse.cz, WenRuo Qu <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190710080243.15988-1-wqu@suse.com>
 <20190710080243.15988-2-wqu@suse.com>
 <0c6525ff-63f5-6342-4c6c-2e229d0e98b2@suse.com>
 <47b88874-6cef-4eb2-74d8-5a1f51efa99d@suse.com>
 <20190724160029.GQ2868@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <777e875c-5190-cd6f-e873-f8be1235409a@gmx.com>
Date:   Thu, 25 Jul 2019 06:54:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724160029.GQ2868@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:78bZ36+mupz6WwuP8xSlq+Pa+1CnjTNPk1Te5z0hVZGbcH6fmjM
 Ku0tQcSTsq2Oh/7No7/CivzYolY3bs6paZ4W9kjWmcwgUaKJXiHbo3PYcEcuzYphafX01zA
 +dyAQDFv2QmwTORmyFH8gQhErNuRrlprv3havpaQSL500QS9smhFjzAkWM3cFXgAQ9NYDZ8
 GPZaANM0ar01fWxWJ/UZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U9g2Eg0Nyx8=:TWfF6kjUiu6C7++OK7uTIx
 6bNlGMhIJ4Aoa9FHGECKOGkosS7Ystl4nvpLbUEf69qfQbANtFQrN2PJ6XA1xtca2vHwtvF43
 pQPST/9/f14OXOq846Zxk9v/FYcSqtFRGy6L7tD571TGKpBhm+rGSj0h3q0RoohWSkzV+GXZD
 5N7z7uNzJxwB62B5JFHJTke6y3lytCGLfysqSxbbC6rwa0mZEmIEnNRlCBuvnUqAmd1LOtcUe
 GFrWFqR71heF+UUiRKB9/fL/5n6KHMdY2h3obLxv+prtu6Ww2Htb/1n7tpLCVl1/5WP29mFHr
 mszeVOx6XmhiA5SqIrBduZaZ3eMEQy+wPeNG5o4L3ny9zT1GTtctwtpqJltcKQbtf+l3R2ViF
 Ehba3UTzXWT882Jpj/iXyzTDntrKWukWTYVi5cWttmshLEdamuTI6wZVGwQ8W3vEBN+221i1q
 4MSoidtfH4GUM0baNizTZIrAB0sRpxlVZ7pOjsmfJFkwqALuHa/5tdfk17qk8U/YbWVK5KA8k
 mEoFWCqkkGucrmozzRyg8LkI7vjWNGplzNVm5PuYRHWZOYiEwCVRU++YP5EC4es1JBWZ52unp
 dus8+Bewr1Y5fzlWQDcjaOq1gLhYRnBqHIITw7l5Ml0hhPakUOr2D3IQ0vfjhR2AnGeqr+xTu
 36Mw74ZDIlkQytszfO7E57BU6s90HMiiYMPRv3Bn7a9Ncszc7QmnL2/LyJiQOjoPFCcici1pS
 C80CSnwUU3ii5oozsXFPqMx3LNe5A4RSei2ox5ls4lVDIjqDTiOfZJht+Un5NFfQr9pBehz0Q
 6d0eXsaMi38crFgX9l4a+cYQ1bwHz+epkapv0KAixg0K6PcXT2LpUPO6Xa0PKySZAbUdDBtJ2
 BIU2gZ1XDumCHWq9wB/Uv0YM6Xl3GAMQiHG4VLH39M+HkczCAD+Kni6A3aS2uaFuEVgHaYLzw
 Jl11JnY5u2Yd06N/tnS0iOuLHGoUjKdrCnvinbMCk/fXaixD2EUNVU0eWPa+HN9GGoFoOnA6U
 U3szABGk2OzwGj4oQM9pMssFGuuNDkFk44nqarCqKkWSGKzITo9++MTlfRZ8umDXFlDgYRnyy
 8GJFfDosACn3BB3oEfw7/u+ahyB/udhvkRc
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/25 =E4=B8=8A=E5=8D=8812:00, David Sterba wrote:
> On Wed, Jul 10, 2019 at 10:58:40AM +0000, WenRuo Qu wrote:
>>
>>
>> On 2019/7/10 =E4=B8=8B=E5=8D=886:42, Nikolay Borisov wrote:
>>>
>>>
>> [...]
>>>>
>>>> +/*
>>>> + * Check if the [start, start + len) range is valid before reading/w=
riting
>>>> + * the eb.
>>>> + *
>>>> + * Caller should not touch the dst/src memory if this function retur=
ns error.
>>>> + */
>>>> +static int check_eb_range(const struct extent_buffer *eb, unsigned l=
ong start,
>>>> +			  unsigned long len)
>>>> +{
>>>> +	unsigned long end;
>>>> +
>>>> +	/* start, start + len should not go beyond eb->len nor overflow */
>>>> +	if (unlikely(start > eb->len || start + len > eb->len ||
>>>
>>> I think your check here is wrong, it should be start + len > start +
>>> eb->len. start is the logical address hence it can be a lot bigger tha=
n
>>> the size of the eb which is 16k by default.
>>
>> Definitely NO.
>>
>> [start, start + len) must be in the range of [0, nodesize).
>> So think again.
>
> 'start' is the logical address, that's always larger than eb->len (16K),
> Nikolay is IMO right, the check

No. This @start is not eb->start. It's the offset inside the eb.

>
> 	start > eb->len
>
> does not make sense, neither does 'start + len > eb->len'.
>
> Your reference to nodesize probably means that the interval
> [start, start + len] is subset of [start, start + nodesize].
>
> The test condition in your patch must explode every time the function
> is called.

Nope, it doesn't explode.

>
>>>> +		     check_add_overflow(start, len, &end))) {
>>>> +		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG), KERN_ERR
>>>> +"btrfs: bad eb rw request, eb bytenr=3D%llu len=3D%lu rw start=3D%lu=
 len=3D%lu\n",
>>>> +		     eb->start, eb->len, start, len);
>>>> +		btrfs_warn(eb->fs_info,
>>>> +"btrfs: bad eb rw request, eb bytenr=3D%llu len=3D%lu rw start=3D%lu=
 len=3D%lu\n",
>>>> +			   eb->start, eb->len, start, len);
>>>
>>> If CONFIG_BTRFS_DEBUG is enabled then we will print the warning text
>>> twice. Simply make  it:
>>>
>>> WARN_ON(IS_ENABLED()) and leave the btrfs_Warn to always print the tex=
t.
>>
>> WARN_ON() doesn't contain any text to indicate the reason of the stack =
dump.
>> Thus I still prefer to show exact the reason other than takes developer
>> several seconds to combine the stack with the following btrfs_warn()
>> message.
>
> I agree that a message next to a WARN is a good thing. Plain WARN does
> not have the btrfs header (filesystem, device, ...) so we should use our
> helpers and do WARN_ON(IS_ENABLED()) after that. Why after? Because with
> panic-on-warn enabled the message won't be printed.
>
> Duplicating the message or even the code does not seem like a good
> practice to me.
>
OK, I'll just remove the duplicated error message.

Thanks,
Qu
