Return-Path: <linux-btrfs+bounces-15016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23399AEACD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 04:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7973F4A0111
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 02:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C1917C211;
	Fri, 27 Jun 2025 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XFwZ3V2f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557A3C01
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750991859; cv=none; b=IJ7sWl84r8M11z7YYIwtPn7bJowLW2kx5xklXrT60dtdLF3KN1poxnGsLfhRAUlYQ/PqaxMoFVGs5tFQGjRQHGN1m3e1FEtYemKHPvTZcnSPHGswQtuuFbV3S8uc0tPYNx4e+LdubcmUyPE5Bfk0OHZnTImMVI1mL1kAP9TJyJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750991859; c=relaxed/simple;
	bh=Emc6vosXjKW6xiE1Wux1t5mxDUZuOo92W7bQUOYGyT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8fgAqmHfA0qxoe1bXSCVlPnKHzfu9atYpbL+29zkws9rzTqqxIQmq8VwMwYNDdckUQraZdLICV888wJH0CvqFPflFq7JRmAnw9sxCsZz97GygkQ+3m7HCGXCQFCcEaDmPDjzVLOguFKJN/NC80M291eWNsvTYD9Fx8HK1CDFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XFwZ3V2f; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750991851; x=1751596651; i=quwenruo.btrfs@gmx.com;
	bh=Emc6vosXjKW6xiE1Wux1t5mxDUZuOo92W7bQUOYGyT0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XFwZ3V2fJf9YigAwQyi3SS3/AoEH3bXwPczPnw6Nn0XvyOzDIW3JZOsZ1fK1o/61
	 FT90LJwRTUuYxMtCu00yhFzJCsbme3GQ7F4ZGSOfY6vkl+/2oIjk3u0f5y+SJQ/E5
	 On4E+1Sg2si500lultkRt3i9dDki41p7EjFhzCotDgQDYuU1yWuwkdrJQEfpC2NT/
	 A7+G7EBFHma+RzfnpTK8nZY5U+n+VKVRXgloWg89P1wex5K6k0AAmsA88gJDiGmen
	 Dr8FRatjD7y8k5/gUhfIj1is3KneoeLfyoFTAEaRSrEOTUrsMaUp32alcYo3aqSS5
	 67VQE7excmhelW6hqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QS8-1uQbFq48XI-00EVAX; Fri, 27
 Jun 2025 04:37:31 +0200
Message-ID: <8d6000bf-9317-4ccb-9383-a466a574df83@gmx.com>
Date: Fri, 27 Jun 2025 12:07:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix a use-after-free race if btrfs_open_devices()
 failed
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 syzbot+772bdfe41846e057fa83@syzkaller.appspotmail.com
References: <1c173aadfc405763e3920e4d87c56992cae9e278.1750983699.git.wqu@suse.com>
 <20250627010918.GD31241@twin.jikos.cz>
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
In-Reply-To: <20250627010918.GD31241@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VuNPgMzhnzUxKq34KpfhyP74xrkwUZrr0j0furiJU3WtRoa8Op7
 0ozAXlUcry2k/aNWw6RcHKGdPxEoZiufDkurEM6ju039K6R8pXP0XeRdFGv1/TTVaEBkh5E
 sVSECQ7BGD7JGg+/QGKc/xXAI7vAk6BsNHXlR+Ltpx9tUQ9sR0CqvWwyveXP70sAn3RnJoE
 bnTXZ7m0EzlJI2TCxA79w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fhShvB3wUJA=;gPS7Rq3JeDZipVaYvEtJSJ7PMqh
 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



=E5=9C=A8 2025/6/27 10:39, David Sterba =E5=86=99=E9=81=93:
> On Fri, Jun 27, 2025 at 09:52:58AM +0930, Qu Wenruo wrote:
>> [BUG]
>> With the latest v5 version patchset "btrfs: use fs_holder_ops for btrfs=
"
>> merged into linux-next, syzbot reported an use-after-free:
> ...
>> This will be folded into the patch "btrfs: delay btrfs_open_devices()
>> until super block is created".
>=20
> Thanks, patch added to linux-next branch on top of the series for
> clarity, for the next iteration it can be folded.
>=20

It turns out there are more locations needs similar handling.

I'll need to send out a v2 update for this hot fix unfortunately...

