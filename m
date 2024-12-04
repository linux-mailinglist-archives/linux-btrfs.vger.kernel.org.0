Return-Path: <linux-btrfs+bounces-10051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB6F9E32A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 05:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41C4B23692
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 04:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3D155A52;
	Wed,  4 Dec 2024 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gUa1M/Qd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3B219E4
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733286233; cv=none; b=oVA/d1e0ZdSVXTo+K9AFauroWUUapkwtyd7fEVBf8n8NXJVP4WNbj0vDRnfxduQk1wWNY21GNn+u6IX3eZ/nPdjgYO1krWL4DR6KNp7JrdmONBrOyi6/BAnyjE3lfXJBObpfsa3jwSmnZ/cE6ZS6T5bLLGojNWOPLTYAgYZDsUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733286233; c=relaxed/simple;
	bh=fJrXHt2bLPUrDxLlRpZpm7Aw6Mqxx1qnWHT7h1Lw1xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HQfKLwZmisqtoiOUl0f3A8NjXw/5OLAWeRAp+TbNJRWFWcE4gu5iz3vzP9WWH7XOu3FnDX+BODaynK0L31ErO/XYIq4R1uwp5/WKEyQmrPGaXWgOk/EJV4ZkEwN9GWSglwkNZbEKuaTwC9xpcvujBziGrNFhu3B9aRavxd1jtu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gUa1M/Qd; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733286228; x=1733891028; i=quwenruo.btrfs@gmx.com;
	bh=fJrXHt2bLPUrDxLlRpZpm7Aw6Mqxx1qnWHT7h1Lw1xU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gUa1M/QdYTOkjR3BNtCggH73lNoI8rxgJExcJB5z+Ol7eFF+Usi0GaEprtHvRNa4
	 rChDb/HbjqfCZeXBuFAKmVKJuDprDC0sh+NrdWfhc9B4Jm/a2cz5S/qmCGEiVbw34
	 b+CUh92Ds7YKaTYqWZsd5qkEn0w5NO7xHYbZAhdccsehtPUnDBER+2VdONp/gaAVC
	 ur1WzSkcYopMCpKTQ5Fc0kj4pfrQXvDN4G16GWhH5DnRPlptFemqchDjf5dhYNazd
	 MLP66NTfHsTpCzKUsdA0Llok53uBYPatwWjGo+G9pZNkFF3uodw5fB2/bT06Ulo31
	 K+0N0bRnzAlV8wI9pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvcA-1tEEw00TGS-00IPlE; Wed, 04
 Dec 2024 05:23:48 +0100
Message-ID: <3fc16982-4f69-4b78-95c7-35964d6fd1e0@gmx.com>
Date: Wed, 4 Dec 2024 14:53:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree or chunk allocation
To: Nicolas Gnyra <nicolas.gnyra@gmail.com>, linux-btrfs@vger.kernel.org
References: <207033eb-6e59-45f1-9ec5-09e63eaa4c70@gmail.com>
 <f404a687-cd6b-4014-b2fc-0f070f551820@gmx.com>
 <e9544172-ef74-4a65-b14f-8d3addb957d7@gmail.com>
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
In-Reply-To: <e9544172-ef74-4a65-b14f-8d3addb957d7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NQzkNeSfBlsXKJFcbwvHYE/tRehUMdeEp5aeSWvW36oh/WU3W80
 NrXiT0kwtW9iQ++VgM0AvXwVq6wnUOi4C1lCi05wNTuWZfB0Fw882AsC9BD9F/Ft3qlIc3x
 UrNUjy98akkn7YlKcr2/uF2DsX6tEM0NKvqhz+AQJVT41vUlo8Km3C45fdxzncqzcS4iJPA
 u7TvsoFe7Tci8uHC6LAeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5vBR6I+Su4Q=;2ib8hp2H+gwv049NSVVEMa3nrsC
 zOu8zmYQ/oKyT2QHkpWtud6jOF7wPf56L5+9L8Z0TSSdSLqRwy3BwhiZzPMFga829FYFhskEw
 j2FD/Bze7y26ZJar0wUTjQG3v2bEekhzYsaCy86OMTgbxShFNjLPpgonVdV/rWfNBNgQwpnHl
 U68uQiOgaV9OQ84EoUG4VZA+ZCwzDhISzuF2M13GMGTn+4LMUemsBYs5l+Ed5b8H8YSdRiqO2
 cppJNZUyJJKTvPqlISNBVFz91l7v6OQ+PDB1Nn3u0Swh+sre0y7trtimmxXwkSl052o4NlOMs
 mv8uo/UoGEeH671NBvGBLWJ1RC2BaBIn6UuPNy3tO1OrC4ycwwYWpKSMjxQkqrb0G9P4RzZS/
 /VTNN+MVh1U/JIURee6ieYWCZXxYOubei1wQgJdLafZV0kV02EFyTAg7nxS+ZrmJkItd2FwaA
 JDOFOY6YaMoZx/Z3p4xasgTRhe9ZSC4dRlLnZzIA88cveQDTdFT4EcIL5Atu/5aZft2Xq9IZ5
 mxgQSOoKKvx5r80RK+uL1qoxINPb8UHpB9vmv5Rp/BoSyfoJT/zmkWE75Nrfdo0S46UAdjnMx
 vYpKpudmGW2pI8S9kiWVKQx2UiAe/q1CwnNReK4V2m+GUMgQaEF+373CNWSnJoxClzNWXOIXW
 qptxA5z+ZJVdWvtFzy+6z+CrdxlV/c+PACudRyit6tz5vGeaNwSIAIKD0YoZMSa/FXvc/1Kp8
 WO7EJDqWdCSAqqK/wMZB54Afetj4wwxi1To6W9mHxt1zJJOVe8zGxH64CIyfmS+BXd2bTwAO7
 8U0OtWNlYrsnUvRI1W/B3PSrblVa26Ko+0a89SMI16rdh6vVSagpD00rDK3wlL53AmONgI1NW
 iDPhMudVAhoKTDsb8BcXfm+2kTwCiSiSVhPE4s75cjaUGXW4UOr0zsc/RX2m48UOQTTde5nrX
 ZBeAlqzpqgPfL2/8E99WpQO/mRxi3LfU2KvrBZegmdAD4HkcjH/fTN0Sj15iT+t99BN/Vsom4
 i5b0n93iBqNp1uuNRjaswkHYIBzzca5fnzMI+cZFNoZ04DzX3/tnfU9boVKh1ZHKu8xT1dJCb
 OY022XnBeHFpUmNAHSQWnLLAl/TDTH



=E5=9C=A8 2024/12/4 14:28, Nicolas Gnyra =E5=86=99=E9=81=93:
> Thank you for replying so quickly!
>
[...]
>>
>> This is a new corner case we have never seen, thus I'll send a new patc=
h
>> to handle such case in tree-checker.
>
> Ah okay, interesting! I'm glad I reported this then haha.
>
>>> `btrfs check`: https://pastebin.com/7SJZS3Yv
>>> `btrfs check --repair` (ran after a discussion in Libera Chat, failed)=
:
>>> https://pastebin.com/BGLSx6GM
>>
>> In theory, btrfs should be able to repair this particular error,
>> but the error message seems to indicate ENOSPC, meaning there is not
>> enough space for metadata at least.
>
> Oh, I just remembered I copied a rather large file (just under 400 GiB)
> onto the array while it was doing the balance without thinking about it.
> I think I had around 600 GiB of space left when I first started the
> balance, so I might've messed it up by doing that?

That's totally fine, and it should not cause any problem.
(As long as hardware and software are working as expected).

>
>>>
>>> I'm currently running btrfs-progs v6.12 but the balance was originally
>>> run on v5.10.1. Is there any way to recover from this or should I just
>>> nuke the filesystem and restart from scratch? There's nothing super
>>> important on there, it's just going to be annoying to restore from a
>>> backup, and I thought it'd be interesting to try to figure out what
>>> happened here.
>>
>> Recommended to run a full memtest before doing anything, just to verify
>> if it's really a hardware bitflip.
>
> I started Memtest86+ ~3.5 hours ago (it's on the 7th pass) based on a
> recommendation when I asked in the IRC channel; no errors yet, but I'll
> let it run overnight at least and let you know if it fails.

Just in case, have you tried memtester?

There used to be a AMD SFH driver bug that causes random memory corruption=
.

Tools like memtest86+ are doing its own EFI payload so that it will
detect problems caused by kernel drivers.

Anyway, 7 passes already look good enough to me.

Then the cause will be much harder to pin down.

Thanks,
Qu
>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks!
>>>
>>
>


