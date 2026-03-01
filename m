Return-Path: <linux-btrfs+bounces-22128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDiDIockpGn5YQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22128-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 12:35:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F371CF5B1
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 12:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 192CA301AB8F
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28864320CD3;
	Sun,  1 Mar 2026 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKnVcvnn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62342E3AF1
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2026 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772364905; cv=none; b=JzVCYhPHqJi60GF4MTQG+TFbID4hzItPniEbZB0TzkpL/r29+2uCkrfI3aXxGD61M409QyDfZ1bB8bIrC4QB2xG4L5sMDLYJwdkpHK+4WOY3bfAfo2IYCDO8oJb/FTY29sMOqFHticcjo4ikSFm/hhG0+1jfKi6+k3s41Dl8n3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772364905; c=relaxed/simple;
	bh=qnLLFG/SZGZn4csT7tprzSg7zh1mbGI6yaIY7sH+hIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/gTt49ObDPfu/t28Tny1JSyb0vTM85z7LGxed595cXG3oRDZXmLVsUTOKa3M80++Xei1rtr6F/CA+WgrpbDrjS8HN8OCGoKSJG3ULDtmgF6fI3JdHSkgxgCjjF2kGNrcSt1IbYtrlJlc4PDPt7/VXQU2OawTtQn6Rt/LHC8xyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKnVcvnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B7FC2BC9E
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2026 11:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772364904;
	bh=qnLLFG/SZGZn4csT7tprzSg7zh1mbGI6yaIY7sH+hIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IKnVcvnnTW8vrfz5wFOfRC4iQ9RJDy+6pG9VfmSZVmfQgqS3uFU8I7lbgvaLLY+5u
	 LSyHGBwzpPmloo5snj9YwvyOnFbEMLKVM83bSZXNxdh263bZJl7BcBydB3S2fgDph8
	 jRP7sLY1KKi4+ZV4yJ7Cwri2GJytH6vGoC8oOHQkIxwqJ4NcRhs8RqFILttxgdKL6v
	 Wlg9XvEs8PQ7Gz+ve30EVdF+fFdZGNojOuGXX/Ib/YTA/7F56j7G/iGkhjF2wqJ3h3
	 /Z5LU6BBrlZ1uBpDpCXOAdp1YA1j9TUaxFdD7UjjMECIYZ7yfm5uUPhRoS3ey+M7SX
	 308KpsW3O+a4Q==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9381e78a31so301178966b.2
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2026 03:35:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0Ri3snkFEikBcIw4y3LFRoRTDgkS4Qv/Slf/M+JlbLoRyTOsErCglUs2eyOcf7sQ828TnBu1rTlxMkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIqcG1YZJi5j/ylEDa7QmjL3GEfnCaqVeuof5tC1sqnGZLM06B
	dbqlstQ2UphlH3hjK6fOAhAdqiEJmHL0MNgYlWy4Mt7y8KPlw7aM2oO47Cqrrsgts1Q2rvudVBa
	WXLqCKjhQrz5siuSpyd7f6eXD+5iUepA=
X-Received: by 2002:a17:907:da9:b0:b93:8460:4a3 with SMTP id
 a640c23a62f3a-b9384600779mr503132366b.56.1772364903279; Sun, 01 Mar 2026
 03:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228090621.100841-1-adarshdas950@gmail.com> <20260228090621.100841-2-adarshdas950@gmail.com>
In-Reply-To: <20260228090621.100841-2-adarshdas950@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 1 Mar 2026 11:34:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H73KNJSCZQN8R_uSrCnsPZUqOdiyszuwjhjtFV7d4VPzw@mail.gmail.com>
X-Gm-Features: AaiRm52lgCnBcpkR4m_bvQcPSn8jz_hJlaCQziCVqYErNUhha4pddSUBvBa9tZ4
Message-ID: <CAL3q7H73KNJSCZQN8R_uSrCnsPZUqOdiyszuwjhjtFV7d4VPzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: replace BUG() with error handling in compression.c
To: Adarsh Das <adarshdas950@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, terrelln@fb.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22128-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 06F371CF5B1
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 9:07=E2=80=AFAM Adarsh Das <adarshdas950@gmail.com>=
 wrote:
>
> v2:
> - use ASSERT() instead of btrfs_err() + -EUCLEAN
> - remove default: branches and add upfront ASSERT() for type validation
> - fold coding style fixes into this patch
>
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
> ---
>  fs/btrfs/compression.c | 74 ++++++++++++++----------------------------
>  1 file changed, 25 insertions(+), 49 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 790518a8c803..0d8da8ce5fd3 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -36,9 +36,9 @@
>
>  static struct bio_set btrfs_compressed_bioset;
>
> -static const char* const btrfs_compress_types[] =3D { "", "zlib", "lzo",=
 "zstd" };
> +static const char * const btrfs_compress_types[] =3D { "", "zlib", "lzo"=
, "zstd" };

Please don't do that.

You are changing a lot of lines in this patch, and the next one, just
to change coding style.
We don't do that in btrfs: we only fix the coding style of a line when
we need to change it anyway due to a bug fix, refactoring, cleanup,
implementing something new, etc.

Also don't send patches to fix only coding style.

Thanks.

>
> -const char* btrfs_compress_type2str(enum btrfs_compression_type type)
> +const char *btrfs_compress_type2str(enum btrfs_compression_type type)
>  {
>         switch (type) {
>         case BTRFS_COMPRESS_ZLIB:
> @@ -89,24 +89,21 @@ bool btrfs_compress_is_valid_type(const char *str, si=
ze_t len)
>  static int compression_decompress_bio(struct list_head *ws,
>                                       struct compressed_bio *cb)
>  {
> +       ASSERT(cb->compress_type > BTRFS_COMPRESS_NONE &&
> +              cb->compress_type < BTRFS_NR_COMPRESS_TYPES);
>         switch (cb->compress_type) {
>         case BTRFS_COMPRESS_ZLIB: return zlib_decompress_bio(ws, cb);
>         case BTRFS_COMPRESS_LZO:  return lzo_decompress_bio(ws, cb);
>         case BTRFS_COMPRESS_ZSTD: return zstd_decompress_bio(ws, cb);
> -       case BTRFS_COMPRESS_NONE:
> -       default:
> -               /*
> -                * This can't happen, the type is validated several times
> -                * before we get here.
> -                */
> -               BUG();
>         }
> +       return -EUCLEAN;
>  }
>
>  static int compression_decompress(int type, struct list_head *ws,
>                 const u8 *data_in, struct folio *dest_folio,
>                 unsigned long dest_pgoff, size_t srclen, size_t destlen)
>  {
> +       ASSERT(type > BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYP=
ES);
>         switch (type) {
>         case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, des=
t_folio,
>                                                 dest_pgoff, srclen, destl=
en);
> @@ -114,14 +111,8 @@ static int compression_decompress(int type, struct l=
ist_head *ws,
>                                                 dest_pgoff, srclen, destl=
en);
>         case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, des=
t_folio,
>                                                 dest_pgoff, srclen, destl=
en);
> -       case BTRFS_COMPRESS_NONE:
> -       default:
> -               /*
> -                * This can't happen, the type is validated several times
> -                * before we get here.
> -                */
> -               BUG();
>         }
> +       return -EUCLEAN;
>  }
>
>  static int btrfs_decompress_bio(struct compressed_bio *cb);
> @@ -484,6 +475,7 @@ static noinline int add_ra_bio_pages(struct inode *in=
ode,
>
>                         if (zero_offset) {
>                                 int zeros;
> +
>                                 zeros =3D folio_size(folio) - zero_offset=
;
>                                 folio_zero_range(folio, zero_offset, zero=
s);
>                         }
> @@ -697,33 +689,25 @@ static const struct btrfs_compress_levels * const b=
trfs_compress_levels[] =3D {
>
>  static struct list_head *alloc_workspace(struct btrfs_fs_info *fs_info, =
int type, int level)
>  {
> +
> +       ASSERT(type >=3D BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_=
TYPES);
>         switch (type) {
>         case BTRFS_COMPRESS_NONE: return alloc_heuristic_ws(fs_info);
>         case BTRFS_COMPRESS_ZLIB: return zlib_alloc_workspace(fs_info, le=
vel);
>         case BTRFS_COMPRESS_LZO:  return lzo_alloc_workspace(fs_info);
>         case BTRFS_COMPRESS_ZSTD: return zstd_alloc_workspace(fs_info, le=
vel);
> -       default:
> -               /*
> -                * This can't happen, the type is validated several times
> -                * before we get here.
> -                */
> -               BUG();
>         }
> +       return ERR_PTR(-EUCLEAN);
>  }
>
>  static void free_workspace(int type, struct list_head *ws)
>  {
> +       ASSERT(type >=3D BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_=
TYPES);
>         switch (type) {
>         case BTRFS_COMPRESS_NONE: return free_heuristic_ws(ws);
>         case BTRFS_COMPRESS_ZLIB: return zlib_free_workspace(ws);
>         case BTRFS_COMPRESS_LZO:  return lzo_free_workspace(ws);
>         case BTRFS_COMPRESS_ZSTD: return zstd_free_workspace(ws);
> -       default:
> -               /*
> -                * This can't happen, the type is validated several times
> -                * before we get here.
> -                */
> -               BUG();
>         }
>  }
>
> @@ -792,7 +776,7 @@ struct list_head *btrfs_get_workspace(struct btrfs_fs=
_info *fs_info, int type, i
>         struct workspace_manager *wsm =3D fs_info->compr_wsm[type];
>         struct list_head *workspace;
>         int cpus =3D num_online_cpus();
> -       unsigned nofs_flag;
> +       unsigned int nofs_flag;
>         struct list_head *idle_ws;
>         spinlock_t *ws_lock;
>         atomic_t *total_ws;
> @@ -868,18 +852,14 @@ struct list_head *btrfs_get_workspace(struct btrfs_=
fs_info *fs_info, int type, i
>
>  static struct list_head *get_workspace(struct btrfs_fs_info *fs_info, in=
t type, int level)
>  {
> +       ASSERT(type >=3D BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_=
TYPES);
>         switch (type) {
>         case BTRFS_COMPRESS_NONE: return btrfs_get_workspace(fs_info, typ=
e, level);
>         case BTRFS_COMPRESS_ZLIB: return zlib_get_workspace(fs_info, leve=
l);
>         case BTRFS_COMPRESS_LZO:  return btrfs_get_workspace(fs_info, typ=
e, level);
>         case BTRFS_COMPRESS_ZSTD: return zstd_get_workspace(fs_info, leve=
l);
> -       default:
> -               /*
> -                * This can't happen, the type is validated several times
> -                * before we get here.
> -                */
> -               BUG();
>         }
> +       return ERR_PTR(-EUCLEAN);
>  }
>
>  /*
> @@ -919,17 +899,12 @@ void btrfs_put_workspace(struct btrfs_fs_info *fs_i=
nfo, int type, struct list_he
>
>  static void put_workspace(struct btrfs_fs_info *fs_info, int type, struc=
t list_head *ws)
>  {
> +       ASSERT(type >=3D BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_=
TYPES);
>         switch (type) {
>         case BTRFS_COMPRESS_NONE: return btrfs_put_workspace(fs_info, typ=
e, ws);
>         case BTRFS_COMPRESS_ZLIB: return btrfs_put_workspace(fs_info, typ=
e, ws);
>         case BTRFS_COMPRESS_LZO:  return btrfs_put_workspace(fs_info, typ=
e, ws);
>         case BTRFS_COMPRESS_ZSTD: return zstd_put_workspace(fs_info, ws);
> -       default:
> -               /*
> -                * This can't happen, the type is validated several times
> -                * before we get here.
> -                */
> -               BUG();
>         }
>  }
>
> @@ -1181,17 +1156,17 @@ static u64 file_offset_from_bvec(const struct bio=
_vec *bvec)
>   * @buf:               The decompressed data buffer
>   * @buf_len:           The decompressed data length
>   * @decompressed:      Number of bytes that are already decompressed ins=
ide the
> - *                     compressed extent
> + *                     compressed extent
>   * @cb:                        The compressed extent descriptor
>   * @orig_bio:          The original bio that the caller wants to read fo=
r
>   *
>   * An easier to understand graph is like below:
>   *
> - *             |<- orig_bio ->|     |<- orig_bio->|
> - *     |<-------      full decompressed extent      ----->|
> - *     |<-----------    @cb range   ---->|
> - *     |                       |<-- @buf_len -->|
> - *     |<--- @decompressed --->|
> + *             |<- orig_bio ->|     |<- orig_bio->|
> + *     |<-------      full decompressed extent      ----->|
> + *     |<-----------    @cb range   ---->|
> + *     |                       |<-- @buf_len -->|
> + *     |<--- @decompressed --->|
>   *
>   * Note that, @cb can be a subpage of the full decompressed extent, but
>   * @cb->start always has the same as the orig_file_offset value of the f=
ull
> @@ -1313,7 +1288,8 @@ static u32 shannon_entropy(struct heuristic_ws *ws)
>  #define RADIX_BASE             4U
>  #define COUNTERS_SIZE          (1U << RADIX_BASE)
>
> -static u8 get4bits(u64 num, int shift) {
> +static u8 get4bits(u64 num, int shift)
> +{
>         u8 low4bits;
>
>         num >>=3D shift;
> @@ -1388,7 +1364,7 @@ static void radix_sort(struct bucket_item *array, s=
truct bucket_item *array_buf,
>                  */
>                 memset(counters, 0, sizeof(counters));
>
> -               for (i =3D 0; i < num; i ++) {
> +               for (i =3D 0; i < num; i++) {
>                         buf_num =3D array_buf[i].count;
>                         addr =3D get4bits(buf_num, shift);
>                         counters[addr]++;
> --
> 2.53.0
>
>

