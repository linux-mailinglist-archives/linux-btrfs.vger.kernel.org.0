Return-Path: <linux-btrfs+bounces-15367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C79AFE251
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015321895768
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093742701D0;
	Wed,  9 Jul 2025 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GztuRSID"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725226B76B
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049102; cv=none; b=aiVFQkHS7JCb1JJddTCvJ+pCmV/mLOiDULCw6kIc/PVAbB9o5LI1XGuk3nVOf6ahXfLd5X5+xK6yGAbWVzjYMGwVnl+FWhNR13fdR8kCwtXy81Fopeh1MyvlG0DTHmiaQJbJyYeM6aBhvpdI+tkQQ2V8VDIHL7/wmQ3HXW+LLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049102; c=relaxed/simple;
	bh=EqdZaQnVbgDHnUwsn1bOoQQCmz33fOu8B8xft0Pp3E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0A3hmVIrbsA71obhgrFNpLZA3DuECaGMFxEEtXhaZ5BHO1I8pToreCx2MF2D7As3vZND+Z6xHBMFe7IA+oujHZ0o1kM9huJ/hGzqhc4Nb9gQijA/WKOLvzAs8bXtiqa8UoqfGPFGMABmwmnu0nr8mnNCKox78QNw4wBwkQx6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GztuRSID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DD2C4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752049101;
	bh=EqdZaQnVbgDHnUwsn1bOoQQCmz33fOu8B8xft0Pp3E4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GztuRSIDxqdLX24O+IxREKy3nwhdQQcQNvUdCeWBgTg7iEmyuWci+SZc/Lfy/D/H4
	 p5hx6Y30KQOD4iIueyUAMTCCx8iokNfR/jJjD4tkKOIrUQN8IrVhD3zpf13LPVzzt3
	 GF4x8ZbknHstTuD4LA7bAhPbysmNteuzcP3K3ZY4PxIx36y34y3AX5UkMIL+WN0EN/
	 +TOQkYWIVJHP1kUX1TJ53iBHBLXvs56Sy/Giq3rnky5ydK2/yglfrO9HUXhTOxNibk
	 LZLOGSiQ03dnuelVmJW6cUOU9455IdpNbRJmyzvb+YXyMGlQR7mOKIaRVkyM28jvRY
	 qzL103FDqjlwg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so157910566b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Jul 2025 01:18:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YwA1qLi0uF4IzT4r2p/p0cOqhdCXxCWvHLGI4tRN/mWerEY6G/y
	BY9mLAnX/UZ3fCKq78hoII+yvy7VhGc+rKB/VZk51oyb8NcXqNOaTfLElyLFkLe6N/8SzYj7i02
	Sl84/ymhyIikpmUQJ4VYYrCqBmUiTbJo=
X-Google-Smtp-Source: AGHT+IHuxOaQMg/iIyJvf3cVs1GAZstJVlbJ3qS6wEeiUGlIWHxxY8DNjbG5MDbBo8ZSpEUoFZ/H0wh93klJuAu5M8A=
X-Received: by 2002:a17:907:3e21:b0:ae3:f3c4:c0b1 with SMTP id
 a640c23a62f3a-ae6d12c43f0mr157205766b.7.1752049100104; Wed, 09 Jul 2025
 01:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8142f4eb91ae32eed53c5ae7121296b44b52d627.1751574142.git.boris@bur.io>
 <CAL3q7H7dVuiKPuuDE7DO+sSp4wH_uNjqJ_N6+PDmRPs796=hzQ@mail.gmail.com> <20250709025557.GA87434@zen.localdomain>
In-Reply-To: <20250709025557.GA87434@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 9 Jul 2025 09:17:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5q0q=0qg2Xh=vS_-ySagj3YxokjuKkLphCv5zjWm+EOw@mail.gmail.com>
X-Gm-Features: Ac12FXyMEPeuxSGbgdRSkVnbiaNfuLjvvBnTTNLAJ98qa2gpxYcPhX61uVlbxWM
Message-ID: <CAL3q7H5q0q=0qg2Xh=vS_-ySagj3YxokjuKkLphCv5zjWm+EOw@mail.gmail.com>
Subject: Re: [PATCH v6] btrfs: try to search for data csums in commit root
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:54=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> On Tue, Jul 08, 2025 at 11:15:17PM +0100, Filipe Manana wrote:
> > On Thu, Jul 3, 2025 at 9:22=E2=80=AFPM Boris Burkov <boris@bur.io> wrot=
e:
> > >
> > > If you run a workload like:
> > > - a cgroup that does tons of data reading, with a harsh memory limit
> > > - a second cgroup that tries to write new files
> > >
> > > then what quickly occurs is:
> > > - a high degree of contention on the csum root node eb rwsem
> > > - memory starved cgroup doing tons of reclaim on CPU.
> > > - many reader threads in the memory starved cgroup "holding" the sem
> > >   as readers, but not scheduling promptly. i.e., task __state =3D=3D =
0, but
> > >   not running on a cpu.
> > > - btrfs_commit_transaction stuck trying to acquire the sem as a write=
r.
> >
> > Where exactly is the transaction commit trying to acquire the csum
> > root eb rwsem?
> > It's not obvious - is this with the mount option flushoncommit set?
> >
> > >
> > > This results in arbitrarily long transactions. This then results in
> > > seriously degraded performance for any cgroup using the filesystem (t=
he
> > > victim cgroup in the script).
> > >
> > > It isn't an academic problem, as we see this exact problem in product=
ion
> > > at Meta with one cgroup over its memory limit ruining btrfs performan=
ce
> > > for the whole system, stalling critical system services that depend o=
n
> > > btrfs syncs.
> > >
> > > The underlying scheduling "problem" with global rwsems is sort of tho=
rny
> > > and apparently well known and was discussed at LPC 2024, for example.
> > >
> > > As a result, our main lever in the short term is just trying to reduc=
e
> > > contention on our various rwsems. In the case of the csum tree, we ca=
n
> > > either redesign btree locking (hard...) or try to use the commit root
> > > when we can. Luckily, it seems likely that many reads are for old ext=
ents
> > > written many transactions ago, and that for those we *can* in fact
> > > search the commit root!
> > >
> > > This change detects when we are trying to read an old extent (accordi=
ng
> > > to extent map generation) and then wires that through bio_ctrl to the
> > > btrfs_bio, which unfortunately isn't allocated yet when we have this
> > > information. Luckily, we don't need this flag in the bio after
> > > submitting, so we can save space by setting it on bbio->bio.bi_flags
> > > and clear before submitting, so the block layer is unaffected.
> > >
> > > When we go to lookup the csums in lookup_bio_sums we can check this
> > > condition on the btrfs_bio and do the commit root lookup accordingly.
> > >
> > > Note that a single bio_ctrl might collect a few extent_maps into a si=
ngle
> > > bio, so it is important to track a maximum generation across all the
> > > extent_maps used for each bio to make an accurate decision on whether=
 it
> > > is valid to look in the commit root. If any extent_map is updated in =
the
> > > current generation, we can't use the commit root.
> > >
> > > To test and reproduce this issue, I wrote a script that does the
> > > following:
> > > - creates 512 20MiB files (10GiB) each in it's own subvolume (importa=
nt
> > >   to avoid any contention on the fs-tree root lock)
> > > - spawns 512 processes that loop using dd to read 1GiB at a random Gi=
B
> > >   aligned offset of each file. These "villains" run in a cgroup with
> > >   memory.high set to 1GiB. Obviously this will generate a lot of memo=
ry
> > >   pressure on this cgroup.
> > > - spawns 32 processes that loop creating new small files, to trigger =
a
> > >   decent amount of csum writes to create the csum root lock contentio=
n.
> > >   These run in a cgroup restricted to just one cpu with cpuset, but n=
o
> > >   memory restriction. This cpu overlaps with the cpus available to th=
e
> > >   bad neighbor villain cgroup.
> > > - attempts to sync every 10 seconds
> > > - after 60s, it waits for the final sync and kills all the processes =
via
> > >   their cg cgroup.kill file.
> >
> > In case anyone wants to try this, it would be nice to paste the script
> > here in the changelog.
> >
> > >
> > > Without this patch, that reproducer:
> > > hung indefinitely, I killed manually via the cgroup.kill file. At thi=
s
> > > time, it had racked up 200s and counting in a btrfs commit critical
> > > section and had 200+ threads stuck in D state on the csum reader lock=
:
> > >
> > > elapsed: 914
> > > commits 3
> > > cur_commit_ms 0
> > > last_commit_ms 233784
> > > max_commit_ms 233784
> > > total_commit_ms 235056
> > > 214 hits state D, R comms dd
> > >                  btrfs_tree_read_lock_nested
> > >                  btrfs_read_lock_root_node
> > >                  btrfs_search_slot
> > >                  btrfs_lookup_csum
> > >                  btrfs_lookup_bio_sums
> > >                  btrfs_submit_bbio
> > >
> > > With the patch, the reproducer exits naturally, in 75s, completing a
> > > pretty decent 5 commits, depsite heavy memory pressure:
> >
> > typo, depsite -> despite
> >
> > >
> > > elapsed: 76
> > > commits 5
> > > cur_commit_ms 0
> > > last_commit_ms 1801
> > > max_commit_ms 3901
> > > total_commit_ms 8727
> > > pressure
> > > some avg10=3D99.49 avg60=3D69.22 avg300=3D21.64 total=3D72068757
> > > full avg10=3D44.81 avg60=3D24.18 avg300=3D6.97 total=3D23015022
> > >
> > > some random rwalker samples showed the most common stack in reclaim,
> > > rather than the csum tree:
> > > 145 hits state R comms bash, sleep, dd, shuf
> > >                  shrink_folio_list
> > >                  shrink_lruvec
> > >                  shrink_node
> > >                  do_try_to_free_pages
> > >                  try_to_free_mem_cgroup_pages
> > >                  reclaim_high
> > >
> > > Link: https://lpc.events/event/18/contributions/1883/
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > > Changelog:
> > > v6:
> > > - properly handle bio_ctrl submitting a bbio spanning multiple
> > >   extent_maps with different generations. This was causing csum error=
s
> > >   on the previous versions.
> > > v5:
> > > - static inline flag functions
> > > - make bbio const for the getter
> > > - move around and improve the comments
> > > v4:
> > > - replace generic private flag machinery with specific function for t=
he
> > >   one flag
> > > - move the bio_ctrl field to take advantage of alignment
> > > v3:
> > > - add some simple machinery for setting/getting/clearing btrfs privat=
e
> > >   flags in bi_flags
> > > - clear those flags before bio_submit (ensure no-op wrt block layer)
> > > - store the csum commit root flag there to save space
> > > v2:
> > > - hold the commit_root_sem for the duration of the entire lookup, not
> > >   just per btrfs_search_slot. Note that we can't naively do the thing
> > >   where we release the lock every loop as that is exactly what we are
> > >   trying to avoid. Theoretically, we could re-grab the lock and fully
> > >   start over if the lock is write contended or something. I suspect t=
he
> > >   rwsem fairness features will let the commit writer get it fast enou=
gh
> > >   anyway.
> > >
> > > ---
> > >  fs/btrfs/bio.c         | 10 ++++++++++
> > >  fs/btrfs/bio.h         | 17 +++++++++++++++++
> > >  fs/btrfs/compression.c |  2 ++
> > >  fs/btrfs/extent_io.c   | 40 ++++++++++++++++++++++++++++++++++++++++
> > >  fs/btrfs/file-item.c   | 29 +++++++++++++++++++++++++++++
> > >  5 files changed, 98 insertions(+)
> > >
> > > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > > index 50b5fc1c06d7..789cb3e5ba6d 100644
> > > --- a/fs/btrfs/bio.c
> > > +++ b/fs/btrfs/bio.c
> > > @@ -93,6 +93,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btr=
fs_fs_info *fs_info,
> > >                 refcount_inc(&orig_bbio->ordered->refs);
> > >                 bbio->ordered =3D orig_bbio->ordered;
> > >         }
> > > +       if (btrfs_bio_csum_search_commit_root(orig_bbio))
> > > +               btrfs_bio_set_csum_search_commit_root(bbio);
> > >         atomic_inc(&orig_bbio->pending_ios);
> > >         return bbio;
> > >  }
> > > @@ -479,6 +481,14 @@ static void btrfs_submit_mirrored_bio(struct btr=
fs_io_context *bioc, int dev_nr)
> > >  static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_contex=
t *bioc,
> > >                              struct btrfs_io_stripe *smap, int mirror=
_num)
> > >  {
> > > +       /*
> > > +        * It is important to clear the bits we used in bio->bi_flags=
.
> > > +        * Because bio->bi_flags belongs to the block layer, we shoul=
d
> > > +        * avoid leaving stray bits set when we transfer ownership of
> > > +        * the bio by submitting it.
> > > +        */
> > > +       btrfs_bio_clear_csum_search_commit_root(btrfs_bio(bio));
> > > +
> > >         if (!bioc) {
> > >                 /* Single mirror read/write fast path. */
> > >                 btrfs_bio(bio)->mirror_num =3D mirror_num;
> > > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > > index dc2eb43b7097..9f4bcbe0a76c 100644
> > > --- a/fs/btrfs/bio.h
> > > +++ b/fs/btrfs/bio.h
> > > @@ -104,6 +104,23 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int n=
r_vecs, blk_opf_t opf,
> > >                                   btrfs_bio_end_io_t end_io, void *pr=
ivate);
> > >  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
> > >
> > > +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT (1U << (BIO_FLAG_LAST=
 + 1))
> > > +
> > > +static inline void btrfs_bio_set_csum_search_commit_root(struct btrf=
s_bio *bbio)
> > > +{
> > > +       bbio->bio.bi_flags |=3D BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROO=
T;
> > > +}
> > > +
> > > +static inline void btrfs_bio_clear_csum_search_commit_root(struct bt=
rfs_bio *bbio)
> > > +{
> > > +       bbio->bio.bi_flags &=3D ~BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_RO=
OT;
> > > +}
> > > +
> > > +static inline bool btrfs_bio_csum_search_commit_root(const struct bt=
rfs_bio *bbio)
> > > +{
> > > +       return bbio->bio.bi_flags & BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT=
_ROOT;
> > > +}
> > > +
> > >  /* Submit using blkcg_punt_bio_submit. */
> > >  #define REQ_BTRFS_CGROUP_PUNT                  REQ_FS_PRIVATE
> > >
> > > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > > index d09d622016ef..cadf5eccc640 100644
> > > --- a/fs/btrfs/compression.c
> > > +++ b/fs/btrfs/compression.c
> > > @@ -602,6 +602,8 @@ void btrfs_submit_compressed_read(struct btrfs_bi=
o *bbio)
> > >         cb->compressed_len =3D compressed_len;
> > >         cb->compress_type =3D btrfs_extent_map_compression(em);
> > >         cb->orig_bbio =3D bbio;
> > > +       if (btrfs_bio_csum_search_commit_root(bbio))
> > > +               btrfs_bio_set_csum_search_commit_root(&cb->bbio);
> > >
> > >         btrfs_free_extent_map(em);
> > >
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index 7ad4f10bb55a..7a19c257fd4a 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -101,6 +101,16 @@ struct btrfs_bio_ctrl {
> > >         enum btrfs_compression_type compress_type;
> > >         u32 len_to_oe_boundary;
> > >         blk_opf_t opf;
> > > +       /*
> > > +        * For data read bios, we attempt to optimize csum lookups if=
 the extent
> > > +        * generation is older than the current one. To make this pos=
sible, we
> > > +        * need to track the maximum generation of an extent in a bio=
_ctrl to
> > > +        * make the decision when submitting the bio.
> > > +        *
> > > +        * See the comment in btrfs_lookup_bio_sums for more detail o=
n the
> > > +        * need for this optimization.
> > > +        */
> > > +       u64 generation;
> > >         btrfs_bio_end_io_t end_io_func;
> > >         struct writeback_control *wbc;
> > >
> > > @@ -113,6 +123,30 @@ struct btrfs_bio_ctrl {
> > >         struct readahead_control *ractl;
> > >  };
> > >
> > > +/*
> > > + * Helper to set the csum search commit root option for a bio_ctrl's=
 bbio
> > > + * before submitting the bio.
> > > + *
> > > + * Only for use by submit_one_bio().
> > > + */
> > > +static void bio_set_csum_search_commit_root(struct btrfs_bio_ctrl *b=
io_ctrl)
> > > +{
> > > +       struct btrfs_bio *bbio =3D bio_ctrl->bbio;
> > > +       struct btrfs_fs_info *fs_info;
> > > +
> > > +       ASSERT(bbio);
> > > +       fs_info =3D bbio->inode->root->fs_info;
> >
> > It's only used once, so we could get away with the fs_info variable.
> >
> > > +
> > > +       if (!(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_READ && is_data_i=
node(bbio->inode)))
> > > +               return;
> > > +
> > > +       if (bio_ctrl->generation &&
> > > +           bio_ctrl->generation < btrfs_get_fs_generation(fs_info))
> > > +               btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio)=
;
> > > +       else
> > > +               btrfs_bio_clear_csum_search_commit_root(bio_ctrl->bbi=
o);
> > > +}
> > > +
> > >  static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> > >  {
> > >         struct btrfs_bio *bbio =3D bio_ctrl->bbio;
> > > @@ -123,6 +157,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl =
*bio_ctrl)
> > >         /* Caller should ensure the bio has at least some range added=
 */
> > >         ASSERT(bbio->bio.bi_iter.bi_size);
> > >
> > > +       bio_set_csum_search_commit_root(bio_ctrl);
> > > +
> > >         if (btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_READ &&
> > >             bio_ctrl->compress_type !=3D BTRFS_COMPRESS_NONE)
> > >                 btrfs_submit_compressed_read(bbio);
> > > @@ -131,6 +167,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl =
*bio_ctrl)
> > >
> > >         /* The bbio is owned by the end_io handler now */
> > >         bio_ctrl->bbio =3D NULL;
> > > +       /* Reset the generation for the next bio */
> > > +       bio_ctrl->generation =3D 0;
> > >  }
> > >
> > >  /*
> > > @@ -1026,6 +1064,8 @@ static int btrfs_do_readpage(struct folio *foli=
o, struct extent_map **em_cached,
> > >                 if (prev_em_start)
> > >                         *prev_em_start =3D em->start;
> > >
> > > +               bio_ctrl->generation =3D max(bio_ctrl->generation, em=
->generation);
> > > +
> > >                 btrfs_free_extent_map(em);
> > >                 em =3D NULL;
> > >
> > > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > > index c09fbc257634..3d2403941d97 100644
> > > --- a/fs/btrfs/file-item.c
> > > +++ b/fs/btrfs/file-item.c
> > > @@ -397,6 +397,33 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio=
)
> > >                 path->skip_locking =3D 1;
> > >         }
> > >
> > > +       /*
> > > +        * If we are searching for a csum of an extent from a past
> > > +        * transaction, we can search in the commit root and reduce
> > > +        * lock contention on the csum tree root node's extent buffer=
.
> > > +        *
> > > +        * This is important because that lock is an rwswem which get=
s
> > > +        * pretty heavy write load, unlike the commit_root_csum.
> >
> > commit_root_csum -> commit_root_sem
> >
> > > +        *
> > > +        * Due to how rwsem is implemented, there is a possible
> > > +        * priority inversion where the readers holding the lock don'=
t
> > > +        * get scheduled (say they're in a cgroup stuck in heavy recl=
aim)
> > > +        * which then blocks writers, including transaction commit. B=
y
> > > +        * using a semaphore with fewer writers (only a commit switch=
ing
> > > +        * the roots), we make this issue less likely.
> > > +        *
> > > +        * Note that we don't rely on btrfs_search_slot to lock the
> > > +        * commit root csum. We call search_slot multiple times, whic=
h would
> > > +        * create a potential race where a commit comes in between se=
arches
> > > +        * while we are not holding the commit_root_csum, and we get =
csums
> >
> > commit_root_csum -> commit_root_sem
> >
> > > +        * from across transactions.
> >
> > Ok, but by acquiring the commit_root_sem in read mode during reads,
> > which is also a rwsemaphore, why isn't this leading to the same lock
> > contention problem you describe in the changelog?
> > That is, delaying transaction commits since transaction commits also
> > need to write lock the commit_root_sem.
> >
> > This seems like it can also lead to the same problem it's trying to
> > fix regarding the csum root's rwsem, since data readers read lock that
> > rwsem and transaction commits want to write lock that rwsem.
> > We are just changing from one semaphore to another that is being used
> > both by the data reads (in read mode) and by transaction commits (in
> > write mode).
> >
> > I would like to have some explanation on that. Reading the comment and
> > the changelog leaves me confused about that.
>
> Sorry, I missed this part of your review the first time I read it.
>
> Good question. I agree that fundamentally it is the same, but in
> practice I believe the improvement comes from the fact that the commit
> root semaphore has one rare writer (just the committer at switch root)
> while the csum tree has many threads locking it write, not just
> run_delayed_refs in commit transaction. And the priority inversion
> rwsem issue needs a writer on the queue to trigger, so more writers more
> frequently makes it more likely for such a pileup to happen. That's at
> least my best handwavy explanation.
>
> I agree with you that if a single instance of readers vs. writers under
> severe memory pressure caused trouble 100% of the time, then this wouldn'=
t
> help as you would immediately get stuck at changing the commit root. I
> think this just reduces the pain.
>
> My (over) focus on commit_transaction in the commit message stems from
> the fact that that is the best way to fully propagate a state of
> universal D sadness across processes and cgroups. Once the csum root sem
> is in this state (can be caused by all manner of writers/readers) AND
> once the transaction gets stuck, that then stalls any thread that needs
> a new transaction. That is when this issue gets really noticeable, so I
> think I over-indexed on that aspect in the description.
>
> I will also attempt to collect more data on this, to make the
> explanation more satisfying. I should be able to measure the relative
> number of write lock attempts, for example.

I don't think you need to collect more data.

In the other message, the stack trace you showed makes everything clear:

       btrfs_lock_root_node+1
        btrfs_search_slot+956
        btrfs_del_csums+669
        __btrfs_free_extent.isra.0+2650
        __btrfs_run_delayed_refs+2811
        btrfs_run_delayed_refs+214
        btrfs_commit_transaction+6318

So I was puzzled because a transaction commit itself shouldn't have
the need to do changes to the csum tree.

The problem is really delayed refs that delete the last reference of a
data extent, triggering csum deletions in the csum tree.
We only run delayed refs in two places: committing a transaction and
flushing space to satisfy reservations.

So if we have many delayed refs that delete the last ref of data
extents, we have a lot of write locking on the csum tree - not just
the root node, but in a lot of nodes and leaves.

Once the root node and higher level nodes are COWed, we normally don't
need to write lock them again soon unless they get written before the
transaction commits - but in that scenario, due to the memory
pressure, the btree inode is getting flushed (writeback triggered)
very often, so we end up having to COW them again and again, requiring
the write lock (should_cow_block() returns true in btrfs_search_slot()
and we have to restart the search and set the write lock level
higher).

So we should have such an explanation to the change log and that
comment in the code.
In short:

- We need to have lots of delayed refs that delete the last ref of a
data extent, and that triggers deletions in the csum tree, therefore
lots of write lock attempts on csum tree nodes and leaves - not just
the root node...

- The memory pressure further increases write locking on the csum
tree, we have to COW csum tree nodes/leaves more often because the
btree inode gets flushed by the VM due to memory pressure.

- More time running delayed refs means slowing down transaction commits.

Now that makes it clear, and the commit_root_sem is only acquired once
in write mode by a transaction commit for a relatively short period,
and that's why it's better to make the reads use it and the csum
commot root for looking up checksums.

Thanks!


>
> Thanks again for the thoughtful questions,
> Boris
>
> >
> > Thanks.
> >
> > > +        */
> > > +       if (btrfs_bio_csum_search_commit_root(bbio)) {
> > > +               path->search_commit_root =3D 1;
> > > +               path->skip_locking =3D 1;
> > > +               down_read(&fs_info->commit_root_sem);
> > > +       }
> > > +
> > >         while (bio_offset < orig_len) {
> > >                 int count;
> > >                 u64 cur_disk_bytenr =3D orig_disk_bytenr + bio_offset=
;
> > > @@ -442,6 +469,8 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
> > >                 bio_offset +=3D count * sectorsize;
> > >         }
> > >
> > > +       if (btrfs_bio_csum_search_commit_root(bbio))
> > > +               up_read(&fs_info->commit_root_sem);
> > >         return ret;
> > >  }
> > >
> > > --
> > > 2.49.0
> > >
> > >

