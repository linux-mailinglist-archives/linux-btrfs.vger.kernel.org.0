Return-Path: <linux-btrfs+bounces-15693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BC0B12D2F
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 02:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10524A0602
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 00:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D0B849C;
	Sun, 27 Jul 2025 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PMMBaGGk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615710E3
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753574922; cv=none; b=qWSAF+XSzOgHmITOZenvL0rtl/L+mzMO6PfmOZJEJ36KXtnx1+Ux27br3pv78NhY2jbIt3BZl2B/MLPRu10MkJYJeCUsPMA1PuRuRV1Wg10Vj9Fmb3y38jqpXCmu4Q7SeytWIKkChgksbHGmBoEg5DLjrsSek/YL7JNg0BJ91J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753574922; c=relaxed/simple;
	bh=N6oLnvJ0ca0TS7+9E2AeoIS8Mxfkp8n+1FH47Sky1ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fG/9f6+TNKtimxTQlO8dAehMvDLMtH6JGltmuRLdTv8oCLdEUk8OjB0yNWOhU522otJ7dJeIyqM1wiwbq/njkBwbgLyi+DB4L25AL3chqvGobRshavbqNczH+HjopliePKga8SYxYdMGdhXtdcpVPE0GkMMnRaLMhXvMKRqnCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PMMBaGGk; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753574918; x=1754179718; i=quwenruo.btrfs@gmx.com;
	bh=YfDqLNYgRO3GCQRQDLC6lXog2fiy7+2JYI/gQjN36nE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PMMBaGGk5tXwzz6+dW00le0OluXEWCBukW4wyDK9t2T0Su0tS8YrCzbghl3gtNIU
	 fTHK2ruakuimkHTAbV0qa2FsPQiYi+hi6P2Avpmo2vb7jEJGxagTcBsUtFdIOBBxa
	 /KFnbiA+dvT3sLD8gpXvrMQxC3Oq27MCOEQrOqTEqQgLvTcI/7hAKlqT/ZPG0Fp4N
	 LvGGyvdqOd4nBCyAPnsocTEzQETafZEZjBZvlz7SRpEf8II5ghJ8Tus6zk10nHDZE
	 kDboCa57eAuQFfZLxpAPLrHe6hzBs+HOFvyGH+KdO4KGE8m0HGmdO6nEKUhl8Sb5V
	 7pGhzpTvJq3tTNhaRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAfYw-1uqmFB2D04-004eul for
 <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 02:08:38 +0200
Message-ID: <4bf5d74c-910f-4cc9-b290-26bf5bcc8e47@gmx.com>
Date: Sun, 27 Jul 2025 09:38:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: balance failed with checksum error
To: linux-btrfs@vger.kernel.org
References: <20250726234755.GA842273@tik.uni-stuttgart.de>
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
In-Reply-To: <20250726234755.GA842273@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OMEMg7IFXNW9Kt6aoncRk+Ykmz2qmFoV2axGa2XITr5IB6D85US
 +73xTSUdh3w7UwCPAWF6/QT4bEbe/fwy3E61pdPMTjzFANizCPkTsephLMVfGi4sGPgEoi/
 U+lorytMhoC3QwCJS5LwVVyzpQFSeOkIeMX5c8dMOH3EZqKNeZQnnvkTjKHMpnIXvk1uMb+
 SzikbJGJVdEEI/BWzPxNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K35s+QNBGpk=;89CG1xHPNmwOhCrEkUIDepskIGf
 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
 1CPlaW0wpbTEjpE=



=E5=9C=A8 2025/7/27 09:17, Ulli Horlacher =E5=86=99=E9=81=93:
>=20
> This is just a test VM, but this error should not happen?
>=20
> root@mux22:~# btrfs balance start /
> WARNING:
>=20
>          Full balance without filters requested. This operation is very
>          intense and takes potentially very long. It is recommended to
>          use the balance filters to narrow down the scope of balance.
>          Use 'btrfs balance start --full-balance' option to skip this
>          warning. The operation will start in 10 seconds.
>          Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting balance without any filters.
> ERROR: error during balancing '/': Input/output error
> There may be more info in syslog - try dmesg | tail
>=20
> root@mux22:~# dmesg | tail
> [22612.591075] BTRFS warning (device sda3): checksum error at logical 34=
50908672 mirror 1 root 806 inode 1509 offset 294912 length 4096 links 1 (p=
ath: tux/.cache/mesa_shader_cache/index)
> [22612.591095] BTRFS warning (device sda3): checksum error at logical 34=
50908672 mirror 1 root 805 inode 1509 offset 294912 length 4096 links 1 (p=
ath: tux/.cache/mesa_shader_cache/index)
> [22612.591115] BTRFS warning (device sda3): checksum error at logical 34=
50908672 mirror 1 root 257 inode 1509 offset 294912 length 4096 links 1 (p=
ath: tux/.cache/mesa_shader_cache/index)
> [22612.591184] BTRFS warning (device sda3): checksum error at logical 34=
50912768 mirror 1 root 810 inode 1509 offset 299008 length 4096 links 1 (p=
ath: tux/.cache/mesa_shader_cache/index)
> [22612.591204] BTRFS warning (device sda3): checksum error at logical 34=
50912768 mirror 1 root 809 inode 1509 offset 299008 length 4096 links 1 (p=
ath: tux/.cache/mesa_shader_cache/index)
> [22612.591224] BTRFS warning (device sda3): checksum error at logical 34=
50912768 mirror 1 root 808 inode 1509 offset 299008 length 4096 links 1 (p=
ath: tux/.cache/mesa_shader_cache/index)
> [22612.591244] BTRFS warning (device sda3): checksum error at logical 34=
50912768 mirror 1 root 807 inode 1509 offset 299008 length 4096 links 1 (p=
ath: tux/.cache/mesa_shader_cache/index)
> [22612.591264] BTRFS warning (device sda3): checksum error at logical 34=
50912768 mirror 1 root 806 inode 1509 offset 299008 length 4096 links 1 (p=
ath: tux/.cache/mesa_shader_cache/index)
> [22612.591283] BTRFS warning (device sda3): checksum error at logical 34=
50912768 mirror 1 root 805 inode 1509 offset 299008 length 4096 links 1 (p=
ath: tux/.cache/mesa_shader_cache/index)

So it's the same file with data checksum, but shared by tons of=20
different subvolume.

Data checksum mismatch is known to happen for certain workload.
E.g. direct IO with buffer modification during writeback.

Thus upstream commit 968f19c5b1b7 ("btrfs: always fallback to buffered=20
write if the inode requires checksum") fix this hole, at the cost of=20
performance for those direct IOs.

And that commit is only a preventive method, it won't fix any already=20
corruption already on-disk.


Another possibility is, it's just a real corruption.

Either way the best solution is to remove all offending files.

> [22613.689939] BTRFS info (device sda3): balance: ended with status: -5
>=20
> root@mux22:~# btrfs version
> btrfs-progs v6.6.3
>=20
> root@quak:~# sysinfo
> System:        Linux quak 6.8.0-64-generic x86_64

This kernel is EOL, thus it will not that fix unless the vendor is=20
actively doing backport.

Thanks,
Qu

> Distribution:  Linux Mint 22.1
>=20
> root@mux22:~# df -TH /
> Filesystem     Type   Size  Used Avail Use% Mounted on
> /dev/sda3      btrfs   32G   17G   16G  52% /
>=20
> root@mux22:~# mount | grep sda3
> /dev/sda3 on / type btrfs (rw,relatime,space_cache=3Dv2,subvolid=3D256,s=
ubvol=3D/@)
>=20
> root@mux22:~# btrfs filesystem show /
> Label: none  uuid: 13168cc9-1fde-4d4a-8af1-fc91da4f12db
>          Total devices 1 FS bytes used 14.15GiB
>          devid    1 size 29.76GiB used 17.06GiB path /dev/sda3
>=20
> root@mux22:~# btrfs filesystem df /
> Data, single: total=3D15.00GiB, used=3D13.39GiB
> System, DUP: total=3D32.00MiB, used=3D16.00KiB
> Metadata, DUP: total=3D1.00GiB, used=3D784.42MiB
>=20
> root@mux22:~# btrfs filesystem usage /
> Overall:
>      Device size:                  29.76GiB
>      Device allocated:             17.06GiB
>      Device unallocated:           12.69GiB
>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Used:                         14.92GiB
>      Free (estimated):             14.31GiB      (min: 7.96GiB)
>      Free (statfs, df):            14.31GiB
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:               37.58MiB      (used: 0.00B)
>      Multiple profiles:                  no
>=20
> Data,single: Size:15.00GiB, Used:13.39GiB (89.24%)
>     /dev/sda3      15.00GiB
>=20
> Metadata,DUP: Size:1.00GiB, Used:784.42MiB (76.60%)
>     /dev/sda3       2.00GiB
>=20
> System,DUP: Size:32.00MiB, Used:16.00KiB (0.05%)
>     /dev/sda3      64.00MiB
>=20
> Unallocated:
>     /dev/sda3      12.69GiB
>=20


