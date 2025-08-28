Return-Path: <linux-btrfs+bounces-16509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A4B3AD81
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 00:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF0F1C21399
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 22:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6A26D4ED;
	Thu, 28 Aug 2025 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lwmBo1pf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150281C84A0
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419999; cv=none; b=Zw1HPUY5I10U2fGRs+DwyhF76TvzZrqSY7t0ebkT0z8XH1uU52H02YTXQBGgS7i33uoibFsKbbZZ4ELIUKfTST14p5GPkesYHIEPioshZz5n+ECg+VyxWQ6QFjSwWmEiFly8CB6h/3JtBlRcwTFXdCkJQvA/CtF/ZZQR08Kzcao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419999; c=relaxed/simple;
	bh=p4k+ul61FW5zf6PgVVEIF/a2SXNpMqCA5oV8OlPOs8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FoExf3UoaG2TSGcfSGqAl6+j0OT1/MvLxRXWq+ZmcyAOt6c0uG8BsOrcdkMDVeBz7Cz0H+cdr3Sp4ynWuN4HCiEirx5g+lxk7dxwmilThdJ4XWkKXIGJB6h21r4F3lm7ZMcE0e4S2/W5hxwyL4/Z17w3cdeRHTLZ5e5exKd43o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lwmBo1pf; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756419994; x=1757024794; i=quwenruo.btrfs@gmx.com;
	bh=8OUX+MS0u83kYr24Cz6lGLmhy8xi+3UX5KwuTcSQ9y8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lwmBo1pfGPpMXVYjAuwmYdFbME2TVn0BAms/sPgz3/mUAV4tdHqOELel7XKPaL4A
	 SxUJ/8/9t4w2aobYuSkbDvshBFR4sx8s8xMmfcDpLjir8fCBj2Xgh+J8nkcem8RQC
	 YI19GAhcfSzezx8KYIq7MM4VTbiRB3GdWpUto7d9FXcb9lvYtGsx5xPXUjQNweTwS
	 JDTTpXdBEELATRtRhbrk4IV9ekgNv81h0gDy3JwXZciFJywtWRGdb61yScvxazpEN
	 Msp0OTlaHSQMh1pUr+L4VPFcpkdlvuXog6ZkKccmlhV8Tg4MDWiA/EUOSljcQPUow
	 YJNFXjvmyPfqfTgPlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlGq-1uE0PB2b0C-00pHuC; Fri, 29
 Aug 2025 00:26:34 +0200
Message-ID: <e776e393-896c-4d96-89bb-dd8b18042caa@gmx.com>
Date: Fri, 29 Aug 2025 07:56:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: add 16K and 64K slabs for extent buffers
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1756417687.git.dsterba@suse.com>
 <8c448bf2fcf0c2e7b52c05234d420b78cfe4b1d7.1756417687.git.dsterba@suse.com>
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
In-Reply-To: <8c448bf2fcf0c2e7b52c05234d420b78cfe4b1d7.1756417687.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y8L1YuqxStOuXn+i4hQPgP7uZrnUmChnJxbuVouFyB6QHgOOO1A
 Oe8XvWgmLIJd/zoOJhPA24QD28gzNVaZmM8iCaSXLIt11sRNxf1HYN+6Dc0ALAfruMA5cHv
 m101TYY/RVo8eGCWgySqxu6HUiZrrG2Owgr3qWEm3X6WxAS1a27OhFudnvV6+FQ7aRzKKgK
 R9s9OzYZkc1MydCYeULeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eoAoCmR9Cmg=;YeOh7hrUnvFHM+1HqovIxfvP+o1
 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



=E5=9C=A8 2025/8/29 07:23, David Sterba =E5=86=99=E9=81=93:
> This is preparatory work to use cache folio address in the extent buffer
> to avoid reading folio_address() all the time (this is hidden in the
> accessors).
>=20
> However this is not as straightforward as just adding the array, the
> extent buffers are of variable size depending on the node size and
> adding 16*8=3D128 bytes would bloat the whole structure too much.
>=20
> We already waste 3/4 of the folios array on x86_64 and default node size
> 16K so we need to make the arrays variable size. This is allowed only
> for one such array and it must be at the end of the structure. And we
> need two.
>=20
> With one indirection this is possible. For N folios in a node the
> variable sized array will be 2N:

I'm OK with the variable folio pointer array, but why faddrs?

It looks like a little overkilled just to get rid of folio_address().


And to be honest, if we really want to reduce the complexity of=20
folio_address(), we should go direct to large folios, which is much=20
easier and less risky.
>=20
> 	faddr     ----+
> 	folios[]      |
> 	[0]           |
> 	[1]           |
> 	...           |
> 	[N]       <---+
> 	[N+1]
> 	...
>=20
> There are 5 node sizes supported in total, but not all of them are used.
> Create slabs only for 2 sizes where 16K is for the default size on
> x86_64 and 64K. The one that contains the node size will be used,
> possibly with some slack space.

I'm not a fan of two magic numbers.

Can we just make folios[] variable size first without bothering the=20
cached folio address?
Especially you're mentioning the series do not pass btrfs/002.

Thanks,
Qu

>=20
> In case of 16K node size we'll gain a few more objects per slab:
>=20
> Before this change:
>=20
>    sizeof (struct extent_buffer) =3D 240
>    objects in 8K slab =3D 34
>=20
> After, the base size of extent buffer is 120 bytes:
>=20
> For 16K:
>=20
>    size =3D 120 + 2 * 4 * 8 =3D 184
>    objects in 8K slab =3D 44
>=20
> For 64K:
>=20
>    size =3D 120 + 2 * 16 * 8 =3D 376
>    objects in 8K slab =3D 21
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent_io.c | 71 +++++++++++++++++++++++++++++++++-----------
>   fs/btrfs/extent_io.h | 20 +++++++++----
>   2 files changed, 68 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ca7174fa024056..4c906e5ea8ac70 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -35,7 +35,21 @@
>   #include "super.h"
>   #include "transaction.h"
>  =20
> -static struct kmem_cache *extent_buffer_cache;
> +static struct kmem_cache *extent_buffer_cache_16k;
> +static struct kmem_cache *extent_buffer_cache_64k;
> +
> +static void free_eb(struct extent_buffer *eb)
> +{
> +	if (!eb)
> +		return;
> +
> +	if (test_bit(EXTENT_BUFFER_16K, &eb->bflags))
> +		kmem_cache_free(extent_buffer_cache_16k, eb);
> +	else if (test_bit(EXTENT_BUFFER_64K, &eb->bflags))
> +		kmem_cache_free(extent_buffer_cache_64k, eb);
> +	else
> +		DEBUG_WARN("eb size mismatch");
> +}
>  =20
>   #ifdef CONFIG_BTRFS_DEBUG
>   static inline void btrfs_leak_debug_add_eb(struct extent_buffer *eb)
> @@ -81,7 +95,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs=
_fs_info *fs_info)
>   		       btrfs_header_owner(eb));
>   		list_del(&eb->leak_list);
>   		WARN_ON_ONCE(1);
> -		kmem_cache_free(extent_buffer_cache, eb);
> +		free_eb(eb);
>   	}
>   	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
>   }
> @@ -221,11 +235,24 @@ static void submit_write_bio(struct btrfs_bio_ctrl=
 *bio_ctrl, int ret)
>  =20
>   int __init extent_buffer_init_cachep(void)
>   {
> -	extent_buffer_cache =3D kmem_cache_create("btrfs_extent_buffer",
> -						sizeof(struct extent_buffer), 0, 0,
> -						NULL);
> -	if (!extent_buffer_cache)
> +	size_t size;
> +
> +	size  =3D sizeof(struct extent_buffer);
> +	size +=3D (SZ_16K >> PAGE_SHIFT) * sizeof(struct folio *);
> +	size +=3D (SZ_16K >> PAGE_SHIFT) * sizeof(void *);
> +	extent_buffer_cache_16k =3D kmem_cache_create("btrfs_extent_buffer_16k=
",
> +						    size, 0, 0, NULL);
> +
> +	size  =3D sizeof(struct extent_buffer);
> +	size +=3D (SZ_64K >> PAGE_SHIFT) * sizeof(struct folio *);
> +	size +=3D (SZ_64K >> PAGE_SHIFT) * sizeof(void *);
> +	extent_buffer_cache_64k =3D kmem_cache_create("btrfs_extent_buffer_64k=
",
> +						    size, 0, 0, NULL);
> +
> +	if (!extent_buffer_cache_16k || !extent_buffer_cache_64k) {
> +		extent_buffer_free_cachep();
>   		return -ENOMEM;
> +	}
>  =20
>   	return 0;
>   }
> @@ -237,7 +264,8 @@ void __cold extent_buffer_free_cachep(void)
>   	 * destroy caches.
>   	 */
>   	rcu_barrier();
> -	kmem_cache_destroy(extent_buffer_cache);
> +	kmem_cache_destroy(extent_buffer_cache_16k);
> +	kmem_cache_destroy(extent_buffer_cache_64k);
>   }
>  =20
>   static void process_one_folio(struct btrfs_fs_info *fs_info,
> @@ -692,8 +720,10 @@ static int alloc_eb_folio_array(struct extent_buffe=
r *eb, bool nofail)
>   	if (ret < 0)
>   		return ret;
>  =20
> -	for (int i =3D 0; i < num_pages; i++)
> +	for (int i =3D 0; i < num_pages; i++) {
>   		eb->folios[i] =3D page_folio(page_array[i]);
> +		eb->faddr[i] =3D folio_address(eb->folios[i]);
> +	}
>   	eb->folio_size =3D PAGE_SIZE;
>   	eb->folio_shift =3D PAGE_SHIFT;
>   	return 0;
> @@ -2192,7 +2222,7 @@ static noinline_for_stack void write_one_eb(struct=
 extent_buffer *eb,
>  =20
>   	prepare_eb_write(eb);
>  =20
> -	bbio =3D btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
> +	bbio =3D btrfs_bio_alloc(num_extent_folios(eb),
>   			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
>   			       eb->fs_info, end_bbio_meta_write, eb);
>   	bbio->bio.bi_iter.bi_sector =3D eb->start >> SECTOR_SHIFT;
> @@ -2929,7 +2959,7 @@ static void btrfs_release_extent_buffer_folios(con=
st struct extent_buffer *eb)
>   {
>   	ASSERT(!extent_buffer_under_io(eb));
>  =20
> -	for (int i =3D 0; i < INLINE_EXTENT_BUFFER_PAGES; i++) {
> +	for (int i =3D 0; i < num_extent_folios(eb); i++) {
>   		struct folio *folio =3D eb->folios[i];
>  =20
>   		if (!folio)
> @@ -2946,7 +2976,7 @@ static inline void btrfs_release_extent_buffer(str=
uct extent_buffer *eb)
>   {
>   	btrfs_release_extent_buffer_folios(eb);
>   	btrfs_leak_debug_del_eb(eb);
> -	kmem_cache_free(extent_buffer_cache, eb);
> +	free_eb(eb);
>   }
>  =20
>   static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_inf=
o *fs_info,
> @@ -2954,7 +2984,16 @@ static struct extent_buffer *__alloc_extent_buffe=
r(struct btrfs_fs_info *fs_info
>   {
>   	struct extent_buffer *eb =3D NULL;
>  =20
> -	eb =3D kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
> +	ASSERT(fs_info->nodesize <=3D BTRFS_MAX_METADATA_BLOCKSIZE);
> +	if (fs_info->nodesize <=3D SZ_16K) {
> +		eb =3D kmem_cache_zalloc(extent_buffer_cache_16k, GFP_NOFS | __GFP_NO=
FAIL);
> +		__set_bit(EXTENT_BUFFER_16K, &eb->bflags);
> +		eb->faddr =3D (void **)(eb->folios + (SZ_16K >> PAGE_SHIFT));
> +	} else {
> +		eb =3D kmem_cache_zalloc(extent_buffer_cache_64k, GFP_NOFS | __GFP_NO=
FAIL);
> +		__set_bit(EXTENT_BUFFER_64K, &eb->bflags);
> +		eb->faddr =3D (void **)(eb->folios + (SZ_64K >> PAGE_SHIFT));
> +	}
>   	eb->start =3D start;
>   	eb->len =3D fs_info->nodesize;
>   	eb->fs_info =3D fs_info;
> @@ -2965,8 +3004,6 @@ static struct extent_buffer *__alloc_extent_buffer=
(struct btrfs_fs_info *fs_info
>   	spin_lock_init(&eb->refs_lock);
>   	refcount_set(&eb->refs, 1);
>  =20
> -	ASSERT(eb->len <=3D BTRFS_MAX_METADATA_BLOCKSIZE);
> -
>   	return eb;
>   }
>  =20
> @@ -3550,7 +3587,7 @@ static inline void btrfs_release_extent_buffer_rcu=
(struct rcu_head *head)
>   	struct extent_buffer *eb =3D
>   			container_of(head, struct extent_buffer, rcu_head);
>  =20
> -	kmem_cache_free(extent_buffer_cache, eb);
> +	free_eb(eb);
>   }
>  =20
>   static int release_extent_buffer(struct extent_buffer *eb)
> @@ -3586,7 +3623,7 @@ static int release_extent_buffer(struct extent_buf=
fer *eb)
>   		btrfs_release_extent_buffer_folios(eb);
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   		if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))) {
> -			kmem_cache_free(extent_buffer_cache, eb);
> +			free_eb(eb);
>   			return 1;
>   		}
>   #endif
> @@ -3837,7 +3874,7 @@ int read_extent_buffer_pages_nowait(struct extent_=
buffer *eb, int mirror_num,
>   	check_buffer_tree_ref(eb);
>   	refcount_inc(&eb->refs);
>  =20
> -	bbio =3D btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
> +	bbio =3D btrfs_bio_alloc(num_extent_folios(eb),
>   			       REQ_OP_READ | REQ_META, eb->fs_info,
>   			       end_bbio_meta_read, eb);
>   	bbio->bio.bi_iter.bi_sector =3D eb->start >> SECTOR_SHIFT;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 61130786b9a3ad..3903913924f02c 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -48,6 +48,9 @@ enum {
>   	EXTENT_BUFFER_ZONED_ZEROOUT,
>   	/* Indicate that extent buffer pages a being read */
>   	EXTENT_BUFFER_READING,
> +	/* Size of slab derived from fs_info->nodesize. */
> +	EXTENT_BUFFER_16K,
> +	EXTENT_BUFFER_64K,
>   };
>  =20
>   /* these are flags for __process_pages_contig */
> @@ -107,16 +110,21 @@ struct extent_buffer {
>  =20
>   	struct rw_semaphore lock;
>  =20
> -	/*
> -	 * Pointers to all the folios of the extent buffer.
> -	 *
> -	 * For now the folio is always order 0 (aka, a single page).
> -	 */
> -	struct folio *folios[INLINE_EXTENT_BUFFER_PAGES];
>   #ifdef CONFIG_BTRFS_DEBUG
>   	struct list_head leak_list;
>   	pid_t lock_owner;
>   #endif
> +	/*
> +	 * Pointers to all folios of the extent buffer.
> +	 *
> +	 * For now the folio is always order 0 (a single page).
> +	 *
> +	 * Extent buffer size is determined at runtime, and allocated from the
> +	 * right slab depending on "nodesize <=3D 16K". Cached folio address a=
rray
> +	 * is stored after folios, @faddr is set up at allocation time.
> +	 */
> +	void **faddr;
> +	struct folio *folios[];
>   };
>  =20
>   struct btrfs_eb_write_context {


