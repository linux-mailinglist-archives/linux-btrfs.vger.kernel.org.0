Return-Path: <linux-btrfs+bounces-2771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08461866DE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 10:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D01B1F28447
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 09:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666D1EA7C;
	Mon, 26 Feb 2024 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Cgl71mwr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277E1EB33
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936216; cv=none; b=MBmFol1TFWKLy8g1IGh9vge4crAmsy9vDu9oy3c5wTMKOwDrNjhH7r+m2hE+nL2i9oWxhFI+ZvvIGdyTsl03DuDDxJQDZ5mZPdh5oiSxyQyxV76hOb+LUMNOArT+rvDtNbzIWAOABPprDFKzmUfWTuAbwYd+OwXJ4+I4cayZTJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936216; c=relaxed/simple;
	bh=fc8xKyddvh7o5CpV7oISgybRL+uDpvxRpuJ4hPr/NM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O7aRF0o/d9rWKAUWsaWEsJQh0C2vLwh67Ck/7vjOyj8BvBwIEUuhfhA8luHNYtYYXKDHP4PX7xi9cfbTv87Qgiv9bJbJTWzSeiS9GeUzkoyUMSYxb3bIditB5khZi8pt4DVChbV+7NFoBYWTsXo3eUiox90f2RDQcbrlWL4/KcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Cgl71mwr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708936204; x=1709541004; i=quwenruo.btrfs@gmx.com;
	bh=fc8xKyddvh7o5CpV7oISgybRL+uDpvxRpuJ4hPr/NM0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Cgl71mwrzXsrxzDLPBh5z8KLPw6X271ih1UX2OxOXs3gIJmea1UMkbew5dczN8+D
	 /BLCajP6nRzmWNVUaBkbvpgHTD0HnVGV26cCaeH52sSRu9l9700ZsLiGJrItY/Wfb
	 N7aXCUZ5UeHDIFPEZgHGXRF9SHQo0fP+b40vPL5m0PuneTm3507R5EOtK4W4kwe2Z
	 Les0JrzfRuC7EJLw16FJqHN6wBclUs0BLZCKn8R0DPt36xdBxXBUtYtdVZfFvVpcR
	 2/BMA9duJ38BfHOcmMVekBtEJWLOfHFirbQ8/OgNdeWuOSSmsl1HnLHTljFdcokOJ
	 HFH5gRWaSx1ZLM+6Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1qlaMt1RUW-00tFVS; Mon, 26
 Feb 2024 09:30:03 +0100
Message-ID: <f9296554-9c90-4991-a67e-d1a8defafca3@gmx.com>
Date: Mon, 26 Feb 2024 19:00:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Corruption while bisecting (was: [PATCH] btrfs: tree-checker:
 dump the page status if hit something wrong)
Content-Language: en-US
To: Tavian Barnes <tavianator@tavianator.com>, linux-btrfs@vger.kernel.org
References: <CABg4E-=u7m_g3HCFUYHS-+RC==pefkUZXiTT2Aor86jruHSF9Q@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CABg4E-=u7m_g3HCFUYHS-+RC==pefkUZXiTT2Aor86jruHSF9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZzLKoyO2UPwdYORaA0J191xzZSu6TYPyz6y4GeIAGx16cGymus8
 i3yAphJ7wsoI09YzCHlUvAgikYhm/9Ltj64S64YsaIUx9w5Y22b4BwoU+cYuI/VR1Y5RlwA
 bBaC/AoaxLZqPkptY/5K1Qb077EEbuFZhYUlNLGgyFQ09OVw7WaWOZpJIbMWsYMvsxTqkTU
 xdIOwizW4KLtXOv3S2t9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TnqI/m5BDiA=;Gxx8j9R4KeoG7/8kqOiOawMUU+t
 zdErfL5PA6BQEeD8DlJoK+VACT/BI3eDawA2IEpgzxiWZZOJauBMc626XFo65mWQg8oxy/nH/
 pPoIivA3fdU4IDudIwM8PGe+zK/PJHV2vJczc+1cB3Hni1BJIdxuoCN9eKHKv7xAjv4ipE9dL
 kTj9UTdv/chPzk6KsCJKTys4LCXlis5xCmWlJtrD9fpeFz76iL1UluuYvbQtx7FvinGpCSmvH
 oH3rSAqaB4wVrkUZMjwjRdZOKhmoPozYyj9n/shm7HOHxrkqo2LdJTHFv3b2anPdB3XA29+6h
 V0b5MSalzvOo1Big3PptlbRLGf36fkERniRNeKUJt9Zq7y+Mc/mzl122xg1sKTzYXoJVaXctX
 Ncmc331vTAe7QaXlMSMF+ADXrYg5maogJf/qBHoJmXOJ+LK4zzN5WrUewXh4Vq3HCuvgejfzz
 d+aPuC8txZRIxmswlmINFdAIj9CrSN89rhKFvSnLCYUVIo4pBEGFosfTrmNo7wYJ2AcEbJd+V
 DE4T0U/4lBUMuMPigHw3hTHdI8I5cUfB6+Dmq51Eqne58f4kCZ3G/EpDnKxNCXIYyZv0ehLsg
 9u66b6nClJKpRd8om6abaf5znIJGHlYe6YN4tHpS1eo9VFjFpKOcGX5asYHOmAEgQ/AAOEgyM
 uXwestZUqEA4LAuWFLreE3rLs/cgpofwhSI/THO4+VI0PIPqMV0mr+I1qHosuESBPGxyIL4wQ
 uUSKWGh0eIiJCIb19fAnRt9P7xL9i0x8CN0pr5MRN4XH2gB6AGaV5KDo1HJgPkB7AVzhSiVGF
 FhOgw4cKVKhFMZejgyQA/wNFDvprgAGBrbTkNf9djtMMs=



=E5=9C=A8 2024/2/26 06:00, Tavian Barnes =E5=86=99=E9=81=93:
> Well, bad news: I started bisecting from v6.0 and after a couple
> rounds, my root fs is really corrupted:
>
> UUID:             e1902620-c206-4e34-9f24-e66cdb6b8872
> Scrub started:    Sun Feb 25 18:47:29 2024
> Status:           finished
> Duration:         0:20:18
> Total to scrub:   2.72TiB
> Rate:             2.29GiB/s
> Error summary:    csum=3D2073625
>    Corrected:      0
>    Uncorrectable:  2073625
>    Unverified:     0
>
> All the errors seem confined to one of the four disks which is strange:

Mind to share which commit you're at when hitting the scrub errors?

And have you tried with offline scrub (aka, "btrfs check
=2D-check-data-csum")?

IIRC during the rework of scrub, there are several regression caused by
the rework (e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to
scrub_stripe infrastructure"), which is around 6.4).

So if "btrfs check --check-data-csum" shows no error, it would be a
false alert and you can just ignore them for now.

Thanks,
Qu
>
> BTRFS error (device dm-0): unable to fixup (regular) error at logical
> 7242230988800 on dev /dev/mapper/slash3 physical 914556321792
> BTRFS error (device dm-0): unable to fixup (regular) error at logical
> 7242227580928 on dev /dev/mapper/slash3 physical 914555469824
> BTRFS error (device dm-0): unable to fixup (regular) error at logical
> 7242228105216 on dev /dev/mapper/slash3 physical 914555600896
> BTRFS error (device dm-0): unable to fixup (regular) error at logical
> 7242230202368 on dev /dev/mapper/slash3 physical 914556125184
> BTRFS error (device dm-0): unable to fixup (regular) error at logical
> 7242233348096 on dev /dev/mapper/slash3 physical 914556911616
> BTRFS error (device dm-0): unable to fixup (regular) error at logical
> 7242227843072 on dev /dev/mapper/slash3 physical 914555535360
> BTRFS error (device dm-0): unable to fixup (regular) error at logical
> 7242228367360 on dev /dev/mapper/slash3 physical 914555666432
> BTRFS error (device dm-0): unable to fixup (regular) error at logical
> 7242229415936 on dev /dev/mapper/slash3 physical 914555928576
> BTRFS error (device dm-0): unable to fixup (regular) error at logical
> 7242229940224 on dev /dev/mapper/slash3 physical 914556059648
> BTRFS error (device dm-0): unable to fixup (regular) error at logical
> 7242228891648 on dev /dev/mapper/slash3 physical 914555797504
> BTRFS warning (device dm-0): checksum error at logical 7242227843072
> on dev /dev/mapper/slash3, physical 914555535360, root 136483, inode
> 60736199, offset 720896, length 4096, links 1 (path:
> var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
> BTRFS warning (device dm-0): checksum error at logical 7242228891648
> on dev /dev/mapper/slash3, physical 914555797504, root 136483, inode
> 60736199, offset 1769472, length 4096, links 1 (path:
> var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
> BTRFS warning (device dm-0): checksum error at logical 7242228105216
> on dev /dev/mapper/slash3, physical 914555600896, root 136483, inode
> 60736199, offset 983040, length 4096, links 1 (path:
> var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
> BTRFS warning (device dm-0): checksum error at logical 7242228367360
> on dev /dev/mapper/slash3, physical 914555666432, root 136483, inode
> 60736199, offset 1245184, length 4096, links 1 (path:
> var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
> BTRFS warning (device dm-0): checksum error at logical 7242230988800
> on dev /dev/mapper/slash3, physical 914556321792, root 136483, inode
> 60736199, offset 3866624, length 4096, links 1 (path:
> var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
> BTRFS warning (device dm-0): checksum error at logical 7242229940224
> on dev /dev/mapper/slash3, physical 914556059648, root 136483, inode
> 60736199, offset 2818048, length 4096, links 1 (path:
> var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
> BTRFS warning (device dm-0): checksum error at logical 7242228891648
> on dev /dev/mapper/slash3, physical 914555797504, root 136483, inode
> 60736199, offset 1769472, length 4096, links 1 (path:
> var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
> BTRFS warning (device dm-0): checksum error at logical 7242233348096
> on dev /dev/mapper/slash3, physical 914556911616, root 136483, inode
> 60736199, offset 6225920, length 4096, links 1 (path:
> var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
> BTRFS warning (device dm-0): checksum error at logical 7242230202368
> on dev /dev/mapper/slash3, physical 914556125184, root 136483, inode
> 60736199, offset 3080192, length 4096, links 1 (path:
> var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
> BTRFS warning (device dm-0): checksum error at logical 7242227843072
> on dev /dev/mapper/slash3, physical 914555535360, root 136483, inode
> 60736199, offset 720896, length 4096, links 1 (path:
> var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
> scrub_stripe_report_errors: 344892 callbacks suppressed
> ...
>

