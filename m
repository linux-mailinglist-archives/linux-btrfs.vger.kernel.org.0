Return-Path: <linux-btrfs+bounces-19736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4376CBD3F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67413017668
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 09:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFC6314B69;
	Mon, 15 Dec 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="INyobc2D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306C2BCF5
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791946; cv=none; b=IBT0vPYXoMpOC0aoohgW6BGDLk3lMelM3DsIEst1aNI+cY47MdKWEp5mu5adkao2yO/DRh38h7LvqwFa/2MPrhMRsQeHWmfCMHCiLu3P6D7xK5Dxyk/5TeKgLZKZxmJM6hrV4YKNwlQAh8MGKuqqrT+quoxUD34Tn2lq8oMsRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791946; c=relaxed/simple;
	bh=Pm6mrS+PECjRU0Ck635bKZXyutvYMz5XkJ8v/hpC4uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cVXXZyyAnInVCcRex28EGphUpYzEdwAQ0FvId/pRaSJS+gID0EL7QmFsbdEYc5lw3+c+XNNTR7+ycpgYOOu8buxRqCMOt9bhx+H1EO8wbTx3MLnaxLo5tgZF29v8TFquEL+3qpKkTP8uOOzbQq5pftjnMTu5MUXRCQYQjrgQGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=INyobc2D; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765791942; x=1766396742; i=quwenruo.btrfs@gmx.com;
	bh=xFENCgvcl/wXjXwi0OwqYup2vXgl1gNbjvhdybD5N6U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=INyobc2Drx8tfZodUpG2WPTykVDB7LouScptxpPhSKQ9oj+4qYnfA8r/9a5KW8Pr
	 lDfb6tmWptmHp06q2as886DU84MPRtgi2iI7skZGmw82lS5kClsSi2q6IcmhD32Ix
	 AS+WdH172Bc7yoOHuyK40baoepp4jIH3EclPli7WeRDDPBMWdkUb5bXpN9BTibis1
	 hTVDjUMR5suTmT0uP+Z2Cvo8C9qqjOUNtDjFUplkXT6CoKJbTHMacef4G5RkZDey8
	 zfVBIZbV40ooP/Q40EQ1GLCMfwRczO420pZx20aldkY5LiR73Je3NdTjJPGwIzGjC
	 fXVufUQB8RgtmG0QFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMofc-1vlW4H359Q-00RK6p; Mon, 15
 Dec 2025 10:45:42 +0100
Message-ID: <1ef636ea-48a9-4ff8-8c73-e954497ed4ed@gmx.com>
Date: Mon, 15 Dec 2025 20:15:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: do not free data reservation in fallback from
 inline due to -ENOSPC
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1765743479.git.fdmanana@suse.com>
 <d73d7cef875d6fca9cca0d6db39fdd5d77f55c6f.1765743479.git.fdmanana@suse.com>
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
In-Reply-To: <d73d7cef875d6fca9cca0d6db39fdd5d77f55c6f.1765743479.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aOoZHmXxuNTsPebkDnQwzRt6EMpsGM/sp1vNIPjJQNiXmzPIVhE
 yZsEW2dCdoI8oh3tHPUxd+RNgkDtKZPNo60zvFZiClKtBH0BkBvGINtMfJTsDeSuqW9N/vx
 0JD9yuY51OjlhLJFrDtBV5gcaO/mUuvcNvmVE2ehEEbhCbPHtyV9tIaPOceD839kICvFzOG
 rCpvpPNFyV95LK+KkKjUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FNb6udJDAFU=;ELG5XhaHjVRm7EIgfgveV74x+xu
 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
 OMejsojM=



=E5=9C=A8 2025/12/15 20:08, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> If we fail to create an inline extent due to -ENOSPC, we will attempt to
> go through the normal COW path, reserve an extent, create an ordered
> extent, etc. However we were always freeing the reserved qgroup data,
> which is wrong since we will use data. Fix this by freeing the reserved
> qgroup data in __cow_file_range_inline() only if we are not doing the
> fallback (ret is <=3D 0).
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 566780eb80ff..605589f29da7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -675,8 +675,12 @@ static noinline int __cow_file_range_inline(struct =
btrfs_inode *inode,
>   	 * it won't count as data extent, free them directly here.
>   	 * And at reserve time, it's always aligned to page size, so
>   	 * just free one page here.
> +	 *
> +	 * If we fallback to non-inline (ret =3D=3D 1) due to -ENOSPC, then we=
 need
> +	 * to keep the data reservation.
>   	 */
> -	btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
> +	if (ret <=3D 0)
> +		btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
>   	btrfs_free_path(path);
>   	btrfs_end_transaction(trans);
>   	return ret;


