Return-Path: <linux-btrfs+bounces-13053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B2A8AC7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 02:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6131902CA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 00:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0063C101DE;
	Wed, 16 Apr 2025 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bNhtvSCv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF7EEBA
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762147; cv=none; b=JUiI5HF1MRePx4qKqmkb2ZUu8PhuySKUHXjL0JjkKvjgWzL6brnADPmYCmRKYAyXhl0ksIlNBr57oYHCQHZqg7b0w9KS1lchiy0VV3rhaRBw5lWQ2xB/m07e1paTsc2NJTkqvTddotDFDSI+PyK86ZIwsv2bBSSV83OtnPaFja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762147; c=relaxed/simple;
	bh=UhdwKUdcDaolNRk6aOs/2MmGUSfsVnwLYoZZLc/0N+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKyHNUs2hklC511IyHNYSZjFIcjXdR+eJzJwSfFcOejTBciE5IozK2GBsA+amLdzxNiCOcaXE9zdDlDS+OZS+nRNFBvvFsYf1OFqR7j4xiJyGw9QUc0Oz1J6frwyeINxEhvt285O8aHZ6tYgTFhxEmG7YKHzllXMgtchm8dYMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bNhtvSCv; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744762102; x=1745366902; i=quwenruo.btrfs@gmx.com;
	bh=pLYanMLCw0jEppTeaOLlDE/NTE0sMPUE3vRygYj1ViA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bNhtvSCv0Uec5/g414ohW2Ymqp9/Z1Xwh6utpa9vLzadM2r2Ng/lHXpc4sJ83/sd
	 O09s7qVU8zJV8NYj5LugjUS7hYBNjeNkaP4WRCcoCBvfOGLrgkxD5d5p7w6DwnRzq
	 GxuxpMbZCTgPhocEgIdc6He40tYFSeEHML5Zo15FmaRnkSOUv+pWjP0hhm+2hJodl
	 w+/01L5t1bLPQ/XnKDvh3g+xOqExdZDFUIQPaIr/qhvl25kkRy/lAz/wZ0WUmmSz7
	 Tix4bsj9Yh729ddR+63svyJDWwoiGP+0J9+ZBfsp9/dgudb4BeZKx10OxNFJTgoFu
	 Xi9kwr0VAeEA4D4ZzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5fMY-1txgeV45LG-0047xE; Wed, 16
 Apr 2025 02:08:22 +0200
Message-ID: <277bda51-f6da-4800-b1ff-7c4fe834f0ec@gmx.com>
Date: Wed, 16 Apr 2025 09:38:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
 <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>
 <27440332-2afb-4fb8-9ebe-d36c8c33a89a@gmx.com>
 <20250415172513.GC2701859@perftesting>
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
In-Reply-To: <20250415172513.GC2701859@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tLMpRws9M1Ot3C51dCFwm1S2b2tWJr5EP8A4WxZtyeXzzuztWvG
 IA7Twv0AJeARLowXHZaAMysoftfqNGnsirWIX+MB72cX5VjHN60ZUG8/GI4ykNGN4NVu4x5
 dnhPqqPL1oWmWtoXg8k4AZ234aHtK93Yr+J3FF6RxxLvJaJ7BAMy3ssySPdG4UzJ7nk7poS
 kKWep2WQoqJ8z+W9kt3cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i4UD8IRlzi4=;/E3MZmaYvaGC9ZBJeHwf9EZAPXb
 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
 aFisHDKIxw==



=E5=9C=A8 2025/4/16 02:55, Josef Bacik =E5=86=99=E9=81=93:
> On Tue, Apr 15, 2025 at 08:07:08AM +0930, Qu Wenruo wrote:
[...]
>> 	return ret;
>> }
>=20
> Again, I'm following up with a better solution for all of this.  The cur=
rent
> patch needs to be pulled back to a ton of kernels, so this is targeted a=
t fixing
> the problem, and then we can make it look better with a series that has =
a longer
> bake time.  Thanks,

I'm not against the fix, but just want to point out that, the fix can=20
hit problems if not all ebs are node size aligned.

But after more consideration, I believe we can just push for a backport=20
that rejects unaligned tree blocks completely.

IIRC it's in the v4.4~v4.6 era, so it should be completely fine even for=
=20
the oldest 5.4 kernel to rejects those ebs.


So I'm fine if you just add a small new patch to reject unaligned tree=20
blocks as a dependency, and push all those for v5.15+ kernels.

Thanks,
Qu

>=20
> Josef
>=20


