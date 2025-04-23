Return-Path: <linux-btrfs+bounces-13335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B24A99470
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03B81BC3C4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2CE28EA43;
	Wed, 23 Apr 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1dMW8zu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F9264A94
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424050; cv=none; b=emeCM/sDr4tmQGrAEuL3/2Orkj/mKKggMeQIuyttsQ7CfBy3L2WSXlZt5TfyruriFiiUbjjv83UBouaqgMciVurGaKywfBgJ/nnujVQgqfWcA3X4/qrSr962xMbYXXehJADfIH2zPf8mv/v6Aqh7dDDZjlk09mSdM/PWMVxRBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424050; c=relaxed/simple;
	bh=I/1F2D1xvlw4rTy5Rj41rA7XjJA7MM7RkjJU7KafH3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2deBOvwS7NesOe6h02JRGcgrpjUan8wcU7YvJ14LoaGWjdqUkX38tY9PcNf/Umt8o5RZRVLe2LsSucG1OEyKX6XH/eRRFkBD+akGinTp8/sMrWT4kArU+h7iXUpdyYuGb3doRZw3QIJvqjn/ZTtaD1Ih+atox8S2Ep0qGW6AS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1dMW8zu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC564C4CEEA
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745424050;
	bh=I/1F2D1xvlw4rTy5Rj41rA7XjJA7MM7RkjJU7KafH3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l1dMW8zuvTD+tnA1B+AfpOfJFDAIwnNLL9OOPcvldPZydJvINaspuQHjfn/De6sen
	 w9zOx95iEpJQ1snnRkZ22RHRkmFBPt8ofO/QPeQLq5Pdt3y2b7Za5b20SDr2kKJsgx
	 Iy4YPaoNBLYdPf/pGtvgFmuGCr3rhDXERSwYmslnlOTPDYbnj53jn0t3s7VnKwtuyA
	 PiIMT2c7GBTJ+lhsNJMT8JaQuXW21F+R/Lu6a9MfelIKN6dt70rdcmNKq0o2IA+IZe
	 2kbjIJ6eSYR681HKLAwGjIuGRcK7vOMfoXLfNLoMn69Kh4X23p3J2mlK28oDz/r4om
	 fyIJmc+ea/aeA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so6066466b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 09:00:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YwUfBUCJAWi/yc+b/Lou9mszBBxIb4jilviOyLvegkB+uaDiJ1F
	n+r+8w8CC+nmO8zONPqJNIej7JLRYTlefCwViQ4Ur43/6V5QxYEOMdcCvYT7X4S11gwTbfQsWS3
	3UMNufqVpaykD4zP4hk0uvS1YP68=
X-Google-Smtp-Source: AGHT+IFQ3wGzSiNylEsmr8R7kZzEWsaXKNh0YB9pVEOqX5Jnsp6zacp9dykjaBm4ghZupZqnnAFcfBASg22S5iJVHJE=
X-Received: by 2002:a17:906:c10f:b0:ac6:f6e2:7703 with SMTP id
 a640c23a62f3a-acb74ad2854mr1639677766b.8.1745424048359; Wed, 23 Apr 2025
 09:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744984487.git.josef@toxicpanda.com> <cd0f8b9b2ab02a3c0a5fc30596cc5f2b9c7ea349.1744984487.git.josef@toxicpanda.com>
In-Reply-To: <cd0f8b9b2ab02a3c0a5fc30596cc5f2b9c7ea349.1744984487.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 23 Apr 2025 17:00:11 +0100
X-Gmail-Original-Message-ID: <CAL3q7H64_fPGY6M9oOLY6E_HGKQDKANUTqJHz6PzXOw3H206eQ@mail.gmail.com>
X-Gm-Features: ATxdqUHZqXdNir_mvNi9yUYd4PUw0apEvjt8cbcGzUvgrDorA8U_d-cMj41TuhI
Message-ID: <CAL3q7H64_fPGY6M9oOLY6E_HGKQDKANUTqJHz6PzXOw3H206eQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] btrfs: use buffer radix for extent buffer
 writeback operations
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 2:58=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
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
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c   | 344 ++++++++++++++++++++---------------------
>  fs/btrfs/extent_io.h   |   1 +
>  fs/btrfs/transaction.c |   5 +-
>  3 files changed, 173 insertions(+), 177 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ef6df7bcef5d..080409e068e9 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1926,6 +1926,117 @@ static void buffer_tree_clear_mark(const struct e=
xtent_buffer *eb,
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
> +static inline bool eb_batch_add(struct eb_batch *batch,
> +                              struct extent_buffer *eb)

No need for line splitting.

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
> +static inline unsigned int eb_batch_count(struct eb_batch *batch)
> +{
> +       return batch->nr;
> +}

Since this is so simple and it's not a kernel library we can get rid
of this helper and just check ->nr directly.

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
> +       if (end =3D=3D (unsigned long)-1)
> +               *start =3D (unsigned long)-1;

ULONG_MAX

> +       else
> +               *start =3D end + 1;
> +out:
> +       rcu_read_unlock();
> +
> +       return eb_batch_count(batch);
> +}
> +
>  /*
>   * The endio specific version which won't touch any unsafe spinlock in e=
ndio
>   * context.
> @@ -2031,163 +2142,37 @@ static noinline_for_stack void write_one_eb(stru=
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
> + * @fs_info:   the fs_info for this file system
> + * @start:     the offset of the range to start waiting on writeback
> + * @end:       the end of the range, inclusive. This is meant to be used=
 in
> + *             conjuction with wait_marked_extents, so this will usually=
 be
> + *             the_next_eb->start - 1.

Can we make all sentences start with a capitalized word and end with
punctuation?
Some are, others not, and it's mixed.

>   */
> -static int submit_eb_subpage(struct folio *folio, struct writeback_contr=
ol *wbc)
> +void btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start=
, u64 end)

Exported functions should have a "btrfs_" prefix.

With those minor things:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

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
> @@ -2198,25 +2183,27 @@ int btree_write_cache_pages(struct address_space =
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
> @@ -2226,31 +2213,40 @@ int btree_write_cache_pages(struct address_space =
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
> index b344162f790c..4f0cf5b0d38f 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -240,6 +240,7 @@ void extent_write_locked_range(struct inode *inode, c=
onst struct folio *locked_f
>  int btrfs_writepages(struct address_space *mapping, struct writeback_con=
trol *wbc);
>  int btree_write_cache_pages(struct address_space *mapping,
>                             struct writeback_control *wbc);
> +void btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start=
, u64 end);
>  void btrfs_readahead(struct readahead_control *rac);
>  int set_folio_extent_mapped(struct folio *folio);
>  void clear_folio_extent_mapped(struct folio *folio);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 39e48bf610a1..b72ac8b70e0e 100644
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
> +                       btree_wait_writeback_range(fs_info, start, end);
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
> +                       btree_wait_writeback_range(fs_info, start, end);
>                 btrfs_free_extent_state(cached_state);
>                 if (ret)
>                         break;
> --
> 2.48.1
>
>

