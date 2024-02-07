Return-Path: <linux-btrfs+bounces-2220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE184D561
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 23:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D171C25828
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 22:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675CF136667;
	Wed,  7 Feb 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="L5s446Kg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8CA12AAFE
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341427; cv=none; b=sDJX5/f2caDMdvPJlSKk47qpMnEyH333Imu1rH+nT7CISc5u1IXVWZju5leQOcHUJ3wuhYFD7nHC/hO7mVuaZzQYz6G/GOwOzxmZLh4i5N8bOK4osuIHvKBMXm4oRI3tfqh4pvlNpO5iyc6ck2caw+6WXTS+dzaSZz2rEadTgN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341427; c=relaxed/simple;
	bh=ugBZJm4iJXIRo6mlz1P3s/t8gtQx+ykMPm+/kgWUwKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFQJ14L4e1Y4v6KPvcE1Z8Cf4RMVdq4jAYSBkUhf5GUDnLe+yReB2fOhGf4y/lR/evE1pV1mRmSrZ38XVmQAF0uX2ZWBsVICT9RUL64ziQrXknYSJ9jlELou5Vmmz6a1/JgfY8x2OCGh1H+34V1pVf7EgfINdeHlwG4sJGst1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=L5s446Kg; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707341423; x=1707946223; i=quwenruo.btrfs@gmx.com;
	bh=ugBZJm4iJXIRo6mlz1P3s/t8gtQx+ykMPm+/kgWUwKA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=L5s446KgSsE9R8bsmY4vV/nwUt8OO28zyTUInaBB6vBd8l60bw82/c6vtSOdpdRe
	 LgLd2iN/bg6tjR6gLEvM7Wwd6F+LnoL/PdBMVDdL+r9j69fIddTJqMQWSDfrtmv+l
	 SX2eKepDSeMGM5ASBGCNDhrKhGUv5MUeaKM3iAmQy6Nf7YvHzzqiI0DZldY9C9B/5
	 8FFOgg59Vjg3jOb4GkRRksojRHhS35exTHgl+zVRQDcQJE1ZznglAeVaGLTGSSEWB
	 nps9C2lYlj/FTGhfyI35SHLqhE93XhizBqHPxXR9JCCiVQIgHJZqJ36O+xC5QLaWt
	 I3gLb2zd8A8GbYfquw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNswE-1rMkjO29sm-00OIou; Wed, 07
 Feb 2024 22:30:23 +0100
Message-ID: <c83be841-acfc-474b-a4bd-6383957365ef@gmx.com>
Date: Thu, 8 Feb 2024 08:00:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to delete/rewrite a corrupted file in a read only snapshot?
Content-Language: en-US
To: Marc MERLIN <marc@merlins.org>
Cc: linux-btrfs@vger.kernel.org
References: <ZcKEoftmxxp3SOiB@merlins.org>
 <07bc2e91-0106-48ab-b07d-f54b75e9a991@gmx.com> <ZcP1L5SUXNrB_sp_@merlins.org>
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
In-Reply-To: <ZcP1L5SUXNrB_sp_@merlins.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aMfKNoV/hrc+BOZ5GFy9Y1KVdtDdoL/3rxZVFuV5zS/2YFGe9x/
 LrFDTwevKJ/NImXb5hla0lT2lKku4K/PtJ8+jmUEQgbrrPBTnmxQWJnde3TsFXtva/gc1jl
 /PcxlTs8LygKfqYnHfo+7JROwiUXZu69G/6YlFhpT4wYuPx3tJiRvbG1Y+kBHImCuXsvHCa
 RTqNV4bwT1wJW6jglCxsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wAZOqJJ3jDQ=;pfYHPo/TURG0VcKEnwKSRop11rX
 c2xOSYMEq0KTQp6smSbsWPdhh9d/RGVXkLSRGnhB+9MFWPTfA9jWM8RD+Jtc7GKTOtakePjLc
 f3sL0vp3Gag9UAOpZtQ9S7vjxaATdMDNwYEjH0LWhNoXemRuCI65rotdPNxMArNI0lTIUUoze
 UHJiOM9sH9Kl7rLxpB9z1bwAucxS1Gq0rrZklyhymPI85hNRS98PPL7OOaa2blPhgfxu+pl4U
 +hU5F8XUO+Wt1W8kkmxTxKfLENlxdcG4sQj4JPriuBQMH2zYihYypSVNe6VB/bBvfuIWY2S1N
 mmbFROa+Hwi8MH0KCIEiOyGhG9+uGg/sVeu/+RHbTwPDD+iHpNQ7HVQkR1ldDnHP6/DAMCep7
 /onb5EMxPNwTty8PCyC5j3pKWtwBBJkMnDUBiUtlqXpfWRbkpvn1/hPqFqvZ3Dm22ISCrvMP6
 DLh9Z3aK2GRJsgxkYVyx1aG/2bh6Cuamg5g46nzUk9FO8uU2XoYh6Pm0TLwWUNJpgejzq9TBB
 HyT/M0w8gS8gm1joyh24rc8F4ck/nL52PZis/cCokrU9nTtP2ockpLSbvLes+J/UJRygT3L6b
 FcP3z5fPRaNshVmpdjU49ptgBo+BJBUG6SS6JGMNG6Ffvq+RcQUX+QxaMMWeNj4wM3t2vHVRW
 HAPXWwfEjxtG0Df9J0j7SB5/onvV1qvN0leQb4tsdD8LA3oBfkNkdMpUk6Ovg6/ncBhRhQ2KP
 C6TJT5lr76jMEq74cznx54XZ+41L/Nfn4M3nMlEyEqI93A8RfxwUwXfnfT9/terI8/fBoKPE2
 7jsNPPzmrKei2BtvVIT8hw8reYIpx0CbuRl9ejsoBoACU=



On 2024/2/8 07:55, Marc MERLIN wrote:
> On Wed, Feb 07, 2024 at 03:37:04PM +1030, Qu Wenruo wrote:
>>> can I either
>>> 1) force delete it with some admin tool
>>
>> That would break any later incremental receive.
>>
>>> 2) even better force/overwrite it with the correct file from source?
>>
>> That's possible manually.
>
> If I change the snapshot to readwrite, and cat the good file into the
> corrupted one
> cat good > /path/to/bad
> will that work, or will that allocate new COW blocks and do weird things
> that would break later brfs send/receive?

As long as you changed the snapshot to RW, it would break later
incremental receive IIRC, but I'm not 100% sure.

And for that cat, it would definitely lead to COW.

So, no, that would not fix the corrupted sector, you have to go the
dangerous way.

Thanks,
Qu

>
> Thanks,
> Marc

