Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CBC1D91EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 10:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgESITa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 04:19:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:37212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgESITa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 04:19:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A7E6ABE6;
        Tue, 19 May 2020 08:19:31 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [RFC PATCH] btrfs: Speed up buffered writes exceeding memory size
Date:   Tue, 19 May 2020 11:19:25 +0300
Message-Id: <20200519081925.8736-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch 302167c50b32 ("btrfs: don't end the transaction for delayed refs
in throttle") severely penalized buffered workload that exceed the
memory of the machine. Internal benchmarks showed degradation between
20-80%, likely dependent on underlying storage. That patch changed the
way transactions are committed which resulted in less transaction commits
from asynchronous context and instead putting more pressue on the
reclaim code. In my testing this resulted in around 80% performance
drop.

This patch improves the situation as seen from the following perf trace
output for a fixed workload of 8g writes, across 4 threads on a vm with
4g memory:
fio --direct=0 --ioengine=sync --ramp_time=15 --thread \
--directory=/media/scratch/ --invalidate=1 --group_reporting=1 \
--fallocate=posix --name=RandomWrites-async-64512-4k-4 --new_group \
--rw=randwrite --size=2g --numjobs=4 --bs=4k --fsync_on_close=0 \
--end_fsync=0 --filename_format=FioWorkloads.\$jobnum

UNPATCHED:

syscall            calls  errors  total       min       avg       max       stddev
                                  (msec)    (msec)    (msec)    (msec)        (%)
--------------- --------  ------ -------- --------- --------- ---------     ------
write             489906      0 542216.077     0.000     1.107   266.709      1.46%

syscall            calls  errors  total       min       avg       max       stddev
                                  (msec)    (msec)    (msec)    (msec)        (%)
--------------- --------  ------ -------- --------- --------- ---------     ------
write             489461      0 541990.222     0.000     1.107   266.860      1.46%

syscall            calls  errors  total       min       avg       max       stddev
                                  (msec)    (msec)    (msec)    (msec)        (%)
--------------- --------  ------ -------- --------- --------- ---------     ------
write             489846      0 541703.291     0.000     1.106   266.581      1.46%

syscall            calls  errors  total       min       avg       max       stddev
                                  (msec)    (msec)    (msec)    (msec)        (%)
--------------- --------  ------ -------- --------- --------- ---------     ------
write             488249      0 541402.958     0.000     1.109   266.328      1.46%

PATCHED:

syscall            calls  errors  total       min       avg       max       stddev
                                  (msec)    (msec)    (msec)    (msec)        (%)
--------------- --------  ------ -------- --------- --------- ---------     ------
write             480370      0 281132.164     0.000     0.585   427.763      2.11%

syscall            calls  errors  total       min       avg       max       stddev
                                  (msec)    (msec)    (msec)    (msec)        (%)
--------------- --------  ------ -------- --------- --------- ---------     ------
write             477999      0 278641.975     0.000     0.583   402.489      2.14%

syscall            calls  errors  total       min       avg       max       stddev
                                  (msec)    (msec)    (msec)    (msec)        (%)
--------------- --------  ------ -------- --------- --------- ---------     ------
write             483523      0 281265.938     0.000     0.582   422.697      2.14%

syscall            calls  errors  total       min       avg       max       stddev
                                  (msec)    (msec)    (msec)    (msec)        (%)
--------------- --------  ------ -------- --------- --------- ---------     ------
write             478537      0 282329.874     0.000     0.590   392.784      2.16%

Fio's output is as follows:

BAD:
WRITE: bw=13.7MiB/s (14.3MB/s), 13.7MiB/s-13.7MiB/s (14.3MB/s-14.3MB/s),
io=7610MiB (7980MB), run=556713-556713msec

Patched:

Run status group 0 (all jobs):
  WRITE: bw=25.2MiB/s (26.5MB/s), 25.2MiB/s-25.2MiB/s
  (26.5MB/s-26.5MB/s), io=7473MiB (7836MB), run=296151-296151msec

As can be seen the average cost of the write syscall is reduced by ~
50%. This is attributed to the overall lower time in waiting for
metadata space reservation tickets being granted.

The fix work by issuing writeback directly from the writer context and
not from async reclaim context. This helps by exerting backpressure on
concurrent writers giving breathing room to the reclaim logic to catch
up. I came to this conclusion by measuring the DIO performance which is
around 2.3x that of buffered write.

Fixes: 302167c50b32 ("btrfs: don't end the transaction for delayed refs in throttle")

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Sending this as I've run out of ideas how to chase that performance regression
with the hopes it facilitates discussion. This one doesn't regress DIO so it
will eventually be fine merging it. However, it's evident it increases tail
latency somewhat. Furthermore my explanation as to why it helps is the best
hypothesis that I've come up with but I haven't been able to back it up with
numbers.

Josef, in particular I'd like to see your opinion on it?

 fs/btrfs/space-info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 41ee88633769..6355dddd4be9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1223,6 +1223,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	u64 used;
 	int ret = 0;
 	bool pending_tickets;
+	bool should_flush = false;

 	ASSERT(orig_bytes);
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_ALL);
@@ -1269,6 +1270,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
 		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
 		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
+			should_flush = true;
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
 				space_info->flush = 1;
@@ -1303,6 +1305,8 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	if (!ret || flush == BTRFS_RESERVE_NO_FLUSH)
 		return ret;

+	if (should_flush)
+		shrink_delalloc(fs_info, SZ_2M, 0, false);
 	return handle_reserve_ticket(fs_info, space_info, &ticket, flush);
 }

--
2.17.1

