Return-Path: <linux-btrfs+bounces-10200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC8E9EB871
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 18:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623911888825
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC01531C0;
	Tue, 10 Dec 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq+f/0X0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF023ED70;
	Tue, 10 Dec 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852333; cv=none; b=NTATFGNkRs5gaf1zeStW1rtgweLQVGXrSFmfB0/AC0EexGQ6BQW4c6hYQex8eb0YHqpPoSmKWccCYi+6Blh+y6jOC5/ma3y8KbMgkYdI1OhHWWa6XxPGpwcVV8mDJtyYZQiiwQlIAvXefvwqDKdLpAD9nyWpFFh1a+ke4e2bktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852333; c=relaxed/simple;
	bh=QpSq3x92K2QBU/G3bzCL1sfpeIesPxfl0LCDAGXSlsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MfJ/shkeW2LCqn1+m4XKbHaTT8wT5ZCnbHPGFZ/tTAqY/Dyfce1+5GVGETfUlDzSQ/U49potMxglggxo78yqEjq51qJLtDbFZmAIrH+BXm0j4n2nk8eu2B1mmxuvCvhQoh/AicrZbWlSkXBukAMH/6FECqe71XknaCimp7HKoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq+f/0X0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5F3C4CED6;
	Tue, 10 Dec 2024 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733852332;
	bh=QpSq3x92K2QBU/G3bzCL1sfpeIesPxfl0LCDAGXSlsA=;
	h=From:To:Cc:Subject:Date:From;
	b=Nq+f/0X0uTsJOtQuKVIitkFEDrwOOYTILCwAzmxWH9tFGNY7bBWmk4jzfFt/pb4KK
	 8XaxFEZPuhcs0XxbvXo3SMw7NAt2VXXwU2lDTx+m2qUriR7dYQusd6LyoJYpt2Q+DQ
	 8izkt1jhQwHQRHUtkYcfgH/LoLhkSOooSNyZpfrGO5/+Jqh6MxqzG51HfzHcVmpXoH
	 fMrW4ePiepRbgV3jcjDtHnh9wSfTBrMRwof6HGxJnpFzJxCNKA0qEpNVV4WdHTHhw3
	 YPMX4NzOiymO9RHjcZ3+yued2Jyjdn5Vn5sGIwb+WIHA2L4llr6Y/j0Dcf6yYO4h/G
	 icAGKsWLZBhag==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	dchinner@redhat.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/442: fix failure due to missing test number argument for fsync-err
Date: Tue, 10 Dec 2024 17:38:32 +0000
Message-ID: <407b633354417bbadeb3e665246f5c5f8000e1e6.1733852293.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After commit 88c0291d297c ("fstests: per-test dmerror instances") the
script src/dmerror now has an extra argument, corresponding to a test's
sequence number, but generic/442 isn't passing that argument so the test
fails like this:

  $ ./check generic/442
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 SMP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  generic/442 4s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/442.out.bad)
      --- tests/generic/442.out	2020-06-10 19:29:03.850519863 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//generic/442.out.bad	2024-12-10 17:35:59.746597468 +0000
      @@ -1,2 +1,3 @@
       QA output created by 442
      -Test passed!
      +Usage: /home/fdmanana/git/hub/xfstests/src/dmerror {load_error_table|load_working_table}
      +system: program exited: 1
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/442.out /home/fdmanana/git/hub/xfstests/results//generic/442.out.bad'  to see the entire diff)
  Ran: generic/442
  Failures: generic/442
  Failed 1 of 1 tests

Fix this by passing the test's sequence number as an argument.

Fixes: 88c0291d297c ("fstests: per-test dmerror instances")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/442 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/442 b/tests/generic/442
index c1182b5a..ac1b094a 100755
--- a/tests/generic/442
+++ b/tests/generic/442
@@ -29,7 +29,7 @@ _require_test_program dmerror
 
 _dmerror_init
 
-$here/src/fsync-err -d $here/src/dmerror $DMERROR_DEV
+$here/src/fsync-err -d "$here/src/dmerror $seq" $DMERROR_DEV
 
 # success, all done
 _dmerror_load_working_table
-- 
2.45.2


