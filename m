Return-Path: <linux-btrfs+bounces-13449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E60A9E4BD
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Apr 2025 23:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF52189B37E
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Apr 2025 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274A1DB34C;
	Sun, 27 Apr 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dW+7K5Gq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9314433D9
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Apr 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745790852; cv=none; b=HWQot/XX1NCOHRu0BzfUuw/Dh56YRAnmQ28q9JTdfU29xydEhTS82psmX4DAzRk4SoUZcYotlFfitQUwM2YUER7R27KkRJVjTiuvnJp6ApNo+q09vtcpx+8KnVjgzIVCf6tMIOIk9cZsFsRq1lWtsAxbcWi2YSi2GjYdpR3710I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745790852; c=relaxed/simple;
	bh=v5rTtmOUJpfBDSdUmFGPxdAUtXjNJjr6+Ri1pzfR2Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cTfkqfxvBje9kIcHevREPADH0Hh1g6HoO4ryoofMgaPoN/eeFXW+dbYYdFjtQ6qM0EZ/QRzzbImiWJrW2CPjnXjnDd6/Z3AcOBbouFyviFPzIsNmrxlEEjUyWa9wqG4e+8IQYd/EfMkE6vyUGOwspWLEe5hWKpQXp2g8i900pEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dW+7K5Gq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745790848; x=1746395648; i=quwenruo.btrfs@gmx.com;
	bh=XVx00264UCsBNvjqWutKOXJM8HczSksQ3sumWvwkIP8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dW+7K5GqDDmMTVLFihYOJabR6WQMlYmg6eEw9WF1xv9ONTuF7H/qw8KeRduLFPNz
	 8LQtbU5ivGbUmQ9JxtqkcU3e5IowREYPuezxB2VkLryDlJKPebJ9zcnVtjQYWdxHK
	 zQ0XU4s+r6BnM09CN0CUJPkoS84P7dXvqTLnwfrIuTSdDUd4qD0bOkaidiBFb8tsG
	 gol/sEa9n91KrJtHJg3qWMVTV6crzVKo3tVS/A4947GpU84DP0PHNylFWgnXhcTCO
	 Wle3GJeOyPejOAkEaA/oBdWDf86Ee3hNGp89bFygOWdqqSlPqaWTAbb62tv/PbpqX
	 7rHpOamAUXrdtq2txA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MA7GM-1uFBHY1FKU-00A2lB; Sun, 27
 Apr 2025 23:54:07 +0200
Message-ID: <4acb00aa-622f-42af-97a2-bc216a050ebc@gmx.com>
Date: Mon, 28 Apr 2025 07:24:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stack trace on next-20250424
To: Christian Heusel <christian@heusel.eu>, linux-btrfs@vger.kernel.org
References: <c5833b22-d8ea-4077-9283-de9d13f0e4b2@heusel.eu>
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
In-Reply-To: <c5833b22-d8ea-4077-9283-de9d13f0e4b2@heusel.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Deu/QTnVRWLkMcszFHSkwysa5FngNIzLuQhztwfET0xLZ4lbqyp
 kRGKmyHauFL+5TGGVwIcpA4I881nd6MmTriX6BG7ZEzdCCnc+fEpLKGySas12uqbPk7oyDu
 Xe6/3xq+ANviGGy1butBvbo6jBibFVCFOp9tDBKLAEgWWx99ab4jBaqXMXPBMIeeZKWwH38
 0mALLL7LeYlQ7yCrF1Z2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4mOcDPcSzzY=;3GPZZlNxgTg78ndLWimkN4c6/Va
 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
 2XBE3qQ6L+ihGkVGPd1m8RysMflx6Ic=



=E5=9C=A8 2025/4/28 02:55, Christian Heusel =E5=86=99=E9=81=93:
> Hey all,
>=20
> I have just test-booted linux-next on the next-20250424 tag and
> encountered the following error:
>=20
> [    5.397970] BUG: kernel NULL pointer dereference, address: 0000000000=
000000
> [    5.399379] #PF: supervisor read access in kernel mode
> [    5.400417] #PF: error_code(0x0000) - not-present page
> [    5.401357] PGD 0 P4D 0
> [    5.401826] Oops: Oops: 0000 [#1] SMP NOPTI
> [    5.402555] CPU: 2 UID: 0 PID: 375 Comm: (udev-worker) Tainted: G    =
B               6.15.0-rc3-next-20250424-1-next-git-06092-g393d0c54cae3-di=
rty #1 PREEMPT(full)  e5bd168551b00ee32e542180030e13fc43de91d1
> [    5.405546] Tainted: [B]=3DBAD_PAGE
> [    5.406079] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
Arch Linux 1.16.3-1-1 04/01/2014
> [    5.407287] RIP: 0010:alloc_extent_buffer+0x2d6/0x670

This is fixed by reverting this patch "btrfs: unlock all extent buffer=20
folios in failure case".

Personally speaking, our linux-next is a little less stable than our=20
internal development branch at https://github.com/btrfs/linux/tree/for-nex=
t

Thanks,
Qu

