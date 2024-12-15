Return-Path: <linux-btrfs+bounces-10390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B289F268E
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 23:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F31C164727
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872DB1BC08B;
	Sun, 15 Dec 2024 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TXWV6cWk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF68A41
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734301407; cv=none; b=eanQpAuNRVcK/AAk1+FpI3WvhkX1GrkZiFPSy357bbRnOLBQCiiXw//i43gSUiOsWpcz/5tOH6gNp50f3qna20yOmGkYNBC5+pjtF5D2Y0DDPLfEkvOemchLYMYgY2o02a+3WO3lZF3bEECDhePlCzAp5kOCozHxAj7wMrO1/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734301407; c=relaxed/simple;
	bh=YT/DgKcVOxG2CrKFhS3LBQZN5n/lOlnq2RRSQrSq3eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDZvQ6QQk5BQ0WsERR/WzgMaofCQlfR4RA6ABTr49U6h9z+SiJ6l1AluDgUUQ3QeDBeanSaFvutBer/6R+D88nyexTnkRy4rFxNwN2idKDBqE0lqhlj+u2rhLlrPAzp+0J4MWESAR1cSM6HAi7SwFfZuldoQE79cp3ScNcF1Jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TXWV6cWk; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734301401; x=1734906201; i=quwenruo.btrfs@gmx.com;
	bh=giMhDv5Tnre6u0Qma6RpUlOkLEXL9wRJ14KIW1U8pi0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TXWV6cWk0dk9nlfQ4tM3HiWXh014Kl6l39kgnA4rKLU8TVu2taaGf3fgjgbA9o4Q
	 YstnuFD2/F1i5Opfv9DcXJ9IsFkePvjLiLGsI1OctIM/i7FlUQB2eNob1z7QQRzGA
	 avUwCla8NUezijEHgu4cehJZX8PYu3joZJ3HHkjBPpfS2LQtNuG/yAlxobaNj9ptT
	 JVfJx2bttzEEA7YMhUHbg62csGejV53Zf842Ym3m7nOzAjUV94MJ1TmRseR+sdue3
	 ie9dEpzHVUiXwdJj/0G6S2bh94kzi8LixO7B2/tI3GyUGsyBhHXJx5RffFgMt4xGa
	 PpElsBqQUuclnNbTbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33Ib-1tjslJ30Or-00rN7f; Sun, 15
 Dec 2024 23:23:21 +0100
Message-ID: <9e98c788-ecbd-4a9e-9d19-3adbcb439b20@gmx.com>
Date: Mon, 16 Dec 2024 08:53:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] btrfs: update btrfs_add_block_group_cache() to use
 rb helper
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
 linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
References: <cover.1734108739.git.beckerlee3@gmail.com>
 <e5a958037e7f03b124b66f392d20343482b65e61.1734108739.git.beckerlee3@gmail.com>
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
In-Reply-To: <e5a958037e7f03b124b66f392d20343482b65e61.1734108739.git.beckerlee3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8q6/buPEhsN2CSU4myOgCQ5jw7rnGllDVYRdGLzv1mBVUlDXA7E
 7TN6sWDCpW4ETKPCzCK0YoWGqrRp3Q/VZOU0HptbG3KzNBBjI4Q97KQgIflLnTmP9Pgf91P
 R64a4H/isDWO23Br7hx/sFmIMS5lEoallDaFc4ah3LWVHRjDAMVS5NiH3YUg36dPEztdWv4
 RbWJjM++aB48olh6v+9KA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B77BLYdVCdw=;T0IOZwtgeSyDgSwVFdTPEojfVoq
 pBJvyqX34+crymYABqSIGcWx9RstNhyknqB3NKZ/WtkzC3qRjJCIFdvSIR5v7JNKRvipmYIht
 Nhk/eE/2s+oBegfmKIRAbABK0TNBQHbp1GbvIFVFUMymh0oh6fllCvZyvGxWIl1+GtA6YHMRZ
 0gwrBEP9myrFCmdIAbXfT0OoARgNj6vE/oEzHIvchdddr2NWcTGun8/K2mPBptY3Ya3otc5a2
 +pnxcpI9EUkDwT6lFp07+N06MfzTYa7i+Rz6wiTCcobwNqUSFBE6eKsncUZII2JoDAAZiFBmC
 YBpU7yklItpY7U6IhkYRcr6fLj1qjsWP3DvbKLivYyV93hsGP2eqMlcbtgFl4/RC0jsfNJVSE
 4FKiFAC+rYcsX2XcylrUac1v6kghxGis57r1jYptfmPsNqimuT8ecO+7mpUqgNff06IlY2hhv
 6Nv2X8zARiO/UIP2RMFNyvNEKUivoj00SMOzhoxtScURdtZSPFMc8tXlE2o0xKRkEyP8EyNWv
 +M+IPW5TrJjL+pACM6FPYDCkVFCT/u4kqW4RJImVWk7D7upUDIZpnKTxgM314THWtzPPz/1Pv
 ayjJqmwDhunbTEJLg+bKToTe5TEBFbRbc0EYD7wseyyBU46fwbMNQQxKN2oi4Y24A5owIaKwh
 +OSpwoOOagMXIQ0V5mOX+4gbUsmo2iI2EqSm1BDcuYRzUiAe0aeZdbWxnotNIrIN1dP+TQKZL
 IA3T+9hgnrtt6/Hoc1hMVtNxY3obSmxtokS2A2QcgKfV4UqOYEtMXfkO96Px5S31sXDDCfnDv
 PeT9v2ZomjyOYfHkhuzjKnJ/g40mBqqzjaBdALtWkyiAgsfhQ0pjkCJT38bmzbIr6Hmix94Dz
 RVsY7ww2rlc1AZxcMAgZ3zVPYmQHyndPPtk1av6/2I1WtV7Sn8fPdUcolLNDdiM9JZe4wh7Rb
 y++WC20d1qEir2vp1ABsgp24yQCP6txieBcXJiPbT2180t5n0DHKh/C3MI1yNHC91zighToot
 wCYkIA26SfAvE4qxv3bKxwUn9J0VysH1QcDH/QvHCzqxPiGqCp6TfyMaT1jFIDfmV1ccjlOUm
 Lkvhd+iCfFb4d+dzYH4UEPsXxXgW2+



=E5=9C=A8 2024/12/16 01:56, Roger L. Beckermeyer III =E5=86=99=E9=81=93:
> update fs/btrfs/block-group.c to use rb_find_add_cached(),
> also implements btrfs_bg_start_cmp() for use with
> rb_find_add_cached().
>
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> ---
>   fs/btrfs/block-group.c | 41 ++++++++++++++++++-----------------------
>   1 file changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5be029734cfa..a8d51023f7a4 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -173,40 +173,35 @@ void btrfs_put_block_group(struct btrfs_block_grou=
p *cache)
>   	}
>   }
>
> +static int btrfs_bg_start_cmp(struct rb_node *new, const struct rb_node=
 *exist)
> +{
> +	struct btrfs_block_group *cmp1 =3D rb_entry(new, struct btrfs_block_gr=
oup, cache_node);
> +	const struct btrfs_block_group *cmp2 =3D rb_entry(exist, struct btrfs_=
block_group, cache_node);
> +
> +	if (cmp1->start < cmp2->start)
> +		return -1;
> +	if (cmp1->start > cmp2->start)
> +		return 1;
> +	return 0;
> +}
> +
>   /*
>    * This adds the block group to the fs_info rb tree for the block grou=
p cache
>    */
>   static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
>   				       struct btrfs_block_group *block_group)
>   {
> -	struct rb_node **p;
> -	struct rb_node *parent =3D NULL;
> -	struct btrfs_block_group *cache;
> -	bool leftmost =3D true;
> +	struct rb_node *exist;
>
>   	ASSERT(block_group->length !=3D 0);
>
>   	write_lock(&info->block_group_cache_lock);
> -	p =3D &info->block_group_cache_tree.rb_root.rb_node;
> -
> -	while (*p) {
> -		parent =3D *p;
> -		cache =3D rb_entry(parent, struct btrfs_block_group, cache_node);
> -		if (block_group->start < cache->start) {
> -			p =3D &(*p)->rb_left;
> -		} else if (block_group->start > cache->start) {
> -			p =3D &(*p)->rb_right;
> -			leftmost =3D false;
> -		} else {
> -			write_unlock(&info->block_group_cache_lock);
> -			return -EEXIST;
> -		}
> -	}
> -
> -	rb_link_node(&block_group->cache_node, parent, p);
> -	rb_insert_color_cached(&block_group->cache_node,
> -			       &info->block_group_cache_tree, leftmost);
>
> +	exist =3D rb_find_add_cached(&block_group->cache_node,
> +			&info->block_group_cache_tree, btrfs_bg_start_cmp);
> +	if (exist)
> +		write_unlock(&info->block_group_cache_lock);
> +		return -EEXIST;

IIRC latest GCC would already warn about such indent.
This will cause the function to always return -EEXIST.

Thanks,
Qu

>   	write_unlock(&info->block_group_cache_lock);
>
>   	return 0;


