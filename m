Return-Path: <linux-btrfs+bounces-16685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE66B46672
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Sep 2025 00:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D451E4E0368
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54502ECD30;
	Fri,  5 Sep 2025 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UiI0+0ML"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA322F548C
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110353; cv=none; b=KTzrbwVUoAt/oGlFE34rkt7bNQT5YeuSOJuB91kQw7KVIX6dju3P/iR/bcdU4wBofvf6MfvofNpKMMK+bzMpQZZGyw5ZSXOZzK31SiVSppA03STapsW+xqLQcJtdT76s4s8Dn3H8yIKfn+WodlrHOguKNhyYMBlVqW+0fLVwlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110353; c=relaxed/simple;
	bh=KfokimG3grT6OOjSJF6Ks7gXyuqr6uZSUq8KIXqPqyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvZvvQg8oGBXClKsF9RNRankQhbsuB7nLjmseteKPDlQcHDit1Uad4++zge/BiqeeBOl2IjA/QDL/OIpOgk5NilKkYoZ3PJyJo1aAhfRw8mNH0nVa9fMwpVae7FKTytuNpH/3vo7qPJsTzZb4IjkNesYczDfreqvPuBA6mbVY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UiI0+0ML; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1757110345; x=1757715145; i=quwenruo.btrfs@gmx.com;
	bh=aQ8qM7+8OwLf6s9WZVwxZjfskdtzKMpOPczdMb/dZR0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UiI0+0MLGLfdXUYacjs3xICu6Uj6JUf7GrQ/59YgWM4AkUlCy3aNKbyE3KkflNcb
	 JRHFtobRUF6//VWYXQ24SeExVC3Gr6HR519DrL9wNsjqw39fLBohUx0pt7hosJfSD
	 mGLm3gd7xw/9r4a1fxm+t+gJ2SLqQP/9SxjZTmy1PQhu26Uslge01HUm79GMYK8On
	 kV9+WCrUyedQey+2rAyy/kJIRj4tOjWgZLCBWYqZND1Jt1TmdzSGGIHUxA+gwyk/t
	 Nsl3v4OX9i+LncDcwiNTP2vKOUSKLFB5JDniFhbm7p5SgoMTxOp6+xnD2HhkdbAwY
	 9c+ubj+0h+XdMMlJWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9nxt-1ur6R20fED-0026TQ; Sat, 06
 Sep 2025 00:12:25 +0200
Message-ID: <595fb33e-a3e8-46cc-80ff-e50c2a70bffd@gmx.com>
Date: Sat, 6 Sep 2025 07:42:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs RAID 1 mounting as R/O
To: jonas.timothy@proton.me, Qu Wenruo <wqu@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me>
 <ac473f81-506a-4f7b-b182-a3a53db2f6c9@suse.com>
 <h5sKXFIVsnBPX0i1K8jnrgzAQu2oE-NMORKYVaNPyp-FnKaQN032HGmejwSQl8KIbtpMj-37pFT3KDrbn_xmrdzqNVzjzIw-9YU6s8DW0mA=@proton.me>
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
In-Reply-To: <h5sKXFIVsnBPX0i1K8jnrgzAQu2oE-NMORKYVaNPyp-FnKaQN032HGmejwSQl8KIbtpMj-37pFT3KDrbn_xmrdzqNVzjzIw-9YU6s8DW0mA=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k+WcrswAQEEfJWO70sT/Eh19xmGFgePSNX0Gf4BtCs+WWL4+pdC
 PhH30NMGvE6tKlHzJ9F+adLS9W4ALBURy4qveq8q1DojiBBVUBgm8b/NMOBwex815vKFN5O
 i9bj1ho6ZEvkK5A/laNdSDDt2mUgeNZeh2HdiZQlu9h+meibpDpTyHV2BC9HUlaDcXwebQM
 FU6fOAXRV1afjLqto/yvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bXcX6o7GF1o=;rn1TSbvoyYF0YpHRyGH5LImKD3z
 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



=E5=9C=A8 2025/9/5 19:34, jonas.timothy@proton.me =E5=86=99=E9=81=93:
[...]
>=20
> Hi Qu,
>=20
> I currently have 2 profiles because I have 2 sets of disks:
>=20
> $ sudo btrfs filesystem df /mnt/disks/disk-12TB
> Data, RAID1: total=3D5.28TiB, used=3D5.16TiB
> System, RAID1: total=3D64.00MiB, used=3D800.00KiB
> Metadata, RAID1: total=3D7.00GiB, used=3D6.18GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

So this means this fs is more or less corrupted, recommended to salvage=20
the data first, then either re-format the fs or try `btrfs check=20
=2D-repair` (which may not always repair the fs).

>=20
> $ sudo btrfs filesystem df /mnt/disks/disk-20TB
> Data, single: total=3D6.79TiB, used=3D6.75TiB
> Data, RAID1: total=3D6.74TiB, used=3D6.71TiB
> System, RAID1: total=3D32.00MiB, used=3D1.84MiB
> Metadata, RAID1: total=3D14.00GiB, used=3D13.85GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
> WARNING:    Data: single, raid1
>=20
> the one that went R/O is the 12TB pair, but the 20TB currently is having=
 trouble finishing setting up RAID 1.

`btrfs fi usage` output please for the 20T fs.

My guess is, you're mixing different sized disks in that 20T array.
And you're using RAID1 with 2 disks, the usage won't balance that well=20
among just 2 disks.

>=20
> Would I have to redo this if COW is broken?

Mostly yes.

Thanks,
Qu

>=20
> P.S. resending because I accidentally used regular "reply".  Sorry.
>=20
> It also just finished scrubbing my 12TB RAID 1 array, and it aborted :-(
>=20
> Sep 05 06:45:42 skarletsky kernel: BTRFS error (device sdb1): parent tra=
nsid verify failed on logical 54114557984768 mirror 1 wanted 1250553 found=
 1250557
> Sep 05 06:45:42 skarletsky kernel: BTRFS error (device sdb1): parent tra=
nsid verify failed on logical 54114557984768 mirror 2 wanted 1250553 found=
 1250557
>=20
> $ sudo btrfs filesystem df /mnt/disks/disk-12TB
> Data, RAID1: total=3D5.28TiB, used=3D5.16TiB
> System, RAID1: total=3D64.00MiB, used=3D800.00KiB
> Metadata, RAID1: total=3D7.00GiB, used=3D6.18GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
> $ sudo btrfs scrub status /dev/sda1
> UUID:             8641eeeb-ddf0-47af-8ed0-254327dcc050
> Scrub resumed:    Fri Sep  5 03:16:31 2025
> Status:           aborted
> Duration:         5:33:42
> Total to scrub:   10.34TiB
> Rate:             182.62MiB/s
> Error summary:    no errors found
>=20
> $ sudo btrfs scrub status /dev/sdb1
> UUID:             8641eeeb-ddf0-47af-8ed0-254327dcc050
> Scrub resumed:    Fri Sep  5 03:16:31 2025
> Status:           aborted
> Duration:         6:05:48
> Total to scrub:   10.34TiB
> Rate:             200.25MiB/s
> Error summary:    no errors found
>=20
>=20


