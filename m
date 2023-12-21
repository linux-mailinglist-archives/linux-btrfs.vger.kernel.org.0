Return-Path: <linux-btrfs+bounces-1109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE93C81BFA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 21:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2AE286882
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B370976909;
	Thu, 21 Dec 2023 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KAF7RoIH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A87760B8;
	Thu, 21 Dec 2023 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703191059; x=1703795859; i=quwenruo.btrfs@gmx.com;
	bh=y3Vr8OBtrbWu+WuJeurEbVDD8rmpE0rQqeZ+az136S4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=KAF7RoIHzH/b5qFUgA+Dfl3g9h5dfdtt71Z8fPO/T1bzpQsEjmSXV/jmamE7BtWF
	 h4UlDhBoxosc9b9tH3GL59b9Fcn7N/cBYL6X66u/tqW3JoP8OMVfc2PezmkSVopM4
	 UTADmxwnehUDn51dKZ8ORBHP3Ct21P8U+rgoMCJFaIvECeGa17li9wgL2ehK5/X/S
	 IAL/BaaS0Foe/nT7c4GhZZeuKdnA+rkDjddQunvNhQ9lIC3nB30o5qVAPwi7l2N4g
	 /QLQR7WmY1nmYYBa5uX7mJINjz36+DC6gAK9V4KXeh8Fa0uuvnrrxSHshCbclasaF
	 dySipGkKrRhupI0LWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.114.154]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7i8O-1rCTho1TEY-014kTT; Thu, 21
 Dec 2023 21:37:39 +0100
Message-ID: <cf3808eb-0c8f-4a51-b2b4-14eb33b88992@gmx.com>
Date: Fri, 22 Dec 2023 07:07:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Qu Wenruo <wqu@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-btrfs@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <ZYL5CI4aEyVnabhe@smile.fi.intel.com>
 <15cf089f-be9a-4762-ae6b-4791efca6b44@gmx.com>
 <ZYQo6DB4nQj58iUg@smile.fi.intel.com>
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
In-Reply-To: <ZYQo6DB4nQj58iUg@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:prYbZ8LRirqClbMpjl5VPjbCQZysSGPZH4h5iyrtPoDhxhED5t6
 QG3cDeBVLMXnR5BbKfLjouNJOshEYG6R9FvMcvti1Bl3jadh6fpnFnsXaa6vWeuXehdUVza
 0JPFXKv0mjsLRM7DLQlMQowy3P3pzhL83q07x3oYSMvEqNOTQ6d4wGK43kaybkZgOIR5als
 GZAiWIMBpR6iGR7RjS/7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GbW1fzBlwX0=;l/cwhsbPb7rI4LiBqzNGTdYV+wk
 mqbfQ2nh7gq7uhml8zPFSKUjhGE41yqxCgEJ4AUaC7OIYZtKxZKMFfADaX+VKNb3AXhIuWWGi
 paRNZA6YF3w9M0MxeXsA3lfDz3BujFhgh0NY7ft/9cg5uxzSwg15Ke1p/g5M9hHcfO8XAkZg3
 MWGO5zDAedcrvn2euPl9kkejNpJ1ZvQglX8IWKaxuYYtL5FECbQPG5YIk0j/GeIbcbN5pXhwV
 mMIUR8ymyynFHrhx0+oljxANPtu8ScUFYUVkv1ateTPtVxTSstrCY5VHADsgQcJFKJtzyH/2A
 PdH7cOSKd9ksX32bjAVgQK5ONiPzApvmzgrtCeQamKb1JEa19jShufBk0DZ3O5hsBsXtoGnp6
 FlIkN5LSZfxTARcnPczET0lEhYdrni5KcISKSuJUJ00b0v2xvpStUco9J2aSWJOVhASwQUiZu
 RPu90Om1O2PUDEVqSkWtafIs/EB8zIFQWDwqsQ9VEKAL756PNfuI+w9Ada1fE0qTZdIFjw/uJ
 fAxVWUZkzWnOq6lE8SZLhu20sYIhDaOq3S7DJuT55KrSjeodqerT8Z2ei/cs33u4x96nd5DML
 aJNtL/DwnGpH4HmcZ6FYahzi5vSuoiF6PLKQgFOrKJCwQDYnWLUG5ZAfyJO6A3xTQwXkPSpbw
 LBgwDR4YmTR1GhCyiO9LTMnR8QtName86H96wSpkg37MOBDyjhSxYiv2immsPT8NK9F+fPm2Y
 A7PtJQDH7PYZTTqueVix0dd+kc4Hjvir8ME1PedUbFzHu7fteqODWRK3BUgDibOxJkv/AkuPQ
 RErsUh+DKNL05VNCYuTDfGXIJgxO5yE/vzNEWcXJFu98ZslblqxGFn/cnVZo6wdKoxnpfUPbq
 X9PGezyECj/neLbcgQQ+cTtMMhTDY/BEV3NJUVgSmZ7duVUgSKNrtBTkv+fE8v9qezt74om3e
 7nGMj1dCPrn8ljDUpCG11d0j7/k=



On 2023/12/21 22:30, Andy Shevchenko wrote:
> On Thu, Dec 21, 2023 at 07:08:08AM +1030, Qu Wenruo wrote:
>> On 2023/12/21 00:54, Andy Shevchenko wrote:
>>> On Wed, Dec 20, 2023 at 08:31:09PM +1030, Qu Wenruo wrote:
>>>> On 2023/12/20 20:24, Alexey Dobriyan wrote:
>>>>>> Just as mentioned in the comment of memparse(), the simple_stroull(=
)
>>>>>> usage can lead to overflow all by itself.
>>>>>
>>>>> which is the root cause...
>>>>>
>>>>> I don't like one char suffixes. They are easy to integrate but then =
the
>>>>> _real_ suffixes are "MiB", "GiB", etc.
>>>>>
>>>>> If you care only about memparse(), then using _parse_integer() can b=
e
>>>>> arranged. I don't see why not.
>>>>
>>>> Well, personally speaking I don't think we should even support the su=
ffix at
>>>> all, at least for the only two usage inside btrfs.
>>>>
>>>> But unfortunately I'm not the one to do the final call, and the final=
 call
>>>> is to keep the suffix behavior...
>>>>
>>>> And indeed using _parse_integer() with _parse_interger_fixup_radix() =
would
>>>> be better, as we don't need to extend the _kstrtoull() code base.
>>>
>>> My comment on the first patch got vanished due to my MTA issues, but I=
'll try
>>> to summarize my point here.
>>>
>>> First of all, I do not like the naming, it's too vague. What kind of s=
uffix?
>>> Do we suppose to have suffix in the input? What will be the behaviour =
w/o
>>> suffix?  And so on...
>>
>> I really like David Sterb to hear this though.
>
> Me too, I like to hear opinions. But I will fight for the best we can do=
 here.
>
>> To me, we should mark memparse() as deprecated as soon as possible, not
>> spreading the damn pandemic to any newer code.
>
> Send a patch!
>
>> The "convenience" is not an excuse to use incorrect code.
>
> I do not object this.
>
>>> Second, if it's a problem in memparse(), just fix it and that's all.
>>
>> Nope, the memparse() itself doesn't have any way to indicate errors.
>>
>> It's not fixable in the first place, as long as you want a drop-in solu=
tion.
>>
>>> Third, as Alexey said, we have metric and byte suffixes and they are d=
ifferent.
>>> Supporting one without the other is just adding to the existing confus=
ion.
>>>
>>> Last, but not least, we do NOT accept new code in the lib/ without tes=
t cases.
>>>
>>> So, that said here is my formal NAK for this series (at least in this =
form).
>>
>> Then why there is the hell of memparse() in the first place?
>
> You have all means to investigate.
> It used to be setup_mem() till 9b0f5889b12b ("Linux 2.2.18pre9"),
> which in turn was split from setup_arch() in 716454f016a9 ("Import
> 2.1.121pre1")... Looking deeper seems it comes as a parser at hand
> for the mem=3D command line parameter very long time ago.
>
>> It doesn't have test case (we have cmdline_kunit, but it doesn't test
>> memparse() at all), nor the proper error detection.
>
> Exactly! Someone's job to add this. And the best is the one who touches
> the code. See how cmdline_kunit appears.
>
>> I'm fine to get my patch rejected, but why the hell of memparse() is
>> here in the first place?
>> It doesn't fit any of the standard you mentioned.
>
> So, what standard did we have in above mentioned (prehistorical) time?

Fine, there is no standard in the ancient days.

Then what about going the following path for the whole memparse() rabbit
hole?

- Mark the old memparse() deprecated
- Add a new function memparse_safe() (or rename the older one to
   __memparse, and let the new one to be named memparse()?)
- Add unit test for the new memparse_safe() or whatever the name is
- Try my best to migrate as many call sites as possible
   Only the two btrfs ones I'm 100% confident for now

Would that be a sounding plan?

Thanks,
Qu
>
>>> P.S> The Subject should start with either kstrtox: or lib/kstrtox.c.
>

