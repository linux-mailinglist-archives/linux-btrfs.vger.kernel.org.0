Return-Path: <linux-btrfs+bounces-7608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7A962355
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 11:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A787BB21E27
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACB9161328;
	Wed, 28 Aug 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pUQ/hHFD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E64962E;
	Wed, 28 Aug 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837090; cv=none; b=fkz0Yq5+jEpZ7P73OKKPKW/l1zgFonikjaKcDriJWr6BaMtxOG0FD3F0qmfQEJ0K1W/iVSJaW43vp+zrn/vZddPwMs24TBDMv0hv5wQlDPMGbTw3z6YJgWmOa7FgLirdXaKZ43GtXdDhExxdLN8D47VBvlKNnnguvSUCa5Mc+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837090; c=relaxed/simple;
	bh=zEEvvmMHHethjhx/UbDufFu0zlfdsiKGmPQhRHLmT38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0LjavbTPYWD64JjSO4S8NTdDLQ4Um2Brouvipj37J5f5OlGP9GURV5w137QCqCSNvKTwQSlz/0Bv3k0SsPq+f0z/zSceTzkMyroAZ2kXviFtypFm1YFENSiUQMFIp0JjRCpQGfKFza27XOj5/0pdYCES793I0ksXEs5Me6r/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pUQ/hHFD; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724837078; x=1725441878; i=quwenruo.btrfs@gmx.com;
	bh=ciRy81xM+CrYH1HKx6y9mLzVn5NoLKfbXyQHxh8FBKA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pUQ/hHFD9SKCE9LXP3wrAHob9lGi8FX7jZmYrDK1CsiSAtOytwwZ6VsqwJq9pb/V
	 GLTkhrfI8mtpjtVfcCz8+175lfCXbfoLb/6nHxRRdzxnUkI6YZ0H/vWBe9ZTweZZH
	 WIHURJ8EaJxCSqsOXK2A3YGjnxTnxNC7CUN7aDT0HGPb4M8FglD4VAo18MkMNBKbT
	 LyfllxvbOpEz/ZiJUEQz8LbnjsVeDYQFaZSWNycQOhC8fD3wh/Jiouj7p+iPDYJQQ
	 dyOAlimc0Pv3lJvWHmlaDi4s4KaIxNUCgaEiFZ6Lnr6VWacWdAW8a+oA2dXXfMMJJ
	 Y6RMCPk4JB4B1j2HRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wyy-1smYIT1Nyu-002VHz; Wed, 28
 Aug 2024 11:24:37 +0200
Message-ID: <230ede6f-1cbb-4b25-ab1a-a54f7d29c92d@gmx.com>
Date: Wed, 28 Aug 2024 18:54:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: add missing extent changeset release
To: Fedor Pchelkin <pchelkin@ispras.ru>, David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20240827151243.63493-1-pchelkin@ispras.ru>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240827151243.63493-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Re6W4ZiR3Zs0weRH5Vo0bjZ3SIWiHLvuqEQ77bWAHOi1RxDcCEk
 iW4WBYds7n5dXnbhDc8x4MB3/NZoC59XNn6hRlusT90NeqO1dOB9DmOkjx0rop++Nvehqak
 HpmmrI2s3dTL1HAhGFd+MBeMaFE7dW5R4n768GqslZEhNKKzUJDoICAWLCnjxrxMYFr1WzL
 amW5pQ5MLh4CWDW7HV5Kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qXi6ftpcN5s=;jymtqZIZSVWyFqX1gOvm3gHOfee
 57h348Xq9JYC2J0jZhvecxROquZAPXEMEzPWffoXtp7qCOf//C3QBRBiJoZZ8xiTBVbDmG6r8
 uk640YZHEmWvex1Moe+m8WANY+sRCTRS1w8XHEqKcqYkZwb3NkkCCXEXU9KNnl8te+vbXRH4v
 GR6teIsOydmoxEUl4IbClkYwAmMINmk7ykLbxZLefbZjWz8CaLyPnbkKCYiIlvXVt8/qKk2lY
 pO0PS2eBqCGeCWSIh7QnAmiwYvGkCs/doUyA7iqQHcJGA8hx2nXXeKHLCv17qPQ2yWuVlK9Tw
 +eCWtNm2ulSh172bk55UAPycEtDVUs8SxHrJQ+cJv9Yqff4DmifDTU4ecVdf+xfMDXKmjFSj+
 ayVwacbzZ+TqjAqZA41VR0MFMwlR0n2LL5+vGx78eCXt+vaYNPLtq5a6StTgsRbBFQ4aHeJqc
 bMkh9EG6F/GrMELMxLWdnWTQfT4axsOjq6QJzDyK/4zMHLWD4fSmjryJ6N+i06PYx9wyO/f0J
 REwqo7R21d3Vyh2nyZtsLw0O0xt7/9gt3x0yufq9INe+3qUevIBSgtAxNYKfsGFXuE/O8Rsdq
 X2UiAEHeezo7snJ7xoX3J8XXQscA0X8aFCVdP6W/DZ/YCn0DzkP51ZxFOM5iB0O8Tivalblur
 VrLOVLRvTrJAfpsbh+fUBbvq9liCNqwJ228YlH8NnPEfHiO4b2C/OLCpbzUdgGiVd0j8E3+nB
 2oITUVtJHGL5YYrq9Jbcz+tYkYs+U5oRQxDeKAGomG2QrxboFbCeQzcYZaMqx+XbsWX0vISwK
 xUqhlMdu09kQCP0/VKEM5LdvgVSrxJKSKrj3cozCGnaiY=



=E5=9C=A8 2024/8/28 00:42, Fedor Pchelkin =E5=86=99=E9=81=93:
> The extent changeset may have some additional memory dynamically allocat=
ed
> for ulist in result of clear_record_extent_bits() execution.
>
> Release it after the local changeset is no longer needed in
> BTRFS_QGROUP_MODE_DISABLED case.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Reported-by: syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000aa8c0c060ade165e@google=
.com
> Fixes: af0e2aab3b70 ("btrfs: qgroup: flush reservations during quota dis=
able")
> Cc: stable@vger.kernel.org # 6.10+
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Reviewed-by: Qu Wenruo <wqu@suse.com>

In this particular case, the changeset is really only locally utilized,
thus should always be released.

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 5d57a285d59b..4f1fa5d427e1 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4345,9 +4345,10 @@ static int __btrfs_qgroup_release_data(struct btr=
fs_inode *inode,
>
>   	if (btrfs_qgroup_mode(inode->root->fs_info) =3D=3D BTRFS_QGROUP_MODE_=
DISABLED) {
>   		extent_changeset_init(&changeset);
> -		return clear_record_extent_bits(&inode->io_tree, start,
> -						start + len - 1,
> -						EXTENT_QGROUP_RESERVED, &changeset);
> +		ret =3D clear_record_extent_bits(&inode->io_tree, start,
> +					       start + len - 1,
> +					       EXTENT_QGROUP_RESERVED, &changeset);
> +		goto out;
>   	}
>
>   	/* In release case, we shouldn't have @reserved */

