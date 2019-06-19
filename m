Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765B04B7A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 14:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfFSMGa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 08:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfFSMG3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 08:06:29 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0802F206E0;
        Wed, 19 Jun 2019 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560945988;
        bh=rBMLUubLEqagGy5MDLeJ89gbQWLVzxg1NVJ1TpeYEi4=;
        h=From:To:Cc:Subject:Date:From;
        b=M5XHYJhvZYU27WhdvrAGybU+RYcAXzyXZiwICJdEQjJvJzYvLLNsThN13HBz5SctY
         W4uPyhTr2C/d68SYKzI3RJrwKdDaMeLsmu3x/eoOokJtoPBSJ/jx7xg15DzCg7JLve
         f1ZFzV90XId+7HJWp/qiOXp7q/2AuBqsKSoNYzmo=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] generic/059: also test that the file's mtime and ctime are updated
Date:   Wed, 19 Jun 2019 13:06:24 +0100
Message-Id: <20190619120624.9922-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test as well that hole punch operations that affect a single file block
also update the file's mtime and ctime.

This is motivated by a bug a found in btrfs which is fixed by the
following patch for the linux kernel:

 "Btrfs: add missing inode version, ctime and mtime updates when
  punching hole"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/059 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/generic/059 b/tests/generic/059
index e8cb93d8..fd44b2ea 100755
--- a/tests/generic/059
+++ b/tests/generic/059
@@ -18,6 +18,9 @@
 #
 #  Btrfs: add missing inode update when punching hole
 #
+# Also test the mtime and ctime properties of the file change after punching
+# holes with ranges that operate only on a single block of the file.
+#
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -68,6 +71,13 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 # fsync log.
 sync
 
+# Sleep for 1 second, because we want to check that the next punch operations we
+# do update the file's mtime and ctime.
+sleep 1
+
+mtime_before=$(stat -c %Y $SCRATCH_MNT/foo)
+ctime_before=$(stat -c %Z $SCRATCH_MNT/foo)
+
 # Punch a hole in our file. This small range affects only 1 page.
 # This made the btrfs hole punching implementation write only some zeroes in
 # one page, but it did not update the btrfs inode fields used to determine if
@@ -94,5 +104,13 @@ _flakey_drop_and_remount
 echo "File content after:"
 od -t x1 $SCRATCH_MNT/foo
 
+mtime_after=$(stat -c %Y $SCRATCH_MNT/foo)
+ctime_after=$(stat -c %Z $SCRATCH_MNT/foo)
+
+[ $mtime_after -gt $mtime_before ] || \
+	echo "mtime did not increase (before: $mtime_before after: $mtime_after"
+[ $ctime_after -gt $ctime_before ] || \
+	echo "ctime did not increase (before: $ctime_before after: $mtime_after"
+
 status=0
 exit
-- 
2.11.0

