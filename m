Return-Path: <linux-btrfs+bounces-13535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04360AA44D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018B5461DED
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB207FBA2;
	Wed, 30 Apr 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksWUpvTt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413E1EB19B;
	Wed, 30 Apr 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000392; cv=none; b=b8pCWND3OPdjYhOqojm2vFtec99fMr3uQTBtkT2dcdiDN1gLipVECXzeenQQuNh19c6dDyHwCnLChXjQI72imPDNEuVgjzncrie8MenihyglPPyybmAloILIuo3rNiTk+3F2MYsOCB5MRNs6r5z1FtlmUrAR8MD2fDQEBo4JfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000392; c=relaxed/simple;
	bh=d+xqyJGxPPMubpz50pJok3NYN1wJ3D+cCsQr6KyI5eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgCN+Y44b5rq31yPFPfckutnwcDonPPE8HyYA8Z500NP9ndbjcBe3F6KBLZhsJcM9HZ+lKvJkybOB/xOdbAf8z3HdIfvgJt6zM5kwbHIo9f9AUJpgp3VySQEEsYOPXUfkWQ8ghjEcWv2jJUNtffoE1bXJ8R9sRPPC+RXiCMkr0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksWUpvTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868FCC4CEEA;
	Wed, 30 Apr 2025 08:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746000391;
	bh=d+xqyJGxPPMubpz50pJok3NYN1wJ3D+cCsQr6KyI5eg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ksWUpvTtiEVKwETQ0O1U7Mf8SyN/gjeB7dN8z5Wvm6c+DPRiZhuR3aSknlYkMwLMt
	 GPx54nBHp3u7Pm4ws1KRQ7raj9qcvOnVfvsAiUYdIpqOwKVQ54GCqxo0Khe+cOkGaR
	 F1A2iSp9E5wX+5ULo52/MahMX814ZsuY/JweKcMWewAmDbrBjrc0EOWjmXmVldN6p/
	 PvyuHFgLJk2mB2qrNK1s2CB0Ur/rvEot1WXfYweXSQYOwnAlMpo5+u/j5pV3bp4jke
	 xDgGOZ9MFntZwdHCqwu+B3mVOvBrBMXSnVqOsdQxV+88ff2eDHAIspIFqk9urerVdi
	 JMqDtk4QZ7PHw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac34257295dso1173095766b.2;
        Wed, 30 Apr 2025 01:06:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzoEZrA+T6kXyVurZy/l/5rWysnAbppocy8/WoDOvyOBhEcisU3/blXNmDAwJsTPoIXcblrBKVGWZw+KT1@vger.kernel.org, AJvYcCVBF41eM50UGxiso/LppJ0KIiUBDGi7uttr/eR7Us80upbst+uas0ia81blwhnUixhxf0HFthCbjaYETw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzTbbCVwxicdAXYtlxNjPqB1TVLAIQeD1HFLH13ypcuIhAMRAN
	0spXbU6hhZZTah16wNX4242SQQGu8ZI3JByKhxgvyXMBMYjW/Rvg6qxM6UxK4X0PcvQKOjY3awn
	SnTaHdlXZKSHYf0cOEm6FaJe/Hhw=
X-Google-Smtp-Source: AGHT+IGeCTblzu4hgGHcXsa8l8TTLynW1R9ju534Sha5BCVUWpAb44ae2/DP+jplREtMnahXcyPHWd0adi4c7qotlH8=
X-Received: by 2002:a17:907:948c:b0:ace:6bfb:372a with SMTP id
 a640c23a62f3a-acedc79e7b4mr252811266b.54.1746000389778; Wed, 30 Apr 2025
 01:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com>
In-Reply-To: <20250429151800.649010-1-neelx@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 30 Apr 2025 09:05:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7WPE+26v1uCKa5C=BwcGpUN3OjnaPUkexPGD=mpJbkSA@mail.gmail.com>
X-Gm-Features: ATxdqUHdxshEunLvRHVLiye9e77yQIpqQF9WP1cabiWv6CFtDUGPsvvw_-GzMUE
Message-ID: <CAL3q7H7WPE+26v1uCKa5C=BwcGpUN3OjnaPUkexPGD=mpJbkSA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 4:19=E2=80=AFPM Daniel Vacek <neelx@suse.com> wrote=
:
>
> Even super block nowadays uses nodesize for eb->len. This is since commit=
s
>
> 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
> da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into =
fs_info")
> ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
> a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree_=
block")
>
> With these the eb->len is not really useful anymore. Let's use the nodesi=
ze
> directly where applicable.
>
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> [RFC]
>  * Shall the eb_len() helper better be called eb_nodesize()? Or even rath=
er
>    opencoded and not used at all?
>
>  fs/btrfs/accessors.c             |  4 +--
>  fs/btrfs/disk-io.c               | 11 ++++---
>  fs/btrfs/extent-tree.c           | 28 +++++++++--------
>  fs/btrfs/extent_io.c             | 54 ++++++++++++++------------------
>  fs/btrfs/extent_io.h             | 11 +++++--
>  fs/btrfs/ioctl.c                 |  2 +-
>  fs/btrfs/relocation.c            |  2 +-
>  fs/btrfs/subpage.c               |  8 ++---
>  fs/btrfs/tests/extent-io-tests.c | 12 +++----
>  fs/btrfs/zoned.c                 |  2 +-
>  10 files changed, 67 insertions(+), 67 deletions(-)
>
> diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> index e3716516ca387..a2bdbc7990906 100644
> --- a/fs/btrfs/accessors.c
> +++ b/fs/btrfs/accessors.c
> @@ -14,10 +14,10 @@ static bool check_setget_bounds(const struct extent_b=
uffer *eb,
>  {
>         const unsigned long member_offset =3D (unsigned long)ptr + off;
>
> -       if (unlikely(member_offset + size > eb->len)) {
> +       if (unlikely(member_offset + size > eb_len(eb))) {
>                 btrfs_warn(eb->fs_info,
>                 "bad eb member %s: ptr 0x%lx start %llu member offset %lu=
 size %d",
> -                       (member_offset > eb->len ? "start" : "end"),
> +                       (member_offset > eb_len(eb) ? "start" : "end"),
>                         (unsigned long)ptr, eb->start, member_offset, siz=
e);
>                 return false;
>         }
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3592300ae3e2e..31eb7419fe11f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -190,7 +190,7 @@ static int btrfs_repair_eb_io_failure(const struct ex=
tent_buffer *eb,
>         for (int i =3D 0; i < num_extent_folios(eb); i++) {
>                 struct folio *folio =3D eb->folios[i];
>                 u64 start =3D max_t(u64, eb->start, folio_pos(folio));
> -               u64 end =3D min_t(u64, eb->start + eb->len,
> +               u64 end =3D min_t(u64, eb->start + fs_info->nodesize,
>                                 folio_pos(folio) + eb->folio_size);
>                 u32 len =3D end - start;
>                 phys_addr_t paddr =3D PFN_PHYS(folio_pfn(folio)) +
> @@ -230,7 +230,7 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb=
,
>                         break;
>
>                 num_copies =3D btrfs_num_copies(fs_info,
> -                                             eb->start, eb->len);
> +                                             eb->start, fs_info->nodesiz=
e);
>                 if (num_copies =3D=3D 1)
>                         break;
>
> @@ -260,6 +260,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbi=
o)
>  {
>         struct extent_buffer *eb =3D bbio->private;
>         struct btrfs_fs_info *fs_info =3D eb->fs_info;
> +       u32 nodesize =3D fs_info->nodesize;
>         u64 found_start =3D btrfs_header_bytenr(eb);
>         u64 last_trans;
>         u8 result[BTRFS_CSUM_SIZE];
> @@ -268,7 +269,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbi=
o)
>         /* Btree blocks are always contiguous on disk. */
>         if (WARN_ON_ONCE(bbio->file_offset !=3D eb->start))
>                 return BLK_STS_IOERR;
> -       if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size !=3D eb->len))
> +       if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size !=3D nodesize))
>                 return BLK_STS_IOERR;
>
>         /*
> @@ -277,7 +278,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbi=
o)
>          * ordering of I/O without unnecessarily writing out data.
>          */
>         if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
> -               memzero_extent_buffer(eb, 0, eb->len);
> +               memzero_extent_buffer(eb, 0, nodesize);
>                 return BLK_STS_OK;
>         }
>
> @@ -883,7 +884,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_tra=
ns_handle *trans,
>         btrfs_set_root_generation(&root->root_item, trans->transid);
>         btrfs_set_root_level(&root->root_item, 0);
>         btrfs_set_root_refs(&root->root_item, 1);
> -       btrfs_set_root_used(&root->root_item, leaf->len);
> +       btrfs_set_root_used(&root->root_item, fs_info->nodesize);
>         btrfs_set_root_last_snapshot(&root->root_item, 0);
>         btrfs_set_root_dirid(&root->root_item, 0);
>         if (is_fstree(objectid))
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index e0811a86d0cbd..25560a162d93e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2211,7 +2211,7 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_=
handle *trans,
>         extent_op->update_flags =3D true;
>         extent_op->update_key =3D false;
>
> -       ret =3D btrfs_add_delayed_extent_op(trans, eb->start, eb->len,
> +       ret =3D btrfs_add_delayed_extent_op(trans, eb->start, eb_len(eb),
>                                           btrfs_header_level(eb), extent_=
op);
>         if (ret)
>                 btrfs_free_delayed_extent_op(extent_op);
> @@ -2660,10 +2660,10 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_=
trans_handle *trans,
>         if (ret)
>                 goto out;
>
> -       pin_down_extent(trans, cache, eb->start, eb->len, 0);
> +       pin_down_extent(trans, cache, eb->start, eb_len(eb), 0);
>
>         /* remove us from the free space cache (if we're there at all) */
> -       ret =3D btrfs_remove_free_space(cache, eb->start, eb->len);
> +       ret =3D btrfs_remove_free_space(cache, eb->start, eb_len(eb));
>  out:
>         btrfs_put_block_group(cache);
>         return ret;
> @@ -3436,13 +3436,14 @@ int btrfs_free_tree_block(struct btrfs_trans_hand=
le *trans,
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_block_group *bg;
> +       u32 nodesize =3D fs_info->nodesize;
>         int ret;
>
>         if (root_id !=3D BTRFS_TREE_LOG_OBJECTID) {
>                 struct btrfs_ref generic_ref =3D {
>                         .action =3D BTRFS_DROP_DELAYED_REF,
>                         .bytenr =3D buf->start,
> -                       .num_bytes =3D buf->len,
> +                       .num_bytes =3D nodesize,
>                         .parent =3D parent,
>                         .owning_root =3D btrfs_header_owner(buf),
>                         .ref_root =3D root_id,
> @@ -3478,7 +3479,7 @@ int btrfs_free_tree_block(struct btrfs_trans_handle=
 *trans,
>         bg =3D btrfs_lookup_block_group(fs_info, buf->start);
>
>         if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> -               pin_down_extent(trans, bg, buf->start, buf->len, 1);
> +               pin_down_extent(trans, bg, buf->start, nodesize, 1);
>                 btrfs_put_block_group(bg);
>                 goto out;
>         }
> @@ -3502,17 +3503,17 @@ int btrfs_free_tree_block(struct btrfs_trans_hand=
le *trans,
>
>         if (test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags)
>                      || btrfs_is_zoned(fs_info)) {
> -               pin_down_extent(trans, bg, buf->start, buf->len, 1);
> +               pin_down_extent(trans, bg, buf->start, nodesize, 1);
>                 btrfs_put_block_group(bg);
>                 goto out;
>         }
>
>         WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
>
> -       btrfs_add_free_space(bg, buf->start, buf->len);
> -       btrfs_free_reserved_bytes(bg, buf->len, 0);
> +       btrfs_add_free_space(bg, buf->start, nodesize);
> +       btrfs_free_reserved_bytes(bg, nodesize, 0);
>         btrfs_put_block_group(bg);
> -       trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
> +       trace_btrfs_reserved_extent_free(fs_info, buf->start, nodesize);
>
>  out:
>         return 0;
> @@ -4768,7 +4769,7 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_ha=
ndle *trans,
>                 return -ENOSPC;
>         }
>
> -       ret =3D pin_down_extent(trans, cache, eb->start, eb->len, 1);
> +       ret =3D pin_down_extent(trans, cache, eb->start, eb_len(eb), 1);
>         btrfs_put_block_group(cache);
>         return ret;
>  }
> @@ -5050,6 +5051,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct extent_buffer *buf;
>         u64 lockdep_owner =3D owner;
> +       u32 nodesize =3D fs_info->nodesize;
>
>         buf =3D btrfs_find_create_tree_block(fs_info, bytenr, owner, leve=
l);
>         if (IS_ERR(buf))
> @@ -5107,16 +5109,16 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *=
trans, struct btrfs_root *root,
>                  */
>                 if (buf->log_index =3D=3D 0)
>                         btrfs_set_extent_bit(&root->dirty_log_pages, buf-=
>start,
> -                                            buf->start + buf->len - 1,
> +                                            buf->start + nodesize - 1,
>                                              EXTENT_DIRTY, NULL);
>                 else
>                         btrfs_set_extent_bit(&root->dirty_log_pages, buf-=
>start,
> -                                            buf->start + buf->len - 1,
> +                                            buf->start + nodesize - 1,
>                                              EXTENT_NEW, NULL);
>         } else {
>                 buf->log_index =3D -1;
>                 btrfs_set_extent_bit(&trans->transaction->dirty_pages, bu=
f->start,
> -                                    buf->start + buf->len - 1, EXTENT_DI=
RTY, NULL);
> +                                    buf->start + nodesize - 1, EXTENT_DI=
RTY, NULL);
>         }
>         /* this returns a buffer locked for blocking */
>         return buf;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 20cdddd924852..e4050fd5db285 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -76,8 +76,8 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_=
fs_info *fs_info)
>                 eb =3D list_first_entry(&fs_info->allocated_ebs,
>                                       struct extent_buffer, leak_list);
>                 pr_err(
> -       "BTRFS: buffer leak start %llu len %u refs %d bflags %lu owner %l=
lu\n",
> -                      eb->start, eb->len, atomic_read(&eb->refs), eb->bf=
lags,
> +       "BTRFS: buffer leak start %llu refs %d bflags %lu owner %llu\n",
> +                      eb->start, atomic_read(&eb->refs), eb->bflags,
>                        btrfs_header_owner(eb));
>                 list_del(&eb->leak_list);
>                 WARN_ON_ONCE(1);
> @@ -1746,8 +1746,8 @@ static noinline_for_stack bool lock_extent_buffer_f=
or_io(struct extent_buffer *e
>
>                 btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
>                 percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> -                                        -eb->len,
> -                                        fs_info->dirty_metadata_batch);
> +                                        -fs_info->nodesize,
> +                                         fs_info->dirty_metadata_batch);
>                 ret =3D true;
>         } else {
>                 spin_unlock(&eb->refs_lock);
> @@ -1953,7 +1953,7 @@ static unsigned int buffer_tree_get_ebs_tag(struct =
btrfs_fs_info *fs_info,
>         rcu_read_lock();
>         while ((eb =3D find_get_eb(&xas, end, tag)) !=3D NULL) {
>                 if (!eb_batch_add(batch, eb)) {
> -                       *start =3D (eb->start + eb->len) >> fs_info->sect=
orsize_bits;
> +                       *start =3D (eb->start + fs_info->nodesize) >> fs_=
info->sectorsize_bits;
>                         goto out;
>                 }
>         }
> @@ -2020,7 +2020,7 @@ static void prepare_eb_write(struct extent_buffer *=
eb)
>         nritems =3D btrfs_header_nritems(eb);
>         if (btrfs_header_level(eb) > 0) {
>                 end =3D btrfs_node_key_ptr_offset(eb, nritems);
> -               memzero_extent_buffer(eb, end, eb->len - end);
> +               memzero_extent_buffer(eb, end, eb_len(eb) - end);
>         } else {
>                 /*
>                  * Leaf:
> @@ -2056,7 +2056,7 @@ static noinline_for_stack void write_one_eb(struct =
extent_buffer *eb,
>                 struct folio *folio =3D eb->folios[i];
>                 u64 range_start =3D max_t(u64, eb->start, folio_pos(folio=
));
>                 u32 range_len =3D min_t(u64, folio_pos(folio) + folio_siz=
e(folio),
> -                                     eb->start + eb->len) - range_start;
> +                                     eb->start + fs_info->nodesize) - ra=
nge_start;
>
>                 folio_lock(folio);
>                 btrfs_meta_folio_clear_dirty(folio, eb);
> @@ -2171,7 +2171,7 @@ int btree_write_cache_pages(struct address_space *m=
apping,
>                         if (ctx.zoned_bg) {
>                                 /* Mark the last eb in the block group. *=
/
>                                 btrfs_schedule_zone_finish_bg(ctx.zoned_b=
g, eb);
> -                               ctx.zoned_bg->meta_write_pointer +=3D eb-=
>len;
> +                               ctx.zoned_bg->meta_write_pointer +=3D fs_=
info->nodesize;
>                         }
>                         write_one_eb(eb, wbc);
>                 }
> @@ -2807,7 +2807,6 @@ static struct extent_buffer *__alloc_extent_buffer(=
struct btrfs_fs_info *fs_info
>
>         eb =3D kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFA=
IL);
>         eb->start =3D start;
> -       eb->len =3D fs_info->nodesize;
>         eb->fs_info =3D fs_info;
>         init_rwsem(&eb->lock);
>
> @@ -2816,8 +2815,6 @@ static struct extent_buffer *__alloc_extent_buffer(=
struct btrfs_fs_info *fs_info
>         spin_lock_init(&eb->refs_lock);
>         atomic_set(&eb->refs, 1);
>
> -       ASSERT(eb->len <=3D BTRFS_MAX_METADATA_BLOCKSIZE);
> -
>         return eb;
>  }
>
> @@ -3505,7 +3502,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_ha=
ndle *trans,
>                 return;
>
>         buffer_tree_clear_mark(eb, PAGECACHE_TAG_DIRTY);
> -       percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len=
,
> +       percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -fs_info=
->nodesize,
>                                  fs_info->dirty_metadata_batch);
>
>         for (int i =3D 0; i < num_extent_folios(eb); i++) {
> @@ -3557,8 +3554,8 @@ void set_extent_buffer_dirty(struct extent_buffer *=
eb)
>                 if (subpage)
>                         folio_unlock(eb->folios[0]);
>                 percpu_counter_add_batch(&eb->fs_info->dirty_metadata_byt=
es,
> -                                        eb->len,
> -                                        eb->fs_info->dirty_metadata_batc=
h);
> +                                         eb_len(eb),
> +                                         eb->fs_info->dirty_metadata_bat=
ch);
>         }
>  #ifdef CONFIG_BTRFS_DEBUG
>         for (int i =3D 0; i < num_extent_folios(eb); i++)
> @@ -3670,7 +3667,7 @@ int read_extent_buffer_pages_nowait(struct extent_b=
uffer *eb, int mirror_num,
>                 struct folio *folio =3D eb->folios[i];
>                 u64 range_start =3D max_t(u64, eb->start, folio_pos(folio=
));
>                 u32 range_len =3D min_t(u64, folio_pos(folio) + folio_siz=
e(folio),
> -                                     eb->start + eb->len) - range_start;
> +                                     eb->start + eb_len(eb)) - range_sta=
rt;
>
>                 bio_add_folio_nofail(&bbio->bio, folio, range_len,
>                                      offset_in_folio(folio, range_start))=
;
> @@ -3698,8 +3695,8 @@ static bool report_eb_range(const struct extent_buf=
fer *eb, unsigned long start,
>                             unsigned long len)
>  {
>         btrfs_warn(eb->fs_info,
> -               "access to eb bytenr %llu len %u out of range start %lu l=
en %lu",
> -               eb->start, eb->len, start, len);
> +               "access to eb bytenr %llu out of range start %lu len %lu"=
,
> +               eb->start, start, len);
>         DEBUG_WARN();
>
>         return true;
> @@ -3717,8 +3714,8 @@ static inline int check_eb_range(const struct exten=
t_buffer *eb,
>  {
>         unsigned long offset;
>
> -       /* start, start + len should not go beyond eb->len nor overflow *=
/
> -       if (unlikely(check_add_overflow(start, len, &offset) || offset > =
eb->len))
> +       /* start, start + len should not go beyond nodesize nor overflow =
*/
> +       if (unlikely(check_add_overflow(start, len, &offset) || offset > =
eb_len(eb)))
>                 return report_eb_range(eb, start, len);
>
>         return false;
> @@ -3774,8 +3771,8 @@ int read_extent_buffer_to_user_nofault(const struct=
 extent_buffer *eb,
>         unsigned long i =3D get_eb_folio_index(eb, start);
>         int ret =3D 0;
>
> -       WARN_ON(start > eb->len);
> -       WARN_ON(start + len > eb->start + eb->len);
> +       WARN_ON(start > eb_len(eb));
> +       WARN_ON(start + len > eb->start + eb_len(eb));
>
>         if (eb->addr) {
>                 if (copy_to_user_nofault(dstv, eb->addr + start, len))
> @@ -3866,8 +3863,8 @@ static void assert_eb_folio_uptodate(const struct e=
xtent_buffer *eb, int i)
>                 folio =3D eb->folios[0];
>                 ASSERT(i =3D=3D 0);
>                 if (WARN_ON(!btrfs_subpage_test_uptodate(fs_info, folio,
> -                                                        eb->start, eb->l=
en)))
> -                       btrfs_subpage_dump_bitmap(fs_info, folio, eb->sta=
rt, eb->len);
> +                                                        eb->start, fs_in=
fo->nodesize)))
> +                       btrfs_subpage_dump_bitmap(fs_info, folio, eb->sta=
rt, fs_info->nodesize);
>         } else {
>                 WARN_ON(!folio_test_uptodate(folio));
>         }
> @@ -3960,12 +3957,10 @@ void copy_extent_buffer_full(const struct extent_=
buffer *dst,
>         const int unit_size =3D src->folio_size;
>         unsigned long cur =3D 0;
>
> -       ASSERT(dst->len =3D=3D src->len);
> -
> -       while (cur < src->len) {
> +       while (cur < eb_len(src)) {
>                 unsigned long index =3D get_eb_folio_index(src, cur);
>                 unsigned long offset =3D get_eb_offset_in_folio(src, cur)=
;
> -               unsigned long cur_len =3D min(src->len, unit_size - offse=
t);
> +               unsigned long cur_len =3D min(eb_len(src), unit_size - of=
fset);
>                 void *addr =3D folio_address(src->folios[index]) + offset=
;
>
>                 write_extent_buffer(dst, addr, cur, cur_len);
> @@ -3980,7 +3975,6 @@ void copy_extent_buffer(const struct extent_buffer =
*dst,
>                         unsigned long len)
>  {
>         const int unit_size =3D dst->folio_size;
> -       u64 dst_len =3D dst->len;
>         size_t cur;
>         size_t offset;
>         char *kaddr;
> @@ -3990,8 +3984,6 @@ void copy_extent_buffer(const struct extent_buffer =
*dst,
>             check_eb_range(src, src_offset, len))
>                 return;
>
> -       WARN_ON(src->len !=3D dst_len);
> -
>         offset =3D get_eb_offset_in_folio(dst, dst_offset);
>
>         while (len > 0) {
> @@ -4266,7 +4258,7 @@ static int try_release_subpage_extent_buffer(struct=
 folio *folio)
>                         xa_unlock_irq(&fs_info->buffer_tree);
>                         break;
>                 }
> -               cur =3D eb->start + eb->len;
> +               cur =3D eb->start + fs_info->nodesize;
>
>                 /*
>                  * The same as try_release_extent_buffer(), to ensure the=
 eb
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 1415679d7f88c..9a842eea47d6d 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -16,6 +16,7 @@
>  #include "messages.h"
>  #include "ulist.h"
>  #include "misc.h"
> +#include "fs.h"
>
>  struct page;
>  struct file;
> @@ -80,7 +81,6 @@ void __cold extent_buffer_free_cachep(void);
>  #define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / P=
AGE_SIZE)
>  struct extent_buffer {
>         u64 start;
> -       u32 len;
>         u32 folio_size;
>         unsigned long bflags;
>         struct btrfs_fs_info *fs_info;
> @@ -263,17 +263,22 @@ void btrfs_readahead_tree_block(struct btrfs_fs_inf=
o *fs_info,
>                                 u64 bytenr, u64 owner_root, u64 gen, int =
level);
>  void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
>
> +static inline u32 eb_len(const struct extent_buffer *eb)
> +{
> +       return eb->fs_info->nodesize;
> +}

Please always add a "btrfs_" prefix to the name of exported functions.

In this case I don't think adding this helper adds any value.
We can just do eb->fs_info->nodesize everywhere and in some places we
already have fs_info in a local variable and can just do
fs_info->nodesize.

Thanks.

> +
>  /* Note: this can be used in for loops without caching the value in a va=
riable. */
>  static inline int __pure num_extent_pages(const struct extent_buffer *eb=
)
>  {
>         /*
>          * For sectorsize =3D=3D PAGE_SIZE case, since nodesize is always=
 aligned to
> -        * sectorsize, it's just eb->len >> PAGE_SHIFT.
> +        * sectorsize, it's just nodesize >> PAGE_SHIFT.
>          *
>          * For sectorsize < PAGE_SIZE case, we could have nodesize < PAGE=
_SIZE,
>          * thus have to ensure we get at least one page.
>          */
> -       return (eb->len >> PAGE_SHIFT) ?: 1;
> +       return (eb_len(eb) >> PAGE_SHIFT) ?: 1;
>  }
>
>  /*
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 68fac77fb95d1..6be2d56d44917 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -598,7 +598,7 @@ static noinline int create_subvol(struct mnt_idmap *i=
dmap,
>         btrfs_set_root_generation(root_item, trans->transid);
>         btrfs_set_root_level(root_item, 0);
>         btrfs_set_root_refs(root_item, 1);
> -       btrfs_set_root_used(root_item, leaf->len);
> +       btrfs_set_root_used(root_item, fs_info->nodesize);
>         btrfs_set_root_last_snapshot(root_item, 0);
>
>         btrfs_set_root_generation_v2(root_item,
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 6287e71ebad5f..5086485a4ae21 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4352,7 +4352,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle=
 *trans,
>                         mark_block_processed(rc, node);
>
>                 if (first_cow && level > 0)
> -                       rc->nodes_relocated +=3D buf->len;
> +                       rc->nodes_relocated +=3D fs_info->nodesize;
>         }
>
>         if (level =3D=3D 0 && first_cow && rc->stage =3D=3D UPDATE_DATA_P=
TRS)
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index d4f0192334936..711792f32e9ce 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -631,7 +631,7 @@ void btrfs_meta_folio_set_##name(struct folio *folio,=
 const struct extent_buffer
>                 folio_set_func(folio);                                  \
>                 return;                                                 \
>         }                                                               \
> -       btrfs_subpage_set_##name(eb->fs_info, folio, eb->start, eb->len);=
 \
> +       btrfs_subpage_set_##name(eb->fs_info, folio, eb->start, eb_len(eb=
)); \
>  }                                                                      \
>  void btrfs_meta_folio_clear_##name(struct folio *folio, const struct ext=
ent_buffer *eb) \
>  {                                                                      \
> @@ -639,13 +639,13 @@ void btrfs_meta_folio_clear_##name(struct folio *fo=
lio, const struct extent_buff
>                 folio_clear_func(folio);                                \
>                 return;                                                 \
>         }                                                               \
> -       btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start, eb->len=
); \
> +       btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start, eb_len(=
eb)); \
>  }                                                                      \
>  bool btrfs_meta_folio_test_##name(struct folio *folio, const struct exte=
nt_buffer *eb) \
>  {                                                                      \
>         if (!btrfs_meta_is_subpage(eb->fs_info))                        \
>                 return folio_test_func(folio);                          \
> -       return btrfs_subpage_test_##name(eb->fs_info, folio, eb->start, e=
b->len); \
> +       return btrfs_subpage_test_##name(eb->fs_info, folio, eb->start, e=
b_len(eb)); \
>  }
>  IMPLEMENT_BTRFS_PAGE_OPS(uptodate, folio_mark_uptodate, folio_clear_upto=
date,
>                          folio_test_uptodate);
> @@ -765,7 +765,7 @@ bool btrfs_meta_folio_clear_and_test_dirty(struct fol=
io *folio, const struct ext
>                 return true;
>         }
>
> -       last =3D btrfs_subpage_clear_and_test_dirty(eb->fs_info, folio, e=
b->start, eb->len);
> +       last =3D btrfs_subpage_clear_and_test_dirty(eb->fs_info, folio, e=
b->start, eb_len(eb));
>         if (last) {
>                 folio_clear_dirty_for_io(folio);
>                 return true;
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-=
tests.c
> index 00da54f0164c9..657f8f1d9263e 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -342,7 +342,7 @@ static int check_eb_bitmap(unsigned long *bitmap, str=
uct extent_buffer *eb)
>  {
>         unsigned long i;
>
> -       for (i =3D 0; i < eb->len * BITS_PER_BYTE; i++) {
> +       for (i =3D 0; i < eb_len(eb) * BITS_PER_BYTE; i++) {
>                 int bit, bit1;
>
>                 bit =3D !!test_bit(i, bitmap);
> @@ -411,7 +411,7 @@ static int test_bitmap_clear(const char *name, unsign=
ed long *bitmap,
>  static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer=
 *eb)
>  {
>         unsigned long i, j;
> -       unsigned long byte_len =3D eb->len;
> +       unsigned long byte_len =3D eb_len(eb);
>         u32 x;
>         int ret;
>
> @@ -670,7 +670,7 @@ static int test_find_first_clear_extent_bit(void)
>  static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *=
memory,
>                                         const char *test_name)
>  {
> -       for (int i =3D 0; i < eb->len; i++) {
> +       for (int i =3D 0; i < eb_len(eb); i++) {
>                 struct page *page =3D folio_page(eb->folios[i >> PAGE_SHI=
FT], 0);
>                 void *addr =3D page_address(page) + offset_in_page(i);
>
> @@ -686,7 +686,7 @@ static void dump_eb_and_memory_contents(struct extent=
_buffer *eb, void *memory,
>  static int verify_eb_and_memory(struct extent_buffer *eb, void *memory,
>                                 const char *test_name)
>  {
> -       for (int i =3D 0; i < (eb->len >> PAGE_SHIFT); i++) {
> +       for (int i =3D 0; i < (eb_len(eb) >> PAGE_SHIFT); i++) {
>                 void *eb_addr =3D folio_address(eb->folios[i]);
>
>                 if (memcmp(memory + (i << PAGE_SHIFT), eb_addr, PAGE_SIZE=
) !=3D 0) {
> @@ -703,8 +703,8 @@ static int verify_eb_and_memory(struct extent_buffer =
*eb, void *memory,
>   */
>  static void init_eb_and_memory(struct extent_buffer *eb, void *memory)
>  {
> -       get_random_bytes(memory, eb->len);
> -       write_extent_buffer(eb, memory, 0, eb->len);
> +       get_random_bytes(memory, eb_len(eb));
> +       write_extent_buffer(eb, memory, 0, eb_len(eb));
>  }
>
>  static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 9d42bf2bfd746..c7a8cdd87c509 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2422,7 +2422,7 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_blo=
ck_group *bg,
>                                    struct extent_buffer *eb)
>  {
>         if (!test_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &bg->runtime_flag=
s) ||
> -           eb->start + eb->len * 2 <=3D bg->start + bg->zone_capacity)
> +           eb->start + eb_len(eb) * 2 <=3D bg->start + bg->zone_capacity=
)
>                 return;
>
>         if (WARN_ON(bg->zone_finish_work.func =3D=3D btrfs_zone_finish_en=
dio_workfn)) {
> --
> 2.47.2
>
>

