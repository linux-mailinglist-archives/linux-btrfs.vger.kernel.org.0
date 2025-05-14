Return-Path: <linux-btrfs+bounces-13989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332EBAB6147
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 05:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B08179D43
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 03:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27121D79A5;
	Wed, 14 May 2025 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UP1M8Oz/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC114900B
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747193849; cv=none; b=rkqllRl9ZzED//hUbErIelBVWSvif9Y1uIk2sFHwBEJk5EPMcAXUYe6w05ZWNvtQoDDRIDC0fqkf2MM7OsI2kjJkyRdyPerkrssUSpsEi6uBfA0ww0EaeejV25CaYlYZwa8YjZeMQQtcXxedXlvho6orqJn2P+T27TnpsTbfkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747193849; c=relaxed/simple;
	bh=x4N1/39mnDl2kA8l3eMGL9VU22g7lFLAMZfAI5bPs0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HvbiwdQYBMdZZ5rQ7O4nN6yWCsF9guSNokhVnBrsv4bas5a8lVk2w0nl682pxU6U0sYaJNRno3Pf2ZP1q1ZC7CRijawn1XvniOiN8GOLrSrhKIXuw9A5sx9FpttxhhbXdpqr2D836A8Os3Ad131B1fYps+/63mshojp9av22wI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UP1M8Oz/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747193841; x=1747798641; i=quwenruo.btrfs@gmx.com;
	bh=l65iJbyi5ej6EioIH9iilxcV41g7UvVnDd4WPsklC4I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UP1M8Oz/ninTLkhSyeTmeebSQhOPe2WPLpN6r0m8+WFUD1dmSZg617fJgs5vteMI
	 OUUXa+x8hp+Rrc7ajYqEMX5ApnQnw2SAVcctF0Cnm3KEjcNAUflplyfRsAhxEsMIu
	 qdfhmfWz6DPsB6F4ql3cqCNOMEmU6aiOPBO80autT/M+mD/gHrOo8MI56Ivo5StyW
	 TnCsUt5kzGC1xravEaAsyoLaM33vdTqDF9UlArOk9mR0ZPyJf1AzP98M33qFPsF3v
	 0xT7AU7o9SHuJF0+ygl6yp1XfQz6baC4rsD30M8aYLiLr9gXDpxhC5zSzVjoQjVrF
	 TTUAIq9ikUbgg2SPVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3HU-1uCtC41p1s-004cTw; Wed, 14
 May 2025 05:37:20 +0200
Message-ID: <9ba1fc52-38b2-43f6-9c29-df924d8045a4@gmx.com>
Date: Wed, 14 May 2025 13:07:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add prefix for the scrub error message
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
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
In-Reply-To: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9xGch2nDPV7lRswyRsKouY7FO7/720jv/bvzYIdGeWXqULWIccz
 lPg8K/oqZYeaNVvPtaYH4NtIy3LR0aA1UzR6CGx4mVtYg1PNGgxggQSmM7a1d8wGGsJwcga
 UV9ObccuuTYf5K6puXEAm4ZD6AE2Bwx1gs4tiX7ZJXxqJgKlHa8bi5qrcTfzCEdV4WyUl13
 Mc/U9HyCtm6dECgqOlM8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZwPzedWpIFw=;vfXF9nqCzovauSGtBQiMexZjCAL
 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
 AMWzq2prprSns=



=E5=9C=A8 2025/5/14 11:15, Anand Jain =E5=86=99=E9=81=93:
> Below is the dmesg output for the failing scrub. Since scrub messages ar=
e
> prefixed with "scrub:", please add this to the missing error as well.
> It helps dmesg grep for monitoring and debug.
>=20
> [ 5948.614757] BTRFS info (device sda state C): scrub: started on devid =
1
> [ 5948.615141] BTRFS error (device sda state C): no valid extent or csum=
 root for scrub
> [ 5948.615144] BTRFS info (device sda state C): scrub: not finished on d=
evid 1 with status: -117
>=20
> Fixes: f95d186255b3 ("btrfs: avoid NULL pointer dereference if no valid =
csum tree")
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/scrub.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index ed120621021b..521c977b6c87 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1658,7 +1658,8 @@ static int scrub_find_fill_first_stripe(struct btr=
fs_block_group *bg,
>   	int ret;
>  =20
>   	if (unlikely(!extent_root || !csum_root)) {
> -		btrfs_err(fs_info, "no valid extent or csum root for scrub");
> +		btrfs_err(fs_info,
> +			  "scrub: no valid extent or csum root for scrub");

In that case we can remove the phrase of "for scrub".

Thanks,
Qu>   		return -EUCLEAN;
>   	}
>   	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *


