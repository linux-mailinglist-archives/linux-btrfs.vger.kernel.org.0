Return-Path: <linux-btrfs+bounces-19737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EFACBD40D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F268300C874
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAEE313529;
	Mon, 15 Dec 2025 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hCJ/63rt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192E2727FC
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792063; cv=none; b=asfkJGkVq2+8lMf0IUY0GKtGkYyVC9I79u04IC1zG37eVl/aFFCex+xkY99z5ZGn+xkCi+ru+rK0AvUjjqqAWfVB20TOaGA4oM5fVRsahad0+DVLL7ebuvVOZ/eGk0mWqh70KFIbZXWQmADv2fMtnr7zx//0Gp04PAlQa1rW9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792063; c=relaxed/simple;
	bh=2lhQ/yu7hEFPGmlGXQ4ut1FtJoHPh2J0Ln2Jz0LYLp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E0xZ0KpapwUycSVK+RYrVA7lL90HMRSeZL7sDYk9t3YjxRqf47nG8Fayo0ABbs9l79ryUAhHYBebd5WPvESzpTP0T6txQOSfxDmTS44H+EzLnR7Tr4ILP3OwAEFxODWT/tOXyu4Pj1aE6bYirMU2Om0guimJpDjVY2z3cq3s8q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hCJ/63rt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765792055; x=1766396855; i=quwenruo.btrfs@gmx.com;
	bh=w8eNl5K2SVNDagSQcAWl/3EQwurNx80fPJu47lgrgg4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hCJ/63rt0y7dKmtcbONcHHV9xtsD5JZscnzf55x0ioCzdHFbTtbuqrl0dA4UvS68
	 a0Q3X0NMzxXF9r+zLL+dPVd8T1gJ49FsfdvyrN0CWQzmqtHOyHD5vbhAj1mlgPp79
	 5q7m9K4K0iNRvUWfQ3lnrzltouJ95OTACblJW4j7DPsvZSZFLBRus36cNMHFdYZyj
	 khyoJRJUEtp5TdfJruAQZdC8ZdJkBdOW6uQ7QO7xlTaiJuxWtTd+0d5VZ91gKrMkk
	 Iu+yyQH3uYF6vDh7/BhPeMuZr+03TgqKQ927mDNulnEVmVsSImxe9NUft/TZ52go6
	 lbfPrcVdtvRuGLIEcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6lpG-1vMoVU35Xa-00FgHw; Mon, 15
 Dec 2025 10:47:35 +0100
Message-ID: <24e5d07f-322d-4eba-9aaf-e9f4be027bd6@gmx.com>
Date: Mon, 15 Dec 2025 20:17:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: update stale comment in
 __cow_file_range_inline()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1765743479.git.fdmanana@suse.com>
 <edd0445538783749845d7b1911737237a41595ff.1765743479.git.fdmanana@suse.com>
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
In-Reply-To: <edd0445538783749845d7b1911737237a41595ff.1765743479.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4r7U7pSmB/HfPbmwdlOUAwZ472htOJWeYUOHbvqQ6NgF9YL9d11
 DQDsv3MUkWEVHKyUhaPXyBMETn2GmA0KTeL3WTWD9Z28EFblxIQowBFmkluu8xl10Mp5ImE
 qeCFTOkqbtBwh5MhACE1CjG9XPqvsBU4kkj90bckRePmH7RxizHT2SQKY+7Oo9OjO80nYj4
 o/gmbkdBaGlY8ANlcxP6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:taPZs3r4KiE=;ZCOaRF+CWMPvxSFCAyel4cW/+Qh
 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
 i7hZDzKj1k5ChHAUk=



=E5=9C=A8 2025/12/15 20:08, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We mention that the reserved data space is page size aligned but that's
> not true anymore, as it's sector size aligned instead.
> In commit 0bb067ca64e3 ("btrfs: fix the qgroup data free range for inlin=
e
> data extents") we updated the amount passed to btrfs_qgroup_free_data()
> from page size to sector size, but forgot to update the comment.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f1ead789146b..6ae36cc5bcda 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -676,7 +676,7 @@ static noinline int __cow_file_range_inline(struct b=
trfs_inode *inode,
>   	/*
>   	 * Don't forget to free the reserved space, as for inlined extent
>   	 * it won't count as data extent, free them directly here.
> -	 * And at reserve time, it's always aligned to page size, so
> +	 * And at reserve time, it's always aligned to sector size, so
>   	 * just free one page here.

There is still a "page" reference here.

Other than that it looks good to me.

Thanks,
Qu

>   	 *
>   	 * If we fallback to non-inline (ret =3D=3D 1) due to -ENOSPC, then w=
e need


