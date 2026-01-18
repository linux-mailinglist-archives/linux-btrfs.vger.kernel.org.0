Return-Path: <linux-btrfs+bounces-20653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE37D391E0
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 01:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C85DA3014A2A
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 00:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E27750097F;
	Sun, 18 Jan 2026 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RLosWMMg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC835169AD2
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696179; cv=none; b=pN/n+O0KC7AfKVBrvGXfhldisVYN/yJimeKaW0ZgmwxmuiHzggLlHV9vs6Ze5wr6tG0AkK4kIyrJN9y6HRVthTLHpc5WAFslE+23rWVGAGqkYKnxYBTc0AgqOAKJHxeIbpVa6K7SBGlnzLer4hejxKOrYDBcTnfQu3a7vvr5v3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696179; c=relaxed/simple;
	bh=m6dGkaJA8jl9FdubVzpoAL8AJC7mMROPRlNrrggc8pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P+O1tpCAyjoh9htb+DcLlq6N030dpcKJLuzqGwSYczDre0ARgUA6aTzOlqElddX/m5hjhiI47yG3LTVYJWEusJroV4fq+tv3V3mcMArTpcyn5+ws2HK8GRYET6Gz1cnmvUkdHkwW505CCWtciEa38EJv6ye6wZhntMOmGFPz4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RLosWMMg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768696172; x=1769300972; i=quwenruo.btrfs@gmx.com;
	bh=apEk/vL6ah9JUk+OSStdX1/RCaIYC+6p2/vTxeK4sj0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RLosWMMgFy2flYAAhapGis+Jr/6OaGlp3Fp9ucljCtYZF3Q3n9k50Az3t45+1o79
	 +CR1ff6T9lv4oEW/IEZ8EdA8xdrlUyr/W+zaJOjb25ObwGOyishndowBvt/b3z3wT
	 Wo3pFZONZVJsK+SuYu3e6eD7rOJvGSwZj/Xz9qDOCj1Ga36FkxMpWy5GDHdb8aAW9
	 setpfOF2ChMevEYeUwyaBninMyb5GEvw51LFmPPWcQpi3/0kw/oqa73JCE8Vz47fM
	 PRfuTG1MyjdXtHY2pMHoINZf5V5TdTkj1U11hrdsMyaVMhdcVNoqt0WPDwxagJVox
	 raj0xOn2z15yNFWzeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Qr-1wHQhU19cp-00g2KE; Sun, 18
 Jan 2026 01:29:32 +0100
Message-ID: <e32a5190-3959-4983-8cd7-3eac9c37f20d@gmx.com>
Date: Sun, 18 Jan 2026 10:59:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs check, file item bytenr 0
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <2cd6db87-bf12-4888-ade1-2fdea527a08c@app.fastmail.com>
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
In-Reply-To: <2cd6db87-bf12-4888-ade1-2fdea527a08c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IYkzFDEspAU38hFwUhbbhXPNHW3XOlA2MxT69VAmi45H/mQs0J2
 I0/HQgGD/g5zVjrLKoZA5DS4Kh+CKtwze2Xyy6qA884w9/s6sXoxlomEbVwn4I2nFONEt3H
 Z4lee9rF48gL3reIPk7IupW3nMhzpQmyJyPZcNu7KtC/TK3vPpze3NZrLVsVfwBDIB/oAcU
 wT3/jdS3aaXBjtGPP63UA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GLLaNX2eiTQ=;Q45RJJ9983u4L2UDGSHHEmHhLVl
 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



=E5=9C=A8 2026/1/18 10:45, Chris Murphy =E5=86=99=E9=81=93:
> On a healthy file system, do all file items have a non-zero bytenr? Seem=
s like that would be true, and I'm wondering what, other than metadata cow=
 failure, results in file item bytenr being zero?
>=20
> More info:
>=20
> User reports a file system about 1 year old, running kernel 6.18.5 at th=
e time of the problem, with no dmesg saved other than this excerpt.
>=20
> [   27.927279] BTRFS: error (device nvme0n1p3 state A) in btrfs_create_n=
ew_inode:6670: errno=3D-17 Object already exists
> [   27.927283] BTRFS info (device nvme0n1p3 state EA): forced readonly
>=20
> Subsequently `btrfs check --repair` is run,

That just destroys the original fs, please provide a full 'btrfs check=20
=2D-readonly' output.

And for who ever reported the problem, let him/her run a full memtest firs=
t.

I strongly doubt if it's another bitflip.

Thanks,
Qu

  but the output is also not saved by the user. We don't have check=20
=2D-readonly output before repair, and we don't have check output for=20
=2D-repair. All I have is the btrfs check after repair. And therefore I=20
don't know if the errors are the result of --repair, or the original=20
problem. I'll guess the original problem is fatal and not fixable=20
therefore repair had no effect, but I don't know this.
>=20
> $ sudo btrfs check /dev/nvme0n1p3
> Opening filesystem to check=E2=80=A6
> Checking filesystem on /dev/nvme0n1p3
> UUID: 5a79da3a-afb6-4b7a-846f-e5be70def2b0
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> ref mismatch on [108706131968 4096] extent item 14, found 12
> data extent[108706131968, 4096] bytenr mimsmatch, extent item bytenr 108=
706131968 file item bytenr 0
> data extent[108706131968, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[108706131968, 4096] bytenr mimsmatch, extent item bytenr 108=
706131968 file item bytenr 0
> data extent[108706131968, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [108706131968 4096]
> ref mismatch on [108709425152 4096] extent item 11, found 9
> data extent[108709425152, 4096] bytenr mimsmatch, extent item bytenr 108=
709425152 file item bytenr 0
> data extent[108709425152, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[108709425152, 4096] bytenr mimsmatch, extent item bytenr 108=
709425152 file item bytenr 0
> data extent[108709425152, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [108709425152 4096]
> ref mismatch on [108777738240 4096] extent item 14, found 12
> data extent[108777738240, 4096] bytenr mimsmatch, extent item bytenr 108=
777738240 file item bytenr 0
> data extent[108777738240, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[108777738240, 4096] bytenr mimsmatch, extent item bytenr 108=
777738240 file item bytenr 0
> data extent[108777738240, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [108777738240 4096]
> ref mismatch on [108886646784 4096] extent item 14, found 12
> data extent[108886646784, 4096] bytenr mimsmatch, extent item bytenr 108=
886646784 file item bytenr 0
> data extent[108886646784, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[108886646784, 4096] bytenr mimsmatch, extent item bytenr 108=
886646784 file item bytenr 0
> data extent[108886646784, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [108886646784 4096]
> ref mismatch on [109075341312 4096] extent item 14, found 12
> data extent[109075341312, 4096] bytenr mimsmatch, extent item bytenr 109=
075341312 file item bytenr 0
> data extent[109075341312, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[109075341312, 4096] bytenr mimsmatch, extent item bytenr 109=
075341312 file item bytenr 0
> data extent[109075341312, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [109075341312 4096]
> ref mismatch on [109164244992 4096] extent item 14, found 12
> data extent[109164244992, 4096] bytenr mimsmatch, extent item bytenr 109=
164244992 file item bytenr 0
> data extent[109164244992, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[109164244992, 4096] bytenr mimsmatch, extent item bytenr 109=
164244992 file item bytenr 0
> data extent[109164244992, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [109164244992 4096]
> ref mismatch on [109401321472 4096] extent item 14, found 12
> data extent[109401321472, 4096] bytenr mimsmatch, extent item bytenr 109=
401321472 file item bytenr 0
> data extent[109401321472, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[109401321472, 4096] bytenr mimsmatch, extent item bytenr 109=
401321472 file item bytenr 0
> data extent[109401321472, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [109401321472 4096]
> ref mismatch on [134378655744 8192] extent item 14, found 12
> data extent[134378655744, 8192] bytenr mimsmatch, extent item bytenr 134=
378655744 file item bytenr 0
> data extent[134378655744, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[134378655744, 8192] bytenr mimsmatch, extent item bytenr 134=
378655744 file item bytenr 0
> data extent[134378655744, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [134378655744 8192]
> ref mismatch on [134389161984 8192] extent item 14, found 12
> data extent[134389161984, 8192] bytenr mimsmatch, extent item bytenr 134=
389161984 file item bytenr 0
> data extent[134389161984, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[134389161984, 8192] bytenr mimsmatch, extent item bytenr 134=
389161984 file item bytenr 0
> data extent[134389161984, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [134389161984 8192]
> ref mismatch on [134390292480 8192] extent item 14, found 12
> data extent[134390292480, 8192] bytenr mimsmatch, extent item bytenr 134=
390292480 file item bytenr 0
> data extent[134390292480, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[134390292480, 8192] bytenr mimsmatch, extent item bytenr 134=
390292480 file item bytenr 0
> data extent[134390292480, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [134390292480 8192]
> ref mismatch on [134391074816 8192] extent item 14, found 12
> data extent[134391074816, 8192] bytenr mimsmatch, extent item bytenr 134=
391074816 file item bytenr 0
> data extent[134391074816, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[134391074816, 8192] bytenr mimsmatch, extent item bytenr 134=
391074816 file item bytenr 0
> data extent[134391074816, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [134391074816 8192]
> ref mismatch on [134397329408 8192] extent item 14, found 12
> data extent[134397329408, 8192] bytenr mimsmatch, extent item bytenr 134=
397329408 file item bytenr 0
> data extent[134397329408, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[134397329408, 8192] bytenr mimsmatch, extent item bytenr 134=
397329408 file item bytenr 0
> data extent[134397329408, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [134397329408 8192]
> ref mismatch on [134404030464 8192] extent item 14, found 12
> data extent[134404030464, 8192] bytenr mimsmatch, extent item bytenr 134=
404030464 file item bytenr 0
> data extent[134404030464, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[134404030464, 8192] bytenr mimsmatch, extent item bytenr 134=
404030464 file item bytenr 0
> data extent[134404030464, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [134404030464 8192]
> ref mismatch on [134516363264 12288] extent item 14, found 12
> data extent[134516363264, 12288] bytenr mimsmatch, extent item bytenr 13=
4516363264 file item bytenr 0
> data extent[134516363264, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[134516363264, 12288] bytenr mimsmatch, extent item bytenr 13=
4516363264 file item bytenr 0
> data extent[134516363264, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [134516363264 12288]
> ref mismatch on [134960566272 8192] extent item 14, found 12
> data extent[134960566272, 8192] bytenr mimsmatch, extent item bytenr 134=
960566272 file item bytenr 0
> data extent[134960566272, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[134960566272, 8192] bytenr mimsmatch, extent item bytenr 134=
960566272 file item bytenr 0
> data extent[134960566272, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [134960566272 8192]
> ref mismatch on [134962233344 8192] extent item 14, found 12
> data extent[134962233344, 8192] bytenr mimsmatch, extent item bytenr 134=
962233344 file item bytenr 0
> data extent[134962233344, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[134962233344, 8192] bytenr mimsmatch, extent item bytenr 134=
962233344 file item bytenr 0
> data extent[134962233344, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [134962233344 8192]
> ref mismatch on [134962601984 8192] extent item 14, found 12
> data extent[134962601984, 8192] bytenr mimsmatch, extent item bytenr 134=
962601984 file item bytenr 0
> data extent[134962601984, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[134962601984, 8192] bytenr mimsmatch, extent item bytenr 134=
962601984 file item bytenr 0
> data extent[134962601984, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [134962601984 8192]
> ref mismatch on [135127560192 8192] extent item 14, found 12
> data extent[135127560192, 8192] bytenr mimsmatch, extent item bytenr 135=
127560192 file item bytenr 0
> data extent[135127560192, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[135127560192, 8192] bytenr mimsmatch, extent item bytenr 135=
127560192 file item bytenr 0
> data extent[135127560192, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [135127560192 8192]
> ref mismatch on [135146340352 8192] extent item 14, found 12
> data extent[135146340352, 8192] bytenr mimsmatch, extent item bytenr 135=
146340352 file item bytenr 0
> data extent[135146340352, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[135146340352, 8192] bytenr mimsmatch, extent item bytenr 135=
146340352 file item bytenr 0
> data extent[135146340352, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [135146340352 8192]
> ref mismatch on [135196753920 8192] extent item 14, found 12
> data extent[135196753920, 8192] bytenr mimsmatch, extent item bytenr 135=
196753920 file item bytenr 0
> data extent[135196753920, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
> data extent[135196753920, 8192] bytenr mimsmatch, extent item bytenr 135=
196753920 file item bytenr 0
> data extent[135196753920, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
> backpointer mismatch on [135196753920 8192]
> ref mismatch on [135997460480 12288] extent item 14, found 12
> data extent[135997460480, 12288] bytenr mimsmatch, extent item bytenr 13=
5997460480 file item bytenr 0
> data extent[135997460480, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[135997460480, 12288] bytenr mimsmatch, extent item bytenr 13=
5997460480 file item bytenr 0
> data extent[135997460480, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [135997460480 12288]
> ref mismatch on [135998251008 12288] extent item 14, found 12
> data extent[135998251008, 12288] bytenr mimsmatch, extent item bytenr 13=
5998251008 file item bytenr 0
> data extent[135998251008, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[135998251008, 12288] bytenr mimsmatch, extent item bytenr 13=
5998251008 file item bytenr 0
> data extent[135998251008, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [135998251008 12288]
> ref mismatch on [135998578688 12288] extent item 14, found 12
> data extent[135998578688, 12288] bytenr mimsmatch, extent item bytenr 13=
5998578688 file item bytenr 0
> data extent[135998578688, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[135998578688, 12288] bytenr mimsmatch, extent item bytenr 13=
5998578688 file item bytenr 0
> data extent[135998578688, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [135998578688 12288]
> ref mismatch on [136127258624 12288] extent item 14, found 12
> data extent[136127258624, 12288] bytenr mimsmatch, extent item bytenr 13=
6127258624 file item bytenr 0
> data extent[136127258624, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[136127258624, 12288] bytenr mimsmatch, extent item bytenr 13=
6127258624 file item bytenr 0
> data extent[136127258624, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [136127258624 12288]
> ref mismatch on [136129404928 16384] extent item 14, found 12
> data extent[136129404928, 16384] bytenr mimsmatch, extent item bytenr 13=
6129404928 file item bytenr 0
> data extent[136129404928, 16384] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[136129404928, 16384] bytenr mimsmatch, extent item bytenr 13=
6129404928 file item bytenr 0
> data extent[136129404928, 16384] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [136129404928 16384]
> ref mismatch on [136129548288 20480] extent item 11, found 9
> data extent[136129548288, 20480] bytenr mimsmatch, extent item bytenr 13=
6129548288 file item bytenr 0
> data extent[136129548288, 20480] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> data extent[136129548288, 20480] bytenr mimsmatch, extent item bytenr 13=
6129548288 file item bytenr 0
> data extent[136129548288, 20480] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> backpointer mismatch on [136129548288 20480]
> ref mismatch on [136130199552 16384] extent item 14, found 12
> data extent[136130199552, 16384] bytenr mimsmatch, extent item bytenr 13=
6130199552 file item bytenr 0
> data extent[136130199552, 16384] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[136130199552, 16384] bytenr mimsmatch, extent item bytenr 13=
6130199552 file item bytenr 0
> data extent[136130199552, 16384] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [136130199552 16384]
> ref mismatch on [136145211392 16384] extent item 14, found 12
> data extent[136145211392, 16384] bytenr mimsmatch, extent item bytenr 13=
6145211392 file item bytenr 0
> data extent[136145211392, 16384] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[136145211392, 16384] bytenr mimsmatch, extent item bytenr 13=
6145211392 file item bytenr 0
> data extent[136145211392, 16384] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [136145211392 16384]
> ref mismatch on [136155037696 20480] extent item 14, found 12
> data extent[136155037696, 20480] bytenr mimsmatch, extent item bytenr 13=
6155037696 file item bytenr 0
> data extent[136155037696, 20480] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[136155037696, 20480] bytenr mimsmatch, extent item bytenr 13=
6155037696 file item bytenr 0
> data extent[136155037696, 20480] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [136155037696 20480]
> ref mismatch on [136281296896 12288] extent item 11, found 9
> data extent[136281296896, 12288] bytenr mimsmatch, extent item bytenr 13=
6281296896 file item bytenr 0
> data extent[136281296896, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[136281296896, 12288] bytenr mimsmatch, extent item bytenr 13=
6281296896 file item bytenr 0
> data extent[136281296896, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [136281296896 12288]
> ref mismatch on [145211674624 24576] extent item 14, found 12
> data extent[145211674624, 24576] bytenr mimsmatch, extent item bytenr 14=
5211674624 file item bytenr 0
> data extent[145211674624, 24576] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[145211674624, 24576] bytenr mimsmatch, extent item bytenr 14=
5211674624 file item bytenr 0
> data extent[145211674624, 24576] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [145211674624 24576]
> ref mismatch on [149326233600 53248] extent item 14, found 12
> data extent[149326233600, 53248] bytenr mimsmatch, extent item bytenr 14=
9326233600 file item bytenr 0
> data extent[149326233600, 53248] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[149326233600, 53248] bytenr mimsmatch, extent item bytenr 14=
9326233600 file item bytenr 0
> data extent[149326233600, 53248] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [149326233600 53248]
> ref mismatch on [149571932160 49152] extent item 14, found 12
> data extent[149571932160, 49152] bytenr mimsmatch, extent item bytenr 14=
9571932160 file item bytenr 0
> data extent[149571932160, 49152] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
> data extent[149571932160, 49152] bytenr mimsmatch, extent item bytenr 14=
9571932160 file item bytenr 0
> data extent[149571932160, 49152] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
> backpointer mismatch on [149571932160 49152]
> ERROR: errors found in extent allocation tree or chunk allocation
> [4/8] checking free space tree
> [5/8] checking fs roots
> [6/8] checking only csums items (without verifying data)
> [7/8] checking root refs
> [8/8] checking quota groups skipped (not enabled on this FS)
> found 326294581248 bytes used, error(s) found
> total csum bytes: 294034880
> total tree bytes: 8848949248
> total fs tree bytes: 8187265024
> total extent tree bytes: 327122944
> btree space waste bytes: 1882580070
> file data blocks allocated: 2168958410752
> referenced 1094921699328
>=20
>=20
> So roughly 33 instances of different data extents, all pointing to a com=
mon parent, with some sort of corruption. All of the errors have in common=
. Scrub shows no errors.
>=20
> parent 219602649088
> parent 172671614976
>=20
> I'm guessing the same extent item repeated twice, with two different par=
ents are due to DUP metadata? But I still don't know what the error means =
other than the extent tree is damage.
>=20
> Is it worth trying rebuilding the extent tree?
>=20
> Thanks,
>=20
>=20
> --
> Chris Murphy
>=20


