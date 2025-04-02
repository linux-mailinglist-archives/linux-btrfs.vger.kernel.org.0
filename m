Return-Path: <linux-btrfs+bounces-12749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F40CA78AAD
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 11:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337D37A14AC
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DDF9444;
	Wed,  2 Apr 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ahb+1E7z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1E20E00B;
	Wed,  2 Apr 2025 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584901; cv=none; b=tNhtrwqf64HPipgVk0MMvlrqhvnvVhPJwDiJ0nrUt/LaWYA7ZIkUkVMGQLY1hzQDsqaX9MDioKMzm6T3ICO81DXG2kdpipshXM8UH0HRkNAT79Jgw8aU0upqui9JBfvnkXUgjrzMnm0nggoZig1HzxO9TDjK7u8E44Boyd7KSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584901; c=relaxed/simple;
	bh=oyrcuxauaAc+wQY/a4+bXAF6rGhrCF8xphP5Y43wdEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RM0BmQeYRjAgyQZJd5k+fFoCjyM+ItYrLWE8bWTD74jXw+EKfqsOSJv/TrBHyIyuPwFShkCl/dIEM1llrP4xff4mWDxk9f4s/AElYjTd5y0I5usr6uL/HpIY7rqHbK5zd7Jt3S6DXJmhHVryAHt/rpCdtJfo/moADKgAs7x8aQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ahb+1E7z; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743584893; x=1744189693; i=quwenruo.btrfs@gmx.com;
	bh=oyrcuxauaAc+wQY/a4+bXAF6rGhrCF8xphP5Y43wdEs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ahb+1E7zuyMmSITH1UX6J2EzRsxRD0TQdkM2aCzKKI3kX02c37dMrhCj5KR5QDkn
	 JLqOi3gLkCV2K5E/8QSW+ueO1B5haIpEoMMPgsNFB4atBYbqJxmWE8C0Le+X7g1Us
	 0qlELzsMWbATz2Wl/z17C+D50kq0xSGUYxbJ/97+mxs7pxDehJ35HTVs5ilspe9fj
	 N1D6/FyZfr2dt5Vr+2Z+F3JzpEsFa/WYLvQkVKuHl6FuB+onE6qLKTmwWcJHKrdAF
	 I/uCFGGM6EOwNelCAusVX0ieQK0vyl0VvL86NFfWDCw0YPHrqtHkN3yloQmnE9pK2
	 mdZ9sIZbykLEAkOL3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdif-1tucjx20kX-00Eq0a; Wed, 02
 Apr 2025 11:08:12 +0200
Message-ID: <e3e5f96a-8b46-4e61-a66b-253d2dbe6aa4@gmx.com>
Date: Wed, 2 Apr 2025 19:38:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast
 modes
To: Daniel Vacek <neelx@suse.com>, dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250331082347.1407151-1-neelx@suse.com>
 <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
 <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
 <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com>
 <20250331225705.GN32661@twin.jikos.cz>
 <CAPjX3Ff2nTrF6K+6Uk707WBfvgKOsDcmbSfXLeRyzWbqN7-xQw@mail.gmail.com>
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
In-Reply-To: <CAPjX3Ff2nTrF6K+6Uk707WBfvgKOsDcmbSfXLeRyzWbqN7-xQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D96aRiH348KHI0l9t2jMqU9cX7AXFj+NMnIQ675tyrHgHFxqTmi
 DeDTKuXqw1C2rANq4oN/A4x6UpGEpV10e/Yf/k+caD1ZSHl8lpvsGvfPbIBp67wvgtRGuaS
 bUAJ4pOPYBxfu8TGx4QYszslHYt/2pPVSOgbToWcCpA75SrQBmijCTGhiaWClTl0dB1ZZvk
 u3GmjWwzNE4hVDqYeGH0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8AlOhUPYLRQ=;u/KOUngyzgp5ZYAd0hkriB6WFEu
 VU4fxRDhFHA995aRJcm3/FP0AuoP0aBIf5AUrim1SIGrgivgXX3GyJPFvSw47r8Mj+1kuTbs+
 AGN0M8OXML+PcdFQFA3H4TyTyE0EjJ4ApC5pIB6O1SlbUsf5kY/qeXDK9mdarqkAzgkscICcf
 A79Uk8WfQeVNGYZ0m73bgOH263lan8yw29iBeHikzu72sg/MvJf4vuOejp69TjdYQpMI3fISP
 3qihUFlQPp30H9ntSdl3dYKjJm2iEgmviV8QLCQ4o7zq7TgxXG318n/4KeXKiKc38vtYQmbyu
 K3WVR4JV2T9uz3WS/8WusH+giNkfzSQDXDu3zqAKbQOo5BahYlN1bz25WPe8Oi4gz3wymgjyL
 WVVtGtHCjUdzJQDc7po/nNLCgAbHPGsZieTGrlPUAnSz1pYpITbeCaZBnz6w6UVlMU+BjSNGZ
 WOcnuCqQ3nHtbj4XjNhiSmuMmdH1gdpXxo7V1J1KFfK3ShOrR6G7C4wwhUxVicJcCmBf3Nroi
 3z0LqgaY9lBdJUHpcqFB7V3W+sIqew+xguMaSohfhZ6eeRdJic/KacWf6Ygm4va17uO+XNviI
 17jxckvNoYs3IKCzx6uyfU9QfkeLHZp2OX5FVUwM3CGvznium16aolJ+toh5CqKnSC68HBYCx
 6h5Kh4sz1sw7cCp326T5yZYqtcftootctTW1wuzMABLOWcyAETiOc7p/6Rk1sd+3qqwXZPONE
 13Nhsvm9dx+N4BewhCdjjVJAooQPJZ7dXJAVaBnzKKB45bMH8uIAlzr3qrsamtAW9/n0tnRhY
 laZpqWVXkAeugdUi539KTzkavvrWbqleRwiqTNTVQioWQYtsA5A8k91IWgR29qw5SEyPo1nXr
 /iH01IHlH8hoeZvKJZnT2imPHF9FmlRTT7TJdmpCmn76e5TCRR8wa39Z+pNKvbTJIkZBtdqnX
 oz8t/zlI8bxCRzckyHGUHBGxMklwwJR389Xe/WlrtPNYMK1PTH6miJWlxJH0ek+RU57OqoBxe
 n8CkXs6wxAFy/OY0H2CQPFelRJgwDcGPpkIi69lipokoJQiJwYKMkFWLknCcAcwq9JduyG7fv
 soGPKy91t6JwLlWClXvXTxpnpcFyeVmz20YhWnmVapkZxnYNAIVU6cd6Y7Oy1bbXGV4MnGU4L
 dD4TfF/L314I/DVjMj8BC16+c3Qa8VEG69lvwhcbeqbWFLa83ebTuhmFsIqrVDoyw01wgRRiM
 NSeWVLLV4/Bs6dlvmlyCYiS3HVpll+OaVZQ1dsIn+dv6RoW8p8pnE17s2O3g9AmG2lISYN3Vp
 aqI9lP4Pybd0maOzGyFrLZU/wVFMGoVSW5+K4oaCjnqKAIupJtfbqnkF8HPDg5IWFW+VBeqjX
 GjGMJ1Ve6lyvLDji1ROEuSb+RslXo6gpFpy2iR7s5ASyabofQWADbN2Vj/TLfxURjVj3CeLp2
 5ZCgmaQ==



=E5=9C=A8 2025/4/2 19:07, Daniel Vacek =E5=86=99=E9=81=93:
> On Tue, 1 Apr 2025 at 00:57, David Sterba <dsterba@suse.cz> wrote:
[...]
>>>> I thought this was solid. Or would you rather bail out with -EINVAL?
>>>
>>> I prefer to bail out with -EINVAL, but it's only my personal choice.
>>
>> I tend to agree with you, the idea for the alias was based on feedback
>> that upstream zstd calls the levels fast, not by the negative numbers.
>> So I think we stick to the zstd: and zstd-fast: prefixes followed only
>> by the positive numbers.
>
> Hmm, so for zlib and zstd if the level is out of range, it's just
> clipped and not failed as invalid. I guess zstd-fast should also do
> the same to be consistent.

Or we can change the zlib/zstd level checks so that it can return
-EINVAL when invalid levels are provided.

But to avoid huge surprise, I'd recommend to add warning/error messages
first.

I'm not a huge fan when invalid values are silently clamped, even it's
just an optional level parameter.

Thanks,
Qu

>
>> We can make this change before 6.15 final so it's not in any released
>> kernel and we don't have to deal with compatibility.
>


