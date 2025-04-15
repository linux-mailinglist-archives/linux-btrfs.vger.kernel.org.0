Return-Path: <linux-btrfs+bounces-13052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF53A8AC58
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 01:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCEF16A205
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 23:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D602D8DD1;
	Tue, 15 Apr 2025 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bJHwL86o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356B24B28
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744761438; cv=none; b=b9GxdmAKEkvyM+chIW5vPe2oKEPU08zI0eqVHOlA06/6bCC5F/x1lOO+6qphSiS/s3a5L8ayfNYnpMWQ8KsreUykEggxe9KO/Fh1cAs97kWUQSb5sabtN98DWaidjyCOkpdQ1URWDpV1sfYjxIPLyzlbzdQNPAimFtTHAzGQIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744761438; c=relaxed/simple;
	bh=eULrIeHWgWUqRJJPWOwGsAr5o6Py0G2mtrLV9Ne0/Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZHxgJ+1Iz51q1cKg1GEilaoe1dzdfMdd1lKV1ma5QJuP+KSNFdSZir29NpxWcjE/ZVdPV8XKbjr89uWVagrm3rHGYxlTadXdOap76sqmQaieQJsDnOjpk38G53z+E0ycQOol8QgGgtVnRBN8f5N/In+Amspfws9wA7s/wG5Z14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bJHwL86o; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744761432; x=1745366232; i=quwenruo.btrfs@gmx.com;
	bh=qtRh98wC3Pbta4FFCEsoiCK/MSd31S0d+WJRsau/ULg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bJHwL86opxaTy+4YRkXqmS4MCdpX9KPQf8r6+3BHUa177GWgbUYZ9U92lJ2Jea04
	 U5T55P9Jb0ess+VnH7tQhDwGO+ZH8+KatB+u8pAMX8l+YGC9BELaco2kfGDR+vJMQ
	 emAIMHKq13Z9y9Mmn0o/JbNaZLlkaoiqDOhlwYSsEq5T+cM8DaBfSZ3c0GiH4fN/k
	 kvoLXu2jLJLmiNglyVTR68oCTCN6i7pnzzAUkNrn6uhl9aS6DbjQyEmiLzK7QGOLF
	 J7AGJkN2vLjA6npJln8jUSbGv27enky3kcDboGAS3e3uMiaDuUgxMpyoiwiXnhAXJ
	 bpXYs36l+gmEF3LUzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKGP-1tpfrl16fx-00C8IL; Wed, 16
 Apr 2025 01:57:12 +0200
Message-ID: <408fff7f-00a9-41ec-91e6-168dcffb2de6@gmx.com>
Date: Wed, 16 Apr 2025 09:27:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range
 for certain subpage corner cases
To: Andy Shevchenko <andy.shevchenko@gmail.com>, dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1744344865.git.wqu@suse.com>
 <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>
 <Z_qycnlLXbCgd7uF@surfacebook.localdomain>
 <37e556c8-d7a4-4d65-81d7-44821d92603e@gmx.com>
 <CAHp75VdyLRQrnByZtPPL2sn9ucGWVkyZu-kBvZvvpr4P_tOTpw@mail.gmail.com>
 <20250415181841.GN16750@twin.jikos.cz>
 <CAHp75Vf3Z=qQPKkALhCbSSCd9VYiYYZ4xVJ9aT=sYKW7tbPd2A@mail.gmail.com>
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
In-Reply-To: <CAHp75Vf3Z=qQPKkALhCbSSCd9VYiYYZ4xVJ9aT=sYKW7tbPd2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EhoqiIkRaiu4jkFL7KM5m7cJqaI/rlnUbL4NSCPZS3J4v8nckRz
 7LGjlDHgQhnwrbfMS79oyPayovKIYHljiT+jXC1d6QZiHCVAFFeIINJ02z2Z2toW3ASkdPr
 qFFwZ69PQSfplSJ3J1B7vpDGfngxGz3FpUvXidAV9sdKxr1s/JqAhJfmxsYgLuWpRj3D4vV
 8O19+mk6zP5Rb6Cl9fbzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UT7yS9Q9WpY=;ei6vHAWKmJ68RfmF9BQgOy04+Ts
 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
 g==



=E5=9C=A8 2025/4/16 03:51, Andy Shevchenko =E5=86=99=E9=81=93:
> On Tue, Apr 15, 2025 at 9:18=E2=80=AFPM David Sterba <dsterba@suse.cz> w=
rote:
>> On Mon, Apr 14, 2025 at 01:40:11PM +0300, Andy Shevchenko wrote:
>>> On Mon, Apr 14, 2025 at 4:20=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
>>>> =E5=9C=A8 2025/4/13 04:05, Andy Shevchenko =E5=86=99=E9=81=93:
>>>>> Fri, Apr 11, 2025 at 02:44:01PM +0930, Qu Wenruo kirjoitti:
>=20
> [...]
>=20
>>>>>> +    block_start =3D round_down(clamp_start, block_size);
>>>>>> +    block_end =3D round_up(clamp_end + 1, block_size) - 1;
>>>>>
>>>>> LKP rightfully complains, I believe you want to use ALIGN*() macros =
instead.
>>>>
>>>> Personally speaking I really want to explicitly show whether it's
>>>> rounding up or down.
>>>>
>>>> And unfortunately the ALIGN() itself doesn't show that (meanwhile the
>>>> ALIGN_DOWN() is pretty fine).
>>>>
>>>> Can I just do a forced conversion on the @blocksize to fix the warnin=
g?
>>>
>>> ALIGN*() are for pointers, the round_*() are for integers. So, please
>>> use ALIGN*().
>>
>> clamp_start and blocksize are integers and there's a lot of use of ALIG=
N
>> with integers too. There's no documentation saying it should be used fo=
r
>> pointers, I can see PTR_ALIGN that does the explicit cast to unsigned
>> logn and then passes it to ALIGN (as integer).
>=20
> Yes, because the unsigned long is natural holder for the addresses and
> due to some APIs use it instead of pointers (for whatever reasons) the
> PTR_ALIGN() does that. But you see the difference? round_*() expect
> _the same_ types of the arguments, while ALIGN*() do not. That is what
> makes it so.
>=20
>> Historically in the btrfs code the use of ALIGN and round_* is basicall=
y
>> 50/50 so we don't have a consistent style, although we'd like to. As th=
e
>> round_up and round_down are clear I'd rather keep using them in new
>> code.
>=20
> And how do you suggest avoiding the warning, please?

By fixing the typo, @block_size -> @blocksize.

The original warning is not about the type difference, but that=20
@block_size is a function pointer.

We have tons of round_down()/round_up() usage inside btrfs, with=20
different types.

E.g. btrfs_check_data_free_space(), which is calling=20
round_down()/round_up() against u64 and u32, and do you got any warnings?

Thanks,
Qu


