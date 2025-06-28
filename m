Return-Path: <linux-btrfs+bounces-15059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD366AEC52D
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 07:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B4F7AEDF8
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 05:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665EB21D5BD;
	Sat, 28 Jun 2025 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Mb8bQ+gV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA50FBF6;
	Sat, 28 Jun 2025 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751088419; cv=none; b=CLNOvFrIjjhtP0PDS4h2xxZHE9tFwZQsqTweH22owIhUQwSvuW+oyr/geIF4FAaCygdj47n9F3cJ+vOKR/3Eg8shLNG2yixf+d8vY4hHoaLRnHonaUGqUTG/JTFbGbwP+7qg25+Wnl+mQrbogOJS5dll/DDdfGjo/D3aRiEEaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751088419; c=relaxed/simple;
	bh=DlIGBrInh5K73tNxGyghyJeTrPoHjiJPkT0NdgT6lso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvbiPkaXtNMw1kvWMYLKUvuf53VwixI67qUxXxsfbvtSnJM/E2puBhmJ+wyvCwGs5CQE0Ob0ox3+52gEtOzzWZDmKITsGYI5WCpy8YNsoEZSwJO8wbCS3/qpspn03TgPkb+ccetO3w8hGGRPoqgLooE58+04rofUyiy3fB3YMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Mb8bQ+gV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751088408; x=1751693208; i=quwenruo.btrfs@gmx.com;
	bh=/QHW6ByD3GYkEcbhxYRm5epY1RHocJz5KFy5XNtlCgs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Mb8bQ+gVhbjVSOq5LVN2vBJsRrfGotMD036r3GYvHXLAAB1nqnWtZnlr22P2AOPR
	 pT4OSGtt3yRzTPX0gzLMO3VYbZAzQFzYj92u7MiWTI7vW1SBI1GVcTqhR50NENrTE
	 YxbAqi1/T3ev2b31tk9nLACo/2bx6/FEet2F2cDgK0dvjwO5fu9MB8cCeWPv0RbLz
	 l+WBk25XFyd3jPEBj/9LMMChXtgBJneTpIk6JnxhDxPXLmtGyStfIs8gWEnSteCA3
	 eK05OuI/4IPSNQlXknbDXVPVOb9XHCGW7T9YeftzAAN3/dEAhXL/64qs2IZIbyPT/
	 9FxsVnaUWqSkbC3XFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmDEm-1vDULX1OLo-00aJAC; Sat, 28
 Jun 2025 07:26:47 +0200
Message-ID: <b316d443-107d-4c85-81cf-37fe653cc8a6@gmx.com>
Date: Sat, 28 Jun 2025 14:56:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: replace nested usage of min & max with clamp in
 btrfs_compress_set_level()
To: George Hu <integral@archlinux.org>, wqu@suse.com
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <669773b7-4428-43ca-ab80-d7ed1c71886c@suse.com>
 <20250628052130.36111-1-integral@archlinux.org>
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
In-Reply-To: <20250628052130.36111-1-integral@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XiLHCvfjSca7SgrGRmJYrPTR/GV3BW3z0fdAnHJfKw0/4uCq8Za
 BSa0UgiMe3XgPDddzXWrWwbVfNP1RLdHlflg0oAKc1iWBETzqRyx/Yfkc2WhkoDs17IqOi1
 M3cT8rrJFm3+BIuiAmhFZK/IbR8gQZqA9MDSlXhEq57yIF8uqhx1ZSrMqXchoYqRUtPD0SU
 cTcOCkUuiNnSA7gL/V4dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gAb9zP3rdW4=;j85/ax5tcUn5oIAckDemJjgv28e
 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



=E5=9C=A8 2025/6/28 14:51, George Hu =E5=86=99=E9=81=93:
> Refactor the btrfs_compress_set_level() function by replacing the
> nested usage of min() and max() macro with clamp() to simplify the
> code and improve readability.
>=20
> Signed-off-by: George Hu <integral@archlinux.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

And merged into for-next branch.

Thanks,
Qu

> ---
>   fs/btrfs/compression.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 48d07939fee4..be8d51c53f39 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -975,7 +975,7 @@ static int btrfs_compress_set_level(unsigned int typ=
e, int level)
>   	if (level =3D=3D 0)
>   		level =3D ops->default_level;
>   	else
> -		level =3D min(max(level, ops->min_level), ops->max_level);
> +		level =3D clamp(level, ops->min_level, ops->max_level);
>  =20
>   	return level;
>   }


