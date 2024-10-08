Return-Path: <linux-btrfs+bounces-8663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D69958DE
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 22:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE01C21D82
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ED1215F7C;
	Tue,  8 Oct 2024 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fud0Do6k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495271DE4CE
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421139; cv=none; b=AdhV+PlLhGbD7uYlu1KaMhfq7K/fi1Pu9YmiIJl2cFwCM5birmIGDYewu6qtY5XvSBXSCXAsBxi+IxEsvYHax0DdPqGNhl1vgKBinJL9tBq0uxkx2np2uiooDd5LMV/UbsKEQagMcEpvonwvs8ZFdVTgDb/xgaL6PSXevvZNtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421139; c=relaxed/simple;
	bh=4hnkd1gpKDM7ZTJwqSubFjNNeZDvaa8i7GjOPCPBWRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8kOgRgsuwU2zEi4ov7RAI11h4HOiNP/mk+xiEHQXl4A1YgNw+lNJvHddkORKwWi88AVnTkqVdPwnS5Uffw8mMGneXunAJ5jRV4MV6caA+YgU1Bm1/XQFhbo/eFt1M5W9/9jN8bFA1J6GtiVJFQjhlGh2VmBpU5PF5Xi+KuCWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fud0Do6k; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728421134; x=1729025934; i=quwenruo.btrfs@gmx.com;
	bh=4hnkd1gpKDM7ZTJwqSubFjNNeZDvaa8i7GjOPCPBWRY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fud0Do6kHWzEFI3Pdq7OQ6SYI9PWBoM1HgoocKr4NXoeis4MO3skOU3AUX5v6MF/
	 n286jJdBQ7o34y7xABFpAmhVqe47xLLqviqQakfINcCNWGULbgI3l4EaTMbo1YQRW
	 gXArWpSXkoRfewjxkKUQBXg/v3sb3494DNhJdz5soGZm9NHFZFK1mUZCNCEhs7lZl
	 h8WlGShAawUCqvfiOxUaz1xsrEu0gd/Xb1XAWIpTtJmvLk7UjuaQPWjHAa82xv+U8
	 BO6h7oD3qVRjvnbinGeASzgzoxuQ5ZUz6WUpikJEKw56PEwOwCdT8AG0bDfjABgvZ
	 QacZFX8IV1yUw4ZGBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1tSKmQ3AUZ-00Rjdm; Tue, 08
 Oct 2024 22:58:54 +0200
Message-ID: <ab5ed1db-7785-404c-a20d-7f11c3346eb6@gmx.com>
Date: Wed, 9 Oct 2024 07:28:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: rename
 btrfs_folio_(set|start|end)_writer_lock()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1728338061.git.wqu@suse.com>
 <d5f42da1109269ad9a4a88000e78eb3a66248591.1728338061.git.wqu@suse.com>
 <20241008170916.GF1609@twin.jikos.cz>
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
In-Reply-To: <20241008170916.GF1609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tIR24D+zXnJ2XJG/dtCdXFpPhUXrj7CKFJOIaeVvPlrEb7Y+48c
 QjjdEj/rw/PY+HjtXCR1MYoK9NBdlbNQsE7d29nq0acpiW7ALzve6Ho2RKreQyDtj5L1P1V
 aYMkVrBgCXC8QsqwkPP6t33OfxZiR8NSDnZ7xNW2hpcYwPqPglBZIdcHqIdV4rKfjr2RWvK
 uFnNRG2A/niCtIKHx4RLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ETvHqa6uGkg=;GM6ZZbroe6IHWjtcWBhYg+DXEQg
 sWiCJuFKW39GsG3c+o2aerUtgLjJI59vY4AhZOdOfXdZjl5fD1CB5Vfk2ZCPcsZBN8H7UTX88
 YrisAkeRpXSgKrLR2ssbt8VWIhrgQLJJ0E3AgEsZ5QPXW0loqQFWd0mguzDJYSQZPDDFn+Som
 aAXunReSjpxsVK52ipD3Ng5BUohvdQ1PoZBh9YiyzWsEwgyW/2xZ4peBiA/r8NGnbSQptN53y
 Wr3SzV2PqhEll/vPr/fvUj2bqg7WkJ/WcSfYRviFph/lG35rM72zlEHPVBO4Jd+Ke1TRyYXY+
 pDLIIeev3vGdsuGMRuzgoJGWV8q9zAJ3nUHKPj3Y3dFgxuthYkao6gS7r6EVkVCShAuuyhgLQ
 8DdLvxi4tHiSuc0cNjeVc5O2J55eSkY8UhKy4LLwT0c57+2gfHrS9+eQxnNB5hutFdnOApo58
 HCpGglIHy5DrP8cNrHcUUx9AAXab/qlzj7F0fRgWPThCAmevYr82WNxCAAH6eK6MPydIrj/Cg
 205Cv7HMzooeVAHw4Rd2unM/3RMNU8HHYH+w6YnLOcDkiD4bgI7n0bW3PjuIB/5TDiYbyAhIl
 UrAXcBmxXgYEmmNyu/X7zjbzKGpcZ4sjpJ1HnqY5cuvOTy2/cAJS3COEs2Up7CTRHkpZk9Mc/
 yFg1M9uBjQTziX5olz+Hja0l0Mjthm5nuYYR763lqOcP1NZNTJMIgn7Mh/8azeRKx6H6kEE2T
 GILyH6jCUmV7ZEutjWRUDvE3l2gHF/1AhdOWG9ZfgmBbmVply0OsslZ1f8GK1ZTQEFvA5aZzV
 0re9fPJwCW7xQc2iiOV9JVSw==



=E5=9C=A8 2024/10/9 03:39, David Sterba =E5=86=99=E9=81=93:
> On Tue, Oct 08, 2024 at 08:28:45AM +1030, Qu Wenruo wrote:
>> Since there is no user of reader locks, rename the writer locks into a
>> more generic name, by removing the "_writer" part from the name.
>>
>> And also rename btrfs_subpage::writer into btrfs_subpage::locked.
>
> 'locked' looks confusing in connection with atomics. It sounds like a
> predicate but is in fact a counter, so I'd suggest to rename it to
> nr_locked or nr_locks or something like that.
>
nr_locked looks much better, and way better than my original
"sectors_locked".

Thanks,
Qu

