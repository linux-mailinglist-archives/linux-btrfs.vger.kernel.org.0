Return-Path: <linux-btrfs+bounces-16268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EADB311D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 10:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7233F1D00D8E
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EC2EBDC8;
	Fri, 22 Aug 2025 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qx/+KvzD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E71E5705;
	Fri, 22 Aug 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851279; cv=none; b=ji57ChDUA58Iy850ZkfOWPCsd1f2ZB2GuAQrAn1lf3GhU5BdgZc8GpwN9tzPYpGj4atHxWwX/A15O8/A8BhZDNRb7ltBUxAVSxiij1bZUzrRMSsu0dLNh6D/Jnpt0TdAf46nDI4+oGqPdt3kayAxzaHMmL0MfniQPMiQYWMKAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851279; c=relaxed/simple;
	bh=6+zBXAnjfxeLOVQ3hV8il3l/Cs/mVRVly0UroKofHaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BydejHTq7LnOZCIEixeGRqr9lgGRZr6UsFWx2pIQkja4zfe80TyvJDSBUghRewi2khIGx+nnBzf/K+SMWPluTd5PfVvbqR9oUlKZVdxcG6e2cfa0RWxlBk1oZWaTRyA9UkcA7LZzQYC+sPvZ2475oBbBtt2g+0GcI+foRYJYvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qx/+KvzD; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1755851274; x=1756456074; i=quwenruo.btrfs@gmx.com;
	bh=NZQyLrCj1pJkdWIIb4U7RAG/83xnld9W/57tLVzceQs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qx/+KvzDZhg3KhtR+/oQ5qe0KOKeq/rd2suPEyYXXUhsTtYT6dqJ3pR3WEAovNdB
	 gyjZUiSi9JRHxe7igXRxpF95wJlmeB4YCXN3ywDfhdrRn1jpLR+gzZQ978dNiCIuL
	 MMfr2RVGq5SbySgbCNywucqlgiPo5Nzi6Z5f0NAw69EOZ738GakHqerS2E4LinrNN
	 4lZMq1P9JMGX6jE4zE/uP7tZaoRkmHntgJaB33r2k16sNx//c6L0TC/SXO20ai4wu
	 AWXz5EFT75zrp+4E0AKICWgKqMUVv3d7weGhqy4OoZ5PtPDim88OplnYSwwy5vDyY
	 uszIfKALoJ4ztMNbQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MacSY-1uEeSh3B1u-00ptKE; Fri, 22
 Aug 2025 10:27:54 +0200
Message-ID: <a637a576-f107-4d05-84c8-280b133e925a@gmx.com>
Date: Fri, 22 Aug 2025 17:57:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
To: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Daniel Vacek <neelx@suse.com>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Chris Mason <clm@fb.com>
References: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
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
In-Reply-To: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iRuYDURP92QNg6RIW3rjynlbGe0pfvL9de5KUE5Kv2RCLkegsAI
 fhBc+RhuAI1Ys8V6ny6fGWrVp742mozUTT3L5pMaN22oZ3bqWMhz3pjI85TH5wKvfJDH84Q
 Ud5mTf0lNZrAjs4HMYdYVxE6dwjyZjJjUpw/epfudr/ZcZs7ohyIe+0BDZYaNFK1U4Xa7eD
 VU5l/qal0rc18az8IPv9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5KeIUFuDJoI=;R+ZyyCLSCEKzXWobuZZQGHszCKz
 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
 AKipiWpllpAaEOQQcBTfv4URha4u



=E5=9C=A8 2025/8/22 17:15, Calvin Owens =E5=86=99=E9=81=93:
> The compression level is meaningless for lzo, but before commit
> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> it was silently ignored if passed.

Since LZO doesn't support compression level, why providing a level=20
parameter in the first place?

I think it's time for those users to properly update their mount options.

>=20
> After that commit, passing a level with lzo fails to mount:
>=20
>      BTRFS error: unrecognized compression value lzo:1
>=20
> Restore the old behavior, in case any users were relying on it.
>=20
> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount option=
s")
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>   fs/btrfs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a262b494a89f..7ee35038c7fb 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_cont=
ext *ctx,
>   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>   		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>   		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
>   		ctx->compress_type =3D BTRFS_COMPRESS_LZO;
>   		ctx->compress_level =3D 0;
>   		btrfs_set_opt(ctx->mount_opt, COMPRESS);


