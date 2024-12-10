Return-Path: <linux-btrfs+bounces-10196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6279EB857
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 18:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F3C28580B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 17:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC78635D;
	Tue, 10 Dec 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI70MI4i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB323ED6D;
	Tue, 10 Dec 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851986; cv=none; b=ixgNeLSHT0qUSbdnBGCQoiiBeSFFr3xctbe66K0KXtl4MzZ+0vsFeAUCvWikx9HWdcyJK8u/F7Sy2vbnuIXOzGAznQcsmAvEEyuT2LdS1NQ+6+Kw72v++p+kIjzMa+mxRoGGDq3dXlHgqm5VccYbBKnWEzKoWgFAtZaNF8+0w9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851986; c=relaxed/simple;
	bh=MsO4pk5STevP+2RxnCHApb97STHn8BHYuygYRvEB8Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sY8Ye5nfC+wnzFSlz+n14dtBybLAxdWeFN3ZZ1uD6MbIvjCYA/RpHpxqe952aE4gi7YYF/O2XE9zBLvkG10QRaTEMT3jUHUBt6azqqdJ/lS3GU+gAamHK8dmBgd9G7NQ7zEp50ab/gEzwjB0S6pWa0YjxNsDhrUnUTi6iv8BpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI70MI4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA54C4CED6;
	Tue, 10 Dec 2024 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733851986;
	bh=MsO4pk5STevP+2RxnCHApb97STHn8BHYuygYRvEB8Qk=;
	h=From:To:Cc:Subject:Date:From;
	b=GI70MI4i/VdPqPOIp4gbWjjTHi7qcB4rnzjh70eanwcW9YJ4gvVXecqehsJK5dvBv
	 +z5If5VufyHIdV3nhzhUIxY8ZAj0tSk3ettN/A7Selp6a9erekVms9DqoLt4LsWuf+
	 4pjnPRs7QrnA8gpu5AuQC1NPvrLnGGHcRisK7+S3/G9lskTy/OV5A0LyAoCzv85qtV
	 ybc+xaCOr5aHjJAPrBd2Gh2fS8NTYUMV/YUVPTrp1aRJJmLkj2CXZoipUaUlPAKXQ4
	 41Lx1aIaodgkuN69XyUyyXvuJ4Ntr5xnM1IBJInW7B/woLLYgGCruWth+lkNU7hjuA
	 gZo+52HiTmTwQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	dchinner@redhat.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: fix argument passing to _run_fsstress and _run_fsstress_bg
Date: Tue, 10 Dec 2024 17:32:54 +0000
Message-ID: <51ccb57553e069946bec983ded52a75640d4fef5.1733851879.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After commit 8973af00ec21 ("fstests: cleanup fsstress process management")
test cases btrfs/007 and btrfs/284 started to fail. For example:

  $ ./check btrfs/007
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 SMP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/007 1s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad)
      --- tests/btrfs/007.out	2020-06-10 19:29:03.810518987 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad	2024-12-10 16:09:56.345937619 +0000
      @@ -1,3 +1,4 @@
       QA output created by 007
       *** test send / receive
      -*** done
      +failed: '2097152000 200'
      +(see /home/fdmanana/git/hub/xfstests/results//btrfs/007.full for details)
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/007.out /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad'  to see the entire diff)
  Ran: btrfs/007

The problem comes from _run_fsstress and _run_fsstress_bg using $*, which
splits the string argument for the -x command used by btrfs/007, so that
fsstress gets the argument for -x as simply:

   "btrfs"

Instead of:

   "btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base"

Fix this by using "$@" instead of $*.

Fixes: 8973af00ec21 ("fstests: cleanup fsstress process management")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 1b2e4508..f4fff59b 100644
--- a/common/rc
+++ b/common/rc
@@ -78,13 +78,13 @@ _kill_fsstress()
 _run_fsstress_bg()
 {
 	cp -f $FSSTRESS_PROG $_FSSTRESS_PROG
-	$_FSSTRESS_PROG $FSSTRESS_AVOID $* >> $seqres.full 2>&1 &
+	$_FSSTRESS_PROG $FSSTRESS_AVOID "$@" >> $seqres.full 2>&1 &
 	_FSSTRESS_PID=$!
 }
 
 _run_fsstress()
 {
-	_run_fsstress_bg $*
+	_run_fsstress_bg "$@"
 	_wait_for_fsstress
 	return $?
 }
-- 
2.45.2


