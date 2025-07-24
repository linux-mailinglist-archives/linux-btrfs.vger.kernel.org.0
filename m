Return-Path: <linux-btrfs+bounces-15658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37758B1120C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 22:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4076B03537
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 20:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF42E253B71;
	Thu, 24 Jul 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="S80i+WVo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OkAsCmBk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F824678C
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Jul 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387976; cv=none; b=VgDzJJA4rwZYvz06dYm4IyhV6RTBFTaDW9YJEKBJy+ZOe/v4J2QqrjEbotqxJdO8YTuBDc/ODNux8X1UDZ7a/GgUWdglonLObMQTTMfWOkEC4c0/LbM+VgEbPhcr+zSNsljc7VFMYvZvauvJz5SE992cByxIQdQS0Ds2SB6qHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387976; c=relaxed/simple;
	bh=vqxK9whbcH5paL6oWdM4wGv0KmqESw7YxG/jmDndLKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xg5S1G7i913gtSfuNJXB3NnjxYICo0qBypOxP0P31/Re3LqI2F4wL5mMTb1AIUZnj+iVMooBvsp9AxdYdx53WEV2gWOc3mSdjud6LjWDm4APmOl2fGwHNMuwMGnW1TYeI6pOUR02rWifqmj4MxczoFB5J8eMGtPj76eWArZ0/5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=S80i+WVo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OkAsCmBk; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3912C7A0195;
	Thu, 24 Jul 2025 16:12:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 24 Jul 2025 16:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1753387972; x=1753474372; bh=cER7bXFP3yM4a7nYd6tph
	2BAkkGHftlJ1CrRg7dEvck=; b=S80i+WVoCCN8s7CaaGClHNvTVukqS6jbFSjFR
	dVZEObd6oQQk5hPZFO43wbAeX6HN+H9CBvLaBqIn3sbmRwyLwyOKMZqF33vgcRYf
	eyRCDC+W5F5Jr71tIBviNBYqGBWY8MTa1h5AQ6fx0JIKrXrz8TnthKEPT8Bz5C/7
	JnR4QgbZ1fN/AW50o6f9iNjwhLcxjcQ13dv5UtqFcrAzmsuMJb5OFLIHncUuyy7G
	2vVkZGUnLDZYsBDNpzNC+I+r1Up3B0PrUUV5tR5Kq8yyovVjGQZ8bZDT+iQa8qMI
	SSD3dIhBmX+VAoQF9uX5flSuzDgAmkl+RpWuRlnwJxw3klJYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753387972; x=1753474372; bh=cER7bXFP3yM4a7nYd6tph2BAkkGHftlJ1Cr
	Rg7dEvck=; b=OkAsCmBkTWoYkp4bTxegNWH7PXVVeWsUHXlVbnL6c/HBhx1ach4
	5qhTQ6h2DkmR9DArW9NY5ihSn4w/hbem85gQHjtT+zDbVpMEbRa1lYmD9L1rALdB
	cb1SFjGGDaZhBfovJRxvO1azZnuflAqN1fO0EWw4okyUdZ0qh25E0HPw1qr6nVGL
	2+JGaUduj7ytoVex6BLIaljFxvTNoIkq4b/IFRuticwnE0MMFW48qIrgIsxkOZAz
	8T0eyD2w3qsfiL/brbPiDd8zp/76tQLIFJ2CI6Jgfq5NXYUsogLGEDGp47ZK6qI9
	fYJkEzczlRYUKvgi9lLGk16iLnnXxMjxOVQ==
X-ME-Sender: <xms:w5OCaBytmBFsEHWlyG8sUERXTDVo-E3gvv4ms1WdHZoBUaKY206osw>
    <xme:w5OCaBfTobsMtsRlMfK5YtHInqbImMe20YvWRjzRf2P-fXFtK1J6NJ3cSjCEGN6Kp
    imaf2WlHOaEBMDUrIA>
X-ME-Received: <xmr:w5OCaNLTm_rgDIjf4CpaE8We7RU0KRc90V1y3vPMU7ufibE4CzHr01VZg1z8ZVtHB5rJywWmQLkcImqL9O4AIcoYaJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepkeejhfeugfeglefftdegueevteduudffffeiieffgfetgfeigf
    elveduveeggfdtnecuffhomhgrihhnpehlphgtrdgvvhgvnhhtshdpsghipghithgvrhdr
    sghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    horhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:w5OCaCFaBgDL_izKUbxHho__yZxau5YVehHbiVKO7NxVArUIo_orKQ>
    <xmx:w5OCaHrxsQktvNZLkYWvyabpzDBewC3XCu8vojOhf4CAQn7rtyr7yg>
    <xmx:w5OCaLQfxENESKewury6f8_zGJ5ZB3dYOqDbmNsneGtUi9rPA5cCNg>
    <xmx:w5OCaEMvvxKKguTCb2Tp4YWUrKuBEomtZT9dHSDfnWjYQmzUZ2V04Q>
    <xmx:xJOCaAIciZXXJiB6UmvQbiJD2N5GPLB4VWuvxqRUeJ8XG3vvYccDVvC8>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 16:12:51 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v8] btrfs: try to search for data csums in commit root
Date: Thu, 24 Jul 2025 13:14:05 -0700
Message-ID: <818a6ecac805e1a9c630275c8485e373ec9c4cb6.1753387903.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If you run a workload with:
- a cgroup that does tons of parallel data reading, with a working set
  much larger than its memory limit
- a second cgroup that writes relatively fewer files, with overwrites,
  with no memory limit
(see full code listing at the bottom for a reproducer)

then what quickly occurs is:
- we have a large number of threads trying to read the csum tree
- we have a decent number of threads deleting csums running delayed refs
- we have a large number of threads in direct reclaim and thus high
  memory pressure

The result of this is that we writeback the csum tree repeatedly mid
transaction, to get back the extent_buffer folios for reclaim. As a
result, we repeatedly COW the csum tree for the delayed refs that are
deleting csums. This means repeatedly write locking the higher levels of
the tree.

As a result of this, we achieve an unpleasant priority inversion. We
have:
- a high degree of contention on the csum root node (and other upper
  nodes) eb rwsem
- a memory starved cgroup doing tons of reclaim on CPU.
- many reader threads in the memory starved cgroup "holding" the sem
  as readers, but not scheduling promptly. i.e., task __state == 0, but
  not running on a cpu.
- btrfs_commit_transaction stuck trying to acquire the sem as a writer.
  (running delayed_refs, deleting csums for unreferenced data extents)

This results in arbitrarily long transactions. This then results in
seriously degraded performance for any cgroup using the filesystem (the
victim cgroup in the script).

It isn't an academic problem, as we see this exact problem in production
at Meta with one cgroup over its memory limit ruining btrfs performance
for the whole system, stalling critical system services that depend on
btrfs syncs.

The underlying scheduling "problem" with global rwsems is sort of thorny
and apparently well known and was discussed at LPC 2024, for example.

As a result, our main lever in the short term is just trying to reduce
contention on our various rwsems with an eye to reducing the frequency
of write locking, to avoid disabling the read lock fast acquistion path.

Luckily, it seems likely that many reads are for old extents written
many transactions ago, and that for those we *can* in fact search the
commit root. The commit_root_sem only gets taken write once, near the
end of transaction commit, no matter how much memory pressure there is,
so we have much less contention between readers and writers.

This change detects when we are trying to read an old extent (according
to extent map generation) and then wires that through bio_ctrl to the
btrfs_bio, which unfortunately isn't allocated yet when we have this
information. When we go to lookup the csums in lookup_bio_sums we can
check this condition on the btrfs_bio and do the commit root lookup
accordingly.

Note that a single bio_ctrl might collect a few extent_maps into a single
bio, so it is important to track a maximum generation across all the
extent_maps used for each bio to make an accurate decision on whether it
is valid to look in the commit root. If any extent_map is updated in the
current generation, we can't use the commit root.

To test and reproduce this issue, I used the following script and
accompanying C program (to avoid bottlenecks in constantly forking
thousands of dd processes):

====== big-read.c ======
  #include <fcntl.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <sys/mman.h>
  #include <sys/stat.h>
  #include <unistd.h>
  #include <errno.h>

  #define BUF_SZ (128 * (1 << 10UL))

  int read_once(int fd, size_t sz) {
  	char buf[BUF_SZ];
  	size_t rd = 0;
  	int ret = 0;

  	while (rd < sz) {
  		ret = read(fd, buf, BUF_SZ);
  		if (ret < 0) {
  			if (errno == EINTR)
  				continue;
  			fprintf(stderr, "read failed: %d\n", errno);
  			return -errno;
  		} else if (ret == 0) {
  			break;
  		} else {
  			rd += ret;
  		}
  	}
  	return rd;
  }

  int read_loop(char *fname) {
  	int fd;
  	struct stat st;
  	size_t sz = 0;
  	int ret;

  	while (1) {
  		fd = open(fname, O_RDONLY);
  		if (fd == -1) {
  			perror("open");
  			return 1;
  		}
  		if (!sz) {
  			if (!fstat(fd, &st)) {
  				sz = st.st_size;
  			} else {
  				perror("stat");
  				return 1;
  			}
  		}

                  ret = read_once(fd, sz);
  		close(fd);
  	}
  }

  int main(int argc, char *argv[]) {
  	int fd;
  	struct stat st;
  	off_t sz;
  	char *buf;
  	int ret;

  	if (argc != 2) {
  		fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
  		return 1;
  	}

  	return read_loop(argv[1]);
  }

====== repro.sh ======
  #!/usr/bin/env bash

  SCRIPT=$(readlink -f "$0")
  DIR=$(dirname "$SCRIPT")

  dev=$1
  mnt=$2
  shift
  shift

  CG_ROOT=/sys/fs/cgroup
  BAD_CG=$CG_ROOT/bad-nbr
  GOOD_CG=$CG_ROOT/good-nbr
  NR_BIGGOS=1
  NR_LITTLE=10
  NR_VICTIMS=32
  NR_VILLAINS=512

  START_SEC=$(date +%s)

  _elapsed() {
  	echo "elapsed: $(($(date +%s) - $START_SEC))"
  }

  _stats() {
  	local sysfs=/sys/fs/btrfs/$(findmnt -no UUID $dev)

  	echo "================"
  	date
  	_elapsed
  	cat $sysfs/commit_stats
  	cat $BAD_CG/memory.pressure
  }

  _setup_cgs() {
  	echo "+memory +cpuset" > $CG_ROOT/cgroup.subtree_control
  	mkdir -p $GOOD_CG
  	mkdir -p $BAD_CG
  	echo max > $BAD_CG/memory.max
  	# memory.high much less than the working set will cause heavy reclaim
  	echo $((1 << 30)) > $BAD_CG/memory.high

  	# victims get a subset of villain CPUs
  	echo 0 > $GOOD_CG/cpuset.cpus
  	echo 0,1,2,3 > $BAD_CG/cpuset.cpus
  }

  _kill_cg() {
  	local cg=$1
  	local attempts=0
  	echo "kill cgroup $cg"
  	[ -f $cg/cgroup.procs ] || return
  	while true; do
  		attempts=$((attempts + 1))
  		echo 1 > $cg/cgroup.kill
  		sleep 1
  		procs=$(wc -l $cg/cgroup.procs | cut -d' ' -f1)
  		[ $procs -eq 0 ] && break
  	done
  	rmdir $cg
  	echo "killed cgroup $cg in $attempts attempts"
  }

  _biggo_vol() {
  	echo $mnt/biggo_vol.$1
  }

  _biggo_file() {
  	echo $(_biggo_vol $1)/biggo
  }

  _subvoled_biggos() {
  	total_sz=$((10 << 30))
  	per_sz=$((total_sz / $NR_VILLAINS))
  	dd_count=$((per_sz >> 20))
  	echo "create $NR_VILLAINS subvols with a file of size $per_sz bytes for a total of $total_sz bytes."
  	for i in $(seq $NR_VILLAINS)
  	do
  		btrfs subvol create $(_biggo_vol $i) &>/dev/null
  		dd if=/dev/zero of=$(_biggo_file $i) bs=1M count=$dd_count &>/dev/null
  	done
  	echo "done creating subvols."
  }

  _setup() {
  	[ -f .done ] && rm .done
  	findmnt -n $dev && exit 1
        if [ -f .re-mkfs ]; then
		mkfs.btrfs -f -m single -d single $dev >/dev/null || exit 2
	else
		echo "touch .re-mkfs to populate the test fs"
	fi

  	mount -o noatime $dev $mnt || exit 3
  	[ -f .re-mkfs ] && _subvoled_biggos
  	_setup_cgs
  }

  _my_cleanup() {
  	echo "CLEANUP!"
  	_kill_cg $BAD_CG
  	_kill_cg $GOOD_CG
  	sleep 1
  	umount $mnt
  }

  _bad_exit() {
  	_err "Unexpected Exit! $?"
  	_stats
  	exit $?
  }

  trap _my_cleanup EXIT
  trap _bad_exit INT TERM

  _setup

  # Use a lot of page cache reading the big file
  _villain() {
  	local i=$1
  	echo $BASHPID > $BAD_CG/cgroup.procs
  	$DIR/big-read $(_biggo_file $i)
  }

  # Hit del_csum a lot by overwriting lots of small new files
  _victim() {
  	echo $BASHPID > $GOOD_CG/cgroup.procs
  	i=0;
  	while (true)
  	do
  		local tmp=$mnt/tmp.$i

  		dd if=/dev/zero of=$tmp bs=4k count=2 >/dev/null 2>&1
  		i=$((i+1))
  		[ $i -eq $NR_LITTLE ] && i=0
  	done
  }

  _one_sync() {
  	echo "sync..."
  	before=$(date +%s)
  	sync
  	after=$(date +%s)
  	echo "sync done in $((after - before))s"
  	_stats
  }

  # sync in a loop
  _sync() {
  	echo "start sync loop"
  	syncs=0
  	echo $BASHPID > $GOOD_CG/cgroup.procs
  	while true
  	do
  		[ -f .done ] && break
  		_one_sync
  		syncs=$((syncs + 1))
  		[ -f .done ] && break
  		sleep 10
  	done
  	if [ $syncs -eq 0 ]; then
  		echo "do at least one sync!"
  		_one_sync
  	fi
  	echo "sync loop done."
  }

  _sleep() {
  	local time=${1-60}
  	local now=$(date +%s)
  	local end=$((now + time))
  	while [ $now -lt $end ];
  	do
  		echo "SLEEP: $((end - now))s left. Sleep 10."
  		sleep 10
  		now=$(date +%s)
  	done
  }

  echo "start $NR_VILLAINS villains"
  for i in $(seq $NR_VILLAINS)
  do
  	_villain $i &
  	disown # get rid of annoying log on kill (done via cgroup anyway)
  done

  echo "start $NR_VICTIMS victims"
  for i in $(seq $NR_VICTIMS)
  do
  	_victim &
  	disown
  done

  _sync &
  SYNC_PID=$!

  _sleep $1
  _elapsed
  touch .done
  wait $SYNC_PID

  echo "OK"
  exit 0

Without this patch, that reproducer:
- Ran for 6+ minutes instead of 60s
- Hung hundreds of threads in D state on the csum reader lock
- Got a commit stuck for 3 minutes

sync done in 388s
================
Wed Jul  9 09:52:31 PM UTC 2025
elapsed: 420
commits 2
cur_commit_ms 0
last_commit_ms 159446
max_commit_ms 159446
total_commit_ms 160058
some avg10=99.03 avg60=98.97 avg300=75.43 total=418033386
full avg10=82.79 avg60=80.52 avg300=59.45 total=324995274

419 hits state R, D comms big-read
                 btrfs_tree_read_lock_nested
                 btrfs_read_lock_root_node
                 btrfs_search_slot
                 btrfs_lookup_csum
                 btrfs_lookup_bio_sums
                 btrfs_submit_bbio

1 hits state D comms btrfs-transacti
                 btrfs_tree_lock_nested
                 btrfs_lock_root_node
                 btrfs_search_slot
                 btrfs_del_csums
                 __btrfs_run_delayed_refs
                 btrfs_run_delayed_refs

With the patch, the reproducer exits naturally, in 65s, completing a
pretty decent 4 commits, despite heavy memory pressure. Occasionally you
can still trigger a rather long commit (couple seconds) but never one
that is minutes long.

sync done in 3s
================
elapsed: 65
commits 4
cur_commit_ms 0
last_commit_ms 485
max_commit_ms 689
total_commit_ms 2453
some avg10=98.28 avg60=64.54 avg300=19.39 total=64849893
full avg10=74.43 avg60=48.50 avg300=14.53 total=48665168

some random rwalker samples showed the most common stack in reclaim,
rather than the csum tree:
145 hits state R comms bash, sleep, dd, shuf
                 shrink_folio_list
                 shrink_lruvec
                 shrink_node
                 do_try_to_free_pages
                 try_to_free_mem_cgroup_pages
                 reclaim_high

Link: https://lpc.events/event/18/contributions/1883/
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v8:
- use the new hole in the btrfs_bio struct for the commit_root_csum
  flag instead of borrowing bio->bi_flags.
v7:
- fix various typos.
- remove an unneeded fs_info variable.
- rework the commit message and inline comment to better reflect the
  important details of the difference in lock contention between the eb
  rwsems and the commit_root_sem.
- include the full standalone reproduction script in the commit message.
v6:
- properly handle bio_ctrl submitting a bbio spanning multiple
  extent_maps with different generations. This was causing csum errors
  on the previous versions.
v5:
- static inline flag functions
- make bbio const for the getter
- move around and improve the comments
v4:
- replace generic private flag machinery with specific function for the
  one flag
- move the bio_ctrl field to take advantage of alignment
v3:
- add some simple machinery for setting/getting/clearing btrfs private
  flags in bi_flags
- clear those flags before bio_submit (ensure no-op wrt block layer)
- store the csum commit root flag there to save space
v2:
- hold the commit_root_sem for the duration of the entire lookup, not
  just per btrfs_search_slot. Note that we can't naively do the thing
  where we release the lock every loop as that is exactly what we are
  trying to avoid. Theoretically, we could re-grab the lock and fully
  start over if the lock is write contended or something. I suspect the
  rwsem fairness features will let the commit writer get it fast enough
  anyway.
---
 fs/btrfs/bio.c         |  1 +
 fs/btrfs/bio.h         |  2 ++
 fs/btrfs/compression.c |  1 +
 fs/btrfs/extent_io.c   | 36 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/file-item.c   | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 50b5fc1c06d7..ea7f7a17a3d5 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -93,6 +93,7 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 		refcount_inc(&orig_bbio->ordered->refs);
 		bbio->ordered = orig_bbio->ordered;
 	}
+	bbio->csum_search_commit_root = orig_bbio->csum_search_commit_root;
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
 }
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index dc2eb43b7097..00883aea55d7 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -82,6 +82,8 @@ struct btrfs_bio {
 	/* Save the first error status of split bio. */
 	blk_status_t status;
 
+	/* Use the commit root to look up csums (data read bio only). */
+	bool csum_search_commit_root;
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index d09d622016ef..f1c6338ae8b9 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -602,6 +602,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb->compressed_len = compressed_len;
 	cb->compress_type = btrfs_extent_map_compression(em);
 	cb->orig_bbio = bbio;
+	cb->bbio.csum_search_commit_root = bbio->csum_search_commit_root;
 
 	btrfs_free_extent_map(em);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 82da27d5e001..c11c93bcc7f6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -101,6 +101,16 @@ struct btrfs_bio_ctrl {
 	enum btrfs_compression_type compress_type;
 	u32 len_to_oe_boundary;
 	blk_opf_t opf;
+	/*
+	 * For data read bios, we attempt to optimize csum lookups if the extent
+	 * generation is older than the current one. To make this possible, we
+	 * need to track the maximum generation of an extent in a bio_ctrl to
+	 * make the decision when submitting the bio.
+	 *
+	 * See the comment in btrfs_lookup_bio_sums() for more detail on the
+	 * need for this optimization.
+	 */
+	u64 generation;
 	btrfs_bio_end_io_t end_io_func;
 	struct writeback_control *wbc;
 
@@ -113,6 +123,26 @@ struct btrfs_bio_ctrl {
 	struct readahead_control *ractl;
 };
 
+/*
+ * Helper to set the csum search commit root option for a bio_ctrl's bbio
+ * before submitting the bio.
+ *
+ * Only for use by submit_one_bio().
+ */
+static void bio_set_csum_search_commit_root(struct btrfs_bio_ctrl *bio_ctrl)
+{
+	struct btrfs_bio *bbio = bio_ctrl->bbio;
+
+	ASSERT(bbio);
+
+	if (!(btrfs_op(&bbio->bio) == BTRFS_MAP_READ && is_data_inode(bbio->inode)))
+		return;
+
+	bio_ctrl->bbio->csum_search_commit_root =
+		(bio_ctrl->generation &&
+		 bio_ctrl->generation < btrfs_get_fs_generation(bbio->inode->root->fs_info));
+}
+
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_bio *bbio = bio_ctrl->bbio;
@@ -123,6 +153,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bbio->bio.bi_iter.bi_size);
 
+	bio_set_csum_search_commit_root(bio_ctrl);
+
 	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
 		btrfs_submit_compressed_read(bbio);
@@ -131,6 +163,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	/* The bbio is owned by the end_io handler now */
 	bio_ctrl->bbio = NULL;
+	/* Reset the generation for the next bio */
+	bio_ctrl->generation = 0;
 }
 
 /*
@@ -1026,6 +1060,8 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
+		bio_ctrl->generation = max(bio_ctrl->generation, em->generation);
+
 		btrfs_free_extent_map(em);
 		em = NULL;
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c09fbc257634..4dd3d8a02519 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -397,6 +397,36 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		path->skip_locking = 1;
 	}
 
+	/*
+	 * If we are searching for a csum of an extent from a past
+	 * transaction, we can search in the commit root and reduce
+	 * lock contention on the csum tree extent buffers.
+	 *
+	 * This is important because that lock is an rwsem which gets
+	 * pretty heavy write load under memory pressure and sustained
+	 * csum overwrites, unlike the commit_root_sem. (Memory pressure
+	 * makes us writeback the nodes multiple times per transaction,
+	 * which makes us cow them each time, taking the write lock.)
+	 *
+	 * Due to how rwsem is implemented, there is a possible
+	 * priority inversion where the readers holding the lock don't
+	 * get scheduled (say they're in a cgroup stuck in heavy reclaim)
+	 * which then blocks writers, including transaction commit. By
+	 * using a semaphore with fewer writers (only a commit switching
+	 * the roots), we make this issue less likely.
+	 *
+	 * Note that we don't rely on btrfs_search_slot to lock the
+	 * commit root csum. We call search_slot multiple times, which would
+	 * create a potential race where a commit comes in between searches
+	 * while we are not holding the commit_root_sem, and we get csums
+	 * from across transactions.
+	 */
+	if (bbio->csum_search_commit_root) {
+		path->search_commit_root = 1;
+		path->skip_locking = 1;
+		down_read(&fs_info->commit_root_sem);
+	}
+
 	while (bio_offset < orig_len) {
 		int count;
 		u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;
@@ -442,6 +472,8 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		bio_offset += count * sectorsize;
 	}
 
+	if (bbio->csum_search_commit_root)
+		up_read(&fs_info->commit_root_sem);
 	return ret;
 }
 
-- 
2.50.1


