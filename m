Return-Path: <linux-btrfs+bounces-13788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458ECAAE1A1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E599C2221
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08E2882A3;
	Wed,  7 May 2025 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="egwjU/Y3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0F27A92D
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625866; cv=none; b=HYOvQVn6COX7OioRED/e216qbd6LvUhcZXRAzqDkxjWFg+Bac1+Dz5sswwkioDyYUwPVZp1I3UK3FJZlzpQIMxyNgBVf0qNTn1eBeyOLaJNl69OprqhLT5LskdvqATGZ6fMHx9Zq9of5/KNRNTGNQrhBGHYDOfqOB/NaE68GYFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625866; c=relaxed/simple;
	bh=MJdqHZ6Ph0hO04XXvzacSH+mVoqf8AzmDTAdrkIJhuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhdvx44WzA09auph+Xamb1xijCOJ0v6HfsIIYzu/ckdmmf+RuqlTjyZWiX9WV7BSrYbYo8lRE1ya4ooCsp3gvVWhqw37Q+ckbp3MMefnCegkSZ8JQeWzzIk7efz9inRzKaOKtDB690AuI4txtpZcPL6aIEvp1wYekxFAWECww2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=egwjU/Y3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac34257295dso436353466b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 07 May 2025 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746625862; x=1747230662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jkDlzTNJcfu8/SgGqeShgytF6E+52sll1JcqF7OHz2Q=;
        b=egwjU/Y3r//kLvHT+y1eHSaXe+iQBT0sOsXgyuMuegM2L7Iz7chosmXf6uFUseS5Dt
         86ZSRFmzbAzPlAVfMKJIgmreI1D67mG+kD4XUPHMaNP7HVBkkMTnzzaWNjd0GG/a3h5p
         g6rpleuB+6DJE72LjNQdnYY7bOnXBQ3SDWsdUdrZe3peHdnnqdPTH2ZVbhOC9sCFUYfz
         wrH0CUiTGsB7o8G5rq/qX+4UYn0PES6fk68hbKWKUqCld1benpyApZNVUJNvrP2fXDJr
         zDUHlLZuYM1dTLRZIckaXVbJofNZaDB/SiSA0bDUQD2pAdJfktEHrNoH9p90L6DDmKd+
         FYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625862; x=1747230662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkDlzTNJcfu8/SgGqeShgytF6E+52sll1JcqF7OHz2Q=;
        b=KMk6jWR2FdNn1arL0gq6RoFYuvm1DCQX9MCtzbzRLsujefY3tC+PberrVVy2c7dqDs
         3rasxcX+XNSduGWr9y+p7CrNU/1eRE+XbGZf1gpALMA9KlU0+Vp9rhSLxoqt4JkEGeZa
         XUOuDxRZxqykcnpF4F8K6dhtcUX7/N4Lp1Afcqn402HIS+qJRdX69KWW9uWa+zvpQ1ak
         TP4HO38JizFKLYCjFWAXAGsdMg1UXt1SXG6sMgCoq0Yjn+eLYNBj6PcsviIAfyQrkwCu
         jLB0BR3K2rjHaFslIS0aNCG/Pa98sx/9fzK2WhKiG6YXhyjYsV+dlHqj40HmsyrBewgi
         IDWw==
X-Gm-Message-State: AOJu0YwroSeluBsRjEeBGpdUeZuontJyfptUgNxnXlaj5q2kig0y1CXQ
	4tkMpuewbS06NPq76VsJBACI21vEyfUwz+uSaEl7CDXwg6DJ/psZn/vSfvh7jFMV+ht1M/vF81P
	rELP+wBqdlVF2km/4pSLG0n+AmGkMtiiszr0bJkkuDR3DaIr3lB8=
X-Gm-Gg: ASbGnct2pgR+rbEmSDiznCEB6EBzS91nPD8+8N3XuE8tkrs152PWicEHOVNXNmz8Efy
	Z8jIMZIGT3NY+2Gv0j4QXTZ5sCACOrvGYEcM8VnEWDM7psgsdRdp3ChnclYMfFcQsbEMMgdp5E/
	2nK0pPRW1V8gFNwP69irXh
X-Google-Smtp-Source: AGHT+IFZ8akDUwd68g46gjqKgRAd1iJewjnxW2UeWeMOyTQUKIqWT9TmxcNTLMButALpj4XH3bxGfWsccT6fIfW1hh0=
X-Received: by 2002:a17:907:6ea6:b0:ace:c518:1327 with SMTP id
 a640c23a62f3a-ad1e8bc2504mr282527266b.14.1746625861777; Wed, 07 May 2025
 06:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422155541.296808-1-dsterba@suse.com>
In-Reply-To: <20250422155541.296808-1-dsterba@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 7 May 2025 15:50:51 +0200
X-Gm-Features: ATxdqUGbx7L8yh8Qk668iLEwwuyDijMfpRi2WPdfSFH9HK8--2EIItXBp8hAD1k
Message-ID: <CAPjX3FcGAUqheUg0TQHG_yvuQExjT3N3SUGRYtk1S3b3aDVZZQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use unsigned types for constants defined as bit shifts
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 17:55, David Sterba <dsterba@suse.com> wrote:
>
> The unsigned type is a recommended practice (CWE-190, CWE-194) for bit
> shifts to avoid problems with potential unwanted sign extensions.
> Although there are no such cases in btrfs codebase, follow the
> recommendation.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/backref.h               |  4 ++--
>  fs/btrfs/direct-io.c             |  4 ++--
>  fs/btrfs/extent_io.h             |  2 +-
>  fs/btrfs/inode.c                 | 12 ++++++------
>  fs/btrfs/ordered-data.c          |  4 ++--
>  fs/btrfs/raid56.c                |  5 ++---
>  fs/btrfs/tests/extent-io-tests.c |  6 +++---
>  fs/btrfs/zstd.c                  |  2 +-
>  8 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 74e6140312747f..953637115956b9 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -423,8 +423,8 @@ struct btrfs_backref_node *btrfs_backref_alloc_node(
>  struct btrfs_backref_edge *btrfs_backref_alloc_edge(
>                 struct btrfs_backref_cache *cache);
>
> -#define                LINK_LOWER      (1 << 0)
> -#define                LINK_UPPER      (1 << 1)
> +#define                LINK_LOWER      (1U << 0)
> +#define                LINK_UPPER      (1U << 1)
>
>  void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
>                              struct btrfs_backref_node *lower,
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 3a03142dee099b..fde612d9b077e3 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -151,8 +151,8 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
>         }
>
>         ordered = btrfs_alloc_ordered_extent(inode, start, file_extent,
> -                                            (1 << type) |
> -                                            (1 << BTRFS_ORDERED_DIRECT));
> +                                            (1U << type) |
> +                                            (1U << BTRFS_ORDERED_DIRECT));
>         if (IS_ERR(ordered)) {
>                 if (em) {
>                         btrfs_free_extent_map(em);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index bcdb067da06d1e..b677006ab14ee6 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -67,7 +67,7 @@ enum {
>   *    single word in a bitmap may straddle two pages in the extent buffer.
>   */
>  #define BIT_BYTE(nr) ((nr) / BITS_PER_BYTE)
> -#define BYTE_MASK ((1 << BITS_PER_BYTE) - 1)
> +#define BYTE_MASK ((1U << BITS_PER_BYTE) - 1)
>  #define BITMAP_FIRST_BYTE_MASK(start) \
>         ((BYTE_MASK << ((start) & (BITS_PER_BYTE - 1))) & BYTE_MASK)
>  #define BITMAP_LAST_BYTE_MASK(nbits) \
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 652db811e5cabd..73ef9b9b2b2cd3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1151,7 +1151,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
>         btrfs_free_extent_map(em);
>
>         ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
> -                                            1 << BTRFS_ORDERED_COMPRESSED);
> +                                            1U << BTRFS_ORDERED_COMPRESSED);
>         if (IS_ERR(ordered)) {
>                 btrfs_drop_extent_map_range(inode, start, end, false);
>                 ret = PTR_ERR(ordered);
> @@ -1396,7 +1396,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>                 btrfs_free_extent_map(em);
>
>                 ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
> -                                                    1 << BTRFS_ORDERED_REGULAR);
> +                                                    1U << BTRFS_ORDERED_REGULAR);
>                 if (IS_ERR(ordered)) {
>                         btrfs_unlock_extent(&inode->io_tree, start,
>                                             start + cur_alloc_size - 1, &cached);
> @@ -1976,8 +1976,8 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
>
>         ordered = btrfs_alloc_ordered_extent(inode, file_pos, &nocow_args->file_extent,
>                                              is_prealloc
> -                                            ? (1 << BTRFS_ORDERED_PREALLOC)
> -                                            : (1 << BTRFS_ORDERED_NOCOW));
> +                                            ? (1U << BTRFS_ORDERED_PREALLOC)
> +                                            : (1U << BTRFS_ORDERED_NOCOW));
>         if (IS_ERR(ordered)) {
>                 if (is_prealloc)
>                         btrfs_drop_extent_map_range(inode, file_pos, end, false);
> @@ -9688,8 +9688,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>         btrfs_free_extent_map(em);
>
>         ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
> -                                      (1 << BTRFS_ORDERED_ENCODED) |
> -                                      (1 << BTRFS_ORDERED_COMPRESSED));
> +                                      (1U << BTRFS_ORDERED_ENCODED) |
> +                                      (1U << BTRFS_ORDERED_COMPRESSED));
>         if (IS_ERR(ordered)) {
>                 btrfs_drop_extent_map_range(inode, start, end, false);
>                 ret = PTR_ERR(ordered);
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index b5b544712e93a3..6151d32704d2da 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -155,7 +155,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
>         u64 qgroup_rsv = 0;
>
>         if (flags &
> -           ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
> +           ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC))) {
>                 /* For nocow write, we can release the qgroup rsv right now */
>                 ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
>                 if (ret < 0)
> @@ -253,7 +253,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
>   * @disk_bytenr:     Offset of extent on disk.
>   * @disk_num_bytes:  Size of extent on disk.
>   * @offset:          Offset into unencoded data where file data starts.
> - * @flags:           Flags specifying type of extent (1 << BTRFS_ORDERED_*).
> + * @flags:           Flags specifying type of extent (1U << BTRFS_ORDERED_*).
>   * @compress_type:   Compression algorithm used for data.
>   *
>   * Most of these parameters correspond to &struct btrfs_file_extent_item. The
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 4657517f5480b7..06670e987f92f8 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -203,8 +203,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
>         struct btrfs_stripe_hash_table *x;
>         struct btrfs_stripe_hash *cur;
>         struct btrfs_stripe_hash *h;
> -       int num_entries = 1 << BTRFS_STRIPE_HASH_TABLE_BITS;
> -       int i;
> +       unsigned int num_entries = 1U << BTRFS_STRIPE_HASH_TABLE_BITS;

This one does not really make much sense. It is an isolated local thing.

>         if (info->stripe_hash_table)
>                 return 0;
> @@ -225,7 +224,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
>
>         h = table->table;
>
> -       for (i = 0; i < num_entries; i++) {
> +       for (unsigned int i = 0; i < num_entries; i++) {

I'd just do:

for (int i = 0; i < 1 << BTRFS_STRIPE_HASH_TABLE_BITS; i++) {

The compiler will resolve the shift and the loop will compare to the
immediate constant value.

---

Quite honestly the whole patch is questionable. The recommendations
are about right shifts. Left shifts are not prone to any sinedness
issues.

What is more important is where the constants are being used. They
should honor the type they are compared with or assigned to. Like for
example 0x80ULL for flags as these are usually declared unsigned long
long, and so on...

For example the LINK_LOWER is converted to int when used as
btrfs_backref_link_edge(..., LINK_LOWER) parameter and then another
LINK_LOWER is and-ed to that int argument. I know, the logical
operations are not really influenced by the signedness, but still.

And btw, the LINK_UPPER is not used at all anywhere in the code, if I
see correctly.

---

In theory the situation could be even worse at some places as
incorrectly using an unsigned constant may force a signed variable to
get promoted to unsigned one to match. This may result in an int
variable with the value of -1 ending up as UINT_MAX instead. And now
imagine if(i < (1U << 4)) where int i = -1;

I did not check all the places where the constants you are changing
are being used, but it looks scary.

>                 cur = h + i;
>                 INIT_LIST_HEAD(&cur->hash_list);
>                 spin_lock_init(&cur->lock);
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
> index b603563bd20986..d6aff41c38b165 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -14,9 +14,9 @@
>  #include "../disk-io.h"
>  #include "../btrfs_inode.h"
>
> -#define PROCESS_UNLOCK         (1 << 0)
> -#define PROCESS_RELEASE                (1 << 1)
> -#define PROCESS_TEST_LOCKED    (1 << 2)
> +#define PROCESS_UNLOCK         (1U << 0)
> +#define PROCESS_RELEASE                (1U << 1)
> +#define PROCESS_TEST_LOCKED    (1U << 2)
>
>  static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
>                                        unsigned long flags)
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 75efca4da194c6..4a796a049b5a24 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -24,7 +24,7 @@
>  #include "super.h"
>
>  #define ZSTD_BTRFS_MAX_WINDOWLOG 17
> -#define ZSTD_BTRFS_MAX_INPUT (1 << ZSTD_BTRFS_MAX_WINDOWLOG)
> +#define ZSTD_BTRFS_MAX_INPUT (1U << ZSTD_BTRFS_MAX_WINDOWLOG)
>  #define ZSTD_BTRFS_DEFAULT_LEVEL 3
>  #define ZSTD_BTRFS_MIN_LEVEL -15
>  #define ZSTD_BTRFS_MAX_LEVEL 15
> --
> 2.49.0
>
>

