Return-Path: <linux-btrfs+bounces-13414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60B3A9C373
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4503B0E45
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AA9238157;
	Fri, 25 Apr 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA0LiQeT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27693237170
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573294; cv=none; b=V9/elSYad0jEqrZIXMp5sQ35hqXRI5tISiE3AE/xHscz8yfCx2umnHWICqAivPHlrmwij5CEwLjiSTmR/oNNcz0SIB4vNz4kj1jSxssIWtmITRWHpILF/HZc9Kz4fAjiX3xgIkGc4GImaEB25byuCEw1hDFxfzd/PYMu8XJI7SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573294; c=relaxed/simple;
	bh=ZOYyGxn17ZgXeVKpzjZ3J3/L4nea8+7zTb4E7B4a1rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZkyAx9rT/P5p0OOlwj75mKi1kLR8Fmd30m9aLxryIiUD1+TprsA6NMmCGjUcghUzCasG/YRDsaLcQlPCyWU58S4MzSUrnCdvUAQIX4N879AuccwWojDemBZ2bj2Q59B19YXcpsLC0EcbMyPVT3XvNgMUIvyYq+pl/pIffqg7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA0LiQeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CDBC4CEEF
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745573293;
	bh=ZOYyGxn17ZgXeVKpzjZ3J3/L4nea8+7zTb4E7B4a1rw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eA0LiQeTNLEdL2h5MobXNlz+7AaxYhn9E/nw75FUtkhXNZSt35kw5zkKe80UIVZPw
	 cmDU7wYy7cdQz2Z5BYz2KoT1xD4CzYsT1W2wnUO7ZWKMwBN2oIk8MZVMu98K/0fA0o
	 5TNLUOQ6/Q04wB/up+bv/a/bEh/zMKQL/xHn8iPxkB489KtdoFCFeAhL2g6tQ4okOS
	 IBJzo4tGrNRMNG6dqgcgz6cZIM5s3GF5qDU1+U/UEsK7pwYA5jL2HmoZhCKD9jks0F
	 /EBjnS6onJEkAhFQLtEAufABkDdF8Xg5FYn6OAwe8+CcPplj3j8+vTLLmx2KAYNb5n
	 2/cjXgc+7RZcQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso2557181a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 02:28:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YxyjpN2nkZjFUAerflxfqcu5f8EBbc2I6bsE3l1vaMqH7dZme1L
	tjstLMENIjr13AISAja26uPN7XduGZ+kK9TF5O+WkkBI9jrsLzrdyMwAno8eOzwCXoBqZoVF5Ws
	54YrZMHfaiG3HFpZ7RJ9m/ieOW7k=
X-Google-Smtp-Source: AGHT+IGNWoWVWus2wQRh79mIH5vj24A0JyiOJA1tMSfWpWKIoyZYs4gZViWF1yEmXdLGQJQ3Pqu79a8VkT81poBbtYA=
X-Received: by 2002:a17:907:7fa5:b0:acb:6853:e703 with SMTP id
 a640c23a62f3a-ace711242bcmr149275766b.26.1745573291746; Fri, 25 Apr 2025
 02:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745519463.git.josef@toxicpanda.com> <247b15d0ca0f5b5678c2c379f49b5f0766b00cde.1745519463.git.josef@toxicpanda.com>
In-Reply-To: <247b15d0ca0f5b5678c2c379f49b5f0766b00cde.1745519463.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 25 Apr 2025 10:27:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7ChrP_6TAdFmZTodSx4h++vw-6HqcZmU_stNB7Lh81Vw@mail.gmail.com>
X-Gm-Features: ATxdqUHwQ8iGPIgmoJUI6Xv0u6-bBCPyL-TyVSaVZzA3lAyg3oWT_ehW7fGK424
Message-ID: <CAL3q7H7ChrP_6TAdFmZTodSx4h++vw-6HqcZmU_stNB7Lh81Vw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] btrfs: use buffer radix for extent buffer
 writeback operations
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 7:34=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Currently we have this ugly back and forth with the btree writeback
> where we find the folio, find the eb associated with that folio, and
> then attempt to writeback.  This results in two different paths for
> subpage eb's and >=3D pagesize eb's.
>
> Clean this up by adding our own infrastructure around looking up tag'ed
> eb's and writing the eb's out directly.  This allows us to unify the
> subpage and >=3D pagesize IO paths, resulting in a much cleaner writeback
> path for extent buffers.
>
> I ran this through fsperf on a VM with 8 CPUs and 16gib of ram.  I used
> smallfiles100k, but reduced the files to 1k to make it run faster, the
> results are as follows, with the statistically significant improvements
> marked with *, there were no regressions.  fsperf was run with -n 10 for
> both runs, so the baseline is the average 10 runs and the test is the
> average of 10 runs.
>
> smallfiles100k results
>       metric           baseline       current        stdev            dif=
f
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> avg_commit_ms               68.58         58.44          3.35   -14.79% *
> commits                    270.60        254.70         16.24    -5.88%
> dev_read_iops                  48            48             0     0.00%
> dev_read_kbytes              1044          1044             0     0.00%
> dev_write_iops          866117.90     850028.10      14292.20    -1.86%
> dev_write_kbytes      10939976.40   10605701.20     351330.32    -3.06%
> elapsed                     49.30            33          1.64   -33.06% *
> end_state_mount_ns    41251498.80   35773220.70    2531205.32   -13.28% *
> end_state_umount_ns      1.90e+09      1.50e+09   14186226.85   -21.38% *
> max_commit_ms                 139        111.60          9.72   -19.71% *
> sys_cpu                      4.90          3.86          0.88   -21.29%
> write_bw_bytes        42935768.20   64318451.10    1609415.05    49.80% *
> write_clat_ns_mean      366431.69     243202.60      14161.98   -33.63% *
> write_clat_ns_p50        49203.20         20992        264.40   -57.34% *
> write_clat_ns_p99          827392     653721.60      65904.74   -20.99% *
> write_io_kbytes           2035940       2035940             0     0.00%
> write_iops               10482.37      15702.75        392.92    49.80% *
> write_lat_ns_max         1.01e+08      90516129    3910102.06   -10.29% *
> write_lat_ns_mean       366556.19     243308.48      14154.51   -33.62% *
>
> As you can see we get about a 33% decrease runtime, with a 50%
> throughput increase, which is pretty significant.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Btw, the subject still says "buffer radix", should be changed to
"buffer xarray" when added to for-next.

> ---
>  fs/btrfs/extent_io.c   | 339 ++++++++++++++++++++---------------------
>  fs/btrfs/extent_io.h   |   2 +
>  fs/btrfs/transaction.c |   5 +-
>  3 files changed, 169 insertions(+), 177 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 65a769329981..6082f37cfca3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1923,6 +1923,111 @@ static void buffer_tree_clear_mark(const struct e=
xtent_buffer *eb, xa_mark_t mar
>         xas_unlock_irqrestore(&xas, flags);
>  }
>
> +static void buffer_tree_tag_for_writeback(struct btrfs_fs_info *fs_info,
> +                                           unsigned long start, unsigned=
 long end)
> +{
> +       XA_STATE(xas, &fs_info->buffer_tree, start);
> +       unsigned int tagged =3D 0;
> +       void *eb;
> +
> +       xas_lock_irq(&xas);
> +       xas_for_each_marked(&xas, eb, end, PAGECACHE_TAG_DIRTY) {
> +               xas_set_mark(&xas, PAGECACHE_TAG_TOWRITE);
> +               if (++tagged % XA_CHECK_SCHED)
> +                       continue;
> +               xas_pause(&xas);
> +               xas_unlock_irq(&xas);
> +               cond_resched();
> +               xas_lock_irq(&xas);
> +       }
> +       xas_unlock_irq(&xas);
> +}
> +
> +struct eb_batch {
> +       unsigned int nr;
> +       unsigned int cur;
> +       struct extent_buffer *ebs[PAGEVEC_SIZE];
> +};
> +
> +static inline bool eb_batch_add(struct eb_batch *batch, struct extent_bu=
ffer *eb)
> +{
> +       batch->ebs[batch->nr++] =3D eb;
> +       return (batch->nr < PAGEVEC_SIZE);
> +}
> +
> +static inline void eb_batch_init(struct eb_batch *batch)
> +{
> +       batch->nr =3D 0;
> +       batch->cur =3D 0;
> +}
> +
> +static inline struct extent_buffer *eb_batch_next(struct eb_batch *batch=
)
> +{
> +       if (batch->cur >=3D batch->nr)
> +               return NULL;
> +       return batch->ebs[batch->cur++];
> +}
> +
> +static inline void eb_batch_release(struct eb_batch *batch)
> +{
> +       for (unsigned int i =3D 0; i < batch->nr; i++)
> +               free_extent_buffer(batch->ebs[i]);
> +       eb_batch_init(batch);
> +}
> +
> +static inline struct extent_buffer *find_get_eb(struct xa_state *xas, un=
signed long max,
> +                                               xa_mark_t mark)
> +{
> +       struct extent_buffer *eb;
> +
> +retry:
> +       eb =3D xas_find_marked(xas, max, mark);
> +
> +       if (xas_retry(xas, eb))
> +               goto retry;
> +
> +       if (!eb)
> +               return NULL;
> +
> +       if (!atomic_inc_not_zero(&eb->refs))
> +               goto reset;
> +
> +       if (unlikely(eb !=3D xas_reload(xas))) {
> +               free_extent_buffer(eb);
> +               goto reset;
> +       }
> +
> +       return eb;
> +reset:
> +       xas_reset(xas);
> +       goto retry;
> +}
> +
> +static unsigned int buffer_tree_get_ebs_tag(struct btrfs_fs_info *fs_inf=
o,
> +                                           unsigned long *start,
> +                                           unsigned long end, xa_mark_t =
tag,
> +                                           struct eb_batch *batch)
> +{
> +       XA_STATE(xas, &fs_info->buffer_tree, *start);
> +       struct extent_buffer *eb;
> +
> +       rcu_read_lock();
> +       while ((eb =3D find_get_eb(&xas, end, tag)) !=3D NULL) {
> +               if (!eb_batch_add(batch, eb)) {
> +                       *start =3D (eb->start + eb->len) >> fs_info->sect=
orsize_bits;
> +                       goto out;
> +               }
> +       }
> +       if (end =3D=3D ULONG_MAX)
> +               *start =3D ULONG_MAX;
> +       else
> +               *start =3D end + 1;
> +out:
> +       rcu_read_unlock();
> +
> +       return batch->nr;
> +}
> +
>  /*
>   * The endio specific version which won't touch any unsafe spinlock in e=
ndio
>   * context.
> @@ -2032,163 +2137,38 @@ static noinline_for_stack void write_one_eb(stru=
ct extent_buffer *eb,
>  }
>
>  /*
> - * Submit one subpage btree page.
> + * Wait for all eb writeback in the given range to finish.
>   *
> - * The main difference to submit_eb_page() is:
> - * - Page locking
> - *   For subpage, we don't rely on page locking at all.
> - *
> - * - Flush write bio
> - *   We only flush bio if we may be unable to fit current extent buffers=
 into
> - *   current bio.
> - *
> - * Return >=3D0 for the number of submitted extent buffers.
> - * Return <0 for fatal error.
> + * @fs_info:   The fs_info for this file system.
> + * @start:     The offset of the range to start waiting on writeback.
> + * @end:       The end of the range, inclusive. This is meant to be used=
 in
> + *             conjuction with wait_marked_extents, so this will usually=
 be
> + *             the_next_eb->start - 1.
>   */
> -static int submit_eb_subpage(struct folio *folio, struct writeback_contr=
ol *wbc)
> +void btrfs_btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64=
 start,
> +                                     u64 end)
>  {
> -       struct btrfs_fs_info *fs_info =3D folio_to_fs_info(folio);
> -       int submitted =3D 0;
> -       u64 folio_start =3D folio_pos(folio);
> -       int bit_start =3D 0;
> -       int sectors_per_node =3D fs_info->nodesize >> fs_info->sectorsize=
_bits;
> -       const unsigned int blocks_per_folio =3D btrfs_blocks_per_folio(fs=
_info, folio);
> +       struct eb_batch batch;
> +       unsigned long start_index =3D start >> fs_info->sectorsize_bits;
> +       unsigned long end_index =3D end >> fs_info->sectorsize_bits;
>
> -       /* Lock and write each dirty extent buffers in the range */
> -       while (bit_start < blocks_per_folio) {
> -               struct btrfs_subpage *subpage =3D folio_get_private(folio=
);
> +       eb_batch_init(&batch);
> +       while (start_index <=3D end_index) {
>                 struct extent_buffer *eb;
> -               unsigned long flags;
> -               u64 start;
> +               unsigned int nr_ebs;
>
> -               /*
> -                * Take private lock to ensure the subpage won't be detac=
hed
> -                * in the meantime.
> -                */
> -               spin_lock(&folio->mapping->i_private_lock);
> -               if (!folio_test_private(folio)) {
> -                       spin_unlock(&folio->mapping->i_private_lock);
> +               nr_ebs =3D buffer_tree_get_ebs_tag(fs_info, &start_index,
> +                                                end_index,
> +                                                PAGECACHE_TAG_WRITEBACK,
> +                                                &batch);
> +               if (!nr_ebs)
>                         break;
> -               }
> -               spin_lock_irqsave(&subpage->lock, flags);
> -               if (!test_bit(bit_start + btrfs_bitmap_nr_dirty * blocks_=
per_folio,
> -                             subpage->bitmaps)) {
> -                       spin_unlock_irqrestore(&subpage->lock, flags);
> -                       spin_unlock(&folio->mapping->i_private_lock);
> -                       bit_start +=3D sectors_per_node;
> -                       continue;
> -               }
>
> -               start =3D folio_start + bit_start * fs_info->sectorsize;
> -               bit_start +=3D sectors_per_node;
> -
> -               /*
> -                * Here we just want to grab the eb without touching extr=
a
> -                * spin locks, so call find_extent_buffer_nolock().
> -                */
> -               eb =3D find_extent_buffer_nolock(fs_info, start);
> -               spin_unlock_irqrestore(&subpage->lock, flags);
> -               spin_unlock(&folio->mapping->i_private_lock);
> -
> -               /*
> -                * The eb has already reached 0 refs thus find_extent_buf=
fer()
> -                * doesn't return it. We don't need to write back such eb
> -                * anyway.
> -                */
> -               if (!eb)
> -                       continue;
> -
> -               if (lock_extent_buffer_for_io(eb, wbc)) {
> -                       write_one_eb(eb, wbc);
> -                       submitted++;
> -               }
> -               free_extent_buffer(eb);
> +               while ((eb =3D eb_batch_next(&batch)) !=3D NULL)
> +                       wait_on_extent_buffer_writeback(eb);
> +               eb_batch_release(&batch);
> +               cond_resched();
>         }
> -       return submitted;
> -}
> -
> -/*
> - * Submit all page(s) of one extent buffer.
> - *
> - * @page:      the page of one extent buffer
> - * @eb_context:        to determine if we need to submit this page, if c=
urrent page
> - *             belongs to this eb, we don't need to submit
> - *
> - * The caller should pass each page in their bytenr order, and here we u=
se
> - * @eb_context to determine if we have submitted pages of one extent buf=
fer.
> - *
> - * If we have, we just skip until we hit a new page that doesn't belong =
to
> - * current @eb_context.
> - *
> - * If not, we submit all the page(s) of the extent buffer.
> - *
> - * Return >0 if we have submitted the extent buffer successfully.
> - * Return 0 if we don't need to submit the page, as it's already submitt=
ed by
> - * previous call.
> - * Return <0 for fatal error.
> - */
> -static int submit_eb_page(struct folio *folio, struct btrfs_eb_write_con=
text *ctx)
> -{
> -       struct writeback_control *wbc =3D ctx->wbc;
> -       struct address_space *mapping =3D folio->mapping;
> -       struct extent_buffer *eb;
> -       int ret;
> -
> -       if (!folio_test_private(folio))
> -               return 0;
> -
> -       if (btrfs_meta_is_subpage(folio_to_fs_info(folio)))
> -               return submit_eb_subpage(folio, wbc);
> -
> -       spin_lock(&mapping->i_private_lock);
> -       if (!folio_test_private(folio)) {
> -               spin_unlock(&mapping->i_private_lock);
> -               return 0;
> -       }
> -
> -       eb =3D folio_get_private(folio);
> -
> -       /*
> -        * Shouldn't happen and normally this would be a BUG_ON but no po=
int
> -        * crashing the machine for something we can survive anyway.
> -        */
> -       if (WARN_ON(!eb)) {
> -               spin_unlock(&mapping->i_private_lock);
> -               return 0;
> -       }
> -
> -       if (eb =3D=3D ctx->eb) {
> -               spin_unlock(&mapping->i_private_lock);
> -               return 0;
> -       }
> -       ret =3D atomic_inc_not_zero(&eb->refs);
> -       spin_unlock(&mapping->i_private_lock);
> -       if (!ret)
> -               return 0;
> -
> -       ctx->eb =3D eb;
> -
> -       ret =3D btrfs_check_meta_write_pointer(eb->fs_info, ctx);
> -       if (ret) {
> -               if (ret =3D=3D -EBUSY)
> -                       ret =3D 0;
> -               free_extent_buffer(eb);
> -               return ret;
> -       }
> -
> -       if (!lock_extent_buffer_for_io(eb, wbc)) {
> -               free_extent_buffer(eb);
> -               return 0;
> -       }
> -       /* Implies write in zoned mode. */
> -       if (ctx->zoned_bg) {
> -               /* Mark the last eb in the block group. */
> -               btrfs_schedule_zone_finish_bg(ctx->zoned_bg, eb);
> -               ctx->zoned_bg->meta_write_pointer +=3D eb->len;
> -       }
> -       write_one_eb(eb, wbc);
> -       free_extent_buffer(eb);
> -       return 1;
>  }
>
>  int btree_write_cache_pages(struct address_space *mapping,
> @@ -2199,25 +2179,27 @@ int btree_write_cache_pages(struct address_space =
*mapping,
>         int ret =3D 0;
>         int done =3D 0;
>         int nr_to_write_done =3D 0;
> -       struct folio_batch fbatch;
> -       unsigned int nr_folios;
> -       pgoff_t index;
> -       pgoff_t end;            /* Inclusive */
> +       struct eb_batch batch;
> +       unsigned int nr_ebs;
> +       unsigned long index;
> +       unsigned long end;
>         int scanned =3D 0;
>         xa_mark_t tag;
>
> -       folio_batch_init(&fbatch);
> +       eb_batch_init(&batch);
>         if (wbc->range_cyclic) {
> -               index =3D mapping->writeback_index; /* Start from prev of=
fset */
> +               index =3D (mapping->writeback_index << PAGE_SHIFT) >> fs_=
info->sectorsize_bits;
>                 end =3D -1;
> +
>                 /*
>                  * Start from the beginning does not need to cycle over t=
he
>                  * range, mark it as scanned.
>                  */
>                 scanned =3D (index =3D=3D 0);
>         } else {
> -               index =3D wbc->range_start >> PAGE_SHIFT;
> -               end =3D wbc->range_end >> PAGE_SHIFT;
> +               index =3D wbc->range_start >> fs_info->sectorsize_bits;
> +               end =3D wbc->range_end >> fs_info->sectorsize_bits;
> +
>                 scanned =3D 1;
>         }
>         if (wbc->sync_mode =3D=3D WB_SYNC_ALL)
> @@ -2227,31 +2209,40 @@ int btree_write_cache_pages(struct address_space =
*mapping,
>         btrfs_zoned_meta_io_lock(fs_info);
>  retry:
>         if (wbc->sync_mode =3D=3D WB_SYNC_ALL)
> -               tag_pages_for_writeback(mapping, index, end);
> +               buffer_tree_tag_for_writeback(fs_info, index, end);
>         while (!done && !nr_to_write_done && (index <=3D end) &&
> -              (nr_folios =3D filemap_get_folios_tag(mapping, &index, end=
,
> -                                           tag, &fbatch))) {
> -               unsigned i;
> +              (nr_ebs =3D buffer_tree_get_ebs_tag(fs_info, &index, end, =
tag,
> +                                                &batch))) {
> +               struct extent_buffer *eb;
>
> -               for (i =3D 0; i < nr_folios; i++) {
> -                       struct folio *folio =3D fbatch.folios[i];
> +               while ((eb =3D eb_batch_next(&batch)) !=3D NULL) {
> +                       ctx.eb =3D eb;
>
> -                       ret =3D submit_eb_page(folio, &ctx);
> -                       if (ret =3D=3D 0)
> +                       ret =3D btrfs_check_meta_write_pointer(eb->fs_inf=
o, &ctx);
> +                       if (ret) {
> +                               if (ret =3D=3D -EBUSY)
> +                                       ret =3D 0;
> +                               if (ret) {
> +                                       done =3D 1;
> +                                       break;
> +                               }
> +                               free_extent_buffer(eb);
>                                 continue;
> -                       if (ret < 0) {
> -                               done =3D 1;
> -                               break;
>                         }
>
> -                       /*
> -                        * the filesystem may choose to bump up nr_to_wri=
te.
> -                        * We have to make sure to honor the new nr_to_wr=
ite
> -                        * at any time
> -                        */
> -                       nr_to_write_done =3D wbc->nr_to_write <=3D 0;
> +                       if (!lock_extent_buffer_for_io(eb, wbc))
> +                               continue;
> +
> +                       /* Implies write in zoned mode. */
> +                       if (ctx.zoned_bg) {
> +                               /* Mark the last eb in the block group. *=
/
> +                               btrfs_schedule_zone_finish_bg(ctx.zoned_b=
g, eb);
> +                               ctx.zoned_bg->meta_write_pointer +=3D eb-=
>len;
> +                       }
> +                       write_one_eb(eb, wbc);
>                 }
> -               folio_batch_release(&fbatch);
> +               nr_to_write_done =3D wbc->nr_to_write <=3D 0;
> +               eb_batch_release(&batch);
>                 cond_resched();
>         }
>         if (!scanned && !done) {
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index b344162f790c..b7c1cd0b3c20 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -240,6 +240,8 @@ void extent_write_locked_range(struct inode *inode, c=
onst struct folio *locked_f
>  int btrfs_writepages(struct address_space *mapping, struct writeback_con=
trol *wbc);
>  int btree_write_cache_pages(struct address_space *mapping,
>                             struct writeback_control *wbc);
> +void btrfs_btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64=
 start,
> +                                     u64 end);
>  void btrfs_readahead(struct readahead_control *rac);
>  int set_folio_extent_mapped(struct folio *folio);
>  void clear_folio_extent_mapped(struct folio *folio);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 39e48bf610a1..a538a85ac2bd 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1155,7 +1155,7 @@ int btrfs_write_marked_extents(struct btrfs_fs_info=
 *fs_info,
>                 if (!ret)
>                         ret =3D filemap_fdatawrite_range(mapping, start, =
end);
>                 if (!ret && wait_writeback)
> -                       ret =3D filemap_fdatawait_range(mapping, start, e=
nd);
> +                       btrfs_btree_wait_writeback_range(fs_info, start, =
end);
>                 btrfs_free_extent_state(cached_state);
>                 if (ret)
>                         break;
> @@ -1175,7 +1175,6 @@ int btrfs_write_marked_extents(struct btrfs_fs_info=
 *fs_info,
>  static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
>                                        struct extent_io_tree *dirty_pages=
)
>  {
> -       struct address_space *mapping =3D fs_info->btree_inode->i_mapping=
;
>         struct extent_state *cached_state =3D NULL;
>         u64 start =3D 0;
>         u64 end;
> @@ -1196,7 +1195,7 @@ static int __btrfs_wait_marked_extents(struct btrfs=
_fs_info *fs_info,
>                 if (ret =3D=3D -ENOMEM)
>                         ret =3D 0;
>                 if (!ret)
> -                       ret =3D filemap_fdatawait_range(mapping, start, e=
nd);
> +                       btrfs_btree_wait_writeback_range(fs_info, start, =
end);
>                 btrfs_free_extent_state(cached_state);
>                 if (ret)
>                         break;
> --
> 2.48.1
>
>

