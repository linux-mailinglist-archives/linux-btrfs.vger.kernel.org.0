Return-Path: <linux-btrfs+bounces-7978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF709773AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 23:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956081C23CCA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 21:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F761C1720;
	Thu, 12 Sep 2024 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kKQysdgF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D42C80
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176983; cv=none; b=KIJCJrntjOJ2JJb3V/pIBaVGSRd3E9sj6bqyk3XmVC1zuc5BV3YgXFoW4vZHqQtz8osJ+bp3v+lRDxsmk+X6Fl9KZ44/XNe4eM+do6uhoIyaYbxY1FDQc5hoTtGJ1sqQg71H8uZSux3mPBtGtsSRbliYpfNYvt7geuOoVlosml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176983; c=relaxed/simple;
	bh=0PZnxb9oDafnshelbF7+IpU0Zzc+QyP040FKauXNp7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TYZv/4wXjS6UEHgf2OotoRcpqtL5c/IPA6JxbuSOQVg4lN/ryqEbW/vIPvdLZzN9b7E26SpnpRWcmrkbZn0ZLcrOd3soplY+ju3Xgzf2CX5AVx3D84EuirBeYuPZLFVfJYiMB7Lv5bRfKK3A+sMZBZ7E4MZ9Fv48KeibuAgnLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kKQysdgF; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726176975; x=1726781775; i=quwenruo.btrfs@gmx.com;
	bh=Yz2DztCBKNAOe+mInWUu+Ja4FgnHXCZvP75Do1lSYbM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kKQysdgFRMkU6JPsZbbDR5vQFZlllKXyqBankZjO9b1Ljc6jhj5zzE7MTR4sEhWI
	 8z7KuVdslOaTMrmOXLGSdBCuzSvjPdtN7r3IUcn6JEza7kK+XFE2D+/u3eJyvHI53
	 Xy7mJaKPTldrmsqkBVFZz+HsKVfOLK6FebhmgL7FG15RwaVgx8pxpGnZeOj0+9BJb
	 yU+qRrZYNfCZfg8YhNX1tyQrJOqDmuCnoG2o1kmpLdgdu3wWeia+OUDp3PC4FHN9l
	 KqcCyl85Q9KmWp/fdvbj69Y6NOGdQGQrcS6a7vgvPSZw+b2kM3Pi8Ys1p/KWfJOmp
	 0iZTZbI52lqW914+pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv2xU-1ry8J42OMS-00qwYC; Thu, 12
 Sep 2024 23:36:15 +0200
Message-ID: <26d6f8ba-6a8f-4519-9945-a50a4a74b502@gmx.com>
Date: Fri, 13 Sep 2024 07:06:12 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: map-logical: fix search miss when extent is
 the first in a leaf
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <dd34707ffd1cd5a458980a209cfcc06a1817b848.1726149878.git.fdmanana@suse.com>
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
In-Reply-To: <dd34707ffd1cd5a458980a209cfcc06a1817b848.1726149878.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v55IHxVjcrCMdJ2dmAIKo37eTQ5K9ATL9KFxx/KACvJ0GFBqn7j
 nfeQszEDeG2J3ZTVMfCA8Tjbr86bY8BzOEZ80WOvA90E2B4g3gde8Xanm7nC7x+tkCN9Hq+
 8NFezjPaosjH8ln/IftY23KLZnXakLectz0+7x9m1Cx8w2T2ZqOAfJII2i+wUCQGIpOEQ/Z
 pMgCNnTclbam60RsAzxYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2XmIJTfZuA8=;sK2hRVF0Io/9/WYmcgC+/a+QNgF
 W5v81H+5NlZH9SNJciqQpGaUtDlOuZ8dZb2lxI7OnD7WFzB478XNteu6qwRQbSgPmTv5rX+NW
 ZqQKji8o+Kv0bKh1Q26IaIVTCN/qXT7KJDSph++yMqFtfpY9nNk9NnJuEeJO8pyjaWXT2P9hA
 uyDmz7KQ9Ym0mBbJhblzYtWmgWLkGrJWMzwg5Nqjfl6WXqWLl5pFtEcdWl9OiGQs2+H6iuskz
 rjIYURROo41We5BMtBzzsRyqWjx2TC/Hy79edra6q7wDXRBUb6+OMHeaPOmR/B7aRzbVwcn7H
 TAUkudzBNoF4gXdCD9gQptpc7pI7zExt3JhMSYsAaskDkdHkkL72UA6LEJhXC1/xT7Hu114O3
 uY2xeSLiZvYeWWumgVAupbXuMSTQqQzuVbx019A0TaBHUuLZSVYQwOKazT6fgCuK8PuRrbuL1
 4nNufWQT7eYv7Bqe3LXnDZ3HNYe3EEoJfGRDuAieOF3as9H22P6QoECR0OJ7eJ/uO2GY/ecuy
 bhLFEhZtUOy313ejb85q3zG445aLXIseY3kpjwI4e1G28jaSv/676qWzjeHPBrEejFqKfRmby
 S3+Mj86U070lloh0iiOBGqL6brsFV+AN1ItKqp0A9zSfLaZcmQbOzMqZBRM89J8Fb1UK4n4c/
 tXsL61UFEh+j3jL8YNFCYMlqQztg9NVOc6bMEV8zUcJFv8mZxW1yXJ5FInNHtNJml3b4SWTrC
 RFckxPj0Ok6IHTPdzvYQvioosUebyXkpBjURCXu/g+Jrit95/WfTeUxyskefmN2eAgk+ZOpUo
 FXgo4aDtu5nRl/LS0sMgtqWg==



=E5=9C=A8 2024/9/12 23:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When searching the extent tree for the target extent item, we can miss i=
t
> if the extent item is the first item in a leaf and if there is a previou=
s
> leaf in the extent tree.
>
> For example, if we call btrfs-map-logical like this:
>
>     $ btrfs-map-logical -l 5382144 /dev/sdc
>
> And we have the following extent tree layout:
>
>     leaf 5386240 items 26 free space 2505 generation 7 owner EXTENT_TREE
>     leaf 5386240 flags 0x1(WRITTEN) backref revision 1
>     (...)
>             item 25 key (5373952 METADATA_ITEM 0) itemoff 3155 itemsize =
33
>                     refs 1 gen 7 flags TREE_BLOCK
>                     tree block skinny level 0
>                     (176 0x5) tree block backref root FS_TREE
>
>     leaf 5480448 items 56 free space 276 generation 7 owner EXTENT_TREE
>     leaf 5480448 flags 0x1(WRITTEN) backref revision 1
>     (...)
>             item 0 key (5382144 METADATA_ITEM 0) itemoff 3962 itemsize 3=
3
>                     refs 1 gen 7 flags TREE_BLOCK
>                     tree block skinny level 0
>                     (176 0x7) tree block backref root CSUM_TREE
>     (...)
>
> Then the following happens:
>
> 1) We enter map_one_extent() with search_forward =3D=3D 0 and
>     *logical_ret =3D=3D 5382144;
>
> 2) We search for the key (5382144 0 0) which leaves us with a path
>     pointing to leaf 5386240 at slot 26 - one slot beyond the last item;
>
> 3) We then call:
>
>       btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0])
>
>     Which is not valid since there's no item at that slot, but since the
>     area of the leaf where an item at that slot should be is zeroed out,
>     we end up getting a key of (0 0 0);
>
> 4) We then enter the "if" statement bellow, since key.type is 0, and cal=
l
>     btrfs_previous_extent_item(), which leaves at slot 25 of leaf 538624=
0,
>     point to the extent item of the extent 5373952.
>
>     The requested extent, 5382144, is the first item of the next leaf
>     (5480448), but we totally miss it;
>
> 5) We return to the caller, the main() function, with 'cur_logical'
>     pointing to the metadata extent at 5373952, and not to the requested
>     one at 5382144.
>
>     In the last while loop of main() we have 'cur_logical' =3D=3D 537395=
2,
>     which makes the loop have no iterations and therefore the local
>     variable 'found' remans with a value of 0, and then the program fail=
s
>     like this:
>
>     $ btrfs-map-logical -l 5382144 /dev/sdc
>     ERROR: no extent found at range [5382144,5386240)
>
> Fix this by never accessing beyond the last slot of a leaf. If we ever e=
nd
> up at a slot beyond the last item in a leaf, just call btrfs_next_leaf()
> and process the first item in the returned path.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   btrfs-map-logical.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
> index 2984e645..a97afea4 100644
> --- a/btrfs-map-logical.c
> +++ b/btrfs-map-logical.c
> @@ -74,6 +74,11 @@ static int map_one_extent(struct btrfs_fs_info *fs_in=
fo,
>   	BUG_ON(ret =3D=3D 0);
>   	ret =3D 0;
>
> +	if (path->slots[0] >=3D btrfs_header_nritems(path->nodes[0])) {
> +		ret =3D btrfs_next_leaf(extent_root, path);
> +		if (ret)
> +			goto out;
> +	}
>   again:
>   	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>   	if ((search_forward && key.objectid < logical) ||

