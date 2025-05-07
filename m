Return-Path: <linux-btrfs+bounces-13813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E57AAEEBB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 00:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDF44C4FA9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BEF283C9E;
	Wed,  7 May 2025 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="D5fwpy+y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5F91DD525
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746657009; cv=none; b=OVUDYQm4rpf6V+w2m8mGnar4CnDydDJED6SFTTzY2picIS16omL3ludtY+C88b9VqiFrRwSbUhgdkGD4Xx0mlco7Oru+QpGjDVrXiR5j2YkgdPzbtOUJx3zUyLlnIeYYvuHBCuO6rFhmqb3Nqvjjmpy3ZgAVaw21E4ehul6pitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746657009; c=relaxed/simple;
	bh=AZt/1gnHf5DtfJycNFNzwj2V00jWlf/PaBTh4TcUzRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BEQbu2344EHHI4gcXiyUWdN7S16ivfrRjkkruGaO3aMrGT1gOjjDbmGDXZ7UfyLIXf7w9so2spZNfwgXnC5oFCYLHLi4j0J2ZnDTT9oZ06sBeYKnb6oG4JOfMlefs2OpJu5Zt+wQHYTGql2npD54rRjmEakim9PaGBHKbIs2B6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=D5fwpy+y; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1746657003; x=1747261803; i=quwenruo.btrfs@gmx.com;
	bh=p2hYfRwAZIsl99umxeg4EpJBD9M6OTx047DDXaF/Cdc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D5fwpy+yIcUUJNMVJxziNiPMNL13tUxn6pc/AKP2d3xCwgM1QDPJ1EcW4ZvvojEx
	 EGJUhDwEZ1bcmqbN4+kvbpCORS/Iadk9uZb60KF3+s7bNuf0LXaK2A4bCFupGliuC
	 xSk4ex2hBAWCBP5Oddz1CmSK+yyGxSkP90NpQaUXtDDjuzdVKCyUtWRAmRZRkumyK
	 +7luCKGfkCbBj1hH7n2OzAbyK9Y823bturG3aZs9A7EtaVGCiyhSY468m2YhMoKv0
	 SURd0FFghUh0nCryKO3/nUmTAJ89+1aV0H3FbJAY+0iHzxpNMzNI7jnWS31u9j4Qh
	 Y0TquvHLYQH/BJSvOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWAOQ-1uVyoT0gWI-00RJRa; Thu, 08
 May 2025 00:30:03 +0200
Message-ID: <68b372dd-2a88-4bd2-9121-89201d01081d@gmx.com>
Date: Thu, 8 May 2025 07:59:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle subpage releasepage properly with xarray
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <d4bd5c3c2f9ce345daa12b059d326d1814cce660.1746640142.git.josef@toxicpanda.com>
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
In-Reply-To: <d4bd5c3c2f9ce345daa12b059d326d1814cce660.1746640142.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:buyhh8p7fyreEaWq9fHFKbu7OxkN6e5Cme9pT18XiH9aUr720MK
 xTe8eVylWQ7TqF5RZYve+RCB5nY0cRnxtzJxarJoXFAtK3dUXHShE+tmAfmjn6o35Tj5mcP
 wUnLp0EjDgnH8mZesfUWJTcodaRKBCa8CHfqy4h41vEBVGnzeeooBQazYiXaSEAnBY+zMuw
 4W1Cno5Qi1Pvm7VXbsawQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1Fk4BB5SBHY=;R4RNdKPcP1TkPsbhl5h9gTK4nHN
 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
 Gh5pZNeZNpwlk=



=E5=9C=A8 2025/5/8 03:19, Josef Bacik =E5=86=99=E9=81=93:
> Qu reported a EB leak with the new xarray stuff.  I messed up and when I
> was converting to the easy xarray helpers I used xa_load() instead of
> xa_find(), so if we failed to find the extent buffer at the given index
> we'd just break. I meant to use the xa_find() logic which would mean
> that it would find the index or later.
>=20
> But instead of hand doing the iteration, rework this function further to
> use the xa_for_each() helper to get all the eb's in the range of the
> folio.  With this we now properly drop all the extent buffers for the
> folio instead of stopping if we fail to find an eb at a given index.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

It's indeed solving all the eb leaks so far.

I'll let the subpage fstests run for longer but I think it's safe now.

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 35 ++++++++++-------------------------
>   1 file changed, 10 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index f56c99eb17dc..b44396846c04 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4246,31 +4246,14 @@ void memmove_extent_buffer(const struct extent_b=
uffer *dst,
>   static int try_release_subpage_extent_buffer(struct folio *folio)
>   {
>   	struct btrfs_fs_info *fs_info =3D folio_to_fs_info(folio);
> -	u64 cur =3D folio_pos(folio);
> -	const u64 end =3D cur + PAGE_SIZE;
> +	struct extent_buffer *eb;
> +	unsigned long start =3D folio_pos(folio) >> fs_info->sectorsize_bits;
> +	unsigned long index =3D start;
> +	unsigned long end =3D index + (PAGE_SIZE >> fs_info->sectorsize_bits) =
- 1;
>   	int ret;
>  =20
> -	while (cur < end) {
> -		unsigned long index =3D cur >> fs_info->sectorsize_bits;
> -		struct extent_buffer *eb =3D NULL;
> -
> -		/*
> -		 * Unlike try_release_extent_buffer() which uses folio private
> -		 * to grab buffer, for subpage case we rely on xarray, thus we
> -		 * need to ensure xarray tree consistency.
> -		 *
> -		 * We also want an atomic snapshot of the xarray tree, thus go
> -		 * with spinlock rather than RCU.
> -		 */
> -		xa_lock_irq(&fs_info->buffer_tree);
> -		eb =3D xa_load(&fs_info->buffer_tree, index);
> -		if (!eb) {
> -			/* No more eb in the page range after or at cur */
> -			xa_unlock_irq(&fs_info->buffer_tree);
> -			break;
> -		}
> -		cur =3D eb->start + eb->len;
> -
> +	xa_lock_irq(&fs_info->buffer_tree);
> +	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
>   		/*
>   		 * The same as try_release_extent_buffer(), to ensure the eb
>   		 * won't disappear out from under us.
> @@ -4278,8 +4261,7 @@ static int try_release_subpage_extent_buffer(struc=
t folio *folio)
>   		spin_lock(&eb->refs_lock);
>   		if (atomic_read(&eb->refs) !=3D 1 || extent_buffer_under_io(eb)) {
>   			spin_unlock(&eb->refs_lock);
> -			xa_unlock_irq(&fs_info->buffer_tree);
> -			break;
> +			continue;
>   		}
>   		xa_unlock_irq(&fs_info->buffer_tree);
>  =20
> @@ -4299,7 +4281,10 @@ static int try_release_subpage_extent_buffer(stru=
ct folio *folio)
>   		 * release_extent_buffer() will release the refs_lock.
>   		 */
>   		release_extent_buffer(eb);
> +		xa_lock_irq(&fs_info->buffer_tree);
>   	}
> +	xa_unlock_irq(&fs_info->buffer_tree);
> +
>   	/*
>   	 * Finally to check if we have cleared folio private, as if we have
>   	 * released all ebs in the page, the folio private should be cleared =
now.


