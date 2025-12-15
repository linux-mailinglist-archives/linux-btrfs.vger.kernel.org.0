Return-Path: <linux-btrfs+bounces-19731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685A8CBD160
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02FD3300C359
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E025032ABCE;
	Mon, 15 Dec 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OCFbNciw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB192E5B05
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765789354; cv=none; b=T068qyPYYVp6kXcC3bQ9RrxmFKYp9AL91zntsh7ZnBiks2WzKiGtcSkUWuCWw0plvv2bXdEuLUFh82N1jLD43aP7F4TVW3j9E9XyXNLNHaL+XhxfRah4bERedgl1HZvySlmfmIaQaecVyeztOVTmxDVqCSRzSdjEb7dvtIo96e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765789354; c=relaxed/simple;
	bh=VJurncpOvYHmnIRuvgqmPrcytTSOPBAhRH6OugvA8Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QVBGRgXelcu54tL5Hoy/572BWNHAoymAzlXrP1lU9DuSQ+swMjaY+l+XJmKMHz5+RDs2fYupTdG+vYGsRFWguH3bkSS4obO+J4NR3KFDWQdL2ldZhFilvEfCt86RiEUdqD15iotPTs6sXvFlQid76vonj87e4+r3IEXqnzbwixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OCFbNciw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765789349; x=1766394149; i=quwenruo.btrfs@gmx.com;
	bh=tHNOSQNhFtCkeD/CW94MRqs9wRgs/y7c/YcSecf6LlU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OCFbNciwv4oFKLU0guYLMFY/vHdN63U7Hl7ueHzAq8Tencu1ILPxB/VF8ZUDKl1S
	 i7MHD0isluS5744wQ52vdBc+khZdw9x69QFBIePH/yBJT689hkn5pe6IelxrAmyxZ
	 ZOSYXJ8t4wZQ+d/tmywjGuSlcxoAC5jvacEpaA0z4Fb6KuJqVoLziYHP27pzE+Ovz
	 80ZWrq/VzqeXXjZxGEulqZjtPbgnrFhMSzfYd+tyq25aaKbWX/jyfDiwpuBOYPkMC
	 MU0FwjhRg+qMF/ZJiXqpQxCF9WsTcxQWK3Dp+niX+W8iVjkhwiUh8tQj8z9/7xa68
	 4YVduNn7w71b15tGLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatRT-1w162Y1To3-00lSut; Mon, 15
 Dec 2025 10:02:29 +0100
Message-ID: <20a1aecc-aaf3-4fe1-8b4a-5c5bb8ba92a8@gmx.com>
Date: Mon, 15 Dec 2025 19:32:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel 6.17 and 6.18, WARNING: CPU: 5 PID: 7181 at
 fs/btrfs/inode.c:4297 __btrfs_unlink_inode, forced readonly
To: Chris Murphy <lists@colorremedies.com>, Qu WenRuo <wqu@suse.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <e2095d93-fa47-46b2-b894-0918b6ce348c@app.fastmail.com>
 <d9ab1004-a7ff-4939-9692-0c8f32df27a9@suse.com>
 <651e259c-ac24-49d0-8eba-4d9c7c9f11c8@app.fastmail.com>
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
In-Reply-To: <651e259c-ac24-49d0-8eba-4d9c7c9f11c8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FGvGODmtkuXNlsFT0PNaRad3D/kwtPjwkyPo+7s/lADwvQaMNOn
 U6BOgeG6Cb4yvfmurTRR5fKArtA3no5u0oIuypxRjXnHPBugbrbqxqACSmSxMfqFzWf+H/g
 1/MEVhRwh17DS7juq9TvaaMa1MvDWp+C9iWHETsoWfFqu7JYPfMWXKVUlh/rPq7a6lGtxIg
 OUdgxZYeqpsIiG4YQ7e5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rtS2u8ghK3U=;YuX4fGvQkPmSrghGyXrYWMOpj+w
 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



=E5=9C=A8 2025/12/12 04:31, Chris Murphy =E5=86=99=E9=81=93:
>=20
>=20
> On Wed, Dec 10, 2025, at 6:55 PM, Qu Wenruo wrote:
>> =E5=9C=A8 2025/12/11 11:58, Chris Murphy =E5=86=99=E9=81=93:
>>> User reports root file system going read-only at some point after star=
tup. Seems to be when a Firefox cache file is accessed.
>>>
>>> Initial report is kernel 6.17.8-300.fc43.x86_64, but the problem also =
happens with 6.18.0-65.fc44.x86_64.
>>>
>>> User previously discovered bad RAM and has replaced it, so I guess it'=
s possible we have a bad write that made it to disk despite write time tre=
e checker (?) and now can't handle the issue when reading the file. But I =
haven't seen this kind of error or call trace before, so I'm not sure what=
 to recommend next. If --repair can fix it.
>>
>> This looks like a previous memory corruption caused on-disk metadata
>> corruption.
>>
>> Tree-checker is not a memtest tool, it can only detect very obvious
>> problems, it can not do cross-reference, and unfortunately this is exac=
t
>> cross-reference case.
>>
>> For this particular one, I'd recommend to do a "btrfs check --repair"
>> then "btrfs check" to verify.
>=20
> Looks like --repair changed from "errors 4" to "errors 6"
>=20
>=20
> [1/8] checking log
> [2/8] checking root items
> [3/8] checking extents
> [4/8] checking free space tree
> [5/8] checking fs roots
> 	unresolved ref dir 1924 index 0 namelen 40 name AC1E6A9C763DC6BC77494D6=
E8DE724C240D36C9E filetype 1 errors 6, no dir index, no inode ref

And repair again?

If after repair, readonly check still shows error, I can craft a quick=20
fix branch for the reporter.

Thanks,
Qu

> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/sda3
> UUID: afdbb979-0b91-499b-976c-0244ba2ed38f
> found 140964491264 bytes used, error(s) found
> total csum bytes: 136339904
> total tree bytes: 969474048
> total fs tree bytes: 751108096
> total extent tree bytes: 62439424
> btree space waste bytes: 178561905
> file data blocks allocated: 490371264512
>   referenced 162984435712
>=20
> End user has btrfs-image before and after repair if that's useful. But a=
dditional --repair attempts do not appear to fix the "errors 6" message - =
and the kernel still produces a warning and goes read-only if the file is =
accessed.
>=20
>=20
>=20


