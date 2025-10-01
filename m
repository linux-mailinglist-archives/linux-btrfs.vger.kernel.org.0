Return-Path: <linux-btrfs+bounces-17303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE756BAF5D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 09:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B683C78E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7926C3BE;
	Wed,  1 Oct 2025 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jyN3atM3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3E26A1CF
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302850; cv=none; b=XzbsKH/fAkoqFJBxoG9ZR/0EcB9SGtz6UVAfzYvM2tISband07aNy4pTesVfV4t8olnL2yNWow4yUAb372ihfG+iLExOO0bz4txnoddBpZBuwFExnXLybkie+mf5lmenripah9F7RaVCEBrR0iGptauebEa1Af+3wJDV+nhJfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302850; c=relaxed/simple;
	bh=8M+5cutOPlFzGMWC/kduzOBQozF7zehFhGdzI77FDTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bDon+tJ9BR9JeBjMXmeRxco38R5lNIreJZgJlwn060koXTinDoZ9nIteg0CneRbrQDhu5oi3UJmXpkrrhUQK3psjytBYWUyNzV3fgdLAeteSpnJdmD+ttQt3l9W4t1/o9sWPpfe1FUQJTASB9+8jBbLAmNUTadCzG/7j0Spej5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jyN3atM3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759302845; x=1759907645; i=quwenruo.btrfs@gmx.com;
	bh=8M+5cutOPlFzGMWC/kduzOBQozF7zehFhGdzI77FDTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jyN3atM3yQyc+e9h1mdR15qTA4UGEI3KhZJN9w6kz1CF2AbeyiQLY54WJOWck3DA
	 yHDv5znLKo+vYfCr/T/DYjZY6l4gAvZh78HvQKO1XhQCu/QmHTV8Qk8cBl2Vz0gQY
	 Rh/3F0GwWONhWByT0uSf8IGG/MQtG5qZJKspnYVYLlPBf/Qkj/oiWRTCQcwYKjNj7
	 UL9bxUAUIPVpGQm52kBHc/3/VQLfLbkIWQIaM6wLWgd7+B0Gh+BN+77mNe0h2FpRr
	 FppmrwG2mOdzMZOj7+faWRSvjiCsKXWRA6g/DKh17PQ7Pb72o3ZR66Ww6A40CMpqN
	 MSz4ZBqD0kmgdVU1OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hZJ-1uziIe0bth-00ByGa; Wed, 01
 Oct 2025 09:14:05 +0200
Message-ID: <ce039910-3354-4054-aa3a-940bdbcf30b1@gmx.com>
Date: Wed, 1 Oct 2025 16:44:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_btrfs_rescue_chunk-recover_aborts_with_=E2=80=9Csca?=
 =?UTF-8?Q?n_chunk_headers_error=E2=80=9D_on_a_healthy_single-device_FS?=
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CABXGCsPW5P16tN2jX7dkL8FiwKOfSMc6bExZZhjuUzBaBwnLNw@mail.gmail.com>
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
In-Reply-To: <CABXGCsPW5P16tN2jX7dkL8FiwKOfSMc6bExZZhjuUzBaBwnLNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D3EPXxqrkbliaODKjwzMomEqxS1COJ8I/UHPAV0wjSTPu7jacQE
 N1+q+u9IGbQbBn1Uu60imhxG/T8ONddNpAsGQVL1uX+N4WUf6pc9rQ7A/nAeQWUlp6HWGAF
 WHOuO6Pc9mv4XdKUtDfC7QBslCe3mVlD2AMvItY0AHt94VHRrcQmj6Jv9SoQkQusxBY/VNf
 iJXKoQrvos2cfLiZbG41A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M9nanBRJhRY=;YAfKenobiX+9WSt7bibxeahYd33
 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
 FcLzQ==



=E5=9C=A8 2025/10/1 16:27, Mikhail Gavrilov =E5=86=99=E9=81=93:
> Hello,
>=20
> btrfs rescue chunk-recover aborts with an unclear error on a
> filesystem that mounts and works fine. The chunk tree is readable
> (full dump attached).
>=20

Overall you shouldn't trust chunk-recovery tool that much.

It's a very old tool without much active maintenance/testing.
(The existing testing is just to make sure the tool doesn't crash on=20
various fuzzed images, no guarantee it will work correctly)

If you found a bug, we can try to fix it, but overall it's not a high=20
priority tool.

> Environment:
> - Fedora 44 LiveUSB
> - btrfs-progs-6.16.1-2.fc44.x86_64
> - Linux 6.17.0-63.fc44.x86_64
> - Single Btrfs directly on the whole device (no partitions/LVM/LUKS/MD):
>=20
> Symptom:
> root@localhost-live:~# btrfs rescue chunk-recover -v /dev/nvme0n1
> All Devices:
> Device: id =3D 1, name =3D /dev/nvme0n1
>=20
> Scanning: 16643136438272 in dev0scan chunk headers error

There are way too many possibilities that chunk item scanning failed.

E.g. different chunk layout for the same chunk, or failed to insert an=20
chunk item into the cache.

Some errors may be a bug, some may not.

We need a full binary dump (or at least btrfs-image dump) to verify and=20
debug.

Thanks,
Qu

> Chunk tree recovery aborted
> root@localhost-live:~#
>=20
> Is this early abort from chunk-recover expected in such a case (i.e.,
> nothing to recover), or does the tool miss a chance to print a more
> specific message (e.g., =E2=80=9Cno recoverable chunk-tree issues found=
=E2=80=9D vs a
> generic =E2=80=9Cscan chunk headers error=E2=80=9D)?
>=20


