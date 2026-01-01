Return-Path: <linux-btrfs+bounces-20056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B4ACECB18
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 01:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C0EE300722A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 00:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8B165F16;
	Thu,  1 Jan 2026 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LjA/Oi5o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036157260F
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Jan 2026 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767226420; cv=none; b=RaoV0sRje+bL7pEYyvOnydDosXDxQDzyoepIATNvAINMTXDldOgtF3OwfuM1Kw6maseagFnpsqzk5hw/0jbc3dLwMbCOzVD1/KOFKzSXl4xM6ToFdLPQDaVsvA15XFYf47SB23VpTpJUdLa+flrAZTlWW76FKQv1w2jqqup2HwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767226420; c=relaxed/simple;
	bh=sKQ1L2MPzh4JrTan6VkbNUOfYOk8rIGOV5+nfMJPLP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2ACdcZEydGwvLMVUotqu++HpSMdybQob9STAbyvg4gQxxp7NUIMiP/G1hSZ6RyRrndKzFHQmdxByAnwkyJPUxWVh2bXrulmYenHLwlf6jQ26yYXV/6y5wj+sdZ89rtHzlk/2hseHPKUlJLeySRb1SLheeXJbhi/1JhsR3YA5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LjA/Oi5o; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1767226413; x=1767831213; i=quwenruo.btrfs@gmx.com;
	bh=MsIa+0q60D9wXV5Oi3kAgZwxd3orejOPPHGRSvDpUJI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LjA/Oi5oTr3XACc380oB7qdMI1z0QY+/O3AuaymZ7lh463vY3UMP0HBzqoCAn4T/
	 butJEW5pC4EwXSYJbetUMafy1Zk96u+DK9Yn5hcpi7EAwe9opn7rjaKiXaTzaFR7j
	 qXCr3Bzz2JFFmfXGg4PVdhZB5sKh5U5ac208hWkEIISC9KNuMvJemN+5pu08vGOOz
	 CU3fSpkshidf3FB62eX12FSQU99IOVk8iJsWgJE1IqRYUvM10OtgC/mwhM9ZB5mB9
	 WihY0ahMWUYDQ6FoKZcIdbOd/ocVxWvPQEp7Z6HqqBa9tDk8jMO+r1oSZ13pbTAHD
	 FUjjdNe98oWmiXV5Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1w1Of63UZ6-0161Qr; Thu, 01
 Jan 2026 01:13:33 +0100
Message-ID: <380cafc2-1460-474e-b793-ea7813103dda@gmx.com>
Date: Thu, 1 Jan 2026 10:43:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] btrfs: fix periodic reclaim condition with some
 cleanup
To: Sun YangKai <sunk67188@gmail.com>, linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
References: <20251231111623.30136-1-sunk67188@gmail.com>
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
In-Reply-To: <20251231111623.30136-1-sunk67188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZyeXq84COGUnhgj1lQWxEYOjjM3J4pfQ38KXveL6fJPNOEehgFh
 h4D/+uSx5EsApE9bJwlA1ERqVfZsxIXo/FDK+7L15+mTdK8TqqmNNzsURfgY7+C0Dw+VLH7
 6ItpeIDsSMe+/7ohNACT2MlS++lIR94UCWqdzGOqmEHvSZMnrA7FyAdS5TlOyNO6iovvt73
 KZBY0MiRbK5kk8EMxj7Rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lai7qC/f9I0=;J85Ar12U8Y7P3Mjkr1uITO3H3sY
 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
 70XSwOxh2GdByL41DPIy+JOArbCuO



=E5=9C=A8 2025/12/31 21:09, Sun YangKai =E5=86=99=E9=81=93:
> This series eliminates wasteful periodic reclaim operations that were oc=
curring
> when already failed to reclaim any new space, and includes several prepa=
ratory
> cleanups.
>=20
> Patch 1-6 are non-functional changes.
>=20
> Patch 7 fixes the core issue, details are in the commit message.

Fix first then cleanup please, this will make backport much easier.

Thanks,
Qu

>=20
> Thanks.
>=20
> CC: Boris Burkov <boris@bur.io>
>=20
> Sun YangKai (7):
>    btrfs: change block group reclaim_mark to bool
>    btrfs: reorder btrfs_block_group members to reduce struct size
>    btrfs: use proper types for btrfs_block_group fields
>    btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()
>    btrfs: use u8 for reclaim threshold type
>    btrfs: clarify reclaim sweep control flow
>    btrfs: fix periodic reclaim condition
>=20
>   fs/btrfs/block-group.c | 29 ++++++++++-----------
>   fs/btrfs/block-group.h | 22 ++++++++++------
>   fs/btrfs/space-info.c  | 58 ++++++++++++++++++++----------------------
>   fs/btrfs/space-info.h  | 38 +++++++++++++++++----------
>   fs/btrfs/sysfs.c       |  3 ++-
>   5 files changed, 81 insertions(+), 69 deletions(-)
>=20


