Return-Path: <linux-btrfs+bounces-15424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B4B0062C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E5D1C479EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD72749C3;
	Thu, 10 Jul 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="OvfRKoYI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i8PNZCCs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4FB273D9C
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160360; cv=none; b=I6sH2vj2WHhlspZAMiSZWvQDx9mPaPAxbTHuBq2BWBWvZEhG7nLvXW3I5CrcTmyHRS3cDv7zLtgRgZCUVcab2Lqag4Z252AuBJ3VqzjDyn0gs6VutV6Qcv93kQlt0lYPhroY0KsFHo0UlCxwQGw9GiZnxNHvOfSpnP56wcW0XjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160360; c=relaxed/simple;
	bh=BOHFJLtM8Ki/D1ij56VDBpNUF4d456mR4ZBTCwvbIP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMi/CK0uXLwcJaaI2yBoc2exXFOhQZdNHXnze/arzo4qaBF9mRIsP1yhB2yzHheW8yU/wCRj0Ys53byfbsmAes5Fun5wlOHdbQlbVfW80TAx2WGZE+Iezsj8N34uC5a94OP+BiK+jpU3VbaIqI9i9WyzOHZv5ZY9hRNrMphUI/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=OvfRKoYI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i8PNZCCs; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 105567A0119;
	Thu, 10 Jul 2025 11:12:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 10 Jul 2025 11:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1752160355;
	 x=1752246755; bh=NxD19YjBQ48/9DhK1JXEyFDsidy4OvuWVFmZmP96Dbg=; b=
	OvfRKoYIn6AbGKOF9RIZ3blRQM63wPG/05YI5CJyTpxG9rER+ldp2dneFZYzro6K
	qD1O61yod2xYALBLUQ903fGfKHfzKkPPvF3i5DAF7ruge22RyqNe/HNWwklA6H9y
	TSYIiI0B59F9BOqz8RZ/T3jLN7AeTtmBS60981jPz4sHsAj9+s7S+uFVGmJbN4XB
	FHd0K5JmqwgeHbz/iVhAl5kQVLRcbVcd8U+Xpu4fUnvy6ChLmTMnOTKAIBG86FWo
	U0+1RGBsbR81yCrC8YZPblW9qsAO4y9D8sNJ4byelmsPXaiNRROrlw5GQ5i5uDsn
	M43z6/l+xZJ0A+7HtOdqvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752160355; x=
	1752246755; bh=NxD19YjBQ48/9DhK1JXEyFDsidy4OvuWVFmZmP96Dbg=; b=i
	8PNZCCsQZKtSygIicUt5/nz3QLRHTcTgKSWBolSMh80kb4tS8HF5DxvWf5pSrPeW
	6NcXXgOERlcXObqCOW/Xs8HIymA0bHZUCd3nQ+65Gr0Q5CtcBgtMwoj8NdeWPFCo
	Xr1sNyXJblvABqDk14UuWPLzZSGh3mBdmS31FZpezsP0It2qk4tZ58bCMyDtneGF
	cIkGGv+RSNFdHInLfKXiZYUADYCIGGDnn4A2FKs3HynH1aeokicK5A2lRtw7Qoxc
	HQeveab2/qvPKKwoLJKvwoxNLBkkwDQzJ189Wh0cKcq65DGTXKDxGhyWCylYI9E9
	1sKVlsYhwt7H2P0UuVFzQ==
X-ME-Sender: <xms:Y9hvaLc-kmDxGzqHQGoTgzkigBbgAIuQNuzcYXjhTiF-GKeribACbQ>
    <xme:Y9hvaEcmzzkNXb77kvI0lrnQHpKKoFzJQwU_wLPLKyjGyqS5V23brXrtJqHDdxlqL
    NRp27J5Y6PA6UOYKAI>
X-ME-Received: <xmr:Y9hvaN-Z1X0nim0lEj1m1AnVs4ZP1FR6-4pb4tavSohy0FT7xrWQi032LicANEV5PGg3k8-KKqfIVuKA_Pg2yC1tSHI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeffue
    egheegheehueeggfehfedvhefhhefgledtgfelffeffefftdevvdejgeefteenucffohhm
    rghinheplhhptgdrvghvvghnthhspdgsihgpihhtvghrrdgsihenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumh
    grnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmh
    esfhgsrdgtohhm
X-ME-Proxy: <xmx:Y9hvaIlZJiLN5oKAA6rJL4TI8nl8pCxflwvDxrsCKsjOpgV8JVXaYg>
    <xmx:Y9hvaH-2omFAifKBIoXuKtBeTwfT0tnLRBbBIZBGFeNYMIXznngZOg>
    <xmx:Y9hvaOnXJI8Xu-4A4b85ZAVFMqRtJew7_2DzlU355Ta_9rrvy6IIeA>
    <xmx:Y9hvaM0EpoiL56V35gEy5dTrvHYZYjKY29i_SpSzZqFD-ZNkhKHn4w>
    <xmx:Y9hvaHkSQ3c9t80oRobLkduCgGxa5ZhkugTkgjgnVYoH6lsxgN_PT8Su>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 11:12:35 -0400 (EDT)
Date: Thu, 10 Jul 2025 08:14:19 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7] btrfs: try to search for data csums in commit root
Message-ID: <20250710151419.GA588947@zen.localdomain>
References: <112a66d49285e38d7a567aa780d9545baafd3deb.1752101883.git.boris@bur.io>
 <CAL3q7H5ut-z5RAYz0m=k48SjFhxcfH6szonmZu3w2epkgb-few@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5ut-z5RAYz0m=k48SjFhxcfH6szonmZu3w2epkgb-few@mail.gmail.com>

On Thu, Jul 10, 2025 at 01:05:32PM +0100, Filipe Manana wrote:
> On Thu, Jul 10, 2025 at 12:00 AM Boris Burkov <boris@bur.io> wrote:
> >
> > If you run a workload with:
> > - a cgroup that does tons of parallel data reading, with a working set
> >   much larger than its memory limit
> > - a second cgroup that writes relatively fewer files, with overwrites,
> >   with no memory limit
> > (see full code listing at the bottom for a reproducer)
> >
> > then what quickly occurs is:
> > - we have a large number of threads trying to read the csum tree
> > - we have a decent number of threads deleting csums running delayed refs
> > - we have a large number of threads in direct reclaim and thus high
> >   memory pressure
> >
> > The result of this is that we writeback the csum tree repeatedly mid
> > transaction, to get back the extent_buffer folios for reclaim. As a
> > result, we repeatedly COW the csum tree for the delayed refs that are
> > deleting csums. This means repeatedly write locking the higher levels of
> > the tree.
> >
> > As a result of this, we achieve an unpleasant priority inversion. We
> > have:
> > - a high degree of contention on the csum root node (and other upper
> >   nodes) eb rwsem
> > - a memory starved cgroup doing tons of reclaim on CPU.
> > - many reader threads in the memory starved cgroup "holding" the sem
> >   as readers, but not scheduling promptly. i.e., task __state == 0, but
> >   not running on a cpu.
> > - btrfs_commit_transaction stuck trying to acquire the sem as a writer.
> >   (running delayed_refs, deleting csums for unreferenced data extents)
> >
> > This results in arbitrarily long transactions. This then results in
> > seriously degraded performance for any cgroup using the filesystem (the
> > victim cgroup in the script).
> >
> > It isn't an academic problem, as we see this exact problem in production
> > at Meta with one cgroup over its memory limit ruining btrfs performance
> > for the whole system, stalling critical system services that depend on
> > btrfs syncs.
> >
> > The underlying scheduling "problem" with global rwsems is sort of thorny
> > and apparently well known and was discussed at LPC 2024, for example.
> >
> > As a result, our main lever in the short term is just trying to reduce
> > contention on our various rwsems with an eye to reducing the frequency
> > of write locking, to avoid disabling the read lock fast acquistion path.
> >
> > Luckily, it seems likely that many reads are for old extents written
> > many transactions ago, and that for those we *can* in fact search the
> > commit root. The commit_root_sem only gets taken write once, near the
> > end of transaction commit, no matter how much memory pressure there is,
> > so we have much less contention between readers and writers.
> >
> > This change detects when we are trying to read an old extent (according
> > to extent map generation) and then wires that through bio_ctrl to the
> > btrfs_bio, which unfortunately isn't allocated yet when we have this
> > information. Luckily, we don't need this flag in the bio after
> > submitting, so we can save space by setting it on bbio->bio.bi_flags
> > and clear before submitting, so the block layer is unaffected.
> >
> > When we go to lookup the csums in lookup_bio_sums we can check this
> > condition on the btrfs_bio and do the commit root lookup accordingly.
> >
> > Note that a single bio_ctrl might collect a few extent_maps into a single
> > bio, so it is important to track a maximum generation across all the
> > extent_maps used for each bio to make an accurate decision on whether it
> > is valid to look in the commit root. If any extent_map is updated in the
> > current generation, we can't use the commit root.
> >
> > To test and reproduce this issue, I used the following script and
> > accompanying C program (to avoid bottlenecks in constantly forking
> > thousands of dd processes):
> >
> > ====== big-read.c ======
> >   #include <fcntl.h>
> >   #include <stdio.h>
> >   #include <stdlib.h>
> >   #include <sys/mman.h>
> >   #include <sys/stat.h>
> >   #include <unistd.h>
> >   #include <errno.h>
> >
> >   #define BUF_SZ (128 * (1 << 10UL))
> >
> >   int read_once(int fd, size_t sz) {
> >         char buf[BUF_SZ];
> >         size_t rd = 0;
> >         int ret = 0;
> >
> >         while (rd < sz) {
> >                 ret = read(fd, buf, BUF_SZ);
> >                 if (ret < 0) {
> >                         if (errno == EINTR)
> >                                 continue;
> >                         fprintf(stderr, "read failed: %d\n", errno);
> >                         return -errno;
> >                 } else if (ret == 0) {
> >                         break;
> >                 } else {
> >                         rd += ret;
> >                 }
> >         }
> >         return rd;
> >   }
> >
> >   int read_loop(char *fname) {
> >         int fd;
> >         struct stat st;
> >         size_t sz = 0;
> >         int ret;
> >
> >         while (1) {
> >                 fd = open(fname, O_RDONLY);
> >                 if (fd == -1) {
> >                         perror("open");
> >                         return 1;
> >                 }
> >                 if (!sz) {
> >                         if (!fstat(fd, &st)) {
> >                                 sz = st.st_size;
> >                         } else {
> >                                 perror("stat");
> >                                 return 1;
> >                         }
> >                 }
> >
> >                   ret = read_once(fd, sz);
> >                 close(fd);
> >         }
> >   }
> >
> >   int main(int argc, char *argv[]) {
> >         int fd;
> >         struct stat st;
> >         off_t sz;
> >         char *buf;
> >         int ret;
> >
> >         if (argc != 2) {
> >                 fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
> >                 return 1;
> >         }
> >
> >         return read_loop(argv[1]);
> >   }
> >
> > ====== repro.sh ======
> >   #!/usr/bin/env bash
> >
> >   SCRIPT=$(readlink -f "$0")
> >   DIR=$(dirname "$SCRIPT")
> >
> >   dev=$1
> >   mnt=$2
> >   shift
> >   shift
> >
> >   CG_ROOT=/sys/fs/cgroup
> >   BAD_CG=$CG_ROOT/bad-nbr
> >   GOOD_CG=$CG_ROOT/good-nbr
> >   NR_BIGGOS=1
> >   NR_LITTLE=10
> >   NR_VICTIMS=32
> >   NR_VILLAINS=512
> >
> >   START_SEC=$(date +%s)
> >
> >   _elapsed() {
> >         echo "elapsed: $(($(date +%s) - $START_SEC))"
> >   }
> >
> >   _stats() {
> >         local sysfs=/sys/fs/btrfs/$(findmnt -no UUID $dev)
> >
> >         echo "================"
> >         date
> >         _elapsed
> >         cat $sysfs/commit_stats
> >         cat $BAD_CG/memory.pressure
> >   }
> >
> >   _setup_cgs() {
> >         echo "+memory +cpuset" > $CG_ROOT/cgroup.subtree_control
> >         mkdir -p $GOOD_CG
> >         mkdir -p $BAD_CG
> >         echo max > $BAD_CG/memory.max
> >         # memory.high much less than the working set will cause heavy reclaim
> >         echo $((1 << 30)) > $BAD_CG/memory.high
> >
> >         # victims get a subset of villain CPUs
> >         echo 0 > $GOOD_CG/cpuset.cpus
> >         echo 0,1,2,3 > $BAD_CG/cpuset.cpus
> >   }
> >
> >   _kill_cg() {
> >         local cg=$1
> >         local attempts=0
> >         echo "kill cgroup $cg"
> >         [ -f $cg/cgroup.procs ] || return
> >         while true; do
> >                 attempts=$((attempts + 1))
> >                 echo 1 > $cg/cgroup.kill
> >                 sleep 1
> >                 procs=$(wc -l $cg/cgroup.procs | cut -d' ' -f1)
> >                 [ $procs -eq 0 ] && break
> >         done
> >         rmdir $cg
> >         echo "killed cgroup $cg in $attempts attempts"
> >   }
> >
> >   _biggo_vol() {
> >         echo $mnt/biggo_vol.$1
> >   }
> >
> >   _biggo_file() {
> >         echo $(_biggo_vol $1)/biggo
> >   }
> >
> >   _subvoled_biggos() {
> >         total_sz=$((10 << 30))
> >         per_sz=$((total_sz / $NR_VILLAINS))
> >         dd_count=$((per_sz >> 20))
> >         echo "create $NR_VILLAINS subvols with a file of size $per_sz bytes for a total of $total_sz bytes."
> >         for i in $(seq $NR_VILLAINS)
> >         do
> >                 btrfs subvol create $(_biggo_vol $i) &>/dev/null
> >                 dd if=/dev/zero of=$(_biggo_file $i) bs=1M count=$dd_count &>/dev/null
> >         done
> >         echo "done creating subvols."
> >   }
> >
> >   _setup() {
> >         [ -f .done ] && rm .done
> >         findmnt -n $dev && exit 1
> >         if [ -f .re-mkfs ]; then
> >                 mkfs.btrfs -f -m single -d single $dev >/dev/null || exit 2
> >         else
> >                 echo "touch .re-mkfs to populate the test fs"
> >         fi
> >
> >         mount -o noatime $dev $mnt || exit 3
> >         [ -f .re-mkfs ] && _subvoled_biggos
> >         _setup_cgs
> >   }
> >
> >   _my_cleanup() {
> >         echo "CLEANUP!"
> >         _kill_cg $BAD_CG
> >         _kill_cg $GOOD_CG
> >         sleep 1
> >         umount $mnt
> >   }
> >
> >   _bad_exit() {
> >         _err "Unexpected Exit! $?"
> >         _stats
> >         exit $?
> >   }
> >
> >   trap _my_cleanup EXIT
> >   trap _bad_exit INT TERM
> >
> >   _setup
> >
> >   # Use a lot of page cache reading the big file
> >   _villain() {
> >         local i=$1
> >         echo $BASHPID > $BAD_CG/cgroup.procs
> >         $DIR/big-read $(_biggo_file $i)
> >   }
> >
> >   # Hit del_csum a lot by overwriting lots of small new files
> >   _victim() {
> >         echo $BASHPID > $GOOD_CG/cgroup.procs
> >         i=0;
> >         while (true)
> >         do
> >                 local tmp=$mnt/tmp.$i
> >
> >                 dd if=/dev/zero of=$tmp bs=4k count=2 >/dev/null 2>&1
> >                 i=$((i+1))
> >                 [ $i -eq $NR_LITTLE ] && i=0
> >         done
> >   }
> >
> >   _one_sync() {
> >         echo "sync..."
> >         before=$(date +%s)
> >         sync
> >         after=$(date +%s)
> >         echo "sync done in $((after - before))s"
> >         _stats
> >   }
> >
> >   # sync in a loop
> >   _sync() {
> >         echo "start sync loop"
> >         syncs=0
> >         echo $BASHPID > $GOOD_CG/cgroup.procs
> >         while true
> >         do
> >                 [ -f .done ] && break
> >                 _one_sync
> >                 syncs=$((syncs + 1))
> >                 [ -f .done ] && break
> >                 sleep 10
> >         done
> >         if [ $syncs -eq 0 ]; then
> >                 echo "do at least one sync!"
> >                 _one_sync
> >         fi
> >         echo "sync loop done."
> >   }
> >
> >   _sleep() {
> >         local time=${1-60}
> >         local now=$(date +%s)
> >         local end=$((now + time))
> >         while [ $now -lt $end ];
> >         do
> >                 echo "SLEEP: $((end - now))s left. Sleep 10."
> >                 sleep 10
> >                 now=$(date +%s)
> >         done
> >   }
> >
> >   echo "start $NR_VILLAINS villains"
> >   for i in $(seq $NR_VILLAINS)
> >   do
> >         _villain $i &
> >         disown # get rid of annoying log on kill (done via cgroup anyway)
> >   done
> >
> >   echo "start $NR_VICTIMS victims"
> >   for i in $(seq $NR_VICTIMS)
> >   do
> >         _victim &
> >         disown
> >   done
> >
> >   _sync &
> >   SYNC_PID=$!
> >
> >   _sleep $1
> >   _elapsed
> >   touch .done
> >   wait $SYNC_PID
> >
> >   echo "OK"
> >   exit 0
> >
> > Without this patch, that reproducer:
> > - Ran for 6+ minutes instead of 60s
> > - Hung hundreds of threads in D state on the csum reader lock
> > - Got a commit stuck for 3 minutes
> >
> > sync done in 388s
> > ================
> > Wed Jul  9 09:52:31 PM UTC 2025
> > elapsed: 420
> > commits 2
> > cur_commit_ms 0
> > last_commit_ms 159446
> > max_commit_ms 159446
> > total_commit_ms 160058
> > some avg10=99.03 avg60=98.97 avg300=75.43 total=418033386
> > full avg10=82.79 avg60=80.52 avg300=59.45 total=324995274
> >
> > 419 hits state R, D comms big-read
> >                  btrfs_tree_read_lock_nested
> >                  btrfs_read_lock_root_node
> >                  btrfs_search_slot
> >                  btrfs_lookup_csum
> >                  btrfs_lookup_bio_sums
> >                  btrfs_submit_bbio
> >
> > 1 hits state D comms btrfs-transacti
> >                  btrfs_tree_lock_nested
> >                  btrfs_lock_root_node
> >                  btrfs_search_slot
> >                  btrfs_del_csums
> >                  __btrfs_run_delayed_refs
> >                  btrfs_run_delayed_refs
> >
> > With the patch, the reproducer exits naturally, in 65s, completing a
> > pretty decent 4 commits, despite heavy memory pressure. Occasionally you
> > can still trigger a rather long commit (couple seconds) but never one
> > that is minutes long.
> >
> > sync done in 3s
> > ================
> > elapsed: 65
> > commits 4
> > cur_commit_ms 0
> > last_commit_ms 485
> > max_commit_ms 689
> > total_commit_ms 2453
> > some avg10=98.28 avg60=64.54 avg300=19.39 total=64849893
> > full avg10=74.43 avg60=48.50 avg300=14.53 total=48665168
> >
> > some random rwalker samples showed the most common stack in reclaim,
> > rather than the csum tree:
> > 145 hits state R comms bash, sleep, dd, shuf
> >                  shrink_folio_list
> >                  shrink_lruvec
> >                  shrink_node
> >                  do_try_to_free_pages
> >                  try_to_free_mem_cgroup_pages
> >                  reclaim_high
> >
> > Link: https://lpc.events/event/18/contributions/1883/
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v7:
> > - fix various typos.
> > - remove an unneeded fs_info variable.
> > - rework the commit message and inline comment to better reflect the
> >   important details of the difference in lock contention between the eb
> >   rwsems and the commit_root_sem.
> > - include the full standalone reproduction script in the commit message.
> > v6:
> > - properly handle bio_ctrl submitting a bbio spanning multiple
> >   extent_maps with different generations. This was causing csum errors
> >   on the previous versions.
> > v5:
> > - static inline flag functions
> > - make bbio const for the getter
> > - move around and improve the comments
> > v4:
> > - replace generic private flag machinery with specific function for the
> >   one flag
> > - move the bio_ctrl field to take advantage of alignment
> > v3:
> > - add some simple machinery for setting/getting/clearing btrfs private
> >   flags in bi_flags
> > - clear those flags before bio_submit (ensure no-op wrt block layer)
> > - store the csum commit root flag there to save space
> > v2:
> > - hold the commit_root_sem for the duration of the entire lookup, not
> >   just per btrfs_search_slot. Note that we can't naively do the thing
> >   where we release the lock every loop as that is exactly what we are
> >   trying to avoid. Theoretically, we could re-grab the lock and fully
> >   start over if the lock is write contended or something. I suspect the
> >   rwsem fairness features will let the commit writer get it fast enough
> >   anyway.
> >
> > ---
> >  fs/btrfs/bio.c         | 10 ++++++++++
> >  fs/btrfs/bio.h         | 17 +++++++++++++++++
> >  fs/btrfs/compression.c |  2 ++
> >  fs/btrfs/extent_io.c   | 38 ++++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/file-item.c   | 29 +++++++++++++++++++++++++++++
> >  5 files changed, 96 insertions(+)
> >
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index 50b5fc1c06d7..789cb3e5ba6d 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -93,6 +93,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
> >                 refcount_inc(&orig_bbio->ordered->refs);
> >                 bbio->ordered = orig_bbio->ordered;
> >         }
> > +       if (btrfs_bio_csum_search_commit_root(orig_bbio))
> > +               btrfs_bio_set_csum_search_commit_root(bbio);
> >         atomic_inc(&orig_bbio->pending_ios);
> >         return bbio;
> >  }
> > @@ -479,6 +481,14 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
> >  static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
> >                              struct btrfs_io_stripe *smap, int mirror_num)
> >  {
> > +       /*
> > +        * It is important to clear the bits we used in bio->bi_flags.
> > +        * Because bio->bi_flags belongs to the block layer, we should
> > +        * avoid leaving stray bits set when we transfer ownership of
> > +        * the bio by submitting it.
> > +        */
> > +       btrfs_bio_clear_csum_search_commit_root(btrfs_bio(bio));
> > +
> >         if (!bioc) {
> >                 /* Single mirror read/write fast path. */
> >                 btrfs_bio(bio)->mirror_num = mirror_num;
> > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > index dc2eb43b7097..9f4bcbe0a76c 100644
> > --- a/fs/btrfs/bio.h
> > +++ b/fs/btrfs/bio.h
> > @@ -104,6 +104,23 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> >                                   btrfs_bio_end_io_t end_io, void *private);
> >  void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
> >
> > +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT (1U << (BIO_FLAG_LAST + 1))
> > +
> > +static inline void btrfs_bio_set_csum_search_commit_root(struct btrfs_bio *bbio)
> > +{
> > +       bbio->bio.bi_flags |= BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> > +}
> > +
> > +static inline void btrfs_bio_clear_csum_search_commit_root(struct btrfs_bio *bbio)
> > +{
> > +       bbio->bio.bi_flags &= ~BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> > +}
> > +
> > +static inline bool btrfs_bio_csum_search_commit_root(const struct btrfs_bio *bbio)
> > +{
> > +       return bbio->bio.bi_flags & BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
> > +}
> > +
> >  /* Submit using blkcg_punt_bio_submit. */
> >  #define REQ_BTRFS_CGROUP_PUNT                  REQ_FS_PRIVATE
> >
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index d09d622016ef..cadf5eccc640 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -602,6 +602,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
> >         cb->compressed_len = compressed_len;
> >         cb->compress_type = btrfs_extent_map_compression(em);
> >         cb->orig_bbio = bbio;
> > +       if (btrfs_bio_csum_search_commit_root(bbio))
> > +               btrfs_bio_set_csum_search_commit_root(&cb->bbio);
> >
> >         btrfs_free_extent_map(em);
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 685ee685ce92..a8b3d27699e8 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -101,6 +101,16 @@ struct btrfs_bio_ctrl {
> >         enum btrfs_compression_type compress_type;
> >         u32 len_to_oe_boundary;
> >         blk_opf_t opf;
> > +       /*
> > +        * For data read bios, we attempt to optimize csum lookups if the extent
> > +        * generation is older than the current one. To make this possible, we
> > +        * need to track the maximum generation of an extent in a bio_ctrl to
> > +        * make the decision when submitting the bio.
> > +        *
> > +        * See the comment in btrfs_lookup_bio_sums for more detail on the
> > +        * need for this optimization.
> > +        */
> > +       u64 generation;
> >         btrfs_bio_end_io_t end_io_func;
> >         struct writeback_control *wbc;
> >
> > @@ -113,6 +123,28 @@ struct btrfs_bio_ctrl {
> >         struct readahead_control *ractl;
> >  };
> >
> > +/*
> > + * Helper to set the csum search commit root option for a bio_ctrl's bbio
> > + * before submitting the bio.
> > + *
> > + * Only for use by submit_one_bio().
> > + */
> > +static void bio_set_csum_search_commit_root(struct btrfs_bio_ctrl *bio_ctrl)
> > +{
> > +       struct btrfs_bio *bbio = bio_ctrl->bbio;
> > +
> > +       ASSERT(bbio);
> > +
> > +       if (!(btrfs_op(&bbio->bio) == BTRFS_MAP_READ && is_data_inode(bbio->inode)))
> > +               return;
> > +
> > +       if (bio_ctrl->generation &&
> > +           bio_ctrl->generation < btrfs_get_fs_generation(bbio->inode->root->fs_info))
> > +               btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio);
> > +       else
> > +               btrfs_bio_clear_csum_search_commit_root(bio_ctrl->bbio);
> > +}
> > +
> >  static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> >  {
> >         struct btrfs_bio *bbio = bio_ctrl->bbio;
> > @@ -123,6 +155,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> >         /* Caller should ensure the bio has at least some range added */
> >         ASSERT(bbio->bio.bi_iter.bi_size);
> >
> > +       bio_set_csum_search_commit_root(bio_ctrl);
> > +
> >         if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
> >             bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
> >                 btrfs_submit_compressed_read(bbio);
> > @@ -131,6 +165,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> >
> >         /* The bbio is owned by the end_io handler now */
> >         bio_ctrl->bbio = NULL;
> > +       /* Reset the generation for the next bio */
> > +       bio_ctrl->generation = 0;
> >  }
> >
> >  /*
> > @@ -1026,6 +1062,8 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
> >                 if (prev_em_start)
> >                         *prev_em_start = em->start;
> >
> > +               bio_ctrl->generation = max(bio_ctrl->generation, em->generation);
> > +
> >                 btrfs_free_extent_map(em);
> >                 em = NULL;
> >
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index c09fbc257634..b33742aceacb 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -397,6 +397,33 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
> >                 path->skip_locking = 1;
> >         }
> >
> > +       /*
> > +        * If we are searching for a csum of an extent from a past
> > +        * transaction, we can search in the commit root and reduce
> > +        * lock contention on the csum tree root node's extent buffer.
> 
> Well not just the root node's extent buffer, but any extent buffer
> from the csum tree (more so for higher levels of course).
> 

Thanks for re-reading it again.. I did actually lightly edit this
comment too (including this sentence, but also added some stuff about
reclaim/pressure that you highlighted in a previous email) aaaaaand
forgot to add it to my commit. My mistake!

> > +        *
> > +        * This is important because that lock is an rwswem which gets
> 
>  rwswem -> rwsem
> 
> Anyway these can be fixed at commit time.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks Boris!
> 
> > +        * pretty heavy write load, unlike the commit_root_sem.
> > +        *
> > +        * Due to how rwsem is implemented, there is a possible
> > +        * priority inversion where the readers holding the lock don't
> > +        * get scheduled (say they're in a cgroup stuck in heavy reclaim)
> > +        * which then blocks writers, including transaction commit. By
> > +        * using a semaphore with fewer writers (only a commit switching
> > +        * the roots), we make this issue less likely.
> > +        *
> > +        * Note that we don't rely on btrfs_search_slot to lock the
> > +        * commit root csum. We call search_slot multiple times, which would
> > +        * create a potential race where a commit comes in between searches
> > +        * while we are not holding the commit_root_sem, and we get csums
> > +        * from across transactions.
> > +        */
> > +       if (btrfs_bio_csum_search_commit_root(bbio)) {
> > +               path->search_commit_root = 1;
> > +               path->skip_locking = 1;
> > +               down_read(&fs_info->commit_root_sem);
> > +       }
> > +
> >         while (bio_offset < orig_len) {
> >                 int count;
> >                 u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;
> > @@ -442,6 +469,8 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
> >                 bio_offset += count * sectorsize;
> >         }
> >
> > +       if (btrfs_bio_csum_search_commit_root(bbio))
> > +               up_read(&fs_info->commit_root_sem);
> >         return ret;
> >  }
> >
> > --
> > 2.50.0
> >
> >

