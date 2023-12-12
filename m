Return-Path: <linux-btrfs+bounces-838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3180E339
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 05:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C2B1F21F02
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 04:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D94CA65;
	Tue, 12 Dec 2023 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sOxVDIxL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AB0B0
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 20:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702354412; x=1702959212; i=quwenruo.btrfs@gmx.com;
	bh=p1oJ8/ru5mY7ONinjoLwumBDEMEROQcqQJw7lhMEkjU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=sOxVDIxL8uJfz4zjQpz2rMKp4uv56EJoGtKGDVROpH0lq80LP0r1c+WBec2m3wOx
	 /riX3pvCF6Db35ItaksjLhxaWdHDI11H8ZoAOvq3tjAdD2H0Q/oR1Vj5c4oO0x3R3
	 /cHsMqv3wva6gDoOJLWnaZUkSxGPZkfJhUfArnqNyWIkf7OItsYvZPP/g+k7oHVFk
	 7gGyafaiq5KfxG9HBRhctKe6cIj8Ligr/UolLKidBCXOjYHB2lCNCnL/VEiNl/K7n
	 swm7q9wNfWRxHyb29mJsZDCUKRa5YBv2Ff2BcEZ1tRxxOsQgZK07I7EKYYGslYf/7
	 HjNXneVP4RLV0cteSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.79.20]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9yc-1qugm10zLu-00IH9U; Tue, 12
 Dec 2023 05:13:32 +0100
Message-ID: <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
Date: Tue, 12 Dec 2023 14:43:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
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
In-Reply-To: <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ARaz57s0FKsm9gts4VWVs1zPTBhOlEU29Maj/kgv9kuMVO474mJ
 Q7gsSV+GwhaZlqOD78mmLmwRaOp+YQpT1C3ZsmEVn/zV8rFFuOrZPYaGx19hUD8pmX2fpqP
 T+lZ6G3okndtSiOp8tiMfPR6+t1LbCRcmzxREm2JhAxg9OOWx9kYsNK3rH56iE7XlRSibTi
 3qKA6Sg0lC0RiR21/5XFQ==
UI-OutboundReport: notjunk:1;M01:P0:LhtgqrnzAOU=;jAkDZUAgkKOARiOD1hRIME07jd4
 OFTUIDU+S9AQa3pWpoC8ln09EnKqTkyFv4/lC8a2jOwbVpKtqb2KmBaDOx33QhLs7/wIniqeB
 w8VBAGGAmKi6nUnudCDjoAU2AmpYxy5DrvsLJLUPFFdPSw3jIjN2JY/SvzXPdMnz43vfvN7HF
 fau89b6wY+S4yFLwqVx023L0INF6PAQYOF//4C/RqqpW3RoMkg7Ygvwo7sHGaUvA1lH/zVHxI
 bj/u0KFH/0HPCPzz20ektRysAhnTKIZzaT3iwA91RseF6FeNvddmgBH9/WAtIf7Ttx31Knq/j
 Anld82a/TSTqGRsrb/MtsWoCHlz61b2WjuRThc/z+anQvHrKPhZ8sPCVjBwbWbiyV/bbV/0tb
 RdhEWDq73mgOK+fSpyCKGio2PMW4VbVGd2Ft9Ha3ckroXjW40ynq/0uEzNcC6djH2Wj5zNHV9
 REh3l4oBJbSGabMpnhaCwIkbM500wbqHFlXnsHaEj/4vNEnqXyNOAy5f5Ev6Botn8I397YQ8I
 ITWltxzRjf+TD3W92wPDkpjyyoNTGkycwNG1HxVkN8yONX88G3nR2HePyL908wnXvR8pYMb6t
 avl7BDHujYRa0q8Os96+VkzKGvctgegZK2Wkx5vuoB5kgR2b6grTBngIk/TIRXAAouY9AGQvX
 RLeTqmdRJY0nAqueWnbtTGliOhUYckNauCDxSvhbzVaIwV12fOGKtW4ISNqFHcaqn3d7nciJ4
 KkH+9e3ZhN1Xeotzzqx5URWIyW3rVk2p3isAF4tnUg65LXTCZfrHBth6vj5b2AceXCaBvHq/x
 TUlyNCm5R3iTPMuhqM8VGdD9OhLUKIht8iugHEPY0U7bSMIi4A6UzOb+8cWP+v4BOgY956tUI
 clhhGfhK9aLfUn1ee91bCenKDpNrybTs+/WdrVmNqDyN1/PJJSvj/s9wrZfOZSHBePlGF6sL0
 Dqbw4Q==



On 2023/12/12 14:10, Christoph Anton Mitterer wrote:
> I just noticed that others have already had that problem with
> Prometheus:
> https://github.com/prometheus/prometheus/issues/9107
>
> Some users there wondered whether the issue could be caused by too
> aggressive preallocation via `fallocate`.
>
> Do you think that would be something that could also cause the wasted
> space?
>

Well, preallocated inodes (any inodes with any preallocated extents
during its lifespan, it's a btrfs specific flag, won't be cleared until
the inode is evicted), would only lead to btrfs to try NOCOW first, then
fallback to COW if NOCOW failed. (Missing the compression path).

It's not a direct cause to the problem.
The direct cause is frequent fsync()/sync() with overwrites.
Btrfs is really relying on merging the writes between transactions, if
fsync()/sync() is called too frequently (like some data base) and the
program is doing overwrites, this is exactly what you would have.

IIRC we can set the AUTODEFRAG for an directory?

Thanks,
Qu

>
> Thanks,
> Chris.
>

