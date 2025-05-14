Return-Path: <linux-btrfs+bounces-14014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12126AB6E26
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B154C2527
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B31A8F93;
	Wed, 14 May 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="VC6tlYit";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N5H1d+iY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C313B284
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232875; cv=none; b=LTni3ZqiYWvsNDFUSu5N7E4r1aM/vdjrx1o/RV+zfuw5P1I4nncaPmE1UQ5Gb1wyHY2Vn0HMteWz3Tc7ioIM3uzxZ9NzrmOv6DPZpHMBkGjp3fsG1Ntu/6ucTK/silz/jQzHn5M8KzwMyqWoATciUk0BnvxINbYam8EOmvPwR5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232875; c=relaxed/simple;
	bh=JCcBdbV78Z4I4lTSBooGvYgYb1ycPQeYyy3zWI3+G5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW8JG9hwibXRNcMhrEM6ZyTxsHwJNtcDVccPZY04RFFfHk9F1ZJ8GqIB2OhZmjJdXhP3n2X1HehEVeLSDh55293ub1THC5ae/jSZO08zdQdgU6OWixw+b1UuiLH+b29cfJaATkQyDpF7jDdlzorfhDH5bIWSkQuJN/NJVh0AnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=VC6tlYit; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N5H1d+iY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EE4C21380202;
	Wed, 14 May 2025 10:27:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 14 May 2025 10:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1747232870; x=1747319270; bh=BOYf89Xc6u
	EBDtMuSgNOWbPg3BdGy9nCMwCB0GfScI0=; b=VC6tlYitdIb78IoTOcrWkK9VoI
	8Mkqtxm1o+Tx525vL53MpVWEcBcH9y7Ihns1ZBJYRWHfZimRbro+kPDgTZvxjqfv
	XlmzIytNDGOb+dXL5EFcKXJdwtMLaWi9YrRMJs4vwUSlukJKfiLTMwpkPlyb6V5S
	SrdN5/E3GdBiFlWR03O1HOsJg3x+MX1ePWyGtwQ/kUp30LvdpMMNonu6GmaJNtmi
	6gN092J4DsJArKPKkZ7Qe4LAJZkvOmZsSJhlcnVKPU4bBLBjBu0pLziaUvFvM0k8
	NGCUKYDpNLcyLj+CsreImG68FBXKvyH2qvqb/go1K1jPqMes/okNOX5zRoOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747232870; x=1747319270; bh=BOYf89Xc6uEBDtMuSgNOWbPg3BdGy9nCMwC
	B0GfScI0=; b=N5H1d+iYmLk918Cpb428DNlZUrXB6EECdm1pWjLoBV+rke4EfjR
	XVsC9b4GykOL0bBK7Wyf+nk/uyp9FKeKe0FtYaIb/BBsKBI65kWVVLjK1NMgx67j
	u87KwxSZhWfoESn+JFJKNndh1k40qp0qlifRHM1Z+bNQC1V6aUx3QGHIwF8s60t/
	2SUrsi8vLCOeQ4YbL3+5zsgfSTrWOBUlU6u+TKkRMs/X+RUfVKfKcgs13cmhSVXy
	hwkFz4rQXPxY4svrYuH93foywgDwd9cVI9RsZb2JMsU3vpjZaRrWPndGdTqd8Tbw
	ubTbAJJOq6Yo0c6F50AtJi1DlAmhEZYuzIg==
X-ME-Sender: <xms:ZqgkaEwB4J0oEL9mu-Vu_I4f_UrZlBKI-73zZSZW692Mt09MRokFJg>
    <xme:ZqgkaITxkNtPw3L_35usvFdAhxC61bku_P-eJUJV5vC04r-ZjEv-ksmB5tvIbAOMP
    MqHO0tXFygiR4AV1Ds>
X-ME-Received: <xmr:ZqgkaGXFw8ovXJHcCbKuYq7wwocK2NkfuS2D_hx_XTTBlICyS5xCTu9g0X74QoseZmEU3tB1yV6XpPLTw8sQe2MrUFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvggv
    lhigsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgt
    ohhm
X-ME-Proxy: <xmx:ZqgkaCg2swx2GKoKW7hcgAKEJB52ZJ4g5MWFtUQsC6EkZjzSSJYAXQ>
    <xmx:ZqgkaGDDGUTvSHFh9mSkgr0Pr1yQUWBwPzS0VwbaUpwAI1HxHpkIBA>
    <xmx:ZqgkaDIM5wGRNenSWtsCHOIMvgIt8mDs7fy2munSo5RA2UQoIY38eQ>
    <xmx:ZqgkaNCuCnEsEj57vXv5vYvV1pQEmcaIrPEk8LOcSHIrhOR6lKvkqQ>
    <xmx:ZqgkaIxw84gDVRxoq9w20rmiiojv6oJHQoNXekttimz5UQai0lqOw66r>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 10:27:50 -0400 (EDT)
Date: Wed, 14 May 2025 07:28:21 -0700
From: Boris Burkov <boris@bur.io>
To: Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: collect untracked allocation stats
Message-ID: <20250514142821.GA1544463@zen.localdomain>
References: <e42e7c06710b0406ac548739945b386d8319b48e.1747095022.git.boris@bur.io>
 <95f5c89f52556f69decc7f18a6fd1f2c09d711c9.1747095560.git.boris@bur.io>
 <CAPjX3FeVuLj=WDcY9_gaa5Ljj-4w3-hOc+JevXfEwXODO9kgYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FeVuLj=WDcY9_gaa5Ljj-4w3-hOc+JevXfEwXODO9kgYw@mail.gmail.com>

On Wed, May 14, 2025 at 02:11:42PM +0200, Daniel Vacek wrote:
> On Tue, 13 May 2025 at 02:21, Boris Burkov <boris@bur.io> wrote:
> >
> > We allocate memory for extent_buffers and compressed io in a manner that
> > isn't tracked by any memory statistic. It is, in principle, possible to
> 
> Should the eb folios be tracked as page cache/buffers? You can find
> them in btree_inode mapping pages after all.

Actually, I think you're right. When we call filemap_add_folio on the
extent_buffer folios, I think they get accounted under nr_file_pages.

> 
> I guess the same would apply to compressed io folios. Perhaps we just
> need to account both of them as buffers.
> 
> 

I think we don't attach the compressed folios to any filemap. Worth
thinking about.

Even if both do get accounted as file pages, it still seems interesting
to track our own granular stats, though at that point it would not have
much of a benefit towards *detecting* leaks, only debugging them. And at
that point we can probably get there with drgn scripts.

Thanks for the suggestion,
Boris

> > sort of track this memory by subtracting all trackable allocations from
> > the total memory and comparing to the amount free, but that is clumsy to
> > do, breaks when new memory accounting is added in the mm subsystem and
> > lacks any useful granularity.
> >
> > This RFC proposes explicitly tracking btrfs's untracked allocations and
> > reporting them in /sys/fs/btrfs/<uuid>/memory_stats.
> >
> > Open questions:
> > 1. Is this useful?
> > 2. What is the best concurrency model? I experimented with percpu
> >    variables which I don't think allow us to split it by fs_info in a
> >    reasonable way (short of dynamically growing a pointed-to percpu
> >    array as we add fs-es). I haven't thought too hard between spinlock,
> >    atomic, etc..
> > 3. Am I missing any classes of untracked allocations?
> >
> > If this does sound like a good idea to people, I will work harder on
> > validating the correctness of the data and picking an optimal
> > concurrency model. So far, I've just run fstests with this patch.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Note: Resent with a completely dumb work-in-progress commit on the
> > sysfs.c code squashed in. This one should actually apply/compile..
> >
> >  fs/btrfs/compression.c | 31 +++++++++++++++++++++++++++----
> >  fs/btrfs/compression.h |  6 ++++--
> >  fs/btrfs/extent_io.c   | 23 ++++++++++++++++++++++-
> >  fs/btrfs/fs.h          | 10 ++++++++++
> >  fs/btrfs/inode.c       | 16 ++++++++++------
> >  fs/btrfs/lzo.c         | 10 ++++++----
> >  fs/btrfs/sysfs.c       | 15 +++++++++++++++
> >  fs/btrfs/zlib.c        | 16 +++++++---------
> >  fs/btrfs/zstd.c        | 16 +++++++---------
> >  9 files changed, 108 insertions(+), 35 deletions(-)
> >
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index 48d07939fee4..988887cc79ff 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -160,8 +160,10 @@ static int compression_decompress(int type, struct list_head *ws,
> >
> >  static void btrfs_free_compressed_folios(struct compressed_bio *cb)
> >  {
> > +       struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
> > +
> >         for (unsigned int i = 0; i < cb->nr_folios; i++)
> > -               btrfs_free_compr_folio(cb->compressed_folios[i]);
> > +               btrfs_free_compr_folio(fs_info, cb->compressed_folios[i]);
> >         kfree(cb->compressed_folios);
> >  }
> >
> > @@ -223,7 +225,7 @@ static unsigned long btrfs_compr_pool_scan(struct shrinker *sh, struct shrink_co
> >  /*
> >   * Common wrappers for page allocation from compression wrappers
> >   */
> > -struct folio *btrfs_alloc_compr_folio(void)
> > +struct folio *btrfs_alloc_compr_folio(struct btrfs_fs_info *fs_info)
> >  {
> >         struct folio *folio = NULL;
> >
> > @@ -238,10 +240,13 @@ struct folio *btrfs_alloc_compr_folio(void)
> >         if (folio)
> >                 return folio;
> >
> > -       return folio_alloc(GFP_NOFS, 0);
> > +       folio = folio_alloc(GFP_NOFS, 0);
> > +       if (folio)
> > +               btrfs_inc_compressed_io_folios(fs_info);
> > +       return folio;
> >  }
> >
> > -void btrfs_free_compr_folio(struct folio *folio)
> > +void btrfs_free_compr_folio(struct btrfs_fs_info *fs_info, struct folio *folio)
> >  {
> >         bool do_free = false;
> >
> > @@ -259,6 +264,22 @@ void btrfs_free_compr_folio(struct folio *folio)
> >
> >         ASSERT(folio_ref_count(folio) == 1);
> >         folio_put(folio);
> > +       btrfs_dec_compressed_io_folios(fs_info);
> > +}
> > +
> > +void btrfs_inc_compressed_io_folios(struct btrfs_fs_info *fs_info) {
> > +       spin_lock(&fs_info->memory_stats_lock);
> > +       fs_info->memory_stats.nr_compressed_io_folios++;
> > +       spin_unlock(&fs_info->memory_stats_lock);
> > +}
> > +
> > +void btrfs_dec_compressed_io_folios(struct btrfs_fs_info *fs_info)
> > +{
> > +       spin_lock(&fs_info->memory_stats_lock);
> > +       ASSERT(fs_info->memory_stats.nr_compressed_io_folios > 0,
> > +              "%lu", fs_info->memory_stats.nr_compressed_io_folios);
> > +       fs_info->memory_stats.nr_compressed_io_folios--;
> > +       spin_unlock(&fs_info->memory_stats_lock);
> >  }
> >
> >  static void end_bbio_compressed_read(struct btrfs_bio *bbio)
> > @@ -617,6 +638,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
> >                 status = BLK_STS_RESOURCE;
> >                 goto out_free_compressed_pages;
> >         }
> > +       for (int i = 0; i < cb->nr_folios; i++)
> > +               btrfs_inc_compressed_io_folios(fs_info);
> >
> >         add_ra_bio_pages(&inode->vfs_inode, em_start + em_len, cb, &memstall,
> >                          &pflags);
> > diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> > index d34c4341eaf4..a72a58337c76 100644
> > --- a/fs/btrfs/compression.h
> > +++ b/fs/btrfs/compression.h
> > @@ -105,8 +105,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
> >
> >  int btrfs_compress_str2level(unsigned int type, const char *str);
> >
> > -struct folio *btrfs_alloc_compr_folio(void);
> > -void btrfs_free_compr_folio(struct folio *folio);
> > +struct folio *btrfs_alloc_compr_folio(struct btrfs_fs_info *fs_info);
> > +void btrfs_free_compr_folio(struct btrfs_fs_info *fs_info, struct folio *folio);
> >
> >  enum btrfs_compression_type {
> >         BTRFS_COMPRESS_NONE  = 0,
> > @@ -188,5 +188,7 @@ struct list_head *zstd_alloc_workspace(int level);
> >  void zstd_free_workspace(struct list_head *ws);
> >  struct list_head *zstd_get_workspace(int level);
> >  void zstd_put_workspace(struct list_head *ws);
> > +void btrfs_inc_compressed_io_folios(struct btrfs_fs_info *fs_info);
> > +void btrfs_dec_compressed_io_folios(struct btrfs_fs_info *fs_info);
> >
> >  #endif
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 281bb036fcb8..56e036ee3c87 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -611,6 +611,22 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
> >         return 0;
> >  }
> >
> > +static void inc_extent_buffer_folios(struct btrfs_fs_info *fs_info)
> > +{
> > +       spin_lock(&fs_info->memory_stats_lock);
> > +       fs_info->memory_stats.nr_extent_buffer_folios++;
> > +       spin_unlock(&fs_info->memory_stats_lock);
> > +}
> > +
> > +static void dec_extent_buffer_folios(struct btrfs_fs_info *fs_info)
> > +{
> > +       spin_lock(&fs_info->memory_stats_lock);
> > +       ASSERT(fs_info->memory_stats.nr_extent_buffer_folios > 0,
> > +              "%lu", fs_info->memory_stats.nr_extent_buffer_folios);
> > +       fs_info->memory_stats.nr_extent_buffer_folios--;
> > +       spin_unlock(&fs_info->memory_stats_lock);
> > +}
> > +
> >  /*
> >   * Populate needed folios for the extent buffer.
> >   *
> > @@ -626,8 +642,10 @@ static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
> >         if (ret < 0)
> >                 return ret;
> >
> > -       for (int i = 0; i < num_pages; i++)
> > +       for (int i = 0; i < num_pages; i++) {
> >                 eb->folios[i] = page_folio(page_array[i]);
> > +               inc_extent_buffer_folios(eb->fs_info);
> > +       }
> >         eb->folio_size = PAGE_SIZE;
> >         eb->folio_shift = PAGE_SHIFT;
> >         return 0;
> > @@ -2816,6 +2834,7 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
> >                         continue;
> >
> >                 detach_extent_buffer_folio(eb, folio);
> > +               dec_extent_buffer_folios(eb->fs_info);
> >         }
> >  }
> >
> > @@ -2865,6 +2884,7 @@ static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> >                 detach_extent_buffer_folio(eb, eb->folios[i]);
> >                 folio_put(eb->folios[i]);
> >                 eb->folios[i] = NULL;
> > +               dec_extent_buffer_folios(eb->fs_info);
> >         }
> >  }
> >
> > @@ -3418,6 +3438,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> >                 ASSERT(!folio_test_private(folio));
> >                 folio_put(folio);
> >                 eb->folios[i] = NULL;
> > +               dec_extent_buffer_folios(eb->fs_info);
> >         }
> >         btrfs_release_extent_buffer(eb);
> >         if (ret < 0)
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index 4394de12a767..47a66251ed1f 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -3,6 +3,7 @@
> >  #ifndef BTRFS_FS_H
> >  #define BTRFS_FS_H
> >
> > +#include "compression.h"
> >  #include <linux/blkdev.h>
> >  #include <linux/sizes.h>
> >  #include <linux/time64.h>
> > @@ -422,6 +423,11 @@ struct btrfs_commit_stats {
> >         u64 total_commit_dur;
> >  };
> >
> > +struct btrfs_memory_stats {
> > +       unsigned long nr_compressed_io_folios;
> > +       unsigned long nr_extent_buffer_folios;
> > +};
> > +
> >  struct btrfs_fs_info {
> >         u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
> >         unsigned long flags;
> > @@ -866,6 +872,9 @@ struct btrfs_fs_info {
> >         /* Updates are not protected by any lock */
> >         struct btrfs_commit_stats commit_stats;
> >
> > +       spinlock_t memory_stats_lock;
> > +       struct btrfs_memory_stats memory_stats;
> > +
> >         /*
> >          * Last generation where we dropped a non-relocation root.
> >          * Use btrfs_set_last_root_drop_gen() and btrfs_get_last_root_drop_gen()
> > @@ -897,6 +906,7 @@ struct btrfs_fs_info {
> >  #endif
> >  };
> >
> > +
> >  #define folio_to_inode(_folio) (BTRFS_I(_Generic((_folio),                     \
> >                                           struct folio *: (_folio))->mapping->host))
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 964088d3f3f7..6a19f13d2eb6 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -1026,13 +1026,14 @@ static void compress_file_range(struct btrfs_work *work)
> >         if (folios) {
> >                 for (i = 0; i < nr_folios; i++) {
> >                         WARN_ON(folios[i]->mapping);
> > -                       btrfs_free_compr_folio(folios[i]);
> > +                       btrfs_free_compr_folio(fs_info, folios[i]);
> >                 }
> >                 kfree(folios);
> >         }
> >  }
> >
> > -static void free_async_extent_pages(struct async_extent *async_extent)
> > +static void free_async_extent_pages(struct btrfs_fs_info *fs_info,
> > +                                   struct async_extent *async_extent)
> >  {
> >         int i;
> >
> > @@ -1041,7 +1042,7 @@ static void free_async_extent_pages(struct async_extent *async_extent)
> >
> >         for (i = 0; i < async_extent->nr_folios; i++) {
> >                 WARN_ON(async_extent->folios[i]->mapping);
> > -               btrfs_free_compr_folio(async_extent->folios[i]);
> > +               btrfs_free_compr_folio(fs_info, async_extent->folios[i]);
> >         }
> >         kfree(async_extent->folios);
> >         async_extent->nr_folios = 0;
> > @@ -1175,7 +1176,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
> >         if (async_chunk->blkcg_css)
> >                 kthread_associate_blkcg(NULL);
> >         if (free_pages)
> > -               free_async_extent_pages(async_extent);
> > +               free_async_extent_pages(fs_info, async_extent);
> >         kfree(async_extent);
> >         return;
> >
> > @@ -1190,7 +1191,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
> >                                      EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
> >                                      PAGE_UNLOCK | PAGE_START_WRITEBACK |
> >                                      PAGE_END_WRITEBACK);
> > -       free_async_extent_pages(async_extent);
> > +       free_async_extent_pages(fs_info, async_extent);
> >         if (async_chunk->blkcg_css)
> >                 kthread_associate_blkcg(NULL);
> >         btrfs_debug(fs_info,
> > @@ -9723,6 +9724,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
> >                         ret = -ENOMEM;
> >                         goto out_folios;
> >                 }
> > +               btrfs_inc_compressed_io_folios(fs_info);
> >                 kaddr = kmap_local_folio(folios[i], 0);
> >                 if (copy_from_iter(kaddr, bytes, from) != bytes) {
> >                         kunmap_local(kaddr);
> > @@ -9845,8 +9847,10 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
> >         btrfs_unlock_extent(io_tree, start, end, &cached_state);
> >  out_folios:
> >         for (i = 0; i < nr_folios; i++) {
> > -               if (folios[i])
> > +               if (folios[i]) {
> >                         folio_put(folios[i]);
> > +                       btrfs_dec_compressed_io_folios(fs_info);
> > +               }
> >         }
> >         kvfree(folios);
> >  out:
> > diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> > index d403641889ca..741cf70375a9 100644
> > --- a/fs/btrfs/lzo.c
> > +++ b/fs/btrfs/lzo.c
> > @@ -128,7 +128,8 @@ static inline size_t read_compress_length(const char *buf)
> >   *
> >   * Will allocate new pages when needed.
> >   */
> > -static int copy_compressed_data_to_page(char *compressed_data,
> > +static int copy_compressed_data_to_page(struct btrfs_fs_info *fs_info,
> > +                                       char *compressed_data,
> >                                         size_t compressed_size,
> >                                         struct folio **out_folios,
> >                                         unsigned long max_nr_folio,
> > @@ -152,7 +153,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
> >         cur_folio = out_folios[*cur_out / PAGE_SIZE];
> >         /* Allocate a new page */
> >         if (!cur_folio) {
> > -               cur_folio = btrfs_alloc_compr_folio();
> > +               cur_folio = btrfs_alloc_compr_folio(fs_info);
> >                 if (!cur_folio)
> >                         return -ENOMEM;
> >                 out_folios[*cur_out / PAGE_SIZE] = cur_folio;
> > @@ -178,7 +179,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
> >                 cur_folio = out_folios[*cur_out / PAGE_SIZE];
> >                 /* Allocate a new page */
> >                 if (!cur_folio) {
> > -                       cur_folio = btrfs_alloc_compr_folio();
> > +                       cur_folio = btrfs_alloc_compr_folio(fs_info);
> >                         if (!cur_folio)
> >                                 return -ENOMEM;
> >                         out_folios[*cur_out / PAGE_SIZE] = cur_folio;
> > @@ -213,6 +214,7 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                         u64 start, struct folio **folios, unsigned long *out_folios,
> >                         unsigned long *total_in, unsigned long *total_out)
> >  {
> > +       struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
> >         struct workspace *workspace = list_entry(ws, struct workspace, list);
> >         const u32 sectorsize = inode_to_fs_info(mapping->host)->sectorsize;
> >         struct folio *folio_in = NULL;
> > @@ -263,7 +265,7 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                         goto out;
> >                 }
> >
> > -               ret = copy_compressed_data_to_page(workspace->cbuf, out_len,
> > +               ret = copy_compressed_data_to_page(fs_info, workspace->cbuf, out_len,
> >                                                    folios, max_nr_folio,
> >                                                    &cur_out, sectorsize);
> >                 if (ret < 0)
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index 5d93d9dd2c12..ff4ae6dd9e5c 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -1132,6 +1132,20 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
> >         return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
> >  }
> >
> > +static ssize_t btrfs_memory_stats_show(struct kobject *kobj,
> > +                                        struct kobj_attribute *a, char *buf)
> > +{
> > +       struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> > +       struct btrfs_memory_stats *memory_stats = &fs_info->memory_stats;
> > +
> > +       return sysfs_emit(buf,
> > +                         "compressed_io_folios %lu\n"
> > +                         "extent_buffer_folios %lu\n",
> > +                         memory_stats->nr_compressed_io_folios,
> > +                         memory_stats->nr_extent_buffer_folios);
> > +}
> > +
> > +BTRFS_ATTR(, memory_stats, btrfs_memory_stats_show);
> >  BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
> >
> >  static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
> > @@ -1588,6 +1602,7 @@ static const struct attribute *btrfs_attrs[] = {
> >         BTRFS_ATTR_PTR(, bg_reclaim_threshold),
> >         BTRFS_ATTR_PTR(, commit_stats),
> >         BTRFS_ATTR_PTR(, temp_fsid),
> > +       BTRFS_ATTR_PTR(, memory_stats),
> >  #ifdef CONFIG_BTRFS_EXPERIMENTAL
> >         BTRFS_ATTR_PTR(, offload_csum),
> >  #endif
> > diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> > index 5292cd341f70..56dd7acaa50b 100644
> > --- a/fs/btrfs/zlib.c
> > +++ b/fs/btrfs/zlib.c
> > @@ -137,6 +137,8 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                          u64 start, struct folio **folios, unsigned long *out_folios,
> >                          unsigned long *total_in, unsigned long *total_out)
> >  {
> > +       struct btrfs_inode *inode = BTRFS_I(mapping->host);
> > +       struct btrfs_fs_info *fs_info = inode->root->fs_info;
> >         struct workspace *workspace = list_entry(ws, struct workspace, list);
> >         int ret;
> >         char *data_in = NULL;
> > @@ -155,9 +157,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
> >
> >         ret = zlib_deflateInit(&workspace->strm, workspace->level);
> >         if (unlikely(ret != Z_OK)) {
> > -               struct btrfs_inode *inode = BTRFS_I(mapping->host);
> > -
> > -               btrfs_err(inode->root->fs_info,
> > +               btrfs_err(fs_info,
> >         "zlib compression init failed, error %d root %llu inode %llu offset %llu",
> >                           ret, btrfs_root_id(inode->root), btrfs_ino(inode), start);
> >                 ret = -EIO;
> > @@ -167,7 +167,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
> >         workspace->strm.total_in = 0;
> >         workspace->strm.total_out = 0;
> >
> > -       out_folio = btrfs_alloc_compr_folio();
> > +       out_folio = btrfs_alloc_compr_folio(fs_info);
> >         if (out_folio == NULL) {
> >                 ret = -ENOMEM;
> >                 goto out;
> > @@ -225,9 +225,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
> >
> >                 ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
> >                 if (unlikely(ret != Z_OK)) {
> > -                       struct btrfs_inode *inode = BTRFS_I(mapping->host);
> > -
> > -                       btrfs_warn(inode->root->fs_info,
> > +                       btrfs_warn(fs_info,
> >                 "zlib compression failed, error %d root %llu inode %llu offset %llu",
> >                                    ret, btrfs_root_id(inode->root), btrfs_ino(inode),
> >                                    start);
> > @@ -252,7 +250,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                                 ret = -E2BIG;
> >                                 goto out;
> >                         }
> > -                       out_folio = btrfs_alloc_compr_folio();
> > +                       out_folio = btrfs_alloc_compr_folio(fs_info);
> >                         if (out_folio == NULL) {
> >                                 ret = -ENOMEM;
> >                                 goto out;
> > @@ -288,7 +286,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                                 ret = -E2BIG;
> >                                 goto out;
> >                         }
> > -                       out_folio = btrfs_alloc_compr_folio();
> > +                       out_folio = btrfs_alloc_compr_folio(fs_info);
> >                         if (out_folio == NULL) {
> >                                 ret = -ENOMEM;
> >                                 goto out;
> > diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> > index 4a796a049b5a..77cf8a605532 100644
> > --- a/fs/btrfs/zstd.c
> > +++ b/fs/btrfs/zstd.c
> > @@ -389,6 +389,8 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                          u64 start, struct folio **folios, unsigned long *out_folios,
> >                          unsigned long *total_in, unsigned long *total_out)
> >  {
> > +       struct btrfs_inode *inode = BTRFS_I(mapping->host);
> > +       struct btrfs_fs_info *fs_info = inode->root->fs_info;
> >         struct workspace *workspace = list_entry(ws, struct workspace, list);
> >         zstd_cstream *stream;
> >         int ret = 0;
> > @@ -412,8 +414,6 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
> >         stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
> >                         workspace->size);
> >         if (unlikely(!stream)) {
> > -               struct btrfs_inode *inode = BTRFS_I(mapping->host);
> > -
> >                 btrfs_err(inode->root->fs_info,
> >         "zstd compression init level %d failed, root %llu inode %llu offset %llu",
> >                           workspace->req_level, btrfs_root_id(inode->root),
> > @@ -432,7 +432,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
> >         workspace->in_buf.size = cur_len;
> >
> >         /* Allocate and map in the output buffer */
> > -       out_folio = btrfs_alloc_compr_folio();
> > +       out_folio = btrfs_alloc_compr_folio(fs_info);
> >         if (out_folio == NULL) {
> >                 ret = -ENOMEM;
> >                 goto out;
> > @@ -448,9 +448,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                 ret2 = zstd_compress_stream(stream, &workspace->out_buf,
> >                                 &workspace->in_buf);
> >                 if (unlikely(zstd_is_error(ret2))) {
> > -                       struct btrfs_inode *inode = BTRFS_I(mapping->host);
> > -
> > -                       btrfs_warn(inode->root->fs_info,
> > +                       btrfs_warn(fs_info,
> >  "zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
> >                                    workspace->req_level, zstd_get_error_code(ret2),
> >                                    btrfs_root_id(inode->root), btrfs_ino(inode),
> > @@ -482,7 +480,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                                 ret = -E2BIG;
> >                                 goto out;
> >                         }
> > -                       out_folio = btrfs_alloc_compr_folio();
> > +                       out_folio = btrfs_alloc_compr_folio(fs_info);
> >                         if (out_folio == NULL) {
> >                                 ret = -ENOMEM;
> >                                 goto out;
> > @@ -525,7 +523,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                 if (unlikely(zstd_is_error(ret2))) {
> >                         struct btrfs_inode *inode = BTRFS_I(mapping->host);
> >
> > -                       btrfs_err(inode->root->fs_info,
> > +                       btrfs_err(fs_info,
> >  "zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
> >                                   workspace->req_level, zstd_get_error_code(ret2),
> >                                   btrfs_root_id(inode->root), btrfs_ino(inode),
> > @@ -549,7 +547,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                         ret = -E2BIG;
> >                         goto out;
> >                 }
> > -               out_folio = btrfs_alloc_compr_folio();
> > +               out_folio = btrfs_alloc_compr_folio(fs_info);
> >                 if (out_folio == NULL) {
> >                         ret = -ENOMEM;
> >                         goto out;
> > --
> > 2.49.0
> >
> >

