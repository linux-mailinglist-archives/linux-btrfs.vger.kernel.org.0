Return-Path: <linux-btrfs+bounces-1083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B91E81A7B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 21:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72DA287098
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 20:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BDA1EA7B;
	Wed, 20 Dec 2023 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k2VWQSZD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453C1DA49;
	Wed, 20 Dec 2023 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703104696; x=1703709496; i=quwenruo.btrfs@gmx.com;
	bh=652STe0TburQeLYtf7tkw0BbO2YX6p6CYDiyUL+fTAo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=k2VWQSZDZ9yJzZOppcqiYGWYEL547OKMnhwYa53rCCLAK5mDpBzq5BdZm0iMTLm/
	 lHoJjepEBpIGS9yAdKsb71YFQdwxBVUVUFGrS3bycnuSk1N5usUm68MNy3PiGOjb6
	 2qOY5f6rLWDaO5jYpUoM5kCa1GmQSLT8RKY6AfwwmE8xkvucxh6TyRU6aVEx71Q6p
	 5sV0W0Lhgy/v765HU8ReKXBLGFjQTzHPex8lbKzbzbwFlk/gIzI5CaP+IFCxhraIa
	 e2ND6tcqeYVWR2Mq3lLFamXuK+oVX55VfPqWybrBlvvCdKVD/4t33tYzTTfzHaBBO
	 FEDugH8yGU4+IkIuvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([115.64.109.135]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrQJ5-1quUTY0zqh-00oWTu; Wed, 20
 Dec 2023 21:38:16 +0100
Message-ID: <15cf089f-be9a-4762-ae6b-4791efca6b44@gmx.com>
Date: Thu, 21 Dec 2023 07:08:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Qu Wenruo <wqu@suse.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-btrfs@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <ZYL5CI4aEyVnabhe@smile.fi.intel.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ZYL5CI4aEyVnabhe@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0keDZnOQqbuOhNrnXD1C606YRph1UNq+xqzm7kvuiwB/INkNb6N
 EmGnnj1cBsLsAdTfQwctG4LXnZASvAwO0TvIjK96lBq2J9GAPB8yRcfLzNew2oNulVO2mwB
 wpIwi8C09upNQtN/Qt8YUjwb7ou7i5k6uiDCzlMBHWiT75Wd7KhFPHnN+7ghahOyeCR9NDD
 mVDmiiAPHASQEAyfD3ueg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FP4uEyVe//8=;/Tfap43Q9bLW+FPMus/5VVqiWdn
 tuTmSz0jkFzq8eEREhv4SUX5VYep0zzBg8LC+hBuJGhvMlc2fe8fqKzseLicFVmblaw6hXVgY
 0lz5xrvyJXOTYwyjZL1yy9c1QIE90Yll1+Ws5W68xWKbZAjTKH4fJeku8NsEdKWPDasg3IqV0
 9Frwllp3cgfQDIAtXRStdWj93cPQMHZNGeHOLpwmeFxqdb8iopxfMeTAw4Xwaz75nJYDhiUUI
 QdNlt5SHNJHgWKdIJQZFcFyne04dsfEpuc7QiKyYD4xgmul6LF9G4UG5765sArsu+juqcrxUx
 0UzdIE91btSvwT7fx9b/egdRM2XyigI4k4qw6gKaCRnAYHE5x6AX4HlAGvzBjLrT5NJvph+fz
 Jx9FonzFqklmukaWHxyxEvglQ/VkKPGz81NHQJ+4IbR2jKPXH300Q/V41tVQw/BT0OgfYQjt3
 6txaWrBfd5+lnQgiwMoM22N70VSYyNj0Z/zOlxPLuBt1rNsvI4gxYRrgRefe1+xRgvG2WW6t/
 xmEzcz4f0dFCPyKRgQPlDcyLDOBIzfgIhJVn+OdbKla8Ob20A2Kvei0OIsyuITwHRulwDUg46
 6VANCpVVSowTkyedqnCwBjsF8cLCLL8OOd+EV2emX5vDSIibg6aec4veMKjY7CWI1YsyJx4Qx
 gkERVCl6sC8JKlJoPL2w2jd9eTdGXWM36ZyikheP9rBMA7P29AcHcMK1NYNTGTky33CVBMSiY
 es4nshyisKNvIFQdvEIPvaEFCXrfw7GEyRigBMhTkGPWndSt3IK8xo7HrWxiSOzPe2PBOq54D
 SKOIMOhYBOzolg7QFyUXg7ceE9MTtEuJUYBDV55nMZOLuZhzqHDmloVEZtz9mnHkU7Umg36Sw
 7SqmHt54Kd151T5WbJ+d13wIlv/6peHGGYgLR9Pu0qpd12O/d4HgfAcyn2M7iwKk4TzTbuAHd
 m3d2xWzOhvezn/Ze7hvCCj1uZO0=



On 2023/12/21 00:54, Andy Shevchenko wrote:
>
> On Wed, Dec 20, 2023 at 08:31:09PM +1030, Qu Wenruo wrote:
>> On 2023/12/20 20:24, Alexey Dobriyan wrote:
>>>> Just as mentioned in the comment of memparse(), the simple_stroull()
>>>> usage can lead to overflow all by itself.
>>>
>>> which is the root cause...
>>>
>>> I don't like one char suffixes. They are easy to integrate but then th=
e
>>> _real_ suffixes are "MiB", "GiB", etc.
>>>
>>> If you care only about memparse(), then using _parse_integer() can be
>>> arranged. I don't see why not.
>>
>> Well, personally speaking I don't think we should even support the suff=
ix at
>> all, at least for the only two usage inside btrfs.
>>
>> But unfortunately I'm not the one to do the final call, and the final c=
all
>> is to keep the suffix behavior...
>>
>> And indeed using _parse_integer() with _parse_interger_fixup_radix() wo=
uld
>> be better, as we don't need to extend the _kstrtoull() code base.
>
> My comment on the first patch got vanished due to my MTA issues, but I'l=
l try
> to summarize my point here.
>
> First of all, I do not like the naming, it's too vague. What kind of suf=
fix?
> Do we suppose to have suffix in the input? What will be the behaviour w/=
o
> suffix?  And so on...

I really like David Sterb to hear this though.

To me, we should mark memparse() as deprecated as soon as possible, not
spreading the damn pandemic to any newer code.

The "convenience" is not an excuse to use incorrect code.

>
> Second, if it's a problem in memparse(), just fix it and that's all.

Nope, the memparse() itself doesn't have any way to indicate errors.

It's not fixable in the first place, as long as you want a drop-in solutio=
n.

>
> Third, as Alexey said, we have metric and byte suffixes and they are dif=
ferent.
> Supporting one without the other is just adding to the existing confusio=
n.
>
> Last, but not least, we do NOT accept new code in the lib/ without test =
cases.
>
> So, that said here is my formal NAK for this series (at least in this fo=
rm).

Then why there is the hell of memparse() in the first place?
It doesn't have test case (we have cmdline_kunit, but it doesn't test
memparse() at all), nor the proper error detection.

I'm fine to get my patch rejected, but why the hell of memparse() is
here in the first place?
It doesn't fit any of the standard you mentioned.

Thanks,
Qu

>
> P.S> The Subject should start with either kstrtox: or lib/kstrtox.c.
>

