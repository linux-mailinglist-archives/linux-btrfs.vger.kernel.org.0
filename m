Return-Path: <linux-btrfs+bounces-21795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K8uBj7Tl2lM9AIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21795-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 04:21:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 697761645C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 04:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F0B302835D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 03:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234872BDC32;
	Fri, 20 Feb 2026 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UtE+4ubE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F31DF755
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771557678; cv=none; b=EHNi3VFu15VX4Y1YXWoMc+mshwK2jaSIx/oa/kipCTW5B0AXf/YxGnemgt+0V78i/12q2RrdXA1HQn/3O+FRxBiqz77I4HTsYKCOw39N2x9Hcqf5qP8Gq4GqvpTTXz6JdYgraWxM6QnpqiB2p7/+jhZIkciL6cY5Kf40hBVDP3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771557678; c=relaxed/simple;
	bh=7poWq7GyLDdzJd0HEZ43x7sTq8qlnlm/3H+R0kdycVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=myPY2owqPnyaG4NpY35gnU2KV5pa2I73td3qOTW2dgmelkpzFwB1XEoG7X6uDIeTafC588+PEVmVkJTfLn1JMhCw+KsWgpva8rYxEZP8MmsLTgDG7RTvpi0a12nijnmfFMEfhOR9qCrTytWfElYB2r/5FjTfEe9+GtpU6hFqEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UtE+4ubE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771557674; x=1772162474; i=quwenruo.btrfs@gmx.com;
	bh=y0IabiRRbcaoyymF16iVb3QMrSJ9HLnMS7/7WWrBNi8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UtE+4ubExyrokHyZCFaXZRvgEGbY31BEoCIxk8zGt2bMc6Dz6FaV6AyZ/YME2Vav
	 rIwfYHmrecSX/pTjQvr/TpJXpoQCiutwllq++PY7hpGkzUE2gDi7DlQF8SU2C6IWo
	 p6DpQNQlWTZF8SUQCaePDL0+z4OSO/lYfUJ7hh2+ueRjbTP45lKPfOH+OZbmsQ7en
	 WhLGPKIK1tbRePVy9z9DKJhjVED1A3CTdB3xuHNQ5WRa+KF7LzBBZ0j0vqL9JfEzL
	 mbvxxKbFV1lcmPBX/R6Bs7It6gjy0js9HVSNzzLw6UFJhSgkOHwnzbOP7QM6V9p+j
	 5+BFoddw+6wWf/cF1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9yc-1wAFjM0JWs-00J9le; Fri, 20
 Feb 2026 04:21:14 +0100
Message-ID: <7622f6be-2cc3-42b3-97d3-ecb711a760a0@gmx.com>
Date: Fri, 20 Feb 2026 13:51:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: constify arguments of some functions
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <582d0b842cfeed8e97eedf8eabf18b9ebb47cc7b.1771516468.git.fdmanana@suse.com>
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
In-Reply-To: <582d0b842cfeed8e97eedf8eabf18b9ebb47cc7b.1771516468.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cInyQX2K7tHS0YnHJVfudvY61XA0ObdkCU+EYDe8eGilRAHcnxJ
 p55a8j0/UslUKepiJ5fb/D9NCCACARcAOZqB6RzRiHc+1Aw3eHatT42xJdj9SdIj+JrtsoN
 01K0xTN+pwxWjx2Uq6aZyMoiGSmL1q4M9K4eqzcuvUZbeNsHbBC1fv0El9RFh1josOH9KYV
 opgdsXXWTPs1rDejNbCOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y5g5j5poSTc=;gjkhbFz5xhl1J2vGXAap2OkA+DB
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21795-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmx.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 697761645C1
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/20 02:28, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> There are several functions that take pointer arguments but don't need t=
o
> modify the objects they point to, so add the const qualifiers.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c    | 6 +++---
>   fs/btrfs/disk-io.h    | 2 +-
>   fs/btrfs/fs.h         | 4 ++--
>   fs/btrfs/misc.h       | 3 ++-
>   fs/btrfs/space-info.c | 6 +++---
>   fs/btrfs/space-info.h | 2 +-
>   fs/btrfs/super.h      | 2 +-
>   7 files changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 536f431e8844..966e55c7af6e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -728,7 +728,7 @@ void btrfs_global_root_delete(struct btrfs_root *roo=
t)
>   }
>  =20
>   struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
> -				     struct btrfs_key *key)
> +				     const struct btrfs_key *key)
>   {
>   	struct rb_node *node;
>   	struct btrfs_root *root =3D NULL;
> @@ -765,7 +765,7 @@ static u64 btrfs_global_root_id(struct btrfs_fs_info=
 *fs_info, u64 bytenr)
>  =20
>   struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 =
bytenr)
>   {
> -	struct btrfs_key key =3D {
> +	const struct btrfs_key key =3D {
>   		.objectid =3D BTRFS_CSUM_TREE_OBJECTID,
>   		.type =3D BTRFS_ROOT_ITEM_KEY,
>   		.offset =3D btrfs_global_root_id(fs_info, bytenr),
> @@ -776,7 +776,7 @@ struct btrfs_root *btrfs_csum_root(struct btrfs_fs_i=
nfo *fs_info, u64 bytenr)
>  =20
>   struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u6=
4 bytenr)
>   {
> -	struct btrfs_key key =3D {
> +	const struct btrfs_key key =3D {
>   		.objectid =3D BTRFS_EXTENT_TREE_OBJECTID,
>   		.type =3D BTRFS_ROOT_ITEM_KEY,
>   		.offset =3D btrfs_global_root_id(fs_info, bytenr),
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 163f5114973a..2742e6aac7dd 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -76,7 +76,7 @@ struct btrfs_root *btrfs_get_fs_root_commit_root(struc=
t btrfs_fs_info *fs_info,
>   int btrfs_global_root_insert(struct btrfs_root *root);
>   void btrfs_global_root_delete(struct btrfs_root *root);
>   struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
> -				     struct btrfs_key *key);
> +				     const struct btrfs_key *key);
>   struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 =
bytenr);
>   struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u6=
4 bytenr);
>  =20
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 3de3b517810e..f2f4d5b747c5 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -966,13 +966,13 @@ struct btrfs_fs_info {
>   #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
>   					   struct inode *: (_inode)))->root->fs_info)
>  =20
> -static inline gfp_t btrfs_alloc_write_mask(struct address_space *mappin=
g)
> +static inline gfp_t btrfs_alloc_write_mask(const struct address_space *=
mapping)
>   {
>   	return mapping_gfp_constraint(mapping, ~__GFP_FS);
>   }
>  =20
>   /* Return the minimal folio size of the fs. */
> -static inline unsigned int btrfs_min_folio_size(struct btrfs_fs_info *f=
s_info)
> +static inline unsigned int btrfs_min_folio_size(const struct btrfs_fs_i=
nfo *fs_info)
>   {
>   	return 1U << (PAGE_SHIFT + fs_info->block_min_order);
>   }
> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> index 12c5a9d6564f..40433a86fe49 100644
> --- a/fs/btrfs/misc.h
> +++ b/fs/btrfs/misc.h
> @@ -28,7 +28,8 @@
>   	name =3D (1U << __ ## name ## _BIT),              \
>   	__ ## name ## _SEQ =3D __ ## name ## _BIT
>  =20
> -static inline phys_addr_t bio_iter_phys(struct bio *bio, struct bvec_it=
er *iter)
> +static inline phys_addr_t bio_iter_phys(const struct bio *bio,
> +					const struct bvec_iter *iter)
>   {
>   	struct bio_vec bv =3D bio_iter_iovec(bio, *iter);
>  =20
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index b174c68a5ebb..a61947fd5a1a 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -412,10 +412,10 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_in=
fo *info,
>   	up_write(&space_info->groups_sem);
>   }
>  =20
> -struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *in=
fo,
> +struct btrfs_space_info *btrfs_find_space_info(const struct btrfs_fs_in=
fo *info,
>   					       u64 flags)
>   {
> -	struct list_head *head =3D &info->space_info;
> +	const struct list_head *head =3D &info->space_info;
>   	struct btrfs_space_info *found;
>  =20
>   	flags &=3D BTRFS_BLOCK_GROUP_TYPE_MASK;
> @@ -427,7 +427,7 @@ struct btrfs_space_info *btrfs_find_space_info(struc=
t btrfs_fs_info *info,
>   	return NULL;
>   }
>  =20
> -static u64 calc_effective_data_chunk_size(struct btrfs_fs_info *fs_info=
)
> +static u64 calc_effective_data_chunk_size(const struct btrfs_fs_info *f=
s_info)
>   {
>   	struct btrfs_space_info *data_sinfo;
>   	u64 data_chunk_size;
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 174b1ecf63be..24f45072ca4b 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -292,7 +292,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info=
 *info,
>   				struct btrfs_block_group *block_group);
>   void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space=
_info,
>   					u64 chunk_size);
> -struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *in=
fo,
> +struct btrfs_space_info *btrfs_find_space_info(const struct btrfs_fs_in=
fo *info,
>   					       u64 flags);
>   void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
>   void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
> diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
> index d80a86acfbbe..f85f8a8a7bfe 100644
> --- a/fs/btrfs/super.h
> +++ b/fs/btrfs/super.h
> @@ -18,7 +18,7 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs=
_fs_info *fs_info,
>   					  u64 subvol_objectid);
>   void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info=
);
>  =20
> -static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
> +static inline struct btrfs_fs_info *btrfs_sb(const struct super_block *=
sb)
>   {
>   	return sb->s_fs_info;
>   }


