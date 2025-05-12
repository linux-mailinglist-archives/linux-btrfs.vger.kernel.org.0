Return-Path: <linux-btrfs+bounces-13950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C91AAB4770
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 00:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B6F17D796
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 22:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9FA29A323;
	Mon, 12 May 2025 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Io99uYKY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BC11712;
	Mon, 12 May 2025 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747089858; cv=none; b=hRerV/feoBinC8DIA5965jnL2OIGKseyPgDnX9uube6qCnw8XZ91ZQ/geyR7dWzSRvSbyhj5SzVJrz2HABJBdgLeKy9MPJ7XvQQIEl97+C9bL86JVz30R5w0xdPVpzWvUbUewNeme36czpobfxwJ2OzDDERur9l7O1fsgG/fLD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747089858; c=relaxed/simple;
	bh=p3gCaX6kLG4kJSTTXeOW3ZyK0fPbRCxGzBLYP4Q0eD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYnkY7Gewp6laz2Pd98du7GaceDHY1B/TZ/EfVzqS3FtPr9Bsyjm9uMiGuoLGplTFl0yZ2kysPWzxAlZNIwrHSCcOWA8OyUYRScvRRb2N1NtCvJk9wJirEO5+/W8gqFErOKa7eWI1zufiqVmBBHNn3jSZwAMWER9JPLB0ehmVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Io99uYKY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747089853; x=1747694653; i=quwenruo.btrfs@gmx.com;
	bh=TPgcSMmBoHLrqDbWyDKqGM33FpkuSKlxUyLcMjoi+a4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Io99uYKYMJS5U87OMo0NpJPYe1hwaFjpPk3/ymTeofjqr3nDn6r5YZiG95HDDLrd
	 a66bWh6ieIXqR3BY1h8x2zgog9vKfSkRE26UrYeRjJTBIze2HgirNgPlTqQ3CZG50
	 znH1d576Rnhmiq66G34KjGSt/RWOuRK1GuNI2CHwcZ5luvkwF1Bp/jvVWulo3XtvV
	 86Ka4TUGlS+HHWhALTsdJ1GyrzCdR3XYoVCO6i5RoKvNXc8uGxaW0RMb7XRB4erBX
	 DkqEbnwCz59NnGSc7vgKo7IssXEYx3O9se8mskkaVmajsInx6OT8RVpP9Ug+VPL1J
	 crpc++tNv9GNL74AJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdNcG-1unwd71mBU-00kJVI; Tue, 13
 May 2025 00:44:13 +0200
Message-ID: <4b29d4b8-c823-44d0-8647-a53a09e20b5f@gmx.com>
Date: Tue, 13 May 2025 08:14:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250512172321.3004779-1-neelx@suse.com>
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
In-Reply-To: <20250512172321.3004779-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QgymCkrfma5nOzGQswaOsR2NkmwBKcpVfyoG/xkPgXVEzWFGHYo
 GIDJP4gw9DQPMqc5FXRUinbC1yImgDpC0gpWEH3hsBv738O8RuCGB0jftGBuvnWR2qy/Pws
 JU62YdPY6lFUOUF505QohShLy5EtMGPcYSgBny+prHpOlonAW7Z4gC5xMnJrQ3PzXmliB/l
 ucMyBm0IiJ/E0M8hwiFBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6N+GiA7TOuA=;u/aX6BLRDrPFDJEF3e83LTArYY3
 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



=E5=9C=A8 2025/5/13 02:53, Daniel Vacek =E5=86=99=E9=81=93:
> So far we are deriving the buffer tree index using the sector size. But =
each
> extent buffer covers multiple sectors. This makes the buffer tree rather=
 sparse.
>=20
> For example the typical and quite common configuration uses sector size =
of 4KiB
> and node size of 16KiB. In this case it means the buffer tree is using u=
p to
> the maximum of 25% of it's slots. Or in other words at least 75% of the =
tree
> slots are wasted as never used.
>=20
> We can score significant memory savings on the required tree nodes by in=
dexing
> the tree using the node size instead. As a result far less slots are was=
ted
> and the tree can now use up to all 100% of it's slots this way.
>=20
> Signed-off-by: Daniel Vacek <neelx@suse.com>

I'm fine with this change, but I still believe, we should address=20
unaligned tree blocks before doing this.

As this requires all tree blocks are nodesize aligned.

If we have some metadata chunks which starts at a bytenr that is not=20
node size aligned, all tree blocks inside that chunk will not be=20
nodesize aligned and causing problems.

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c   |  1 +
>   fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
>   fs/btrfs/fs.h        |  3 ++-
>   3 files changed, 18 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5bcf11246ba66..dcea5b0a2db50 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3395,6 +3395,7 @@ int __cold open_ctree(struct super_block *sb, stru=
ct btrfs_fs_devices *fs_device
>   	fs_info->delalloc_batch =3D sectorsize * 512 * (1 + ilog2(nr_cpu_ids)=
);
>  =20
>   	fs_info->nodesize =3D nodesize;
> +	fs_info->node_bits =3D ilog2(nodesize);
>   	fs_info->sectorsize =3D sectorsize;
>   	fs_info->sectorsize_bits =3D ilog2(sectorsize);
>   	fs_info->csums_per_leaf =3D BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->c=
sum_size;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4d3584790cf7f..80a8563a25add 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1774,7 +1774,7 @@ static noinline_for_stack bool lock_extent_buffer_=
for_io(struct extent_buffer *e
>   	 */
>   	spin_lock(&eb->refs_lock);
>   	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> -		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize=
_bits);
> +		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node_bits)=
;
>   		unsigned long flags;
>  =20
>   		set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> @@ -1874,7 +1874,7 @@ static void set_btree_ioerr(struct extent_buffer *=
eb)
>   static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_ma=
rk_t mark)
>   {
>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
> -	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_=
bits);
> +	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node_bits);
>   	unsigned long flags;
>  =20
>   	xas_lock_irqsave(&xas, flags);
> @@ -1886,7 +1886,7 @@ static void buffer_tree_set_mark(const struct exte=
nt_buffer *eb, xa_mark_t mark)
>   static void buffer_tree_clear_mark(const struct extent_buffer *eb, xa_=
mark_t mark)
>   {
>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
> -	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_=
bits);
> +	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node_bits);
>   	unsigned long flags;
>  =20
>   	xas_lock_irqsave(&xas, flags);
> @@ -1986,7 +1986,7 @@ static unsigned int buffer_tree_get_ebs_tag(struct=
 btrfs_fs_info *fs_info,
>   	rcu_read_lock();
>   	while ((eb =3D find_get_eb(&xas, end, tag)) !=3D NULL) {
>   		if (!eb_batch_add(batch, eb)) {
> -			*start =3D (eb->start + eb->len) >> fs_info->sectorsize_bits;
> +			*start =3D (eb->start + eb->len) >> fs_info->node_bits;
>   			goto out;
>   		}
>   	}
> @@ -2008,7 +2008,7 @@ static struct extent_buffer *find_extent_buffer_no=
lock(
>   		struct btrfs_fs_info *fs_info, u64 start)
>   {
>   	struct extent_buffer *eb;
> -	unsigned long index =3D start >> fs_info->sectorsize_bits;
> +	unsigned long index =3D start >> fs_info->node_bits;
>  =20
>   	rcu_read_lock();
>   	eb =3D xa_load(&fs_info->buffer_tree, index);
> @@ -2114,8 +2114,8 @@ void btrfs_btree_wait_writeback_range(struct btrfs=
_fs_info *fs_info, u64 start,
>   				      u64 end)
>   {
>   	struct eb_batch batch;
> -	unsigned long start_index =3D start >> fs_info->sectorsize_bits;
> -	unsigned long end_index =3D end >> fs_info->sectorsize_bits;
> +	unsigned long start_index =3D start >> fs_info->node_bits;
> +	unsigned long end_index =3D end >> fs_info->node_bits;
>  =20
>   	eb_batch_init(&batch);
>   	while (start_index <=3D end_index) {
> @@ -2151,7 +2151,7 @@ int btree_write_cache_pages(struct address_space *=
mapping,
>  =20
>   	eb_batch_init(&batch);
>   	if (wbc->range_cyclic) {
> -		index =3D (mapping->writeback_index << PAGE_SHIFT) >> fs_info->sector=
size_bits;
> +		index =3D (mapping->writeback_index << PAGE_SHIFT) >> fs_info->node_b=
its;
>   		end =3D -1;
>  =20
>   		/*
> @@ -2160,8 +2160,8 @@ int btree_write_cache_pages(struct address_space *=
mapping,
>   		 */
>   		scanned =3D (index =3D=3D 0);
>   	} else {
> -		index =3D wbc->range_start >> fs_info->sectorsize_bits;
> -		end =3D wbc->range_end >> fs_info->sectorsize_bits;
> +		index =3D wbc->range_start >> fs_info->node_bits;
> +		end =3D wbc->range_end >> fs_info->node_bits;
>  =20
>   		scanned =3D 1;
>   	}
> @@ -3037,7 +3037,7 @@ struct extent_buffer *alloc_test_extent_buffer(str=
uct btrfs_fs_info *fs_info,
>   	eb->fs_info =3D fs_info;
>   again:
>   	xa_lock_irq(&fs_info->buffer_tree);
> -	exists =3D __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->secto=
rsize_bits,
> +	exists =3D __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->node_=
bits,
>   			      NULL, eb, GFP_NOFS);
>   	if (xa_is_err(exists)) {
>   		ret =3D xa_err(exists);
> @@ -3353,7 +3353,7 @@ struct extent_buffer *alloc_extent_buffer(struct b=
trfs_fs_info *fs_info,
>   again:
>   	xa_lock_irq(&fs_info->buffer_tree);
>   	existing_eb =3D __xa_cmpxchg(&fs_info->buffer_tree,
> -				   start >> fs_info->sectorsize_bits, NULL, eb,
> +				   start >> fs_info->node_bits, NULL, eb,
>   				   GFP_NOFS);
>   	if (xa_is_err(existing_eb)) {
>   		ret =3D xa_err(existing_eb);
> @@ -3456,7 +3456,7 @@ static int release_extent_buffer(struct extent_buf=
fer *eb)
>   		 * in this case.
>   		 */
>   		xa_cmpxchg_irq(&fs_info->buffer_tree,
> -			       eb->start >> fs_info->sectorsize_bits, eb, NULL,
> +			       eb->start >> fs_info->node_bits, eb, NULL,
>   			       GFP_ATOMIC);
>  =20
>   		btrfs_leak_debug_del_eb(eb);
> @@ -4294,9 +4294,9 @@ static int try_release_subpage_extent_buffer(struc=
t folio *folio)
>   {
>   	struct btrfs_fs_info *fs_info =3D folio_to_fs_info(folio);
>   	struct extent_buffer *eb;
> -	unsigned long start =3D folio_pos(folio) >> fs_info->sectorsize_bits;
> +	unsigned long start =3D folio_pos(folio) >> fs_info->node_bits;
>   	unsigned long index =3D start;
> -	unsigned long end =3D index + (PAGE_SIZE >> fs_info->sectorsize_bits) =
- 1;
> +	unsigned long end =3D index + (PAGE_SIZE >> fs_info->node_bits) - 1;
>   	int ret;
>  =20
>   	xa_lock_irq(&fs_info->buffer_tree);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index cf805b4032af3..8c9113304fabe 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -778,8 +778,9 @@ struct btrfs_fs_info {
>  =20
>   	struct btrfs_delayed_root *delayed_root;
>  =20
> -	/* Entries are eb->start / sectorsize */
> +	/* Entries are eb->start >> node_bits */
>   	struct xarray buffer_tree;
> +	int node_bits;
>  =20
>   	/* Next backup root to be overwritten */
>   	int backup_root_index;


