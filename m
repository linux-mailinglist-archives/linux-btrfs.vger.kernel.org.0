Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A826211C57A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 06:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfLLFan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 00:30:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:53416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbfLLFam (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 00:30:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D517DAE17;
        Thu, 12 Dec 2019 05:30:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] fstests: btrfs/09[58]: Use hash to replace unreliable od output
Date:   Thu, 12 Dec 2019 13:30:34 +0800
Message-Id: <20191212053034.21995-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With latest master, btrfs/09[58] fails like:

  btrfs/095 2s ... - output mismatch (see xfstests-dev/results//btrfs/095.out.bad)
      --- tests/btrfs/095.out     2019-12-12 13:23:24.266697540 +0800
      +++ xfstests-dev/results//btrfs/095.out.bad      2019-12-12 13:23:29.340030879 +0800
      @@ -4,32 +4,32 @@
       File contents before power failure:
       0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
       *
      -207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
      +771 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
       *
      -226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
      ...
      (Run 'diff -u xfstests-dev/tests/btrfs/095.out xfstests-dev/results//btrfs/095.out.bad'  to see the entire diff)
  btrfs/098 2s ... - output mismatch (see xfstests-dev/results//btrfs/098.out.bad)
      --- tests/btrfs/098.out     2019-12-12 13:23:24.266697540 +0800
      +++ xfstests-dev/results//btrfs/098.out.bad      2019-12-12 13:23:31.306697545 +0800
      @@ -3,20 +3,20 @@
       File contents before power failure:
       0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
       *
      -144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
      +537 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
       *
      -151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
      ...
      (Run 'diff -u xfstests-dev/tests/btrfs/098.out xfstests-dev/results//btrfs/098.out.bad'  to see the entire diff)
  Ran: btrfs/095 btrfs/098
  Failures: btrfs/095 btrfs/098
  Failed 2 of 2 tests

[CAUSE]
It looks like commit 37520a314bd4 ("fstests: Don't use gawk's strtonum")
is making _filter_od doing stupid filtering.

[FIX]
Personally speaking, I don't really care about whatever _filter_od is
doing at all.
And since these two test cases only care about the content, let's use
hash to replace unreliable _filter_od output.
While move the filtered (and meaningless) od output to $seqres.full.

Reported-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/095     | 13 +++++++++----
 tests/btrfs/095.out | 36 ++++--------------------------------
 tests/btrfs/098     | 14 ++++++++++----
 tests/btrfs/098.out | 24 ++++--------------------
 4 files changed, 27 insertions(+), 60 deletions(-)

diff --git a/tests/btrfs/095 b/tests/btrfs/095
index 4c810a5d..4b381a9e 100755
--- a/tests/btrfs/095
+++ b/tests/btrfs/095
@@ -122,8 +122,10 @@ $CLONER_PROG -s $((768 * $BLOCK_SIZE)) -d $((150 * $BLOCK_SIZE)) -l $((25 * $BLO
 # fsync and before the next transaction commit.
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 
-echo "File contents before power failure:"
-od -t x1 $SCRATCH_MNT/foo | _filter_od
+echo "File hash before power failure:"
+_md5_checksum $SCRATCH_MNT/foo
+echo "File contens before power failure:" >> $seqres.full
+od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
 
 # During log replay, the btrfs delayed references implementation used to run the
 # deletion of back references before the addition of new back references, which
@@ -135,8 +137,11 @@ od -t x1 $SCRATCH_MNT/foo | _filter_od
 # failure of the insertion that ended up turning the fs into read-only mode.
 _flakey_drop_and_remount
 
-echo "File contents after log replay:"
-od -t x1 $SCRATCH_MNT/foo | _filter_od
+echo "File hash after log replay:"
+_md5_checksum $SCRATCH_MNT/foo
+
+echo "File contents after log replay:" >> $seqres.full
+od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
 
 _unmount_flakey
 
diff --git a/tests/btrfs/095.out b/tests/btrfs/095.out
index e73b24d5..5c3ec951 100644
--- a/tests/btrfs/095.out
+++ b/tests/btrfs/095.out
@@ -1,35 +1,7 @@
 QA output created by 095
 Blocks modified: [135 - 164]
 Blocks modified: [768 - 792]
-File contents before power failure:
-0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-*
-207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
-*
-257 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-*
-1137 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-1175 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-*
-1400 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
-*
-1431
-File contents after log replay:
-0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-*
-207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
-*
-257 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-*
-1137 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-1175 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-*
-1400 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
-*
-1431
+File hash before power failure:
+beaf47c36659ac29bb9363fb8ffa10a1
+File hash after log replay:
+beaf47c36659ac29bb9363fb8ffa10a1
diff --git a/tests/btrfs/098 b/tests/btrfs/098
index 0e0b5123..e42e3146 100755
--- a/tests/btrfs/098
+++ b/tests/btrfs/098
@@ -69,8 +69,11 @@ $CLONER_PROG -s $(((200 * $BLOCK_SIZE) + (5 * $BLOCK_SIZE))) \
 # first fsync we did before.
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 
-echo "File contents before power failure:"
-od -t x1 $SCRATCH_MNT/foo | _filter_od
+
+echo "File hash before power failure:"
+_md5_checksum $SCRATCH_MNT/foo
+echo "File contents before power failure:" >> $seqres.full
+od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
 
 # The fsync log replay first processes the file extent item corresponding to the
 # file offset mapped by 100th block (the one which refers to the [5, 10[ block
@@ -95,10 +98,13 @@ od -t x1 $SCRATCH_MNT/foo | _filter_od
 #
 _flakey_drop_and_remount
 
-echo "File contents after log replay:"
 # Must match the file contents we had after cloning the extent and before
 # the power failure happened.
-od -t x1 $SCRATCH_MNT/foo | _filter_od
+echo "File hash after log replay:"
+_md5_checksum $SCRATCH_MNT/foo
+
+echo "File contents after log replay:" >> $seqres.full
+od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
 
 _unmount_flakey
 
diff --git a/tests/btrfs/098.out b/tests/btrfs/098.out
index 98a96dec..e3db64a0 100644
--- a/tests/btrfs/098.out
+++ b/tests/btrfs/098.out
@@ -1,22 +1,6 @@
 QA output created by 098
 Blocks modified: [200 - 224]
-File contents before power failure:
-0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-*
-144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-*
-310 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-341
-File contents after log replay:
-0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-*
-144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-*
-310 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
-*
-341
+File hash before power failure:
+39b386375971248740ed8651d5a2ed9f
+File hash after log replay:
+39b386375971248740ed8651d5a2ed9f
-- 
2.23.0

