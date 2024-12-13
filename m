Return-Path: <linux-btrfs+bounces-10337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0A89F055E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 08:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFF018855A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED4E18E351;
	Fri, 13 Dec 2024 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="udFYjn8M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC11372
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074365; cv=none; b=NG87RaaMfc6yFCKi3ob5qd8TVsMFBoiiWKX/Dlr/SvkAsyxSj2fxWM+lzPEX6oKJTdVCpXsfWX8WXBoNsA/kHf+MDwZy0BejzjTWoEr3o/PdH2H2F6jLgaOUKhtUtEMwyiK12uewf2huArrDjL66ZkLSteGnsV5My6j/GPX4aFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074365; c=relaxed/simple;
	bh=qzLDJO5Ns3krDBSEfgEIPIQggVrymy/d0rMXwKGg5J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7GV8sQIXac3ueNuhyEg/nKTDeE1YpAIxD5l6IPIEaPuVYs1aSiE6VclFKbAC9mHLeXvOm1uV7y7610/nLBTRdsXU4Q2REwrh5r2z71Rk3/5CiruQhE147Pcgs06mseXuNN9eLupomvpBrczja7Qr95+AEQJYA31PPGyYafedQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=udFYjn8M; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734074360; x=1734679160; i=quwenruo.btrfs@gmx.com;
	bh=O4CCgRMbUZvfz61T79VSLdSiujHR/l4qNWBmKVmONRU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=udFYjn8MSVoUe6qwsCWm9nSnIrRc2LQY8xjMZJ3k3w3uj4XRxik4Ok1ArN7XQEN7
	 FmPvS8dL+N5e24taXxAIGShUm71NpRD4rG2x/tAbVrjdoPKsVAB8g/F8li2WS2Ho4
	 fqo+tNDdOZN8DNhlBGqs9AsBQ/r6LVu6GiLqsEENRdxgUVlObq2rqd5qUF5tYQGPH
	 2MiEG9Xmj1+IVW2I7XmYtxQjgGuXX4JSOCdB5ePHRJ+b/78lvttXI8KfOn5buVCdq
	 +Y9jBgz2tRkafU4v24Mu3y08gY+25NYI9I7R6TnKTTdmqtlbQ+Byy5IxE8LYkYJch
	 9a/iPzsRFVqNInh1ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzuB-1tt7Jg1JDb-00cASS; Fri, 13
 Dec 2024 08:19:19 +0100
Message-ID: <4ffe4e81-0fd0-475a-9ad5-2b20269349b1@gmx.com>
Date: Fri, 13 Dec 2024 17:49:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] btrfs: update btrfs_add_block_group_cache() to use rb
 helpers
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <cover.1734033142.git.beckerlee3@gmail.com>
 <e2bd469a65fc93477240ebe9dd53b2ae7d591f46.1734033142.git.beckerlee3@gmail.com>
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
In-Reply-To: <e2bd469a65fc93477240ebe9dd53b2ae7d591f46.1734033142.git.beckerlee3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8jlU0zBlWXHQYxB9K79Jh3QWMjWjXWkXDyhQYq/qTD5W1s9hMNn
 AlyD0czQx+NcVcD7vBsFO2AtjY1O6ePJwv7O1ZnLTKIAAElyV3iOWbriFQsK4+bVdJqRJfm
 lLpfoI/bHqVCFvt8YRWPcvySQxS3O6RaHiamKtC38z5nw11Bsl1UrG00LGEjGUKPr/L95hX
 CZfHirLtmX8Siiccbu3yQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7uZOOQSGKmc=;1HrXATTip98G4iaA70DrI/Qbrs+
 ZQYRXk9kpPpXEgMtIM/vEcs7yFACVosRUIvmLhAPy94+DalimuUOGWBxZhvXZHnECOCK1+wCW
 wkJf+3wcl7u9cVo6VZjHWZd0hgd5GbCiVGTuJdNj62LaNZy5JB42Uo/ZwBrKzi0n/fS/IJKJH
 QYIDN+7K7YNJfKEGIyTf0ueZ9yN7EGdvQzAX+vBmdAnRWh1E9l4ylq4YI5IaxoppeDAiOooYl
 Dw/P+DI+77Y0FfN1GStdUVr6CNHdmEWC38kgmiTBEvN/7z2hu+NLlFgEFhW/Ork666R8HpnAd
 i5TdbZkuKgE9RlSEl4lJpVpv3xtvX6hBnlJwWZ5vKQbfvfF3Vq9FO1up/acRGWpFXO/Cg+KN8
 rWexxJO/D4pW+70YzcDbDEfaKv0adi6HLh2Cxz5FaMs2rVlwj6IQBNZ+XDWOi55nfSg2t9E+v
 wPcYM91IkmD1lvmHARrjsTCpJWln45YMB14ZGKQc0yq2HQak14zVQvSXqibcibbk8EJhzmWFU
 Gflg2KNcBTL46dMPpRfTqSB/Z2Er5jlYYyQ44yqz1g0Cvt/IXri6OpuzHdR1kZ5qRZ75H7QJ6
 xcJwUVfc3DwIN5/NbtF4bMZ6+OVsp3422k0EAvV7cKYWezPZuxWAUzqhXNSwhsWVt5bn4fRcU
 vKvW9p2b0yl6OIGHxftvXUIhqfnAWojSQf98n9hTh4MJB2D9m4WTWp5pdffj22LbdhQCPCXdI
 HAAFHRr+wAJ7NMlVS49XTWeQcBAS0GBku20+7oslrbiWgcRtc+n+zpNucDc/7gx8p2WmEvehC
 Q808LZx1mGDTUWY0a2t5oP+prDN/F/X2+63xW7DuEGqv6LGRU7hl038bJ5NVweeFPJcfFmGEf
 ph9/XKHxKft90JqJRgPVxj/KxK1nyKvNYil0AOU36aipDDROpk/q3lNvuQBfaxOhvI7ENPuSJ
 0FKzNSvmRy74oQlVuwKkPiJR3n5TBEm1Xh2qAoEmnPUNNdj7fuv132tOgmEbKgLbFlDq5ro5f
 tPL8bzf/rAGOw5X0FzzcT0TbCK65DXEySwcBC+eCGymQjymd7lYuIeYlU//pw2iiEpDIOl1sg
 F3odyzFSfjgzsCjcrRbwvOmKC2wADy



=E5=9C=A8 2024/12/13 06:59, Roger L. Beckermeyer III =E5=86=99=E9=81=93:
> update fs/btrfs/block-group.c to use rb_find_add_cached()
> implement btrfs_bg_start_cmp() for use with rb_find_add_cached().
>
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> ---
>   fs/btrfs/block-group.c | 40 +++++++++++++++++-----------------------
>   1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5be029734cfa..6001b78e9ea9 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -173,40 +173,34 @@ void btrfs_put_block_group(struct btrfs_block_grou=
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
> +	if (exist !=3D NULL)
> +		return -EEXIST;

If we hit -EEXIST, the block_group_cache_lock is never unlocked.

>   	write_unlock(&info->block_group_cache_lock);
>
>   	return 0;


