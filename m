Return-Path: <linux-btrfs+bounces-19911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0557CD2384
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 01:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA019302D5F9
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 00:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D08770FE;
	Sat, 20 Dec 2025 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sZzyeTyN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549E186A
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Dec 2025 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766188850; cv=none; b=dE1qSI9mMrG7FmAoYQCtf6X4pYqFK3u4FOFDu+ruxdMe6FKGfXYuQxg2GLtR5E+9OczPKkDYdHDLM3WKx9UWMIxexynZgK7EmoQ945BGerz/JErCC9meUEl2O64N7IG/lUxO1XNPN65UAIEfvSEZI0yQ8tZYjKbt14ySQMh9jE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766188850; c=relaxed/simple;
	bh=+v4tZvXelpK0fVKUfpMkX00nvoOOKqODT68jOd+VxpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pr0R9lElL3FHdLGoLbK94eEm+zvUMP24m640wXFf8HH4AMFxZ17yLg/PXMMEIRLSpF/z9OnCT28T0xbwIAiA3R7e6MMq+Oq/b+K/7OrCLTEUQJUcbEtdBjJMv42vyoFnBFK9wBCMKFARN9N+Fb4d4cyGpPIHbrSq+IxPm3o8WCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sZzyeTyN; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1766188826; x=1766793626; i=quwenruo.btrfs@gmx.com;
	bh=UiMeJFphYsbREkdhNQyjCv1KkuK6cAPGj1004SgmI40=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sZzyeTyNKxtmFy6HI/OzI/M16ma9x+J+teAGXj7acZg47q4rwuYBpJnGuE6IqVCb
	 G1jfQVwa62kyy7gKDrUtFAO7pzG47TTfF/HvNQL2kwhAbmQNWkjNPQQPhRkFlgjVc
	 kdelz+drwPqojKURn2UgKdyZzwbywuCnKQkG9J+W9YzKTP8cvRsTHe+ZiY5WVs8hg
	 GA8pSYJ5KuyhLKoyMUPgYaZBa/CrJ+UN5IPXLdklO0l/1/MqkwonkSo8LLa3jW5BI
	 nBrh3fosXSuI1sD7tL7U48D+CN+0LyyXcs0etaYZ+UArDd/LCKxjFWixZDZRj2Qan
	 JVNjwxu6pDPTGK0Mog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeR1-1vSX9e2Oo7-00YRGv; Sat, 20
 Dec 2025 01:00:26 +0100
Message-ID: <d5be2cba-f9c7-4a8e-9cb1-70600669e508@gmx.com>
Date: Sat, 20 Dec 2025 10:30:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: show correct warning if can't read data reloc tree
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org
References: <20251219181550.12901-1-mark@harmstone.com>
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
In-Reply-To: <20251219181550.12901-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bygw1q4TMJWbiF4CVVvkMF0506kgxMz7wiUK90DkOwb4oHlbiDG
 XVu5bm8j16F83uyCtXVaUlrSICG6M+lOjSAlMbv/A0sLp1w7MLx0kiJYUOhDJv89Y12pyv8
 jWkvwWn6pRyOeAFYfESqkQDtQqg79RSHyQPY2dC4f408xwSd4a2h8c6pi/zyOMH0voTK4Q5
 rrPCUOjX92dtlBUEkdGEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z5/ewB8rlLU=;lPuSbrjWOY/jgO5Tv8zXUiKVzh+
 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
 ekaDP08Ub0JaKLdHEPMNWCyRCQi+E



=E5=9C=A8 2025/12/20 04:45, Mark Harmstone =E5=86=99=E9=81=93:
> If a filesystem is missing its data reloc tree, we get something like
> this in dmesg:
>=20
>    BTRFS warning (device loop11): failed to read root (objectid=3D4): -2
>    BTRFS error (device loop11): open_ctree failed: -2
>=20
> objectid is BTRFS_DEV_TREE_OBJECTID, but this should actually be the
> value of BTRFS_DATA_RELOC_TREE_OBJECTID.
>=20
> btrfs_read_roots() prints location.objectid on failure, but this isn't
> set when reading the data reloc tree. Set location.objectid to the
> correct value on failure, so that the error message makes sense.
>=20
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index e5535bdc5b0c..f1e58c1d6c38 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2221,6 +2221,7 @@ static int btrfs_read_roots(struct btrfs_fs_info *=
fs_info)
>   				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
>   	if (IS_ERR(root)) {
>   		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> +			location.objectid =3D BTRFS_DATA_RELOC_TREE_OBJECTID;
>   			ret =3D PTR_ERR(root);
>   			goto out;
>   		}


