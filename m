Return-Path: <linux-btrfs+bounces-15422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BA8B0012E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 14:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F621BC73B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD23023B639;
	Thu, 10 Jul 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvqOlyNd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0950185E7F
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149172; cv=none; b=LTV+7hNMG0LLXThL3Fxb7rmGOSFlCzA7mbzp09ZW97u72fq3SsNK3XHx+j1Tz4s9YVz7FjwJ0L49ZVYa3yBpcHfTkdWVfftxTlCbut4xXQ1nZqtetJr0vWHV6CzkiQf+vbBOcAYrunH2DqDJMPDwYpKb/uXM1ezAsr9Ob11/E7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149172; c=relaxed/simple;
	bh=XjWBhD7sQullE0I9t/38u0spZibzQlegI2pe1DDUg/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxfmjtE2/RSSNgMZeu/AbdzzrizXq0ohWa5Ar4pQky6jCmAHWSggIg0M6e6MEqdbBh6QdHvUaSEtoj3SqMYc8WjQIdb+DSXmqPO10P7dw1Vk33/PrdAfR/CtLpl+hi7bcntNSwsOdvmxoJyG0efBxLPerXHIlkViASmBQGp6Mu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvqOlyNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7BAC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752149171;
	bh=XjWBhD7sQullE0I9t/38u0spZibzQlegI2pe1DDUg/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fvqOlyNdirp5OFr2wsxVKsHJBbllPxDuAqUmeFe0/8Koy37n9M+RlviFGxrl1EQ2s
	 ppTEzci7KrYYuIHcCmkpa4DGp5aRcRhp4dcx9mjBn4fgZxwkTGKKjaAMVcd4l4wIaU
	 9qD1XpO+i5GGJL+47Yk5sj9ellD89wIVyBXH57CXB+eo7jkWSaWWahUgIe9UjqGz2K
	 0YoE7r28gbhsQefvfWHy5RN5zciSzywMkqblBF/JG74ICLny7wsp6P8JBs7OZB5xJt
	 4xsypKD2vc8YbNj0RzsFrLAqKi10ZM3TLPKhUXIqEPPJ/+mRU4bt+jds9obZe2XNAs
	 +0md/3bhBsqPg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so193474666b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 05:06:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YyC3BJbkbYXpNT4/Jfwai5Go2vmVbgz8zwtHBf27h8ExarEnbvI
	qZoPeqiFGLdVm0F1Nzn6JNZJ4TlUFszX8L1PB2vrbL8Al/GFUOFijmKhtfcm79TLJAaqGoZ5NeO
	uU6rjyXsWCVRjH7S4XA9Kcfmjk+Pw5/U=
X-Google-Smtp-Source: AGHT+IFt2PO8NOPiTwz9ZZBzu3hTfU/EsTJTeQc+9GTABrqSGPbJelhRBm+ngAZfh+3jCzBarD3CPIVc3/Je/WpFhvk=
X-Received: by 2002:a17:906:dc8f:b0:ae6:c334:af3a with SMTP id
 a640c23a62f3a-ae6e227b9admr345251966b.6.1752149169816; Thu, 10 Jul 2025
 05:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <112a66d49285e38d7a567aa780d9545baafd3deb.1752101883.git.boris@bur.io>
In-Reply-To: <112a66d49285e38d7a567aa780d9545baafd3deb.1752101883.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 10 Jul 2025 13:05:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5ut-z5RAYz0m=k48SjFhxcfH6szonmZu3w2epkgb-few@mail.gmail.com>
X-Gm-Features: Ac12FXxR-uLDLaDQa_wzCrUzHhYA3iaD0FbnpH70KxmsV_4jxjZL-XkrI5YJhEQ
Message-ID: <CAL3q7H5ut-z5RAYz0m=k48SjFhxcfH6szonmZu3w2epkgb-few@mail.gmail.com>
Subject: Re: [PATCH v7] btrfs: try to search for data csums in commit root
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:00=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> If you run a workload with:
> - a cgroup that does tons of parallel data reading, with a working set
>   much larger than its memory limit
> - a second cgroup that writes relatively fewer files, with overwrites,
>   with no memory limit
> (see full code listing at the bottom for a reproducer)
>
> then what quickly occurs is:
> - we have a large number of threads trying to read the csum tree
> - we have a decent number of threads deleting csums running delayed refs
> - we have a large number of threads in direct reclaim and thus high
>   memory pressure
>
> The result of this is that we writeback the csum tree repeatedly mid
> transaction, to get back the extent_buffer folios for reclaim. As a
> result, we repeatedly COW the csum tree for the delayed refs that are
> deleting csums. This means repeatedly write locking the higher levels of
> the tree.
>
> As a result of this, we achieve an unpleasant priority inversion. We
> have:
> - a high degree of contention on the csum root node (and other upper
>   nodes) eb rwsem
> - a memory starved cgroup doing tons of reclaim on CPU.
> - many reader threads in the memory starved cgroup "holding" the sem
>   as readers, but not scheduling promptly. i.e., task __state =3D=3D 0, b=
ut
>   not running on a cpu.
> - btrfs_commit_transaction stuck trying to acquire the sem as a writer.
>   (running delayed_refs, deleting csums for unreferenced data extents)
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
> contention on our various rwsems with an eye to reducing the frequency
> of write locking, to avoid disabling the read lock fast acquistion path.
>
> Luckily, it seems likely that many reads are for old extents written
> many transactions ago, and that for those we *can* in fact search the
> commit root. The commit_root_sem only gets taken write once, near the
> end of transaction commit, no matter how much memory pressure there is,
> so we have much less contention between readers and writers.
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
> To test and reproduce this issue, I used the following script and
> accompanying C program (to avoid bottlenecks in constantly forking
> thousands of dd processes):
>
> =3D=3D=3D=3D=3D=3D big-read.c =3D=3D=3D=3D=3D=3D
>   #include <fcntl.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <sys/mman.h>
>   #include <sys/stat.h>
>   #include <unistd.h>
>   #include <errno.h>
>
>   #define BUF_SZ (128 * (1 << 10UL))
>
>   int read_once(int fd, size_t sz) {
>         char buf[BUF_SZ];
>         size_t rd =3D 0;
>         int ret =3D 0;
>
>         while (rd < sz) {
>                 ret =3D read(fd, buf, BUF_SZ);
>                 if (ret < 0) {
>                         if (errno =3D=3D EINTR)
>                                 continue;
>                         fprintf(stderr, "read failed: %d\n", errno);
>                         return -errno;
>                 } else if (ret =3D=3D 0) {
>                         break;
>                 } else {
>                         rd +=3D ret;
>                 }
>         }
>         return rd;
>   }
>
>   int read_loop(char *fname) {
>         int fd;
>         struct stat st;
>         size_t sz =3D 0;
>         int ret;
>
>         while (1) {
>                 fd =3D open(fname, O_RDONLY);
>                 if (fd =3D=3D -1) {
>                         perror("open");
>                         return 1;
>                 }
>                 if (!sz) {
>                         if (!fstat(fd, &st)) {
>                                 sz =3D st.st_size;
>                         } else {
>                                 perror("stat");
>                                 return 1;
>                         }
>                 }
>
>                   ret =3D read_once(fd, sz);
>                 close(fd);
>         }
>   }
>
>   int main(int argc, char *argv[]) {
>         int fd;
>         struct stat st;
>         off_t sz;
>         char *buf;
>         int ret;
>
>         if (argc !=3D 2) {
>                 fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
>                 return 1;
>         }
>
>         return read_loop(argv[1]);
>   }
>
> =3D=3D=3D=3D=3D=3D repro.sh =3D=3D=3D=3D=3D=3D
>   #!/usr/bin/env bash
>
>   SCRIPT=3D$(readlink -f "$0")
>   DIR=3D$(dirname "$SCRIPT")
>
>   dev=3D$1
>   mnt=3D$2
>   shift
>   shift
>
>   CG_ROOT=3D/sys/fs/cgroup
>   BAD_CG=3D$CG_ROOT/bad-nbr
>   GOOD_CG=3D$CG_ROOT/good-nbr
>   NR_BIGGOS=3D1
>   NR_LITTLE=3D10
>   NR_VICTIMS=3D32
>   NR_VILLAINS=3D512
>
>   START_SEC=3D$(date +%s)
>
>   _elapsed() {
>         echo "elapsed: $(($(date +%s) - $START_SEC))"
>   }
>
>   _stats() {
>         local sysfs=3D/sys/fs/btrfs/$(findmnt -no UUID $dev)
>
>         echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
>         date
>         _elapsed
>         cat $sysfs/commit_stats
>         cat $BAD_CG/memory.pressure
>   }
>
>   _setup_cgs() {
>         echo "+memory +cpuset" > $CG_ROOT/cgroup.subtree_control
>         mkdir -p $GOOD_CG
>         mkdir -p $BAD_CG
>         echo max > $BAD_CG/memory.max
>         # memory.high much less than the working set will cause heavy rec=
laim
>         echo $((1 << 30)) > $BAD_CG/memory.high
>
>         # victims get a subset of villain CPUs
>         echo 0 > $GOOD_CG/cpuset.cpus
>         echo 0,1,2,3 > $BAD_CG/cpuset.cpus
>   }
>
>   _kill_cg() {
>         local cg=3D$1
>         local attempts=3D0
>         echo "kill cgroup $cg"
>         [ -f $cg/cgroup.procs ] || return
>         while true; do
>                 attempts=3D$((attempts + 1))
>                 echo 1 > $cg/cgroup.kill
>                 sleep 1
>                 procs=3D$(wc -l $cg/cgroup.procs | cut -d' ' -f1)
>                 [ $procs -eq 0 ] && break
>         done
>         rmdir $cg
>         echo "killed cgroup $cg in $attempts attempts"
>   }
>
>   _biggo_vol() {
>         echo $mnt/biggo_vol.$1
>   }
>
>   _biggo_file() {
>         echo $(_biggo_vol $1)/biggo
>   }
>
>   _subvoled_biggos() {
>         total_sz=3D$((10 << 30))
>         per_sz=3D$((total_sz / $NR_VILLAINS))
>         dd_count=3D$((per_sz >> 20))
>         echo "create $NR_VILLAINS subvols with a file of size $per_sz byt=
es for a total of $total_sz bytes."
>         for i in $(seq $NR_VILLAINS)
>         do
>                 btrfs subvol create $(_biggo_vol $i) &>/dev/null
>                 dd if=3D/dev/zero of=3D$(_biggo_file $i) bs=3D1M count=3D=
$dd_count &>/dev/null
>         done
>         echo "done creating subvols."
>   }
>
>   _setup() {
>         [ -f .done ] && rm .done
>         findmnt -n $dev && exit 1
>         if [ -f .re-mkfs ]; then
>                 mkfs.btrfs -f -m single -d single $dev >/dev/null || exit=
 2
>         else
>                 echo "touch .re-mkfs to populate the test fs"
>         fi
>
>         mount -o noatime $dev $mnt || exit 3
>         [ -f .re-mkfs ] && _subvoled_biggos
>         _setup_cgs
>   }
>
>   _my_cleanup() {
>         echo "CLEANUP!"
>         _kill_cg $BAD_CG
>         _kill_cg $GOOD_CG
>         sleep 1
>         umount $mnt
>   }
>
>   _bad_exit() {
>         _err "Unexpected Exit! $?"
>         _stats
>         exit $?
>   }
>
>   trap _my_cleanup EXIT
>   trap _bad_exit INT TERM
>
>   _setup
>
>   # Use a lot of page cache reading the big file
>   _villain() {
>         local i=3D$1
>         echo $BASHPID > $BAD_CG/cgroup.procs
>         $DIR/big-read $(_biggo_file $i)
>   }
>
>   # Hit del_csum a lot by overwriting lots of small new files
>   _victim() {
>         echo $BASHPID > $GOOD_CG/cgroup.procs
>         i=3D0;
>         while (true)
>         do
>                 local tmp=3D$mnt/tmp.$i
>
>                 dd if=3D/dev/zero of=3D$tmp bs=3D4k count=3D2 >/dev/null =
2>&1
>                 i=3D$((i+1))
>                 [ $i -eq $NR_LITTLE ] && i=3D0
>         done
>   }
>
>   _one_sync() {
>         echo "sync..."
>         before=3D$(date +%s)
>         sync
>         after=3D$(date +%s)
>         echo "sync done in $((after - before))s"
>         _stats
>   }
>
>   # sync in a loop
>   _sync() {
>         echo "start sync loop"
>         syncs=3D0
>         echo $BASHPID > $GOOD_CG/cgroup.procs
>         while true
>         do
>                 [ -f .done ] && break
>                 _one_sync
>                 syncs=3D$((syncs + 1))
>                 [ -f .done ] && break
>                 sleep 10
>         done
>         if [ $syncs -eq 0 ]; then
>                 echo "do at least one sync!"
>                 _one_sync
>         fi
>         echo "sync loop done."
>   }
>
>   _sleep() {
>         local time=3D${1-60}
>         local now=3D$(date +%s)
>         local end=3D$((now + time))
>         while [ $now -lt $end ];
>         do
>                 echo "SLEEP: $((end - now))s left. Sleep 10."
>                 sleep 10
>                 now=3D$(date +%s)
>         done
>   }
>
>   echo "start $NR_VILLAINS villains"
>   for i in $(seq $NR_VILLAINS)
>   do
>         _villain $i &
>         disown # get rid of annoying log on kill (done via cgroup anyway)
>   done
>
>   echo "start $NR_VICTIMS victims"
>   for i in $(seq $NR_VICTIMS)
>   do
>         _victim &
>         disown
>   done
>
>   _sync &
>   SYNC_PID=3D$!
>
>   _sleep $1
>   _elapsed
>   touch .done
>   wait $SYNC_PID
>
>   echo "OK"
>   exit 0
>
> Without this patch, that reproducer:
> - Ran for 6+ minutes instead of 60s
> - Hung hundreds of threads in D state on the csum reader lock
> - Got a commit stuck for 3 minutes
>
> sync done in 388s
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Wed Jul  9 09:52:31 PM UTC 2025
> elapsed: 420
> commits 2
> cur_commit_ms 0
> last_commit_ms 159446
> max_commit_ms 159446
> total_commit_ms 160058
> some avg10=3D99.03 avg60=3D98.97 avg300=3D75.43 total=3D418033386
> full avg10=3D82.79 avg60=3D80.52 avg300=3D59.45 total=3D324995274
>
> 419 hits state R, D comms big-read
>                  btrfs_tree_read_lock_nested
>                  btrfs_read_lock_root_node
>                  btrfs_search_slot
>                  btrfs_lookup_csum
>                  btrfs_lookup_bio_sums
>                  btrfs_submit_bbio
>
> 1 hits state D comms btrfs-transacti
>                  btrfs_tree_lock_nested
>                  btrfs_lock_root_node
>                  btrfs_search_slot
>                  btrfs_del_csums
>                  __btrfs_run_delayed_refs
>                  btrfs_run_delayed_refs
>
> With the patch, the reproducer exits naturally, in 65s, completing a
> pretty decent 4 commits, despite heavy memory pressure. Occasionally you
> can still trigger a rather long commit (couple seconds) but never one
> that is minutes long.
>
> sync done in 3s
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> elapsed: 65
> commits 4
> cur_commit_ms 0
> last_commit_ms 485
> max_commit_ms 689
> total_commit_ms 2453
> some avg10=3D98.28 avg60=3D64.54 avg300=3D19.39 total=3D64849893
> full avg10=3D74.43 avg60=3D48.50 avg300=3D14.53 total=3D48665168
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
> v7:
> - fix various typos.
> - remove an unneeded fs_info variable.
> - rework the commit message and inline comment to better reflect the
>   important details of the difference in lock contention between the eb
>   rwsems and the commit_root_sem.
> - include the full standalone reproduction script in the commit message.
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
>  fs/btrfs/extent_io.c   | 38 ++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/file-item.c   | 29 +++++++++++++++++++++++++++++
>  5 files changed, 96 insertions(+)
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
> index 685ee685ce92..a8b3d27699e8 100644
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
> @@ -113,6 +123,28 @@ struct btrfs_bio_ctrl {
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
> +
> +       ASSERT(bbio);
> +
> +       if (!(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_READ && is_data_inode=
(bbio->inode)))
> +               return;
> +
> +       if (bio_ctrl->generation &&
> +           bio_ctrl->generation < btrfs_get_fs_generation(bbio->inode->r=
oot->fs_info))
> +               btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio);
> +       else
> +               btrfs_bio_clear_csum_search_commit_root(bio_ctrl->bbio);
> +}
> +
>  static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>  {
>         struct btrfs_bio *bbio =3D bio_ctrl->bbio;
> @@ -123,6 +155,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio=
_ctrl)
>         /* Caller should ensure the bio has at least some range added */
>         ASSERT(bbio->bio.bi_iter.bi_size);
>
> +       bio_set_csum_search_commit_root(bio_ctrl);
> +
>         if (btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_READ &&
>             bio_ctrl->compress_type !=3D BTRFS_COMPRESS_NONE)
>                 btrfs_submit_compressed_read(bbio);
> @@ -131,6 +165,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio=
_ctrl)
>
>         /* The bbio is owned by the end_io handler now */
>         bio_ctrl->bbio =3D NULL;
> +       /* Reset the generation for the next bio */
> +       bio_ctrl->generation =3D 0;
>  }
>
>  /*
> @@ -1026,6 +1062,8 @@ static int btrfs_do_readpage(struct folio *folio, s=
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
> index c09fbc257634..b33742aceacb 100644
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

Well not just the root node's extent buffer, but any extent buffer
from the csum tree (more so for higher levels of course).

> +        *
> +        * This is important because that lock is an rwswem which gets

 rwswem -> rwsem

Anyway these can be fixed at commit time.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks Boris!

> +        * pretty heavy write load, unlike the commit_root_sem.
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
> +        * while we are not holding the commit_root_sem, and we get csums
> +        * from across transactions.
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
> 2.50.0
>
>

