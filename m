Return-Path: <linux-btrfs+bounces-13190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A4CA94F78
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 12:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA0757A27E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 10:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAAC2620C6;
	Mon, 21 Apr 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AhtBgOZ1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCE20E01E;
	Mon, 21 Apr 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232179; cv=none; b=C3hQOIsyZ+ex8McGvdI4RONoBT9fz+NuDh+8FFWr6WfwGAyoHtFV+oe8l5E2NIqJxcvwBCp+2nj2dE/HzYGIymVoI+RAwmHyoOB8H16eXSxfVtgua8z0OFhaFEuAncIhGKsPh8SZfRJURDp0NXmooagga1kpKuf0GDuwPGfHcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232179; c=relaxed/simple;
	bh=g6aoNjjUe6gpyU3lEhAAMFrkD8tpCtOClqEvVFyO5lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sswqxkKrJ4njqHqJs2PuOOZX3RQrmASqmVJnxESySDGH8lddEsk2UGZjH9c3+Lp3ZsaQ5zq9Icw+cPwgOV0W53wKQJ2mpnRCQuPtLKxwYz4bMYz8BTHpKc0nxL1y6QBMgy41oMGQGkZyX3FptYGTEHQyZEU6+AYvX1xrfwPW1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AhtBgOZ1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745232172; x=1745836972; i=quwenruo.btrfs@gmx.com;
	bh=fztYMfni9OaHqOaPo9QXn2+QMjAAMakdY/6EGbfxUX0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AhtBgOZ1gWaP1eWPigqxWkPy1fV7y01y0nSGeeuVTIL8P0aVWzAjDGzDKmAtjmC1
	 Uw81tzs9ZL+YdFDjp9mzHAu1cjuETE9vQBKnygNcDayzjmH/ErieFkZvBg0pz44jf
	 XUrw2SSMQ6E9VXz/Hfk3bgiMaaWEI0sTUZmkwWvi691XKQLKnRL5sqLP7xBRD9NUu
	 bVrlOdqYEbLNS92grW1Pws1bKbVDkd1LQ6QZC3/flc8uQ+mhMosVwc/4ul/BF2fsY
	 0TPqzd27MYGqiSJTedbLxfryS9FByzrDo+xMckybVKFdM323F2eexTb5thjJKyyFF
	 cTCqEv8zOQY6eGqXCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sit-1vBq7w1Shj-012aOk; Mon, 21
 Apr 2025 12:42:52 +0200
Message-ID: <9e7babf0-310f-40cd-9935-36ef2cebb63f@gmx.com>
Date: Mon, 21 Apr 2025 20:12:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix the resource leak issue in btrfs_iget()
To: Penglei Jiang <superman.xpt@gmail.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250421103252.44509-1-superman.xpt@gmail.com>
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
In-Reply-To: <20250421103252.44509-1-superman.xpt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mqo4g+batdcBt/v79MDeIgrr3ppT03dgyH7S+a1WC+p3h0rkr9m
 PhEHyQUqOKMnGUgiAeghCMD8PrGYqv66JRCD8RV9M4dSynhoNBoeOAH6kU300bnZwMcEV4i
 nQ3MPrWa5uOBcrm2aNjcTQ9kD3CLlEKpwVK/1hVeHfS/Zb+auXGa5t8xnjRjKDqplHU0KVT
 Kel1wR9eSV6urUgsl9F/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rr8AEwuPX10=;X7EZ6kud8jlIgZ0DnFJkitJylMW
 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



=E5=9C=A8 2025/4/21 20:02, Penglei Jiang =E5=86=99=E9=81=93:
> When btrfs_iget() returns an error, it does not use iget_failed() to mar=
k
> and release the inode. Now, we add the missing iget_failed() call.
>=20
> Reported-by: Penglei Jiang <superman.xpt@gmail.com>
> Closes: https://lore.kernel.org/all/20250421102425.44431-1-superman.xpt@=
gmail.com

IIRC this is not a syzbot report, although it's definitely a C=20
reproducer from syzbot.

Thus I'm not sure if the closes: tag is correct.

> Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
> ---
>   fs/btrfs/inode.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cc67d1a2d611..61d7f3f94090 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5681,16 +5681,22 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct b=
trfs_root *root)
>   		return inode;
>  =20
>   	path =3D btrfs_alloc_path();
> -	if (!path)
> -		return ERR_PTR(-ENOMEM);
> +	if (!path) {
> +		ret =3D -ENOMEM;
> +		goto bad_inode;
> +	}
>  =20
>   	ret =3D btrfs_read_locked_inode(inode, path);

On error, btrfs_read_locked_inode() has already called iget_failed() at=20
out: tag.

>   	btrfs_free_path(path);
>   	if (ret)
> -		return ERR_PTR(ret);
> +		goto bad_inode;

So we will either underflow or use-after-free the inode.

It looks like only the btrfs_alloc_path() failure is missing the handling.

And the error looks like a regression caused by commit 7c855e16ab72=20
("btrfs: remove conditional path allocation in=20
btrfs_read_locked_inode()"), please add a fixes: tag for it, which is=20
more important than the syzbot tag.

Thanks,
Qu

>  =20
>   	unlock_new_inode(&inode->vfs_inode);
>   	return inode;
> +
> +bad_inode:
> +	iget_failed(&inode->vfs_inode);
> +	return ERR_PTR(ret);
>   }
>  =20
>   static struct btrfs_inode *new_simple_dir(struct inode *dir,


