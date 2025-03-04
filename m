Return-Path: <linux-btrfs+bounces-11994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B284A4D2EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 06:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49680170FD8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 05:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD4E1F418B;
	Tue,  4 Mar 2025 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QTreW9pd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612E194080
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Mar 2025 05:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065855; cv=none; b=iRSrIwhdSlvXgtaPbMUKDq0uAd2tE3Tx30Wczxx2YBpgv+zqFEvSLVXQsj7bl52R5dN9Gt4YEEgIXJUPqQr1JXutv3BZY7CDVdUtkZ8IDaT95/G2tOGKnsJJonsh/Abia4szTWMaCCE1Iy5jFVSfHzVj+utLTmUZHp2zjzCo9ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065855; c=relaxed/simple;
	bh=Xq0ZlU1m1BHk5fkpYcYHqBHKDgFkUumhWVkk3rDkpvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oobW6AJmSCRaBUGPm2rkUkinzpS7yBcshYd3mqem3Cl9guUiMSV3FNSgIuIly8tx6MILVRzsfjhVu+TIPd9sjoNATqAJAZccZfrppLBtQXrM9a14tUOAviPsm4cuFzPO7QKdPz1s4jnzeHR66TBq1KOut8U4fufdhiS9t00JBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QTreW9pd; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741065851; x=1741670651; i=quwenruo.btrfs@gmx.com;
	bh=Xq0ZlU1m1BHk5fkpYcYHqBHKDgFkUumhWVkk3rDkpvY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QTreW9pdKOU+awEtq/SETZWGddrHxiUPCgIdOtF0fqRT46/AYbCvDWVbIcnCoU+2
	 FL2QI9y1Rv8Jq6s+iicCXU7tDYFF7TDixJt68MjJqIOKs7NeZHAR1mBn/D/ZmIxjP
	 xyDvKoq+9kDiCuQsVoMW4e4uoJB2iX1JaHWMlM3ABfxg0jREHkW79I0i+3/vmIfru
	 RP8e2XE0gsS0rz4gILeQ4k79oaoSKkM1EutRQnXAImQC35hajo4FWMUHO9xFyyq/2
	 l9QlQfHat9Qm4PF/ofWbOQMQaMwLxHoq7r+O7Zv2MqqqjK+zmRkVOBlvuWCIsx79o
	 N/K/xZ8K/2rdI0FGsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Daq-1tvwSg3vHk-00BAiK; Tue, 04
 Mar 2025 06:24:11 +0100
Message-ID: <2dd7feda-8939-436c-875a-c77fef13b070@gmx.com>
Date: Tue, 4 Mar 2025 15:54:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filesystem corrupted? After balance?
To: 0xBA5E64 <crafterxlife@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAOF-YQReZ-0owSrotJ9=ev83M=kT6mbwcKqKwNAnRSxAGOfE2A@mail.gmail.com>
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
In-Reply-To: <CAOF-YQReZ-0owSrotJ9=ev83M=kT6mbwcKqKwNAnRSxAGOfE2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kuImp5h3SyPsrlV4kgjKlDvhG5KGfmCAgGuEiX2I5tNl6hf2Bh3
 1rITnsj/iJbhd50CThFw26EdOQsdKmfesLKqZoNWGoMOltuOOhcOivOWwtlN1u417/LdE43
 Ht71daPN/RvhGbLHJNaZQmcUtfXIjpn5S5zA4Dv8gvn1USTp6hFTNaPFX2qpS+cCq+dRN0f
 kUW1oHhlO+xbg7Zyt6fYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YPjLvomxuYw=;C3LZD+stDoTat0zTJYDkqZfValC
 pMwplDTHOnkrzbDsrzzTm3qKXQBeXWkmbHqD7yV+sllWRdelXR3XLJ3IXngz5cpZdAt8V9a9y
 W9cuXSAWbV0dznB3T5HnluBVZUbgKt/VzZlTcbXprbJvITgsjE8OmbAp9rwIko+VPq0DyS9Ze
 +Hl+KHuUkYpXp7j3HcW6r/ojgS/iPSV+4KMJyirp20y9Nlzluhs5JYcE/wLSNZyAbReL55Yuw
 je6bpilQaCbe6tida+ZjIWVdNfTp8Y97bHKWljwJ04mxq4x23/FbmuIUaPUbUCwbSLa2jIGXJ
 x8dvvom59D56VgxWptEU7LemDww7XKfYKiUs8RW6Z82cb0dTryPvx/BWRPT6wEwxdPheV0DZB
 PpSUxK+KGl58NSgJWTiRTemdLh90S8aYDGv/y8eN7x2dck15aAnUYNjCGmAWBAuxAedLYpbF+
 Q7MPyo4iEt/0Cv/S+TNh23rJM3uVLbeOVJuoYg0+IQiPZCmZO4oq2wvv+8QWlXHfu7WMyUdUH
 bgJZK2UjLhEurHgiBD+whLMTJ9INk60IKEjnI03ekFvkc9eg27AyDRXwd3l6QcOIzLDTeHIxd
 l73ZKi3yDHUGD2OINszb9MmUGpb1+qE0XtMBx90/57mORScD2QgA6xYYknoA3qmTUu7EOeFsw
 03PdS7FCrCfuSds6T8xs+3aUhvjZzvKiUsW+Wv+MqsUWK02J/xtx61CvCZo2DFj6+k2WKf1af
 hsSxlBqL31964R58ePvczh0IVSAOp0Wq3kWP4gDU4Ar3tLrX6EW9+qq0peIxJ61d/n/GIbVbm
 Gt08OTBWdhJr3/RCWAcwHhnf4GxqzhtBG0EWGcDfzROj59p9QqC6lkuFeFw+Qosql8TRJAahO
 DYaFIoWSugw2rzHzw1RUMAmBq8sP7OodDjKH8tiOl4+iUuuXlYKa5c9GAXGdXg2RZXLRPMG3S
 aavc9RP8VDRIgGqoGTltEdnhW5Dv/a/2//EDFqd4FFICxwOv+yspNPuO0Tz9f3hh66ojQqcOL
 KCy25DLJz5vRk5yyVcgCq+zNGBo5bNnsNxgwsbNh8vUe/xCJgg0jj8gjdWJowbVrdwpGnsWr5
 RVrqafHsoeN/2FaPeRDoqEpoXH1ZQm9dGtkZWhHFxXVnCAZvaI4O+JMYq0pR/Tp/rq+koFRMz
 oV7UDQUg7IToXElE5MJ3JZNYLV0YkIvntewEHE9Bs9ueNVzfl5i4l8+gx0rwlkTMqItohkOTR
 WciAnZBrj/5CnfUUx0zIIErdpXq+qHYI7KkFcqvJhWPjmjZhrAM4coAUQX72xHiYXa7PkwfcN
 3QYqYQscRgXCsFdsvg2eHzCC9D9ToAWhYXX4FTZFKLPARkOgwCIDWXpCejGuxHHSnFxz7mtX6
 7YZLLIIn74LNEPfmQ6FM+OnxtGXhHcPNqiNzwNVs/PPShn0+I0D5oED2tg



=E5=9C=A8 2025/3/4 08:54, 0xBA5E64 =E5=86=99=E9=81=93:
> Good day btrfs mailing list. I write to you all today to ask for advice =
with
> my btrfs root disk which was recently corrupted, seemingly following me
> running "btrfs balance" on it.
>
> The filesystem still mounts and the system still boots just fine, but
> quickly
> locks up into a read-only state a few seconds later.
>
> Running a "btrfs check" from a Arch livecd image shows three errors duri=
ng
> "extents": two "referencer count mismatch" and one "bytenr
> mimsmatch" [sic?].
>
> I believe this might've been caused by my RAM (DDR5 running at 6000MT/s)
> being
> unstable due to "Memory Context Restore" being enabled on my
> motherboard, but
> I'm frankly not sure of much of anything here I'm afraid.

It really looks like a bitflip:

data extent[4174852947968, 184320] referencer count mismatch (root 1145
owner 54342951 offset 0) wanted 0 have 1
data extent[4174852947968, 184320] bytenr mimsmatch, extent item bytenr
4174852947968 file item bytenr 0
data extent[4174852947968, 184320] referencer count mismatch (root 1145
owner 58537255 offset 786432) wanted 1 have 0

Note those owners (inode number):

hex(54342951) =3D 0x33d3527
hex(58537255) =3D 0x37d3527

The 0x40000 difference indicates a bitflip.

And extent tree bitflip is the hardest to detect at runtime, thus it
reached the disk.

>
> It's run perfectly stable though memtest86+ before, but I'll be leaving
> it on
> for the night either way to see if anything shows up.

After you have confirmed the current setup is fine, then `btrfs check
=2D-repair` should be able to fix it.

Thanks,
Qu

>
> I'm not really used to mailing lists, but was ushered here from
> "libera.chat/btrfs", so this "report" a first for me, and I hope I've
> included
> everything that's asked for.
>
> $ uname -a
> Linux wypr 6.13.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 27 Feb 2025
> 18:09:44 +0000 x86_64 GNU/Linux
>
> $ btrfs --version
> btrfs-progs v6.13
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED
> CRYPTO=3Dlibgcrypt
>
> $ btrfs fi df /
> Data, single: total=3D1.60TiB, used=3D1.48TiB
> System, DUP: total=3D32.00MiB, used=3D224.00KiB
> Metadata, DUP: total=3D13.00GiB, used=3D11.10GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> $ dmesg > dmesg.log
> [see attachments]
>
> $ btrfs check /dev/disk/by-label/wypr-root 2>&1 | tee btrfs-check.log
> [see attachments]
>
> Best regards
> / wyrm


