Return-Path: <linux-btrfs+bounces-18724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F384C34A00
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 09:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DAC04FE151
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B072E8B84;
	Wed,  5 Nov 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="T0tF6M4/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C362DF6E9;
	Wed,  5 Nov 2025 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332814; cv=none; b=ZAkWoKu+lrHRMetHHBaCCTtJ5Hop5rimZyp1IQI9VmPCyz9hWchzMvQDxSVSMzE82np1w9EBAU8+7nXK/uG5SD92Bv6u3zlFHxBOivnfyXvfFAUiJozHBM7C9CguuwDQnoHZpXfvAwfeUuQP6tciw9JOMJUZ9R6qKXAsLbkAEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332814; c=relaxed/simple;
	bh=EcYa2WoSowNmtmICUelNbOrunrwhl6avA0dowKusPG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7eu4xW3P6/BOhgui320BHDOEV7Drs46MEvKBWJNt3oLWKK60lViZA/g19L1px59vgfkJCZAFqWaae9JY8HN3VWTQydAuuvQDrBXRXmfXGZxkXuxW64x8SbQK4gQsqCT0ikPlFGM27n6/J/CS/f4gYGcQz0T7WwB4acVrUUSnhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=T0tF6M4/; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762332803; x=1762937603; i=quwenruo.btrfs@gmx.com;
	bh=gTWS6zqH+GSsyOy2bIh3VXy53d1VFkSWeEtosbaaxAg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T0tF6M4/6GIX9PMnQyWTaWOzCHMrzYZGCo9mC1iRa0DYm0j5yq2SInhCgqMdsBYo
	 eE62r6VatHNG0orA0PrlntNrg8HRHnp/+BctDQKvkNOuB9HKavteDS+OS3lKE+Ebo
	 EfBEPpxsb91rn4HH6WlzEyDCTsYRoZ5SM2B50WiWqPJnreamxUQZ7Ty7vMS0mcVpb
	 8EsNp+HV4cdNR4epOA5Xi5GXTGdviLfwuuvyTxA4yzO5vyZYO0mC0zBnzyleMUEHU
	 cBQXwvrwYHC8prV+9naYi/peFh8mMFM6NmgFt1U2I7SKNMoNGn8KP7Ru3qKWpj7yn
	 hHRwT8oBH2mFhXqfLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlw7V-1vxum92cTL-00evGz; Wed, 05
 Nov 2025 09:53:23 +0100
Message-ID: <5e8aa994-a7aa-43f7-86b9-9dec69624167@gmx.com>
Date: Wed, 5 Nov 2025 19:23:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: fix memory leak in
 scrub_raid56_parity_stripe()
To: Zilin Guan <zilin@seu.edu.cn>, clm@fb.com
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20251105035321.1897952-1-zilin@seu.edu.cn>
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
In-Reply-To: <20251105035321.1897952-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oJdQyTSS0QUNd57MfZ3X86QF7JQ3DhU4p8arhNzTZQdPLexshR+
 jcJO9mN2uLbLebzZuIb+mubUWiLXHOyaX3Yl0T2YsrYmARRjch69EgsmxFyq3uBsrH+gRJ0
 1T9n6jCYT076sRfc+4aiCsar/otm0OfU/qk6YpTazQyh/LZbW8OMOeeEvZM2Lhrm82qClNL
 GM0KImojXy6h1YMv66ttA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:McCcxl6HwuM=;LV9CAgGgZcuauKlhpGZ9O3MTDvT
 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



=E5=9C=A8 2025/11/5 14:23, Zilin Guan =E5=86=99=E9=81=93:
> scrub_raid56_parity_stripe() allocates a bio with bio_alloc(), but
> fails to release it on some error paths, leading to a potential
> memory leak.
>=20
> Add the missing bio_put() calls to properly drop the bio reference
> in those error cases.
>=20
> Fixes: 1009254bf22a3 ("btrfs: scrub: use scrub_stripe to implement RAID5=
6 P/Q scrub")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Merged into for-next branch.

Thanks,
Qu
> ---
>   fs/btrfs/scrub.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 651b11884f82..ba20d9286a34 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2203,6 +2203,7 @@ static int scrub_raid56_parity_stripe(struct scrub=
_ctx *sctx,
>   	ret =3D btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
>   			      &length, &bioc, NULL, NULL);
>   	if (ret < 0) {
> +		bio_put(bio);
>   		btrfs_put_bioc(bioc);
>   		btrfs_bio_counter_dec(fs_info);
>   		goto out;
> @@ -2212,6 +2213,7 @@ static int scrub_raid56_parity_stripe(struct scrub=
_ctx *sctx,
>   	btrfs_put_bioc(bioc);
>   	if (!rbio) {
>   		ret =3D -ENOMEM;
> +		bio_put(bio);
>   		btrfs_bio_counter_dec(fs_info);
>   		goto out;
>   	}


