Return-Path: <linux-btrfs+bounces-20373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B199AD0E0FD
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 05:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84BD830060F6
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 04:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C221ADA7;
	Sun, 11 Jan 2026 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aG7rIu8R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6143ABC
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104707; cv=none; b=VSBZe9lLkugoTIm49Gc/Ct+h7H6sRIqpFX6xLN81NZ2WLeOJwqtkiASr1j+QIA8ziyZqCtJeCCxwbY0cbiMdkVbwm8E0L80SXDe1Nf1iE6JdCOjPvmk4jv55PvCBvoihSMd8QmRANCotS5q6DH4f1n35j2Uq2nMhmGDXNNITVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104707; c=relaxed/simple;
	bh=CZ4WNrRL6p8ieR+lhHDshqqdjAxNLWRVeGmFnd32xSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b6eiBv7I+AT5pEUDjdVfdM4BmfPb+NkH574ATopFpB8k27mpnK2/q5qogFArJhJmEuBwSQ2AYdjFk3D4N1+2KVaAbTn52Aifkc7ZYVoT4+IRVXqNnzrbcxqIZ2TvzSZLYvCRCaWbDxr7KxdocpYAekVfQ/7RJJVKre4X3c2jgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aG7rIu8R; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768104703; x=1768709503; i=quwenruo.btrfs@gmx.com;
	bh=ses5xUs1ufPHcnUjUCgq8c+rc7NoSi93pln7TafAusE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aG7rIu8RqFau1+peQ6/jxlO8lPTOsEZA01vRLlihBh49wvJE70SWyE72gJLRItbv
	 6Q44bYVHVD68Hu6nQR5FDy6muD+knxqhyCy8xNA0D9v8oKNenE+G6XKfZLZMA+MTd
	 TaAem2BL4DE1wtJEsV2Jwg89MWye4Gv72765VTmmeYl6gCREF2+ZfecSpaWHEZJ6n
	 J0XBJrtCTeT/YszZeJdvOUSR+vgUSOyT9GYlYqaLZ7oRSvm7o1KHJQfwrEMlnFCdu
	 16p0t65bv20VcUFy4wUZd6MlP9c9/G46WoHaooR5YvykAVlKVyjiTuwrSqh42q2As
	 W6lxMT26v0R0ykt98g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXyJ-1vLKE53L15-00V84p; Sun, 11
 Jan 2026 05:11:43 +0100
Message-ID: <4d1e06e9-0bc6-4dbd-baa7-b4f1176d9d45@gmx.com>
Date: Sun, 11 Jan 2026 14:41:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: invalidate pages instead of truncate after
 reflinking
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1767960735.git.fdmanana@suse.com>
 <91292893f805261c8bd972d039785b74bbb3abee.1767960735.git.fdmanana@suse.com>
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
In-Reply-To: <91292893f805261c8bd972d039785b74bbb3abee.1767960735.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gyn4aIBZLD4C69HLwC8dwjWLe9KkUdZoRkj+KmLa1D+3giWcIVt
 0fx9iTrmkJz8P5dGjqEajjzwL+AHu6GUhoiMpPzR6oFRN5mWNqFuWW0bhbkIk00SCz+LTZf
 NKidBpMyhN0EoYH8I7ldP6B2KkNwXO3gHfdq47iYqifKB/Qg6X2sgSXTmWYv2r85gl0Eo4Y
 cDtt2Cp+Mi8M7jIFzkVvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CEx+zuQsCy8=;nOfUa1tX5i1FX32KAl95vF6uEFS
 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
 P1LC1nTs=



=E5=9C=A8 2026/1/9 22:59, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Qu reported that generic/164 often fails because the read operations get
> zeroes when it expects to either get all bytes with a value of 0x61 or
> 0x62. The issue stems from truncating the pages from the page cache
> instead of invalidating, as truncating can zero page contents. This
> zeroing is not just in case the range is not page sized (as it's comment=
ed
> in truncate_inode_pages_range()) but also in case we are using large
> folios, they need to be split and the splitting fails. Stealing Qu's
> comment in the thread linked below:
>=20
>    "We can have the following case:
>=20
> 	0          4K         8K         12K          16K
>          |          |          |          |            |
>          |<---- Extent A ----->|<----- Extent B ------>|
>=20
>     The page size is still 4K, but the folio we got is 16K.
>=20
>     Then if we remap the range for [8K, 16K), then
>     truncate_inode_pages_range() will get the large folio 0 sized 16K,
>     then call truncate_inode_partial_folio().
>=20
>     Which later calls folio_zero_range() for the [8K, 16K) range first,
>     then tries to split the folio into smaller ones to properly drop the=
m
>     from the cache.
>=20
>     But if splitting failed (e.g. racing with other operations holding t=
he
>     filemap lock), the partially zeroed large folio will be kept, result=
ing
>     the range [8K, 16K) being zeroed meanwhile the folio is still a 16K
>     sized large one."
>=20
> So instead of truncating, invalidate the page cache range with a call to
> filemap_invalidate_inode(), which besides not doing any zeroing also
> ensures that while it's invalidating folios, no new folios are added.

Although I still believe the fix is correct and is the best we can do=20
now, the root cause is that our btrfs_invalidate_folio() callback is not=
=20
supporting partial invalidating.

In the above example case, truncate_inode_partial_folio() will call=20
folio_invalidate() for us to drop the [8K, 16K) range. But unfortunately=
=20
our btrfs callback only supports full folio drop, thus nothing will be=20
done, and left the uptodate bitmap untouched for range [8K, 16K).

So the long-term solution will be to enhance btrfs_invalidate_folio()=20
call back to properly clear the uptodate block bitmap for sub-folio=20
invalidation, so that we can still keep the range [0, 8K) uptodate and=20
skip the read from disk, then go back to use the=20
truncate_inode_pages_range() function.

Thanks,
Qu

>=20
> This helps ensure that buffered reads that happen while a reflink
> operation is in progress always get either the whole old data (the one
> before the reflink) or the whole new data, which is what generic/164
> expects.
>=20
> Link: https://lore.kernel.org/linux-btrfs/7fb9b44f-9680-4c22-a47f-6648cb=
109ddf@suse.com/
> Reported-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/reflink.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index e746980567da..ab4ce56d69ee 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -705,7 +705,6 @@ static noinline int btrfs_clone_files(struct file *f=
ile, struct file *file_src,
>   	struct inode *src =3D file_inode(file_src);
>   	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>   	int ret;
> -	int wb_ret;
>   	u64 len =3D olen;
>   	u64 bs =3D fs_info->sectorsize;
>   	u64 end;
> @@ -750,25 +749,29 @@ static noinline int btrfs_clone_files(struct file =
*file, struct file *file_src,
>   	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_sta=
te);
>   	ret =3D btrfs_clone(src, inode, off, olen, len, destoff, 0);
>   	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_s=
tate);
> +	if (ret < 0)
> +		return ret;
>  =20
>   	/*
>   	 * We may have copied an inline extent into a page of the destination
> -	 * range, so wait for writeback to complete before truncating pages
> +	 * range, so wait for writeback to complete before invalidating pages
>   	 * from the page cache. This is a rare case.
>   	 */
> -	wb_ret =3D btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
> -	ret =3D ret ? ret : wb_ret;
> +	ret =3D btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
> +	if (ret < 0)
> +		return ret;
> +
>   	/*
> -	 * Truncate page cache pages so that future reads will see the cloned
> -	 * data immediately and not the previous data.
> +	 * Invalidate page cache so that future reads will see the cloned data
> +	 * immediately and not the previous data.
>   	 */
> -	truncate_inode_pages_range(&inode->i_data,
> -				round_down(destoff, PAGE_SIZE),
> -				round_up(destoff + len, PAGE_SIZE) - 1);
> +	ret =3D filemap_invalidate_inode(inode, false, destoff, end);
> +	if (ret < 0)
> +		return ret;
>  =20
>   	btrfs_btree_balance_dirty(fs_info);
>  =20
> -	return ret;
> +	return 0;
>   }
>  =20
>   static int btrfs_remap_file_range_prep(struct file *file_in, loff_t po=
s_in,


