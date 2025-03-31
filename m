Return-Path: <linux-btrfs+bounces-12679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6034A75E69
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 06:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AD7188927C
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 04:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A0615383A;
	Mon, 31 Mar 2025 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GFKIASMY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BFFA92E
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 04:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743396465; cv=none; b=pJmet6lLg0b2WbuX0bK9fUn4w2f/kacwNs+uFpuYDAE6a7GYPNEKI+GHLF+W53DkNVSnowpwMzwGT9ybIaZe0O/1Ac0DTRo2/bSvibhoagb4hEvlV+2Gu1I1zrVEa75D9YUg7LW7m15lbonOSIheoC2W6huyabQnlbEoJrTo1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743396465; c=relaxed/simple;
	bh=G/68kBKnnr6/yvUjt3xwhzajaKiK8PegXWV9vk5JDOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsGXwBYobI80lOg1zhX1wyzr2+dtzsG5ouIwXbp5BAgrk5Z8Cpt51T1r2T3LOoR+tD11pr6teNfKmlQVRrEL+OjANW8mEfGrbpzpXcqZ6+ISxtRKZoAfa0brKu23rmXvQQS3Tgt8Om1lnpiP108ZoTEcx2/5/SN2LyPNegR3cvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GFKIASMY; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743396459; x=1744001259; i=quwenruo.btrfs@gmx.com;
	bh=alJwxsusiMXi6lKKAZu1YGu39CrykS5xdzJIFKOmt88=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GFKIASMY82PbqJEDctCRD78qF/u17uVm4UX/trFM6AJCUuvwLigkLzHktEZBFn3x
	 BzUYWPV7lKF0Ql7TVPf6b29z3zAnkeiqJV4Ll+6+ecu6xZQF5Op4i1+GgzHcIOL0l
	 61TdB81BV7JJ0hM2KXBmoEYifYMmhtTd+QJklOXWYNnqcwkpFuoJ8OqUU+AYBaWEW
	 GNlxEROHivwAxzB6FxhOY5XEOSBn5BmF9mpH42KUwGL9zqYVz982b6jld3KDg1g5Y
	 bEtFa/pLrZvj4f1gOhZ8ru/2iWMrbmeomtDt1/HvzR00Fl7b4UDpatoiBn0e7Oyfa
	 Xn7RyfWPio+Zf5zSgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bX1-1szTuj3DW7-014ZUz; Mon, 31
 Mar 2025 06:47:39 +0200
Message-ID: <e9b76101-d14b-43ed-bd9c-97a5978f4d59@gmx.com>
Date: Mon, 31 Mar 2025 15:17:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] btrfs: remove ASSERT()s for folio_order() and
 folio_test_large()
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1742195085.git.wqu@suse.com>
 <20250317135502.GW32661@twin.jikos.cz> <20250317151312.GZ32661@twin.jikos.cz>
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
In-Reply-To: <20250317151312.GZ32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XlHSskgPdNa5Noy99lX/dZdypgVve3p0Ooc/U1t6Ul0FsLBj2l0
 WlvfZ+unNfvd6ZlHI2+980FPlEhd2Vqxj3DxLkJvQ6BjfmCioui7ImDmEMKrCm9oEbJ87OE
 YYuSvUIC5imeBtq6wyuI0Tv9WNCi7CaYWPC6vFrxlIg82w8Q2NRv6HAPtO8ypzJV15wR+/j
 6lwwkkWo5Vs14U6BeC9Tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:amxZFCQhcKI=;0FN+cGulXUHvI8kn0BWsuUF80Io
 TSC0MgEw5Lc2NaU1agil+MAggcZK8YsKgeJ/WKAnuTOY9XQ0wRA2nez8bWV/BP2yrxUwsc/8i
 lTq0vSZFmXJ2rSMD+3wU7dmnRQv/VdtPp5QSBrMcSVig/6u0BJFF0R4FVTqL51ZUsC84/VOcK
 9CmkLS+uOwePBkxAvL/3kRYMJa905Dy2fes/QxWOlRy0uRIJWU7e1IxOeZCkhBoV3CIY1HNrJ
 LFRlXBVMu2P7I2wkfoZKrDghh41BX6/vQ4rtUz0EPaGGAwh9bJkkAWrxu4ulhSgQa8+VvaMY2
 b0yH2UpDy+mzC9dz3Puy7hhrVMdi1z3IGpWZrn3hMuZklItKjpu/cZrLWeFl76RvJ6biGZsuF
 1jOL2CE4RRKrg43svK4ZeFeSvVdv+1RHzXw67crDd1TbXdXg5rvnguUXKiue53n/3IBWFvA84
 wWrAE5a35+pB0hhedFDJQHD+x5ej+fHVVN2Dol4kQHAuouYRj/AI6OQ8vH/+VoDZ+g820m88M
 O7sn5x55LYvJWAQ7DH7AfS4JXWVLyyRGecTVwPvuQRWq/N71s3CqoE6saZUjzjWZDJK0PIimZ
 QvuN/pS9A7FsU0hgzl+t7ZboP8yUIDrOHM3yOa5H2+pbFaexFopYpZHdHeClqKdoy8jeWPcjy
 n9dJOkFNDPFEb6ZP4rcmRT99WZ28tmKxUsEfeetK4f3UsscRdrvLCRchMzJ7joWnz3nmYZ7S3
 MJ1loYE0tM/ZEkpDeGscPTXLDDurhjNtKWAdWQYTvr2bHyd7REwl5bMLg7mPV3IP+W/Aia9x0
 tCNO+Nkc1iGTcXBue8DoBtwUpVtXEe9pcivIv+/UTZL1kr5CaUJTmAKlTCE9GQrcqLIM1C3j2
 OoBOJdM0u+lbYnUCk/VqyHRN8nESaKrxbQrlmbHA2y5oHZCCEyw96qa9aHQmbti1gBA/eZI1r
 uRCaJfxVRKlM9M5zRVfBOPH9MbeHU6ISR5uh45bHmLl7Jz9h8ucELWILtSv8T44nFmkP8Qp17
 xeRiW3D8L0GY1KjHAQDCc8h+UW/htn6CMOp1WkXaSH92gcgkRY520LI8CPIe7Zd2+o4FfsVeK
 nmRrI//Yx6UibCvo/Tx6/G8Ija5ep+9ThrwVJO5xroHeQKb9p78Riiz58K+KgiHzHx25AckwA
 Q/VaUZ0mNpA7rVzl3g85P51Hfqw0pAKsq+ndEYfIFWHBUPv4Vr1bSs2r+8qhvDIvwwzz8vG7i
 nHrXEXCpmwHroIIY8pdUn3qRA6DEnWYxHC8MlKfa0GRgQvW8xddUhaAVQYaw/QZ86f5bT//XT
 0w0duDjy7lgpEmNzCa4BPsoFmOkjd/K3Y7FoVaJuRN16O/PerSueSH7aIfuidr7UKj7fJpnH0
 8W/4xAR+VAYVxPn4+YD4J3ApTMXr0+D7/yGSc766odaMABUaT38kJ9f11ooWZbq+5CrMk0zxG
 TW0wiZIR+aG8qV1ID6OMbnm1Ysu8=



=E5=9C=A8 2025/3/18 01:43, David Sterba =E5=86=99=E9=81=93:
> On Mon, Mar 17, 2025 at 02:55:02PM +0100, David Sterba wrote:
>> On Mon, Mar 17, 2025 at 05:40:45PM +1030, Qu Wenruo wrote:
>>> [CHANGELOG]
>>> v3:
>>> - Prepare btrfs_end_repair_bio() to support larger folios
>>>    Unfortunately folio_iter structure is way too large compared to
>>>    bvec_iter, thus it's not a good idea to convert bbio::saved_iter to
>>>    folio_iter.
>>>
>>>    Thankfully it's not that complex to grab the folio from a bio_vec.
>>>
>>> - Add a new patch to prepare defrag for larger data folios
>>
>> I was not expecting v3 as the series was in for-next so I did some edit=
s
> [...]
>
> Scratch that, this is not the same series.
>

BTW, any extra commends needs to be addressed? (E.g. should I merge them
all into a single patch?)

I notice several small comment conflicts ("larger folio -> large
folio"), but is very easy to resolve (local branch updated).

There is a newer series that is already mostly reviewed:

https://lore.kernel.org/linux-btrfs/cover.1743239672.git.wqu@suse.com/

That relies on this series, and I'm already doing some basic (fsstress
runs) large folio tests now.

So I'm wondering can I push the series now, or should I continue waiting
for extra reviews?

Thanks,
Qu

