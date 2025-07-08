Return-Path: <linux-btrfs+bounces-15350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 547EBAFDAC0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 00:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944DB4A4838
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 22:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E30259C92;
	Tue,  8 Jul 2025 22:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2F8iNDq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E031E7C27
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012957; cv=none; b=X7INvWBvx6vKz/QvivFn7uquDzO8QhRKIsGhFIKTQtS2Z1pnFkVg0gmhmD0rF+xeyYu9KKxWLMNKc8ra0v6ZhpNP5X+/i/SChkZUzwwrjz4MNasJPGiMErUNtjiq+ZUFN93hAiQPsYmcyrriwfax6w9TaclrNghQzgQHHbT3hvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012957; c=relaxed/simple;
	bh=CqXSK5bIugzaqfW+b3G0XJ6TqJN4udo7xGtuc6BX+dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiyOVZajtqz+8rdLQFN84Rl3pdJoAXX7jBZfXkrLooGoSkjy6oin8RW9CnkbRedKNWrfD+bWjcQUyczSZMOlyAWRqd7LXtfVMD+TIiHB8ICRYuc4rLkxEmQX6eyNiwS1oZyndXY3vNvo54NnRKVbjrDbARxWSSOEnqq1qN/Ao+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2F8iNDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA614C4CEED
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 22:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752012957;
	bh=CqXSK5bIugzaqfW+b3G0XJ6TqJN4udo7xGtuc6BX+dA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g2F8iNDq+1fbpL6h5PqajGv2TCdsAKQFr4dPI3iLch/LcR4uKdXr8lELD0E+bKrCr
	 XLcc++eQnXCWynFR6at7ILMOnsIrWs43/A1SWkjw7WF05QZH+66umUWfNftoAZCt3U
	 2jZauXLuA1m3ypIvK3zXXOHtk7ll/GeMJqNCE3DM77trsGL21vc2qaDoh3xviMN1cq
	 Q3QYz+gdWJ4O+LSWLyix6J2FPXa/ovSYa9pHjlNx2dYaSs5Nywb7z39zVSfYLchBVK
	 Yo31wMeVR60rr88WyQonZRioZFgPyGpmfbwXCVOKm8JQYjnvr32OMgwqdSgYV5V4Sz
	 G6C0zOTTAplzw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so782054a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 15:15:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YzFjUk604vLGOXtQe/geKmgGydBBbwyj4tJhr7pmKsIAKqQ8Izj
	SDPPNNZrFvNJi/5Au1uIziFk/1k8lMM8RSiGUFbapM7xv8vrvrSc0qxWb2kCezofnYafFUv7gn6
	zklGPC5ZHD48l85lonLnFV2lcDW3unuU=
X-Google-Smtp-Source: AGHT+IGseqvw1SmcUqJi2M8rRfby+V78JBfizXS/xi8wqLEqJ48my5D+A3mtQN0frlI7WLimNzkgrjgtHzSkoL0u5a8=
X-Received: by 2002:a17:907:7b9c:b0:ae2:3544:8121 with SMTP id
 a640c23a62f3a-ae6d12c3cc2mr4826366b.9.1752012954449; Tue, 08 Jul 2025
 15:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8142f4eb91ae32eed53c5ae7121296b44b52d627.1751574142.git.boris@bur.io>
In-Reply-To: <8142f4eb91ae32eed53c5ae7121296b44b52d627.1751574142.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Jul 2025 23:15:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7dVuiKPuuDE7DO+sSp4wH_uNjqJ_N6+PDmRPs796=hzQ@mail.gmail.com>
X-Gm-Features: Ac12FXzg22fx_HTu9PMvlJLuTDdoJf6yIdaATIt9a3vyhuGsu7njZXa7DjdDd5k
Message-ID: <CAL3q7H7dVuiKPuuDE7DO+sSp4wH_uNjqJ_N6+PDmRPs796=hzQ@mail.gmail.com>
Subject: Re: [PATCH v6] btrfs: try to search for data csums in commit root
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 9:22=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> If you run a workload like:
> - a cgroup that does tons of data reading, with a harsh memory limit
> - a second cgroup that tries to write new files
>
> then what quickly occurs is:
> - a high degree of contention on the csum root node eb rwsem
> - memory starved cgroup doing tons of reclaim on CPU.
> - many reader threads in the memory starved cgroup "holding" the sem
>   as readers, but not scheduling promptly. i.e., task __state =3D=3D 0, b=
ut
>   not running on a cpu.
> - btrfs_commit_transaction stuck trying to acquire the sem as a writer.

Where exactly is the transaction commit trying to acquire the csum
root eb rwsem?
It's not obvious - is this with the mount option flushoncommit set?

>
> This results in arbitrarily long transactions. This then results in
> seriously degraded performance for any cgroup using the filesystem (the
> victim cgroup in the script).
>
> It isn't an academic problem, as we see this exact problem in production
> at Meta with one cgroup over its memory limit ruining btrfs performance
> for the whole system, stalling critical system services that depend on
> btrfs syncs.
>
> The underlying scheduling "problem" with global rwsems is sort of thorny
> and apparently well known and was discussed at LPC 2024, for example.
>
> As a result, our main lever in the short term is just trying to reduce
> contention on our various rwsems. In the case of the csum tree, we can
> either redesign btree locking (hard...) or try to use the commit root
> when we can. Luckily, it seems likely that many reads are for old extents
> written many transactions ago, and that for those we *can* in fact
> search the commit root!
>
> This change detects when we are trying to read an old extent (according
> to extent map generation) and then wires that through bio_ctrl to the
> btrfs_bio, which unfortunately isn't allocated yet when we have this
> information. Luckily, we don't need this flag in the bio after
> submitting, so we can save space by setting it on bbio->bio.bi_flags
> and clear before submitting, so the block layer is unaffected.
>
> When we go to lookup the csums in lookup_bio_sums we can check this
> condition on the btrfs_bio and do the commit root lookup accordingly.
>
> Note that a single bio_ctrl might collect a few extent_maps into a single
> bio, so it is important to track a maximum generation across all the
> extent_maps used for each bio to make an accurate decision on whether it
> is valid to look in the commit root. If any extent_map is updated in the
> current generation, we can't use the commit root.
>
> To test and reproduce this issue, I wrote a script that does the
> following:
> - creates 512 20MiB files (10GiB) each in it's own subvolume (important
>   to avoid any contention on the fs-tree root lock)
> - spawns 512 processes that loop using dd to read 1GiB at a random GiB
>   aligned offset of each file. These "villains" run in a cgroup with
>   memory.high set to 1GiB. Obviously this will generate a lot of memory
>   pressure on this cgroup.
> - spawns 32 processes that loop creating new small files, to trigger a
>   decent amount of csum writes to create the csum root lock contention.
>   These run in a cgroup restricted to just one cpu with cpuset, but no
>   memory restriction. This cpu overlaps with the cpus available to the
>   bad neighbor villain cgroup.
> - attempts to sync every 10 seconds
> - after 60s, it waits for the final sync and kills all the processes via
>   their cg cgroup.kill file.

In case anyone wants to try this, it would be nice to paste the script
here in the changelog.

>
> Without this patch, that reproducer:
> hung indefinitely, I killed manually via the cgroup.kill file. At this
> time, it had racked up 200s and counting in a btrfs commit critical
> section and had 200+ threads stuck in D state on the csum reader lock:
>
> elapsed: 914
> commits 3
> cur_commit_ms 0
> last_commit_ms 233784
> max_commit_ms 233784
> total_commit_ms 235056
> 214 hits state D, R comms dd
>                  btrfs_tree_read_lock_nested
>                  btrfs_read_lock_root_node
>                  btrfs_search_slot
>                  btrfs_lookup_csum
>                  btrfs_lookup_bio_sums
>                  btrfs_submit_bbio
>
> With the patch, the reproducer exits naturally, in 75s, completing a
> pretty decent 5 commits, depsite heavy memory pressure:

typo, depsite -> despite

>
> elapsed: 76
> commits 5
> cur_commit_ms 0
> last_commit_ms 1801
> max_commit_ms 3901
> total_commit_ms 8727
> pressure
> some avg10=3D99.49 avg60=3D69.22 avg300=3D21.64 total=3D72068757
> full avg10=3D44.81 avg60=3D24.18 avg300=3D6.97 total=3D23015022
>
> some random rwalker samples showed the most common stack in reclaim,
> rather than the csum tree:
> 145 hits state R comms bash, sleep, dd, shuf
>                  shrink_folio_list
>                  shrink_lruvec
>                  shrink_node
>                  do_try_to_free_pages
>                  try_to_free_mem_cgroup_pages
>                  reclaim_high
>
> Link: https://lpc.events/event/18/contributions/1883/
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v6:
> - properly handle bio_ctrl submitting a bbio spanning multiple
>   extent_maps with different generations. This was causing csum errors
>   on the previous versions.
> v5:
> - static inline flag functions
> - make bbio const for the getter
> - move around and improve the comments
> v4:
> - replace generic private flag machinery with specific function for the
>   one flag
> - move the bio_ctrl field to take advantage of alignment
> v3:
> - add some simple machinery for setting/getting/clearing btrfs private
>   flags in bi_flags
> - clear those flags before bio_submit (ensure no-op wrt block layer)
> - store the csum commit root flag there to save space
> v2:
> - hold the commit_root_sem for the duration of the entire lookup, not
>   just per btrfs_search_slot. Note that we can't naively do the thing
>   where we release the lock every loop as that is exactly what we are
>   trying to avoid. Theoretically, we could re-grab the lock and fully
>   start over if the lock is write contended or something. I suspect the
>   rwsem fairness features will let the commit writer get it fast enough
>   anyway.
>
> ---
>  fs/btrfs/bio.c         | 10 ++++++++++
>  fs/btrfs/bio.h         | 17 +++++++++++++++++
>  fs/btrfs/compression.c |  2 ++
>  fs/btrfs/extent_io.c   | 40 ++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/file-item.c   | 29 +++++++++++++++++++++++++++++
>  5 files changed, 98 insertions(+)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 50b5fc1c06d7..789cb3e5ba6d 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -93,6 +93,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_f=
s_info *fs_info,
>                 refcount_inc(&orig_bbio->ordered->refs);
>                 bbio->ordered =3D orig_bbio->ordered;
>         }
> +       if (btrfs_bio_csum_search_commit_root(orig_bbio))
> +               btrfs_bio_set_csum_search_commit_root(bbio);
>         atomic_inc(&orig_bbio->pending_ios);
>         return bbio;
>  }
> @@ -479,6 +481,14 @@ static void btrfs_submit_mirrored_bio(struct btrfs_i=
o_context *bioc, int dev_nr)
>  static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *b=
ioc,
>                              struct btrfs_io_stripe *smap, int mirror_num=
)
>  {
> +       /*
> +        * It is important to clear the bits we used in bio->bi_flags.
> +        * Because bio->bi_flags belongs to the block layer, we should
> +        * avoid leaving stray bits set when we transfer ownership of
> +        * the bio by submitting it.
> +        */
> +       btrfs_bio_clear_csum_search_commit_root(btrfs_bio(bio));
> +
>         if (!bioc) {
>                 /* Single mirror read/write fast path. */
>                 btrfs_bio(bio)->mirror_num =3D mirror_num;
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index dc2eb43b7097..9f4bcbe0a76c 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -104,6 +104,23 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_ve=
cs, blk_opf_t opf,
>                                   btrfs_bio_end_io_t end_io, void *privat=
e);
>  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
>
> +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT (1U << (BIO_FLAG_LAST + 1=
))
> +
> +static inline void btrfs_bio_set_csum_search_commit_root(struct btrfs_bi=
o *bbio)
> +{
> +       bbio->bio.bi_flags |=3D BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> +}
> +
> +static inline void btrfs_bio_clear_csum_search_commit_root(struct btrfs_=
bio *bbio)
> +{
> +       bbio->bio.bi_flags &=3D ~BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> +}
> +
> +static inline bool btrfs_bio_csum_search_commit_root(const struct btrfs_=
bio *bbio)
> +{
> +       return bbio->bio.bi_flags & BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROO=
T;
> +}
> +
>  /* Submit using blkcg_punt_bio_submit. */
>  #define REQ_BTRFS_CGROUP_PUNT                  REQ_FS_PRIVATE
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index d09d622016ef..cadf5eccc640 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -602,6 +602,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *b=
bio)
>         cb->compressed_len =3D compressed_len;
>         cb->compress_type =3D btrfs_extent_map_compression(em);
>         cb->orig_bbio =3D bbio;
> +       if (btrfs_bio_csum_search_commit_root(bbio))
> +               btrfs_bio_set_csum_search_commit_root(&cb->bbio);
>
>         btrfs_free_extent_map(em);
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7ad4f10bb55a..7a19c257fd4a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -101,6 +101,16 @@ struct btrfs_bio_ctrl {
>         enum btrfs_compression_type compress_type;
>         u32 len_to_oe_boundary;
>         blk_opf_t opf;
> +       /*
> +        * For data read bios, we attempt to optimize csum lookups if the=
 extent
> +        * generation is older than the current one. To make this possibl=
e, we
> +        * need to track the maximum generation of an extent in a bio_ctr=
l to
> +        * make the decision when submitting the bio.
> +        *
> +        * See the comment in btrfs_lookup_bio_sums for more detail on th=
e
> +        * need for this optimization.
> +        */
> +       u64 generation;
>         btrfs_bio_end_io_t end_io_func;
>         struct writeback_control *wbc;
>
> @@ -113,6 +123,30 @@ struct btrfs_bio_ctrl {
>         struct readahead_control *ractl;
>  };
>
> +/*
> + * Helper to set the csum search commit root option for a bio_ctrl's bbi=
o
> + * before submitting the bio.
> + *
> + * Only for use by submit_one_bio().
> + */
> +static void bio_set_csum_search_commit_root(struct btrfs_bio_ctrl *bio_c=
trl)
> +{
> +       struct btrfs_bio *bbio =3D bio_ctrl->bbio;
> +       struct btrfs_fs_info *fs_info;
> +
> +       ASSERT(bbio);
> +       fs_info =3D bbio->inode->root->fs_info;

It's only used once, so we could get away with the fs_info variable.

> +
> +       if (!(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_READ && is_data_inode=
(bbio->inode)))
> +               return;
> +
> +       if (bio_ctrl->generation &&
> +           bio_ctrl->generation < btrfs_get_fs_generation(fs_info))
> +               btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio);
> +       else
> +               btrfs_bio_clear_csum_search_commit_root(bio_ctrl->bbio);
> +}
> +
>  static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>  {
>         struct btrfs_bio *bbio =3D bio_ctrl->bbio;
> @@ -123,6 +157,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio=
_ctrl)
>         /* Caller should ensure the bio has at least some range added */
>         ASSERT(bbio->bio.bi_iter.bi_size);
>
> +       bio_set_csum_search_commit_root(bio_ctrl);
> +
>         if (btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_READ &&
>             bio_ctrl->compress_type !=3D BTRFS_COMPRESS_NONE)
>                 btrfs_submit_compressed_read(bbio);
> @@ -131,6 +167,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio=
_ctrl)
>
>         /* The bbio is owned by the end_io handler now */
>         bio_ctrl->bbio =3D NULL;
> +       /* Reset the generation for the next bio */
> +       bio_ctrl->generation =3D 0;
>  }
>
>  /*
> @@ -1026,6 +1064,8 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>                 if (prev_em_start)
>                         *prev_em_start =3D em->start;
>
> +               bio_ctrl->generation =3D max(bio_ctrl->generation, em->ge=
neration);
> +
>                 btrfs_free_extent_map(em);
>                 em =3D NULL;
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index c09fbc257634..3d2403941d97 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -397,6 +397,33 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>                 path->skip_locking =3D 1;
>         }
>
> +       /*
> +        * If we are searching for a csum of an extent from a past
> +        * transaction, we can search in the commit root and reduce
> +        * lock contention on the csum tree root node's extent buffer.
> +        *
> +        * This is important because that lock is an rwswem which gets
> +        * pretty heavy write load, unlike the commit_root_csum.

commit_root_csum -> commit_root_sem

> +        *
> +        * Due to how rwsem is implemented, there is a possible
> +        * priority inversion where the readers holding the lock don't
> +        * get scheduled (say they're in a cgroup stuck in heavy reclaim)
> +        * which then blocks writers, including transaction commit. By
> +        * using a semaphore with fewer writers (only a commit switching
> +        * the roots), we make this issue less likely.
> +        *
> +        * Note that we don't rely on btrfs_search_slot to lock the
> +        * commit root csum. We call search_slot multiple times, which wo=
uld
> +        * create a potential race where a commit comes in between search=
es
> +        * while we are not holding the commit_root_csum, and we get csum=
s

commit_root_csum -> commit_root_sem

> +        * from across transactions.

Ok, but by acquiring the commit_root_sem in read mode during reads,
which is also a rwsemaphore, why isn't this leading to the same lock
contention problem you describe in the changelog?
That is, delaying transaction commits since transaction commits also
need to write lock the commit_root_sem.

This seems like it can also lead to the same problem it's trying to
fix regarding the csum root's rwsem, since data readers read lock that
rwsem and transaction commits want to write lock that rwsem.
We are just changing from one semaphore to another that is being used
both by the data reads (in read mode) and by transaction commits (in
write mode).

I would like to have some explanation on that. Reading the comment and
the changelog leaves me confused about that.

Thanks.

> +        */
> +       if (btrfs_bio_csum_search_commit_root(bbio)) {
> +               path->search_commit_root =3D 1;
> +               path->skip_locking =3D 1;
> +               down_read(&fs_info->commit_root_sem);
> +       }
> +
>         while (bio_offset < orig_len) {
>                 int count;
>                 u64 cur_disk_bytenr =3D orig_disk_bytenr + bio_offset;
> @@ -442,6 +469,8 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>                 bio_offset +=3D count * sectorsize;
>         }
>
> +       if (btrfs_bio_csum_search_commit_root(bbio))
> +               up_read(&fs_info->commit_root_sem);
>         return ret;
>  }
>
> --
> 2.49.0
>
>

