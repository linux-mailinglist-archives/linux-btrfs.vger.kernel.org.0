Return-Path: <linux-btrfs+bounces-13443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304ADA9D9FD
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8449E1BC22C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBAC224AF0;
	Sat, 26 Apr 2025 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RoGabJU5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47CB1C36
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745662107; cv=none; b=QYiuLPceSHfbb/Ty6u2mry76vDwd++6Pm+N/cvvBnjkBQwDf4bmmzAmdWUVAg1CoHq67dHHnKtqUmJLbYLEDvlo0rMBdIRNT1i/osA9JsIhNdx8CHWuBe+mipcVPSqJ8ABUJf4M1CrQkNktbLq9Ap6A/izbCsaC/T8Ijfy43i6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745662107; c=relaxed/simple;
	bh=+nJ6uRaQnGGXKmsLQn9WYpI1s2kyAp+BSzqti/I/kRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=McH4ga4m8lmEJ8qRgGFH3MB+/OznehtH5l2xndygKjVoaPYiSUCs52S2N5X+54nVZkiY2czKKtw4HTdviLfeo7aWOWEQRyylenYVQ5tQlFljgYRlfwG8dbSldvsDxEdUNSFPsJ7XVWhcalp0uJ7QIQ/xIEzjQj31SiGG4sTPjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RoGabJU5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745662102; x=1746266902; i=quwenruo.btrfs@gmx.com;
	bh=xKTbLHwQKoVJ6k0VTqmJCfgaSR5RY1ObtvWOO1O3ktg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RoGabJU51XZMvykQSpLw9bhT1B5xD5Nblb8O4I78CALbDIj7aSvAfNNgkOObWuC+
	 GeJ7vfw9H6Ms0nlVbAnuQhLk7UuLYanZ7Q9IoEkj8in/r4/r+E7Gn1tm3UQLg27fJ
	 siXsjRncO6uHeZsBr07y6ZT+AjfM4LyhbuGLqCgCU6MJzzlxwum84smqtN8qULiuX
	 x78vPn5zpt607wvGG82ti6xyhvb26LRn21YwNT4wzzqw0EzmrarLxEHDQU9OQQ1Rc
	 JWbw4bl/Rc6ZSCfNQ/P3Tkmx5yWAZA132v15dJ4wF6f+PE2u/If3RRDsQUgtd/ra9
	 EnOiTMKqBVYIXQXqwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1urodv1473-00kMxp; Sat, 26
 Apr 2025 12:08:22 +0200
Message-ID: <bb9b6bd4-6638-4139-8ccc-dc677f85e3a2@gmx.com>
Date: Sat, 26 Apr 2025 19:38:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bad tree block start, how to repair
To: "Massimo B." <massimo.b@gmx.net>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <180daac980bec43d45d0e6fa4f9e1d14fb126de1.camel@gmx.net>
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
In-Reply-To: <180daac980bec43d45d0e6fa4f9e1d14fb126de1.camel@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nT3OqTtmHCtjFZttpI0bBXbnfF76sgSF8SQKInTferO5S1W6g/w
 Nph6xCfTaCZVy2RSjnJcirv60MuukxfBGtaw60DxQ8wqMm3bWVNVzV5WfbY1tAYec12pNRs
 mRMhduWd+NvQxHyNOdyGp64dUvqfH9C1q1u88SITH2OrY7LQnxoU7scRRFnNkD6yOkntTyP
 IGdnrYyYsAHkbQataZJfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wYGisR/IC+4=;VmuE7yA3+060T0061nNON3jHNH8
 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



=E5=9C=A8 2025/4/26 15:57, Massimo B. =E5=86=99=E9=81=93:
> Hi,
>=20
> I have a btrfs on LUKS on a NVMe disk inside USB enclosure.
> I send all different snapshots from different machines to this btrfs via=
 btrbk and I'm doing a lot of bees.
>=20
> Is there any chance to repair?

It looks like only free space tree is corrupted.

At least you can grab all your data using "resuce=3Dall,ro" mount option.

Unfortunately I'm not aware of tools that can drop a corrupted free=20
space tree (the existing tools all requires a working free space tree to=
=20
drop free space tree...).

Thanks,
Qu

>=20
>  From syslog:
>=20
> [kernel] [10370.573757] BTRFS error (device dm-1): bad tree block start,=
 mirror 1 want 2564600332288 have 4363494421962462810
> [kernel] [10370.574024] BTRFS error (device dm-1): bad tree block start,=
 mirror 2 want 2564600332288 have 12261462772841064395
> [kernel] [10370.597214] BTRFS error (device dm-1): bad tree block start,=
 mirror 1 want 2564600332288 have 4363494421962462810
> [kernel] [10370.597390] BTRFS error (device dm-1): bad tree block start,=
 mirror 2 want 2564600332288 have 12261462772841064395
> [kernel] [10379.866453] BTRFS error (device dm-1): bad tree block start,=
 mirror 1 want 2564600332288 have 4363494421962462810
> [kernel] [10379.866632] BTRFS error (device dm-1): bad tree block start,=
 mirror 2 want 2564600332288 have 12261462772841064395
> [kernel] [10379.866675] BTRFS error (device dm-1 state A): Transaction a=
borted (error -5)
> [kernel] [10379.866678] BTRFS: error (device dm-1 state A) in add_to_fre=
e_space_tree:1057: errno=3D-5 IO failure
> [kernel] [10379.866680] BTRFS info (device dm-1 state EA): forced readon=
ly
> [kernel] [10379.866682] BTRFS: error (device dm-1 state EA) in do_free_e=
xtent_accounting:2994: errno=3D-5 IO failure
> [kernel] [10379.866683] BTRFS error (device dm-1 state EA): failed to ru=
n delayed ref for logical 2564165648384 num_bytes 16384 type 176 action 2 =
ref_mod 1: -5
> [kernel] [10379.866686] BTRFS: error (device dm-1 state EA) in btrfs_run=
_delayed_refs:2215: errno=3D-5 IO failure
> [kernel] [10379.866851] BTRFS info (device dm-1 state EA): last unmount =
of filesystem .....
>=20
> # btrfs check /dev/mapper/mobiledata_crypt
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/mobiledata_crypt
> UUID: 8fefabb7-11a7-4e12-8ee6-dc8f1529f8e5
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab462=
4d
> checksum verify failed on 2564600332288 wanted 0xc04b5087 found 0xc3757d=
e0
> checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab462=
4d
> bad tree block 2564600332288, bytenr mismatch, want=3D2564600332288, hav=
e=3D4363494421962462810
> owner ref check failed [2564600332288 16384]
> ERROR: errors found in extent allocation tree or chunk allocation
> [4/8] checking free space tree
> checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab462=
4d
> checksum verify failed on 2564600332288 wanted 0xc04b5087 found 0xc3757d=
e0
> checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab462=
4d
> bad tree block 2564600332288, bytenr mismatch, want=3D2564600332288, hav=
e=3D4363494421962462810
> could not load free space tree: Input/output error
> checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab462=
4d
> checksum verify failed on 2564600332288 wanted 0xc04b5087 found 0xc3757d=
e0
> checksum verify failed on 2564600332288 wanted 0x98e25cd6 found 0xbab462=
4d
> bad tree block 2564600332288, bytenr mismatch, want=3D2564600332288, hav=
e=3D4363494421962462810
> could not load free space tree: Input/output error
> [5/8] checking fs roots
> [6/8] checking only csums items (without verifying data)
> [7/8] checking root refs
> [8/8] checking quota groups skipped (not enabled on this FS)
> found 1978635726935 bytes used, error(s) found
> total csum bytes: 1785865480
> total tree bytes: 157852188672
> total fs tree bytes: 136425439232
> total extent tree bytes: 19102629888
> btree space waste bytes: 29931988767
> file data blocks allocated: 96097451388928
>   referenced 29948246061056
>=20
>=20


