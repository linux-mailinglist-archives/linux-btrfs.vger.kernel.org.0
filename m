Return-Path: <linux-btrfs+bounces-14537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D9AD0A10
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 00:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787013B379F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1D23D290;
	Fri,  6 Jun 2025 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="m/GELUNa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A31125DF;
	Fri,  6 Jun 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749250349; cv=none; b=hhrekqNFzCpeGi8OTzHcxEwOChAlpo1Kl5+CK+zz/fZQ4LSh9CyoqOC4RDlgiMQByh2/Nawlf7D6R1Ygf5J11P9jgw50AIPKq51iOfP5pCQcrADJsahJs/eA1iKrae6IMfOOsct3WOJHnEkowZXuDLlu4N0Fzr2iritKq96968I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749250349; c=relaxed/simple;
	bh=dTkX7XNaZYmkDAQMq8Drt8ZmUjjG8aaNkTuNl5V3OK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A25T2weFb+zePphNt301fJVcNh/YxOWMerRN8DtnqMAW5038CNpJR0HBC0+wX9PTB1M4Ee5YvX5HRBmPXHx1tBEYlYdpS9DGLUK3LkRkHuk3f4Qf28yv1o7950px/d6y1534vGoS1ntrbaKvwbf1NBuina7Tpi1FcU8B30FOo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=m/GELUNa; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749250344; x=1749855144; i=quwenruo.btrfs@gmx.com;
	bh=UTZIX/JXhzQd3v8CSGc5f9wdOcQqqrdWY6PXgEe+Rq0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m/GELUNauwJn1kwutZfdX352FTVuPaMVo++enGjOS9exEZ8TGWlOVgVaxIM1keHU
	 tnx+kS3Mw7zIfogXtsJFDKJ00mcDgmPfJffMP5ynzto1zWgRjxbxymUssgIAQn9ee
	 wWtkG8OkDFLG74UP/9uXVamGvmkWNZLaq434jGYK27r4ozclGtdvbO4pgMyElvXz6
	 Vq4sT/fCI5QaFI+oe3Nd7X22eIwPjv49rjmCjK0qMxE3q0xF7dPXIS1WAlYFHMdkk
	 0N5pC2LHbhsfuCFU9icki4dnm2gniKNZkAO1vzHjSU4b6XCo17+r5KcygoCsBtuX9
	 /s77plSBlMmxnfZM3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1uWzqL374g-00HL8p; Sat, 07
 Jun 2025 00:52:24 +0200
Message-ID: <9afe2ce1-855e-493a-98e0-296bac5de8d2@gmx.com>
Date: Sat, 7 Jun 2025 08:22:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Kernel Bug] general protection fault in btrfs_lookup_csum
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller <syzkaller@googlegroups.com>
Cc: "coregee2000@gmail.com" <coregee2000@gmail.com>
References: <CALf2hKuQe0R7Bi2L=vMMrQVehv6geC1TFNYiXNY_Sfua53qi9w@mail.gmail.com>
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
In-Reply-To: <CALf2hKuQe0R7Bi2L=vMMrQVehv6geC1TFNYiXNY_Sfua53qi9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TPczr/NFa2Cf51FDFleOjbkGs3TG3+ID6iVdXFyU4z5mUGdrmZO
 FFmKiKGpw6pfJJmzrLJ0NcJRSbIE94sBmvido3LmVDGslE31hYniqVaOFssXnFSntvUboHf
 hpMlNbNwXBNXhNbWbi8Jz3gdBbCqgohcfhyHEkmS9irF+PnYqaPwyFRJxCrinDeHhcWItYg
 lghPGIToPaHfakC7vjGtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7uHJ7Z42TRU=;J1YDKX69e+ViuzENuR+EvdnYa/B
 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
 MMgwBAS31UxuZMVD



=E5=9C=A8 2025/6/7 03:24, Zhiyu Zhang =E5=86=99=E9=81=93:
> Dear Developers and Maintainers,
>=20
> We would like to report a Linux kernel bug titled "general protection
> fault in btrfs_lookup_csum" on Linux-6.12.28, we also reproduce the
> PoC on the latest 6.15 kernel. Here are the relevant attachments:
>=20
> kernel config: https://drive.google.com/file/d/15zwNg6D0mF6eeFOw5zz4QkkH=
1bcK8xCl/view?usp=3Dsharing
> report: https://drive.google.com/file/d/1BPmRKH5Not1_y5briNsAcaYi0hXTe5u=
m/view?usp=3Dsharing
> syz reproducer:
> https://drive.google.com/file/d/1xvAUqtN1mu-49xfCObEYRn1eFc2Tmk8F/view?u=
sp=3Dsharing
> C reproducer: https://drive.google.com/file/d/1cdDqjEqpqhoenhWzxF_GNc06k=
Rkrrjxa/view?usp=3Dsharing

This doesn't feel safe just accessing some unknown source.

Can you let the sysbot to reproduce and forward the report?

>=20
> The crash happens on every read I/O against a broken btrfs image whose
> checksum tree is missing/corrupted. Specifically,
> fs/btrfs/file-item.c:search_csum_tree() calls "csum_root =3D
> btrfs_csum_root(fs_info, disk_bytenr);", where csum_root can be NULL
> under certain on-disk corruptions. Then btrfs_lookup_csum()
> immediately dereferences root->fs_info, causing a general-protection
> fault / KASAN report.
>=20

Undermost case, if csum tree root is corrupted, btrfs can only be=20
mounted with rescue=3Dibadroots, and in that case btrfs should set=20
FS_STATE_NO_DATA_CSUM thus no one should trigger the csum tree search at=
=20
all (btrfs_lookup_bio_sums() will exit early).

The only unknown exception is scrub, which is already fixed by=20
f95d186255b3 ("btrfs: avoid NULL pointer dereference if no valid csum=20
tree").


The call trace just looks like a regular page read, and we didn't have=20
that FS_STATE_NO_DATA_CSUMS set, which isn't correct.

I'd prefer to dig deeper on finding out why.

Thanks,
Qu

> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -201,6 +201,8 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
>                    struct btrfs_path *path,
>                    u64 bytenr, int cow)
>   {
> +       if (unlikely(!root))
> +               return ERR_PTR(-EINVAL); /* or -ENOENT, see below */
>          struct btrfs_fs_info *fs_info =3D root->fs_info;
>          int ret;
>=20
> With this draft patch the PoC no longer panics the kernel.
> search_csum_tree() converts -ENOENT (and -EFBIG) to 0, treating the
> range as =E2=80=9Cno checksum=E2=80=9D and continuing safely. If we inst=
ead return
> -EINVAL, the error propagates upward and aborts the read outright. I
> am unsure which behaviour is preferred: (1) ENOENT: silently
> consistent with existing path handling and avoids spurious I/O errors;
> (2) EINVAL: treats the situation as fatal corruption.
>=20
> Advice on the expected semantics would be appreciated before I submit
> a formal patch.
>=20
> If the issue receives a CVE, we would be grateful to be listed as report=
ers:
> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Reported-by: Longxing Li <coregee2000@gmail.com>
>=20
> Please let us know if a different fix or additional diagnostics are
> preferred. We will be happy to respin the patch accordingly.
>=20
> Thank you for your time!
>=20
> Best regards,
> Zhiyu Zhang
>=20


