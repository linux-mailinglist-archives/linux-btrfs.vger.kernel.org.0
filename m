Return-Path: <linux-btrfs+bounces-14075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B326AB9544
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 06:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9430050229A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 04:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033122F746;
	Fri, 16 May 2025 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YvCiQkXh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D546BF
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747369524; cv=none; b=CBo8vk+zOQSuBgQRsyb0tjJ54RBeKPSU5NPYs1mN9OEE831+jSICztc70+4Dg81s6USneyYg+34zfSYG5ng9O8n8p80CG11Cej+IqAbGRiBdAf//P7/G9FFQ6jYczJq5/L+B9BCbXFBVdxzT4oU7u7egKE0L/gnQgjcvH2Khj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747369524; c=relaxed/simple;
	bh=gi6byble38NMCCsGO246TNRT5ab5hLDwtJbj/t8YZ9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nh2CjBfaU5S9XLk/+EJmG6Gtx5fR8QvCopwHcPvUAJuqVP0BxxmlVwKwM3ndl6PWkBWy+yL1dyuB4BLdPvAF23ntmfZYI6tSc2owxh31FrrXUjG2+o48tOoY5SKcEsSJqwP3deS6s0wjMz1vTjzbb/2iU7td721aE7JvL1SZpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YvCiQkXh; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747369519; x=1747974319; i=quwenruo.btrfs@gmx.com;
	bh=GwLL18eShVVrmKzLdP19xqt4E8R99XpmEP64ig1R/eA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YvCiQkXh1zdhRpC4TNTvkCRsTF4aWDxLq6VGkDwTlLSLfXboXj7O3RF63EpYb3ca
	 jdyctytqy7YA41Zaz7Jt5xCP9g7/e0AWGcpO8z1xZPLUyQumOGigZMLm0pkbtHk2w
	 8zpJn0aiQWIj/flurek57UdAPrgIAXuqv7wF9hXzdLf4amunh7bD5xlH2nFbP3s7F
	 a1Jlh9wSY9eKoDHC1uD42ihEgXZwsSy2rTYl8tE7vFu1DynAurvLtSgveYmsRSbdU
	 V197tS5enxCceIGyBJEuPXZdaGJkQHpjA3OY4QOfcHLbE2xmMu2cgx9X889d51Q2e
	 dlZEkUL7hnhy0CChEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4QsY-1uw1Pc3pPa-018KuY; Fri, 16
 May 2025 06:25:19 +0200
Message-ID: <96747079-c47b-4df6-8200-90ba91220c20@gmx.com>
Date: Fri, 16 May 2025 13:55:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: add prefix for the scrub error message
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
 <adb7e0b9365da95d9497c4cde18233f3e52e41df.1747364822.git.anand.jain@oracle.com>
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
In-Reply-To: <adb7e0b9365da95d9497c4cde18233f3e52e41df.1747364822.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qMRDBnxv55y7ZG+mK1qgi0f9h4C4kjWXDhdIg085H1y7tW6wHgX
 HHyGx/7GNC5ylC8HBGJozLwYJtq3YiO1u7UkZECSqKZusjdcACBzVHHvt/+6ydsv/4ukpVu
 Hqv86QQ0pwBWBsqoDN2UCcHcJWSN7L3RffQNsjMBJE3lAMz1HlL6BBFCpTBaVCLtwlN8H11
 rVoAduS1XiA69esMhHaOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:30mdKBwydso=;EyYqAmZlyNmqjzBZjCuFmhmiRj/
 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



=E5=9C=A8 2025/5/16 13:27, Anand Jain =E5=86=99=E9=81=93:
> Below is the dmesg output for the failing scrub. Since scrub messages ar=
e
> prefixed with "scrub:", please add this to the missing error/warn/info a=
s
> well. It helps dmesg grep for monitoring and debug.
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
>   Fix remaining scrub warn|info|erro missing the "scrub:" prefix (per Da=
vid=E2=80=99s review, ty).
>   Drop rb
>   Drop Fixes:
>   Update git commit log
>=20
>   fs/btrfs/ioctl.c |  3 ++-
>   fs/btrfs/scrub.c | 53 +++++++++++++++++++++++++-----------------------
>   2 files changed, 30 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a498fe524c90..680a5fdf89c3 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3142,7 +3142,8 @@ static long btrfs_ioctl_scrub(struct file *file, v=
oid __user *arg)
>   		return -EPERM;
>  =20
>   	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> -		btrfs_err(fs_info, "scrub is not supported on extent tree v2 yet");
> +		btrfs_err(fs_info,
> +		         "scrub: scrub not yet supported extent tree v2");

Duplicated "scrub", please drop one and change the phrase.

The remaining looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

