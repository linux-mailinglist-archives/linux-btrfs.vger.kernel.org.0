Return-Path: <linux-btrfs+bounces-17521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD90BC2CF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 23:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDBAF34FCAF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 21:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F51025782F;
	Tue,  7 Oct 2025 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SGbN9ozm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06A23F42D
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874307; cv=none; b=XNxIkY+wkMXlBxeQvVi2Bivkrd9wTw1UGPAKkpSfnEbPrxIYc5ZxYRktFuWRTFpvlHQ27qF/tOoFZNCWn6qISxgpSd6ZeFCHY1feOglzAVUAl7BFrwQAaqnJod/0YxL88Qw2AGtmWt/ceMqz1VzrzJkcjdD/WXa9eflQFBe3fBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874307; c=relaxed/simple;
	bh=ji1Xx4SXXdmoLn8Ik0Fw1hP3Rl282ejlDmzqag+HI7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J1nit+yuFM3cRGoMLjRO4p31bwuKFExfWJYrX92GVpbG6KgXHbhee1/24UVdHU2Dm/bdCklIQfFvC5bjPodOqvqI4GWN+5Ao3aGkwFrVy8Gfu7gJcVPvjQod+GVOwjMLysZQ2WO/WBDHvB4EUMKYn1SJClMK5VEYjXhvdLruHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SGbN9ozm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759874297; x=1760479097; i=quwenruo.btrfs@gmx.com;
	bh=IXthaZQeFk8CJsjOV0vIzBJDQpl4JBWeSt89dRLVW1o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SGbN9ozmFPwDKOHJKEExl6wk2+d0LQbEe17ur01uirK1MWdkBEYxsRaEB8bcivBS
	 QoUnk6XAQIgWFswkHRuugxEolE1byFETb5PmZu6WrQMj8pqHcXJpxIxisO+Gx9tx7
	 g0DRFnSHqanIC52Y8tbtzTyrYnfy8k70tHBEO5ZNIv2RrUXfvh2QabwnIzIEXez2W
	 36OuCRiHAfZRmTyvl3dM0vBkAfbuXpY5dmUrMmi5JyGsZR+Bus8FVPEd0gD+tQfYt
	 oVaQPk/wiwlZXZME1g2JXD/jSThGw/Uh20aYyRXQmk/f03P9wRn03o+9P5d/wrRpD
	 arFVBOkxtl4B7Kxeyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mn2aD-1uNKE215ZX-00na2p; Tue, 07
 Oct 2025 23:58:17 +0200
Message-ID: <c310743b-200e-4bdc-83e7-934ae43932dd@gmx.com>
Date: Wed, 8 Oct 2025 08:28:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use end_pos variable where needed in
 btrfs_dirty_folio()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <264523d69e13ece0fd80675a77511caaaaaca421.1759833561.git.fdmanana@suse.com>
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
In-Reply-To: <264523d69e13ece0fd80675a77511caaaaaca421.1759833561.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q3GF643LfCX0IXQuX0tLIx8JCqh1N89lPg+RNzgPsRdWJtnYTti
 +rV4y3YNxCY12yW5hSOrn2/QyCw9/Gyyez/k2WnZ7Qk/ms3AxHo/YqYGilEBfCy+ZhIhjyO
 jPPg9vDNOE17WOpb28nrNN86kcWFaGFDlu0M5m8t0Wu/Ec4m3L7xBVqJ92qKa6vaxBNsplR
 QcMWISZoPfA45WmMNBbkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nGed8MjADK4=;9eWZSVFeqVofM8yBMJTNAyaphWw
 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



=E5=9C=A8 2025/10/7 21:10, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We have a couple places doing the computation "pos + write_bytes" when w=
e
> already have it in the local variable "end_pos". Change then to use the
> variable instead and make source code smaller. Also make the variable
> const since it's not supposed to change.
>=20
> This also has a very slight reduction in the module size.
>=20
> Before:
>=20
>     $ size fs/btrfs/btrfs.ko
>        text	   data	    bss	    dec	    hex	filename
>     1915990	 161647	  15592	2093229	 1ff0ad	fs/btrfs/btrfs.ko
>=20
> After:
>=20
>     $ size fs/btrfs/btrfs.ko
>        text	   data	    bss	    dec	    hex	filename
>     1915974	 161647	  15592	2093213	 1ff09d	fs/btrfs/btrfs.ko
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/file.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 7efd1f8a1912..dcbd038d1ad1 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -75,7 +75,7 @@ int btrfs_dirty_folio(struct btrfs_inode *inode, struc=
t folio *folio, loff_t pos
>   	u64 num_bytes;
>   	u64 start_pos;
>   	u64 end_of_last_block;
> -	u64 end_pos =3D pos + write_bytes;
> +	const u64 end_pos =3D pos + write_bytes;
>   	loff_t isize =3D i_size_read(&inode->vfs_inode);
>   	unsigned int extra_bits =3D 0;
>  =20
> @@ -86,10 +86,9 @@ int btrfs_dirty_folio(struct btrfs_inode *inode, stru=
ct folio *folio, loff_t pos
>   		extra_bits |=3D EXTENT_NORESERVE;
>  =20
>   	start_pos =3D round_down(pos, fs_info->sectorsize);
> -	num_bytes =3D round_up(write_bytes + pos - start_pos,
> -			     fs_info->sectorsize);
> +	num_bytes =3D round_up(end_pos - start_pos, fs_info->sectorsize);
>   	ASSERT(num_bytes <=3D U32_MAX);
> -	ASSERT(folio_pos(folio) <=3D pos && folio_end(folio) >=3D pos + write_=
bytes);
> +	ASSERT(folio_pos(folio) <=3D pos && folio_end(folio) >=3D end_pos);
>  =20
>   	end_of_last_block =3D start_pos + num_bytes - 1;
>  =20


