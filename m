Return-Path: <linux-btrfs+bounces-12806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C27DA7C599
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 23:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DB8189564A
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 21:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7365621507F;
	Fri,  4 Apr 2025 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nNc2AyZJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6468514831E
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802652; cv=none; b=Dz4rglhf6kA2XDcCuWrtn/ba76XuxxI0u6mV1fpf0BsDt5xdNmD1940VuVWlAykhavrOjk/uBftBIcuHz57nt51hrdYyYLma0DbT2kYzmZkd8slY7jq9KlLe+/QHAhVjq5JBk2zYlMTClSCMSxSbSI22KPKugN+CEae4+P+R71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802652; c=relaxed/simple;
	bh=N6JHxTxEwGZ9KY1+ci53kRcuq/17F8GFhHCU06i7rGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CV2gWtb9fsULQAU1IUVOf2xLR789GbKDDeB8vhKUO9mw+hx0DeNekFB741tt8jvIUuhiLbFcD2b9Tj1X/OldAaxcw10tUC/cGYscp/Oxh/NZD1P17bc5gXUdvQQL15YnroX3BPjPC/QvlWLc7YeKqGbHw1KJnQbiJukiIwsHfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nNc2AyZJ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743802648; x=1744407448; i=quwenruo.btrfs@gmx.com;
	bh=N6JHxTxEwGZ9KY1+ci53kRcuq/17F8GFhHCU06i7rGM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nNc2AyZJ8obyW/8ml1OtKKbpgX8CftQQsrCjlakLI0JbpsSyXPT+hyRlXDkphU+3
	 pyXZTCQJIwDG94WJ5Bc0G6YdhfSyDVpR8T5sTXjxtPTY7YDx3qKI4fjRW8WBO9Ae2
	 cHYsLNOtVlPJ9syNZZ3QrwwDlrzSZPVNMwwxf9p8C8/Fxnm+GZMIVyxH/ta0NY0Us
	 UihBGLMbdM8NaRVbt4FpQfBJ5F7wpdWI2UC4BZdFyf69yVqIvCFPmzjSacKvia494
	 IQIz5vmVvZJt+oHcvjtkv59pP9otIwWuhAarBqoBtPP+cyRGb5AYYdtiqYZqy06kr
	 Cm846/8zDhFIXVdU7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1t1KDv3s8m-0121gP; Fri, 04
 Apr 2025 23:37:28 +0200
Message-ID: <7798ba7e-74f3-4ee3-abf3-da2fcc68802c@gmx.com>
Date: Sat, 5 Apr 2025 08:07:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: A lot of errors in btrfscheck. Can fix it?
To: Fernando Peral <fperal@iesmariamoliner.com>, linux-btrfs@vger.kernel.org
References: <CA+n7ozwhzdWs=KaBQh2miNwPwYxqBi+MEb807kddGNUZAOyNEA@mail.gmail.com>
 <ad298eab-b9c9-4954-beb7-fc09b238ed23@gmx.com>
 <2992e93d-ebab-4e00-ae9c-58bcbaecf690@iesmariamoliner.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <2992e93d-ebab-4e00-ae9c-58bcbaecf690@iesmariamoliner.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NN72x/XZms8k8bQRS2rL02+DP+MVPOosVTw+EBJvv9jg9sTGFFC
 z0DGXT2yl7o2KbIh8E5Mj34pzLMtWTVDbX5YTSC+7SlTc+boIlD7U896gts4Bhi5GucX8M6
 u3XzlxzTUH91uNGGdWqloAukdk4GAk9pvQmuAMVZOW83OKg3f4DCcwrl9dhMFpvnU5rsKze
 lq7Q4yPNn7qc6ETZTuwug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NkjdYNVl244=;LfXsD+mk/Cdfnpau+TNm70moHKF
 TCLycRGpl9wWW//bcBVz4Ge7W2SLmBSQi+WB/Zm127M+MIB4IMfCrvJJEMGBzj2/+us3AI9AW
 CcY+mTvsCX2hI1jVGeFm3/fmreZ67gi5V+45HIQegIeZ62ar5SS2hPNLK2R61RnjTGLb2vJyw
 ONEiXGBYUo6MZxhYm1x7gIrUJCIdB0pQusMDKXlmBBRX/V97fpKxMmNkTQYadrksBhfN1doVt
 cZS4Aw4C09qv22uekU8epguYf2iKahJ7zlddfdL6znsJcvcHSdHoqTKQp4Ftp7rZgOEKqCKqn
 CKwbS9CxZQs9kkKxk9JyVLqSd7pmVkTQw2bpsffF+k9Ta8mKsR/ZEoIysdjOGk/1YvRL/X3qN
 Qk0p5+ZVTUZCr2QdUEiESvipozn8AkcllTi9XDZPmZXb4M2KO412Btl62rwvsw49ijivMjTqL
 t9kBpbE1jLhfDps+SVChS7J74C4RC2emsxjZdESxsRj+Un+feWXMpL0li2OvWjk2/Xei76FVj
 BSppMqe2+Mvy6gU77YCo3mHQzJ9rAWweao8oDWBrWcj5dqjGw0acf4zMtOtcT8KicK5tSohpd
 LRR2rjp4oAjjIGB1hOY8eq06unWVSCIVcmiozjA8ADf4ROUJcAp/uwDJJuiRmI9Inj+7/UFC0
 PWZd6bH5LD33VQ8i+Y52Rh/I31BmcA5xEQ9zsyvR3rry4IRlPeG3ZXmRDIx1mWu075gLgQ+MI
 4oW1vDf7rcd4Lcn5q38jtPYynzIPp1BzHzL7SfPmbQJmxzrg8JqcZ9JyhKpEgHeH5y8KQwszg
 vWbLH783gjqzsXJgbLbBbgGf/AhphuNxh7uI64w7QDLwycqoC9Dlzw8Ph91XTJHsEbJjS1Ou2
 JNdP2EM24/qkTrB+AR99Y6zb7ou9Q7wooAX0I1Vic9UbktzvdKAv/hlgQ8smbtTo4Vepe6Pcg
 shr8gJTKSssboLNw5nABUgXSllNd2Vo5bbXBh/RHunBespf9U9OOjR0Woh8cHxS6IDc2KlUvB
 cR+sCpiftIgOojnoB+i52fW15K+XTVUPgZ4GDGjmmn1MmmPMfY5jFgZFcl5N8VYQo5PBr28m7
 qPnjOdhBQCoBB5/Kv7If3X1dPVhKTlBBfSvQhgrc/HYxMEEbffW4UgGcWo2z381iZebUlvs4L
 t1DGK4Jnh+hxfUxjGwLYUkGBkzdRcpUy2RC1k8UNaNL9zgHTPA8MMMXZQm9bgjHFFPD7tT8FY
 yE8UkUZ1jnh7xcm5ghlIO/oCf0568dV1oKrxOtcWGgRKqeEPnAe4QDftH/weviOOZmiJyKWMx
 qD5wQERd6gRa9WEta/MmG+r8+1JfrHfpXwA/BJuuUx1LEGmVKH1YnHfThrLC+MdEaTwEpJZB4
 T+/S/Yh8wb3WJ6YJHcFamQxjPMFl5RDekk3RjTL7GPsfVsjYS8YDkZqjC53WT3iCNRbzzuLjG
 fBCnpyw==



=E5=9C=A8 2025/4/4 19:58, Fernando Peral =E5=86=99=E9=81=93:
> On 4/4/25 09:54, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/4/4 09:00, Fernando Peral P=C3=A9rez =E5=86=99=E9=81=93:
>>> Opensuse leap 15.6 with btrfs in /dev/nvme0n1p1
>>>
>>> one day fs remounts RO.
>>
>> The first time you hit RO the dmesg is the most helpful.
>>
>>> =C2=A0I reboot the system and all works and i
>>> forgot about it.=C2=A0 Then some days after it happen again... and aga=
in,
>>> and once each 1-2 days.
>>>
>>> I boot with last opensuse tumbleweed rescue system and run
>>> btrfs check /dev/nvme0n1p1=C2=A0 > btrfserrors.log 2>&1
>>> file size is 7MB (72000+ lines)
>>> This is an extract
>>> [1/8] checking log skipped (none written)
>>> [2/8] checking root items
>>> [3/8] checking extents
>>> parent transid verify failed on 49450893312 wanted 349472898974925
>>> found 820429
>>> parent transid verify failed on 49450893312 wanted 349472898974925
>>> found 820429
>>
>> Although you have ran memtest, the pattern still looks like some memory
>> corruption at runtime:
>>
>> hex(349472898974925) =3D 0x13dd8000084cd
>> hex(820429)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0=
x00000000c84cd
>>
>> BTW, the 349472898974925 value looks too large for a transid, thus it
>> may be the corrupted one.
>>
>>
>> Not sure why but the lowest 2 bytes matches, maybe an indication of
>> random memory range corruption.
>>
>> There used to be a known bug related to amd_sfh driver which causes
>> runtime kernel memory corruption.
>>
>> But it should not affect the openssue kernel AFAIK.
>>
>> So I have no idea what can cause this, especially when you have ran
>> memtest already.
>>
>> [...]
>>> My questions
>>>
>>> Can the fs be fixed?
>>
>> Nope.
>>
>>> Can the copies I have done be reliables?
>>
>> From the fsck, at least csum tree is not corrupted, thus the recovered
>> one should have csum verified.
>>
>> So yes.
>>
>> Thanks,
>> Qu>
>>> Thanks in advance.
>>>
>>
>>
>>
> I had the memtest running about 2 hours (two full passes).
>
> You say it seems memory error. Then it can have been caused by a "one-
> time" memory error (or one time whatever error) or must I search for
> some fault in my hardware?

Kernel modules have full access to all the pages, and can corrupt the
memory if there are some bugs. Just like the amd_sfh example I mentioned.

In that case, it's possible.

But that can also be exposed by memtester, which runs as a user space
program, mlocks tons of pages and tests those locked pages.
This exposes all those pages to the same kernel you're running, thus if
it's really some bad kernel modules, with enough runs it should expose the=
m.

Thanks,
Qu


