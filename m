Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC8846EA3F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 15:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhLIOrt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 09:47:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45038 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhLIOrs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 09:47:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80EE5B82488;
        Thu,  9 Dec 2021 14:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62200C004DD;
        Thu,  9 Dec 2021 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639061053;
        bh=YprkNrs5Q2tjNnWBp1vFs/paQHCb28ylFF9XBS4AgPo=;
        h=From:To:Cc:Subject:Date:From;
        b=GATxCcDbdiEf6ze5KAjPJ0uSp6ZAnmlo6gOie1TCT2d8nD954G30D1kI+h182ujEO
         HmyJ7P/Zjj++DwSkegqjTuo5918qPHmEOQvPaE8MC+LZP+qOB1Ls+Eo8YlklKKDHWf
         HUIE7AelScRjsrgAtOStHePsWHJ0HiFViciQ/CwWeDff5l2TFq5xtmBePmIwjVl4FF
         VDARkNe0x2j9TQGIXnUY2V8YUmcxpOkf+09/jvMWz7czGD3uDdlT3AI1yG6DFaRs1m
         J+pPmluk4DRKYjFiQZvaQmE7EZHlRqI06W6rXtYgbim8Y9Hh4XBcelRU5P8uBID0IK
         ir/WRhfrBGwfw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/335: explicitly fsync file foo when running on btrfs
Date:   Thu,  9 Dec 2021 14:44:06 +0000
Message-Id: <4e00357fe3aaa843bd8fd02218b97104e5fd74bf.1639060960.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The test is relying on the fact that an fsync on directory "a" will
result in persisting the changes of its subdirectory "b", namely the
rename of "/a/b/foo" to "/c/foo". For this particular filesystem layout,
that will happen on btrfs, because all the directory entries end up in
the same metadata leaf. However that is not a behaviour we can always
guarantee on btrfs. For example, if we add more files to directory
"a" before and after creating subdirectory "b", like this:

  mkdir $SCRATCH_MNT/a
  for ((i = 0; i < 1000; i++)); do
      echo -n > $SCRATCH_MNT/a/file_$i
  done
  mkdir $SCRATCH_MNT/a/b
  for ((i = 1000; i < 2000; i++)); do
      echo -n > $SCRATCH_MNT/a/file_$i
  done
  mkdir $SCRATCH_MNT/c
  touch $SCRATCH_MNT/a/b/foo

  sync

  # The rest of the test remains unchanged...
  (...)

Then after fsyncing only directory "a", the rename of file "foo" from
"/a/b/foo" to "/c/foo" is not persisted.

Guaranteeing that on btrfs would be expensive on large directories, as
it would require scanning for every subdirectory. It's also not required
by posix for the fsync on a directory to persist changes inside its
subdirectories. So add an explicit fsync on file "foo" when the filesystem
being tested is btrfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/335 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/generic/335 b/tests/generic/335
index e04f7a5f..196ada64 100755
--- a/tests/generic/335
+++ b/tests/generic/335
@@ -51,6 +51,15 @@ mv $SCRATCH_MNT/a/b/foo $SCRATCH_MNT/c/
 touch $SCRATCH_MNT/a/bar
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a
 
+# btrfs can not guarantee that when we fsync a directory all its subdirectories
+# created on past transactions are fsynced as well. It may do it sometimes, but
+# it's not guaranteed, giving such guarantees would be too expensive for large
+# directories and posix does not require that recursive behaviour. So if we want
+# the rename of "foo" to be persisted, explicitly fsync "foo".
+if [ $FSTYP == "btrfs" ]; then
+	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/c/foo
+fi
+
 echo "Filesystem content before power failure:"
 ls -R $SCRATCH_MNT/a $SCRATCH_MNT/c | _filter_scratch
 
-- 
2.33.0

