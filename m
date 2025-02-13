Return-Path: <linux-btrfs+bounces-11441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BADA3381C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 07:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929A01643A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 06:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22168207A1C;
	Thu, 13 Feb 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uckzZdFR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C7BA2D
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429065; cv=none; b=JDrBwEVJ64OoyI0x/JnBeAadi3w6gJ5J516r/0vuLSrTX4aWg5hBdJL/96WhN1lObDGq4DHK8J0PYt0PYDnqQQGl/pBlxyu4EqerhZtFTuLCde7IMHw9IP55jK+mX8FaNoMSo9sc51jrht0e+X0bBWwFQLPujLy05RA1/Z89sAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429065; c=relaxed/simple;
	bh=Zo8CpryfV1umC2ZEXAStLRgDNI+4PRym/FgWNlecpso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mx+vl1FmbKNQvVzqUKPUXlSdlZfEfZ+lWq1UUT23pw1IYhC78SVdMzX0SN932sL/b7EfyfNaPg4G0sq4DElEhtNTfsMa41tvBBE6zEQ24B6Zat1tiLo+U8xpMKjGe4Mp6qz7Qq4nj02x4Hy0mYTeVU8Xxvc2NOVzA1t2gTJZqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uckzZdFR; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739429061; x=1740033861; i=quwenruo.btrfs@gmx.com;
	bh=Zo8CpryfV1umC2ZEXAStLRgDNI+4PRym/FgWNlecpso=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uckzZdFRmJN3Q7ZH+79XIDtbNV4EiXLcWgqx1ll5wgsvx8LAZUkvKY56jm/M6OMH
	 qncHsMu8l+GhKUE/gO6B9eSZ1nftQUqOCWNLeYR/LMjSetFUfrQiO5e12PypHHLLF
	 idURkxWcOgGF8T57kpufTT+hd2Vk+qUnuzw1y1348V8OFNAVCyDZjqbM7z/SX66KF
	 /9ZUMShY8A3U4JWqxQw5K/ub0pUxlQJF/T944n5pLuzs4J6eWoyEFhHW0yM2Le+wy
	 gOep023dI5FQf7vcAbGAMI7qzZiWmN163N67hKuO8bFCHWsHwpVcP3wlhWnQtVN25
	 RnB0XkyFotj6DBKO7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmlT2-1szoTy0Wk2-00nRXi; Thu, 13
 Feb 2025 07:44:21 +0100
Message-ID: <e9c5e085-90fa-4d09-81e5-19470060e556@gmx.com>
Date: Thu, 13 Feb 2025 17:14:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: Preserve first error in loop of
 check_extent_refs()
To: tchou <tchou@synology.com>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <20250212064501.314097-1-tchou@synology.com>
 <cac8d40a-b631-4c58-b8b8-70db3ab58443@gmx.com>
 <20250212232927.GA5777@twin.jikos.cz>
 <5bc29d35-2eef-407e-9e71-761c05c0d6e2@synology.com>
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
In-Reply-To: <5bc29d35-2eef-407e-9e71-761c05c0d6e2@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JGxzXY99izW1FhF57nJAQIkCEBMrsPowHHGUdXZBuyN6535oJdS
 ntkfU8oNuLI5Z6mPf7RrBO1Mf2dsr2PONghd8JJf7e/r/gj4BmgTRwYUZc/eFWR46HfPqiY
 AjULlcxRLyZ/T4Zk4dWN9r6kTEM0LHIDl62DQgy4U926iUXSgdeiIo7K1tW+xxoY0UVzxL6
 bpgvc2Q5d3ckh8XFv+pbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X/fgIQsRb3Y=;KzqN6ABcbfTN8FyjIjGoi/I77aH
 no8nwgzMT27gYqxmyw90zjH0HAoPk05U/o76og9az7ZhKvl53YuJ0omHETKUKABxfXICnfLS8
 WlRvdSAhvqQmp7ArODY8KHtTKgiZ1DGTri/g9q+70m4UpZ5sI2V2940df1YbMu6OZJGsIosIB
 4mz0I4SdmvojBtcvZEPTFdnTuR7m2WVRsT5RBs41srQR5yA6jCGpqGIsFOvoVZx51QtiwTaTw
 WdrivJGw5uC8qphqCvm9oPfSew5mmsDh/XnYGHG9wj4MeRD6Z3gE4EUlh9ZxjKaD3Np5sY7X0
 ioer6m4MON7AfRc8KQSuS0aThKoLg5hKukviljMajK9onwQwlYLR0QIFvfD31YnyeSV8to4XE
 zDq7Wx6EHJQiZ8h0ubmpVez+NhCfNq4BlMsT+E+AWR9vtmyHXYtYJcQhODH041AWePAU5Ib67
 HGxOWGiELFRE0BoK9JeZPepO1oMh0NMRneb/kjZ2lOwCNkHkHa//7aDRd2U75oz9WDjBocllE
 RXWuWfrZZCHd2JBfXYKr1WZMsQKQL0gOEfh+xwAucamNnihlyq6D9yTUbMtNSJuGMgWO79JhQ
 En8GdXFJpE9x3M40YF9RBYTz3l0UGDG7qFkd1l57wZIcaG07gCI2K6ZWyQI5O9MZgB3kiE4RG
 5c1Tt5PYoiDPIllFSRen/3v7tI7Pffh9awGQt9dvfOYedJ5Ovj/NtnImynGwA8KmntxcZ+cZZ
 vneKZ87QH1M+m7eoYl56U0BQxTEcmKmAogJ2r/BL6GIZsUAH3X8tuZnacOltY6B2ozNCsDW3B
 CADBFSFSnWVhuPTDrMs3RbEQuxdl3SIDGee4U9OnDWntHG/zhOKPAMpTUiDCijs8yl36nm8H3
 L5CN11xA01DL3go5UZsIPMKfpO665uxwj6OWNq0TJAeEZU8aT6AfQ28zsMg7l1VNY2JwAa73C
 EfIm3vVfncrq/Xa5pL2R06m8Ya0sfGc5oEYg+EqeGadlr12Rllc+UwCj56OLnAsvDwECZGEKa
 CFvwFjel6rIXNTYLmIkZeENuBeQY8IzyVygA2xNaoDXf29lDSto+BpeIpSjTW538BLb27NAQo
 PAvoXeV7RqxJPXUZkt93SoxTZJsNt6SDBx1fJJWL7ft6uVunuev1Ot3kqXR4QhOf24xj4/Uuh
 zfDGQyC0SWPWguIrm+WLXNKUDWo4cfG2+EQVhK2q6AJlAArTDBZuScNqnc/DTOmgro7sCJH8u
 2cDf6E//POmFeOts3uRMUlmoLLc0HS7MHHel8OFPZh8lczAdca2fRUBZa6kKbdZOLS1SqOzuc
 M7B9T9IkP4boC0sCHoN57Vl47aMh9yKjHZNuebGoJ2UAq7bVkqPVYHsiLLjdoLoXknl4S2/ZF
 kcQgPafusq1zuRyf//+HO3vIZYUVZIxOZ6s64=



=E5=9C=A8 2025/2/13 16:39, tchou =E5=86=99=E9=81=93:
> David Sterba =E6=96=BC 2025/2/13 07:29 =E5=AF=AB=E9=81=93:
>> On Wed, Feb 12, 2025 at 05:44:57PM +1030, Qu Wenruo wrote:
>>> =E5=9C=A8 2025/2/12 17:15, tchou =E5=86=99=E9=81=93:
>>>> Previously, the `err` variable inside the loop was updated with
>>>> `cur_err` on every iteration, regardless of whether `cur_err` indicat=
ed
>>>> an error. This caused a bug where an earlier error could be overwritt=
en
>>>> by a later successful iteration, losing the original failure.
>>>>
>>>> This fix ensures that `err` retains the first encountered error and i=
s
>>>> not reset by subsequent successful iterations.
>>>
>>> SoB line please, otherwise looks good to me.
>>
>> For btrfs-progs teh SoB line is optional, I think it's mentioned in the
>> README. It makes sense for kernel to insist on the attribution and some
>> trace to real people but btrfs-progs are much smaller and I think it's
>> better to lower the contribution barriers.
>
> Thanks, I will add it next time send patch.
>
>>
>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks, feel free to add the commit to devel.
>>
>
> Do I need to send PR in github of btrfs-progs, or maintainer will add
> the commit directly?

No worry, feel free to use either/both mail or github pull request.

We can handle both at merge time.

(In fact, I send mail for personal accounting, and github PR for real merg=
e)
>
>>> And if it's a case you hit in real world, mind to extract or craft a
>>> minimal image as a test case?
>>
>> =C2=A0From my experience, casual contributors will rarely write tests a=
nd I do
>> not do that when I'm sending a fix or reporting a problem to other
>> projects. In order to keep the track of that it may be best to open an
>> issue, unless you or me will write the test case.
>
> Not the real case, but fake case by modifying the bytenr of extent to
> wrong number when test the correctness of function we develop with
> backref check. I think every backpointer mismatch case can test it.

Thanks, let me try to craft a minimal image with this method.

Thanks,
Qu
>
> Thanks, TCHou
>


