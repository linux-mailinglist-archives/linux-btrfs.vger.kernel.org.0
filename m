Return-Path: <linux-btrfs+bounces-13031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF41A897BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 11:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3660A1891017
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA7B2820AA;
	Tue, 15 Apr 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lJ8uWvmz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BC27B4F5;
	Tue, 15 Apr 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708640; cv=none; b=ngpjXj+Ae3p3QNDeUT05e8flQzI7jxQtKwZEngLUDqCmWf1/ygO2DBKKnAHXwMQIPSqid1G2oCB20jpzE8TfSjZOSsutxxU9OnwyYXv45835kgoAeBtIGTQeyZvBShggt9E5jITeFDo4OZlEcZ+GClNdkXnVQgQc004JnT+VwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708640; c=relaxed/simple;
	bh=/Z6Vnn+qWI+21lnQkuUK+7Nswud+sktGjAVWAnSCZ5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nI4xuc+K5LZdo6GNGrTfeUeY56hGCcmqyi73NMJcy2s2izlBkmFYK0BXjwAKv/gp5kbl5tVQsFpLhDSezMZ4lXJ9+DeSjWi5V4kdYmAHW34Pe5/Z/oZ2HY1jGDXZF1p1eDQbJpk8HinURbbWtYVqr+dsZ6aMEynfx/PfB8qHETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lJ8uWvmz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744708612; x=1745313412; i=quwenruo.btrfs@gmx.com;
	bh=E8m44XUDiZ8rmpdGVKtUxtqM66u9YgxFJM/5gTCVYPY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lJ8uWvmztbzLU+nNiA7oIMNmiZ65Ja+LYaKNS7aMy+LFXjy3qQAGEqnoZlJX5MUh
	 jO7UpvuKP8jjhifD5hWXfL6uprlVZO9K2kKcA0lq5AVDewHgu2/G9g3Jv7DiO9k1s
	 U1541gPBJBJPp6TcgRtCBZcVc1YkFjw0TpKyMOrewnRxgDX/cLK2DzVlXg/b+4x7R
	 M5K3wuO8zd1WIU5oQwLvpak/AtpMQCmKYIkHUsKOzrvNxcFj4AXFdRxClaWVL8ImL
	 2nwMqcWJ7soQWan4D2rGumvaz1EkPkuk742VQwXsD35AG396aVVQhhzUvF+74CruT
	 aMGEVsLufdCqEw9xsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQv8x-1thKXE4C19-00QF05; Tue, 15
 Apr 2025 11:16:52 +0200
Message-ID: <2e158208-4914-4bfb-984a-0d35e8b93225@gmx.com>
Date: Tue, 15 Apr 2025 18:46:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove BTRFS_REF_LAST from btrfs_ref_type
To: =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>, "clm@fb.com" <clm@fb.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "dsterba@suse.com" <dsterba@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250415083808.893050-1-frank.li@vivo.com>
 <472ae717-5494-44ae-973a-85249a65d289@gmx.com>
 <SEZPR06MB52691756B32BA90DBE82BDFDE8B22@SEZPR06MB5269.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEZPR06MB52691756B32BA90DBE82BDFDE8B22@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D6zxEJdb73VG9FWcLNJ7JFeRbdERziL59ko9inq5fb4VNDDDMV+
 zXSpGkkGpCSJr18UWKo+8VYooiJZnvIZJ8WUpsQGImPx0/e7JwJl4WwFqtakDpCbVjtF5md
 T2sYC7MXp1fnRqsAcnwULCIOPPudam9AuqPJpSZ2HQwgoRVYsH85wdQ/ciGVYEw5Zt2bfIp
 p4wiefKvRtAj8JA3JSIaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mh5kB+Mczr4=;8zYrTSiqDlmduS55hGEieOqfpKx
 GIB/yrp96GCGjc273RVBh+zaDWMcKS1ToteMw/q3w2rPsbnDI28r7VobZCcl9bbBhjaHrCL1y
 1AY5lFYVgu2qUZu0p8uIhna9NBUUy3WuMtQ4BTScaolCsxIEISKTHRazSvce6jXlQVEwKV2kT
 vwokWJesMny45SYHnIOfLzjxrpwxOSA1zJChEXnWHY2PDJCzQxL35ZlMaF8R6moN7+PwvF32k
 9haLOMUY8l37kvye9CF8mOWBb0Ar+XPqkyMsjqZ1vwbPEIolb3Bk82GuJ5iPiPz0xwj6m2nuL
 5DkvM+Bss64rYedKuRPLC5HCpK3xSsObiADteO6L5EC9WtxwFcdjJ63bVcLHJ7sg3x611LTtC
 AlQs8IQxmXqrHcNOeVYo2DmV95VbFovSXj9EFbqpXaOB2eGXbKXB9/7n8/BwoXSUCqp5IFpMY
 OqxaBey9gethsfQ2/LOvAayWxN778DucKB6JuJ3iht/03RyTS6piWKFFxwWg6f1xPr96lZ1Ww
 VYKOWZkhbekf1saXg9Du5KoLxzCHj0zrgi7xvsPWp1HGTEzkLjnaFo/bfFii0mQiR7fw6semy
 3HV8RJ23x4iVVYK7Uh2S3anHL1t9NxbZwjvPt4b4s/wvFs+0ej4kdybCQ6tyfT/V+5phWxpSY
 t5/up5ypYPjzHAYVyFbH3g6+iFtQOwsUxEi4Yjp2ShpQDCryxnsgbxbqg95LMNoK+uKZeF4qr
 itH5qUw4GRGzfI843I8u5b02UsMnzFSuA35g/MDkJH2PLNzc84g6hnTGg11wSLcaC/A2zQnCg
 c0U+CHRIVuyYCdgHvID3FyKgDxFx3X3ZVSZKEUugi2JZM8UFuwQjA6+EHtnuaS/wpDfgrxkIi
 wgTkrEyaSnw5BN194HCw/dk7a1L7KBv3MSuI4H1mWc1nu+PDmixJePdlCr3ZGJysaznWxrU+l
 AE4WWFpyzLuOB+JyHt25caVCc8/vlNyOrEODGrtVbeXtZordh1yyogZcbaUdBcp7qdeRjqnEu
 WqB9nx0OXLWpIoojdL2RaoqpBtMm1Fs9cnDCGsUyMOWsRfCvwK2jCm1LbDWqXkJ4KmK0Nz8V1
 mO5tdzNOiR1Xdt2H99MzFeDaA2hgGCIzXRth/b6D0586Y/gSRpVdNQbutTxucw7kSqCadtmI0
 sHHuWrWL03GXdnhB92Ae0TzxV9ZBworK7MuGhMby0XfbL4uaVZZXry0c11KVgpOAFqCvk7Py7
 TN09v7QseI9Vdhqm9TKLQqX1+za+AtfVVfiNhMNbm39YsCugDuiW+/vSSo4hMmItrMHCJM+VI
 n62AZSg62yy/VZtWUYVn/yJDOY7r7vX7eezbYVQ66Nzhs9a+BJTcxUJz8R7emXT+/1BAn0+4N
 Les/O+w4lHlda9snB4s9bvXzOeq6ERv2gdCwsqDj/6W+UEGYjgd9VYewtgktCwP+4xBXPwUE6
 HLhInog==



=E5=9C=A8 2025/4/15 18:26, =E6=9D=8E=E6=89=AC=E9=9F=AC =E5=86=99=E9=81=93:
>> History please.
>
> Did you mean change commit msg to below?
>
> 	Commit b28b1f0ce44c ("btrfs: delayed-ref: Introduce better documented d=
elayed ref structures") introduce BTRFS_REF_LAST but never use it,
> 	So let's remove it.

It's the common practice to leave a last entry for sanity checks.

But since it's not utilized for anything, I'm fine to remove it.

>
>> The _LAST or _NR suffix can be utilized to do sanity checks, and this i=
s not part of the on-disk format.
>
> IIRC, delayed ref belongs to the extent tree memory kv cache.
>
>> And if this exposed by some automatic tools, please also mention it.
>
> I'm just looking at this code.
>
> Thx,
> Yangtao


