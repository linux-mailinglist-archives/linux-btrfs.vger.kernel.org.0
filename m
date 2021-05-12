Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E506437C9BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 18:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhELQU5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 12:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237638AbhELP4B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 11:56:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DCEF61C18;
        Wed, 12 May 2021 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620833291;
        bh=l/fKcQPsUXuWfJBoQpVKD3LFQXlnpPitMRmXwvg8tqA=;
        h=From:To:Cc:Subject:Date:From;
        b=fIXfddSsvFHBwWG5Uqqx4gJRkW3eiQpfo1hnncSJoRHA3wQv/4G8NLapmEk+dkKCP
         iDj7t2TYOvH8m6j3uknOqNzBd4KSmp8lDmfotVWDXfL72y9yPuiDNuG+2q9lH1pFlE
         QusTORPOtc9/qiRD4qRfM1Kuu8C423G1JYH3qzkSZknLikmdyR0lORgAnKjTe/9sud
         to663zHPcrZ9WwF+AqfFETtUQDlVQgDdNpBVPS6301/Wc8jugmY+b4Fw9nCw/0+a1e
         m3cMTncz6LLAX9lQ77CuQNXH3DtMBg+ztWvWJBqmnlh3Q1kzpF3lDZJPXZPJn4ICr9
         Z+Ivp263/M/YQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Boris Burkov <boris@bur.io>
Subject: [PATCH Resend] btrfs/187: fix test failure when using bash 5.0+ with debug enabled
Date:   Wed, 12 May 2021 16:28:00 +0100
Message-Id: <9d0640f23111b8f1c432af2b62191c802265a218.1620833105.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When running btrfs/187 with a bash 5.0+ build that has debug enabled, the
test fails due to an unexpected warning message from bash:

  $ ./check btrfs/187
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian9 5.12.0-rc8-btrfs-next-92 #1 SMP PREEMPT Wed Apr 21 10:36:03 WEST 2021
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/187 436s ... - output mismatch (see /xfstests/results//btrfs/187.out.bad)
      --- tests/btrfs/187.out	2020-10-16 23:13:46.550152492 +0100
      +++ /xfstests/results//btrfs/187.out.bad	2021-04-27 14:57:02.623941700 +0100
      @@ -1,3 +1,4 @@
       QA output created by 187
       Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
       Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
      +/xfstests/tests/btrfs/187: line 1: warning: wait_for: recursively setting old_sigint_handler to wait_sigint_handler: running_trap = 16
      ...
      (Run 'diff -u /xfstests/tests/btrfs/187.out /xfstests/results//btrfs/187.out.bad'  to see the entire diff)
  Ran: btrfs/187
  Failures: btrfs/187
  Failed 1 of 1 tests

This is because the process running dedupe_files_loop() executes the 'wait'
command in the trap it has setup and very often it receives the SIGTERM
signal while it is running the 'wait' command in the while loop of that
function - so executing the trap makes bash run 'wait' while it is already
running 'wait', triggering the warning message from bash.

That warning message was added in bash 5.0 by commit 36f89ff1d8b761
("SIGINT trap handler SIGINT loop fix"):

  https://git.savannah.gnu.org/cgit/bash.git/commit/?id=36f89ff1d8b761c815d8993e9833e6357a57fc6b

So fix this by making the trap set a local variable named 'stop' to the
value 1 and have the loop exit when the local variable 'stop' is 1.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---

Resending it because it was not picked in the last merge.

 tests/btrfs/187 | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/187 b/tests/btrfs/187
index b2d3e4f0..7da09abd 100755
--- a/tests/btrfs/187
+++ b/tests/btrfs/187
@@ -64,9 +64,19 @@ dedupe_two_files()
 
 dedupe_files_loop()
 {
-	trap "wait; exit" SIGTERM
-
-	while true; do
+	local stop=0
+
+	# Avoid executing 'wait' inside the trap, because when we receive
+	# SIGTERM we might be already executing the wait command in the while
+	# loop below. When that is the case, bash 5.0+ with debug enabled prints
+	# a warning message that makes the test fail due to a mismatch with the
+	# golden output. That warning message is the following:
+	#
+	# warning: wait_for: recursively setting old_sigint_handler to wait_sigint_handler: running_trap = 16
+	#
+	trap "stop=1" SIGTERM
+
+	while [ $stop -eq 0 ]; do
 		for ((i = 1; i <= 5; i++)); do
 			dedupe_two_files &
 		done
-- 
2.28.0

