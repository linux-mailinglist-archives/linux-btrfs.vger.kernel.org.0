Return-Path: <linux-btrfs+bounces-13199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254DA95705
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 22:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69F93A6B55
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370531EFFA3;
	Mon, 21 Apr 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LefJY4Gf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F319F12D;
	Mon, 21 Apr 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745266376; cv=none; b=uPfqGsEb1MjZ6ACJ1fzSfjodc4SUpXPQnUF8yHoqXuA5XW4ubmOJlgD4PJHThmyxlYYykIRYuF33NwnS5QY/zaIHvAHn8mL+107ojSpEEXzyvgSg8Iw9z/xWfIdebrvhJauTTgvucJMNiMjvyR/WJY+ayehcg86RiPBtKiOGwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745266376; c=relaxed/simple;
	bh=HqMx7zMToJ/PhryrEWssLhFhMlxyMymuvXXy8mbKOnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFIY8YL0PI+7Nimk1fq1hr5v6YgRgKETu+Rv4B67jmwvrofKByaZc/M3oqxx2XnEHpP+eW6TwUvW3w1jvrzygFimTM4I++CUtjIym1vjGW98MmmhtCSME+QqKCldcPUqVfLrUws8yUYFOQw3FEGVB24ehDkIFWGpqYIyEgiPlCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LefJY4Gf; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745266369; x=1745871169; i=quwenruo.btrfs@gmx.com;
	bh=qLY5eVn2v/9BK9n2cGKTxL5O17xb7q/3MUD00up0+Zo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LefJY4GfCYmE8XgWAMiPJ99xZeKTpaMGICD+RQwobj2CQkiZOcO4rsVTNPImROYO
	 xb62s1JQ2VBGKK1aSbX0MJpteZKrMa2EHtjNMRlKQtzZzUaSMlo+AGvVKK2S8QblU
	 l/uzGpmd5Ax358XJhjGjrtd16xkX3LDBl/d1UJg+LZ7XnObTksGS4y+CyXu5/c87k
	 +f95HEY1M9vFACE2PIjRLFRwoOZqxFgtrLj+QM5wztZn4Zl7JuNqFkukrxtivr/CX
	 ReJoR2qDKs2idiUFtEugceTqqMHd3u8imqhauiQLlAZ5CWyJ1SRkm3b4oqZ+r+2vt
	 PTJNSmNiiQ0/RVclZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbox-1uUyXz21cp-00Nchg; Mon, 21
 Apr 2025 22:12:48 +0200
Message-ID: <367f977b-9c74-486f-9a27-75a8a7ea50ef@gmx.com>
Date: Tue, 22 Apr 2025 05:42:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix the resource leak issue in btrfs_iget()
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9e7babf0-310f-40cd-9935-36ef2cebb63f@gmx.com>
 <20250421154029.2399-1-superman.xpt@gmail.com>
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
In-Reply-To: <20250421154029.2399-1-superman.xpt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oiL3W3g0AvHZ2KU53FmaLvL1Mr23HxBqr7fVrjw75KeXZS9nrCM
 lD5gzBiDJF8MjXgOSvOGtQMPvoABfvuhkCmBcXqvt9dXxfrgeoUXzoKQBg7985rsBME63mV
 cynBW/P+7cOV2xv9W4H7j+VRDA+3XveU0tYUa9tWzj6b+Uq7WF8HBsj2Q+U2zK3WbmS0B/3
 /z4nMqCd2WjSbQQk7IZgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o1zKeE896Y4=;SsAtNpGgjfpwcvuqzTNQC56nh6B
 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
 w==



=E5=9C=A8 2025/4/22 01:10, Penglei Jiang =E5=86=99=E9=81=93:
> When btrfs_iget() returns an error, it does not use iget_failed() to mar=
k
> and release the inode. Now, we add the missing iget_failed() call.
>=20
> Fixes: 7c855e16ab72 ("btrfs: remove conditional path allocation in btrfs=
_read_locked_inode()")
> Reported-by: Penglei Jiang <superman.xpt@gmail.com>
> Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
> ---
> V1 -> V2: Fixed the issue with multiple calls to btrfs_iget()

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
>   fs/btrfs/inode.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cc67d1a2d611..1cbf92ca748d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5681,8 +5681,10 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct bt=
rfs_root *root)
>   		return inode;
>  =20
>   	path =3D btrfs_alloc_path();
> -	if (!path)
> +	if (!path) {
> +		iget_failed(&inode->vfs_inode);
>   		return ERR_PTR(-ENOMEM);
> +	}
>  =20
>   	ret =3D btrfs_read_locked_inode(inode, path);
>   	btrfs_free_path(path);

