Return-Path: <linux-btrfs+bounces-13848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C961AB0DB7
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 10:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C583BBDD0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE3627464B;
	Fri,  9 May 2025 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kcb9stFm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398B32686A9
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780220; cv=none; b=NFU0Pc12HaqF9qu7W78cYek4Xdy/D6466I0TzQFegQYHb9k7xwx29Jv9Y3oYqgqappPKDD3mHIQHmZs9whQ/3/2Yu9j83UuM4UVEzkElVEAsgEkwUFenivEmz07oK4DYWviXqmdU+Qnjpan3IitDFwcJQy4uXNoDinav8n6NbBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780220; c=relaxed/simple;
	bh=OCmFt1z4OtgAniDvvoyfkRSztfZJFp00gVRUIHGVfiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjvYeBEdZ4NsZ3hcsCoDsmupmqEc3azTJJBAcUifQ9FPIIY57dQFpni8TOFL/ujbh1B+0Y+J74Ko2ks+tsVVfaG0/60GYJYd8kcHZ4mDrbXpInrEepZX/62YMpXNLQvY5c6CAUod2VBbQ0J3vRAN+PBODIEly2yaDszT7AsJ0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kcb9stFm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb2faa9f55so234207366b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 May 2025 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746780216; x=1747385016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CJBkY8p6voQWJX+yU5XgV6cVxjoMK1rR2Ic+zVsJTEA=;
        b=Kcb9stFmPgWKS2UmlYzz8d5lkRUhCKvVYc2vPMZ6edpkY1Z5DeV0VwQpCZ/ikmKr8Z
         wYX3jShwDQ1FjLzqMgRyjy2I6dWqns1WVo8b/QOmYvIlMPsD116Xd5Nfqh7Af1Gd9fn3
         gNPVimIvjTo1Le+WwbKoCESkt98uuxwFeMaeu3mQ6+XFJhK7coWB/ecMSWal7OkqX/C8
         zd+RArMd3dhwFomZYlEq30f6W6krfR2HXvk6we3BDuk5caQCTLUSOa56CeqMNwIImC3q
         NPxCJkzQttGMByUwsBI1fkYkn0kMxS9DoAwmZ10ce8WlWigbHlStKWARvow/uOUwTb3C
         GPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746780216; x=1747385016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJBkY8p6voQWJX+yU5XgV6cVxjoMK1rR2Ic+zVsJTEA=;
        b=uBa8Yr/IlecNDj+IUHD/1v4VSShEgXpfr7RinnC7vxuzNTxQGij4e1z1N7aqI4Fawk
         Nun5E3SxjRCsJxFT0NYzRzqYkF+mWQhnktYDxvt2MIN971G3YE8+tZPvLJuiNl2giw3o
         HvqzoXl2PZjnp5X8ELfXL1dNJUg9n6B+2ZDwgaJQPJ6Sl/X1JgKcqUmuKZ3Mwm20SBkV
         RspF9FSTPAXHAK3PtqqyoNhHDPF1zz1VVt/aLSqNNsdFo+YNqg66g9HU8+9ik9EhZy0I
         i6t248ENwNp0Mpz/QPzRcuj7ETUQDyJ6djkdRXoFxptGONx6bGriN6fneuaH7/CN2sge
         yTPQ==
X-Gm-Message-State: AOJu0YxZrWSpw1HUL0kyHRl5+uzWMNm7oKbyBGp0KtWElD6OKUQXMW5F
	RzCqyIqv5Yuv6VY/04ti8oAiC/fH29dC+35AyArKLJuW4RutOrw46bHhCKQf+nmV6rg99NL0P6k
	FU4UAzA/Y+i5+mi7Slv0OG06TdBY+L73Mfb3aPhHci4qHlfaEYBZe4Q==
X-Gm-Gg: ASbGncsubLuSW9k9BKWrxHN6RRDSYEOq4PZCiC4ai9gOQ7mCWHpug9NwFJi2+CrXzWy
	3Drh/IKurjx2bNDkVyPi+3QgOC8CGSQnjujkHnc4EpdiqrObNzVwI6ixiGTaztrWtH81BrLrEI+
	eNaJ0ztWDhyksyU7km+Zyzf4MJQLMFWupPRyDxLzxkfHCYJDorHPnYSVzN
X-Google-Smtp-Source: AGHT+IElHqMxYX17g30yYHfHX5DQOpgYIMrdcj82IeCyZRALj73Do9vRobG6Y4KxitSsnareO34hhsGqyKERMauxjZ8=
X-Received: by 2002:a17:907:3f91:b0:ac7:805f:905a with SMTP id
 a640c23a62f3a-ad218fa14cdmr240024366b.28.1746780216321; Fri, 09 May 2025
 01:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422155541.296808-1-dsterba@suse.com>
In-Reply-To: <20250422155541.296808-1-dsterba@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 9 May 2025 10:43:25 +0200
X-Gm-Features: ATxdqUHbUYFANdhjcVvDUtfSs8BAe8smsWWdvE31tstjs42NcHr9YPLYGL4Hh2M
Message-ID: <CAPjX3FfmCV=jV3AdJiLkPPo3ZnOG=V35cUeuUHM_0dfyrfs9DQ@mail.gmail.com>
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

With this maybe you also want

--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3164,7 +3164,7 @@ void btrfs_backref_release_cache(struct
btrfs_backref_cache *cache)
 void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
                             struct btrfs_backref_node *lower,
                             struct btrfs_backref_node *upper,
-                            int link_which)
+                            unsigned int link_which)
 {
        ASSERT(upper && lower && upper->level == lower->level + 1);
        edge->node[LOWER] = lower;

Otherwise you changed it to unsigned which gets converted back to
signed again. Ie., the change does not make much sense. The end result
is (int)(1U << 0).

And as mentioned before, the LINK_UPPER may be removed.

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

Technically these should be 1ul but this will get implicitly promoted.
Luckily we're using no more than 13 bits so far so no bit is lost.

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

1UL

>         if (IS_ERR(ordered)) {
>                 btrfs_drop_extent_map_range(inode, start, end, false);
>                 ret = PTR_ERR(ordered);
> @@ -1396,7 +1396,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>                 btrfs_free_extent_map(em);
>
>                 ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
> -                                                    1 << BTRFS_ORDERED_REGULAR);
> +                                                    1U << BTRFS_ORDERED_REGULAR);

and again

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

same

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

same

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

same

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
>
>         if (info->stripe_hash_table)
>                 return 0;
> @@ -225,7 +224,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
>
>         h = table->table;
>
> -       for (i = 0; i < num_entries; i++) {
> +       for (unsigned int i = 0; i < num_entries; i++) {
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

same

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

This one is being used in place of size_t, so technically it should
also be 1UL. But also, 17 bits happily fit into uint here.

Anyways, all these 1ULs are not a big deal. Having 1U is just fine. So
sorry about the noise.

To wrap it up, it's just the btrfs_backref_link_edge() prototype being
fishy and LINK_UPPER being useless. The rest is OK.

>  #define ZSTD_BTRFS_DEFAULT_LEVEL 3
>  #define ZSTD_BTRFS_MIN_LEVEL -15
>  #define ZSTD_BTRFS_MAX_LEVEL 15
> --
> 2.49.0
>
>

