Return-Path: <linux-btrfs+bounces-19804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B818CC530D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 22:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6E563017F31
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51F6310652;
	Tue, 16 Dec 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XiQKz3tx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A0182B8
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765919836; cv=none; b=Sdq8DUSOTk7ATQi+cDqAR26RZDvEt/MeYuekACBQshmXioNxiM9qcHfC8NzdHOE7IFY7jQpuFpSFvwSkBAFNdau5mznMr7Hn2fIndsyZi6zSzj8o5KAjS9t2SNYbiYHB3B47lwF/bw2nCXnV7dcQGstiQZ23kEk2/KCag2OQk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765919836; c=relaxed/simple;
	bh=kWZLBSGv8M30w1r9asBeG2Gz0ecpOrWi0+kWE3kDpRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IZfgPEtWFA4036wyTIqhjkOMbVG6QcJHaC1e7jNocb8wgby8ziPbhHpW5LwGf5SB1XfQWv+kuzCoj4dGrjK+SPd90YVYDEEf3TKbcOL0CARXNYcwNXojNd3/LEKbehLlcVK9F6vm+YBfGxbZOL/L2Cb0snvsPMqADtrvj2PcF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XiQKz3tx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765919831; x=1766524631; i=quwenruo.btrfs@gmx.com;
	bh=qyRC1lr6pckZnPFTmSkAwZJRRRo97mTTBdZAdZngEQY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XiQKz3txSxG2PWkauIBpUDMRFusHmW3KU4ypm5ysE6GtJ8yNUN+NvcsIUVR4LjtU
	 dVkq7Fr2lUKJk1p9ryozVEP798fMLx6iH/oMHO3ZoQrFM5lnqhMvXSyRFdb2UFucI
	 bpPcgfgstl1Kx6bKEbfADSssjXi2gj02qwlpv+3yOE5raMRVorJdK2qrNmyys0sMO
	 7t5fMiS9oqmsXH/YnIwbJLmFq5zF8g4iWBeAwi6s/9gTtKlwD7POx2cMB0ZKo9stG
	 8yvbclbddOmD9kHq0GcL496pk2nFrsOlDZftm5iIc3I6jpJ3ZgnGkCRcOWdjv00VS
	 UlMjd1KNR1Argg9qWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9kC-1vm9ko2B8m-007T4R; Tue, 16
 Dec 2025 22:17:11 +0100
Message-ID: <3433a1ee-f639-4ce1-a823-02d2957045d9@gmx.com>
Date: Wed, 17 Dec 2025 07:47:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid transaction commit on error in
 del_balance_item()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <de940c4488c9be72d8df22f48651b3c2f7d2978f.1765900568.git.fdmanana@suse.com>
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
In-Reply-To: <de940c4488c9be72d8df22f48651b3c2f7d2978f.1765900568.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0gVp4fvsOpKbkwNCIqgoE4wc65RgcqmrWVGqMHZ4A0DGL9DcvS4
 jCgao8e3s8MTNDDkG9P1FzCvvqQI7ZyOZAvXJDUNebq7gkEIjll6ceZppYTegX9x6ht2VQe
 gg+1v3q3kdm2LpsOtCABMwHo8nbCXl2aO9w5WzyJSAsr8Zpc3BkQJrfOUH4lKbXDkxFiNyI
 pGacelFFN0ZbpOYH/XQ4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bgm/4VKdoVU=;3uyz9wjDIv8zr32u7GdxDB+UL6w
 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
 MwFJvpnk=



=E5=9C=A8 2025/12/17 02:26, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> There's no point in committing the transaction if we failed to delete th=
e
> item, since we haven't done anything before. Also stop using two variabl=
es
> for tracking the return value and use only 'ret'.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/volumes.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d580d8669668..102f7b85206c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3689,7 +3689,7 @@ static int del_balance_item(struct btrfs_fs_info *=
fs_info)
>   	struct btrfs_trans_handle *trans;
>   	struct btrfs_path *path;
>   	struct btrfs_key key;
> -	int ret, err;
> +	int ret;
>  =20
>   	path =3D btrfs_alloc_path();
>   	if (!path)
> @@ -3716,9 +3716,9 @@ static int del_balance_item(struct btrfs_fs_info *=
fs_info)
>   	ret =3D btrfs_del_item(trans, root, path);
>   out:
>   	btrfs_free_path(path);
> -	err =3D btrfs_commit_transaction(trans);
> -	if (err && !ret)
> -		ret =3D err;
> +	if (ret =3D=3D 0)
> +		ret =3D btrfs_commit_transaction(trans);
> +
>   	return ret;
>   }
>  =20


