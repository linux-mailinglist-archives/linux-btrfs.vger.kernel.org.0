Return-Path: <linux-btrfs+bounces-6984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0FD947DA0
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 17:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D428599F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC49158DCC;
	Mon,  5 Aug 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7VArIDH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CA1552FF;
	Mon,  5 Aug 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870234; cv=none; b=NJV+JQ73JykDVKwBnRvq1ZcwAVNlX2EsV4z+0GLZCecXhmyZtmmhvXKBTCH+Cre+xzoe83umoaw0BL5CvIyrXH1mOllRBDeQazJ/6iIFUQwrGKr3IGY09sHv2GqEHldHk7d/oadUXBZvFJHevJicia+qzN+0ORMkeGkHLS6Z1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870234; c=relaxed/simple;
	bh=jRwT9onfoqYm0rxs5VDUHci0cibwKQ8rwuL3ju/vxXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKR1rwXyp4A3npti1GOtC0kS6134ezm6Uvv20mRF0lWkE3oR949T0/3VtRHMQqnAyjrTh4LU14AhZ4FGMqIIxjCyFhc3tEe5hBba+5RLiWoqi+D2DUjXrg4tCNcuUOVv5p+33Wjlxnt75qnl/3I6cQSXpxKIfrYUPD8vcZ6uXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7VArIDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48810C32782;
	Mon,  5 Aug 2024 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722870234;
	bh=jRwT9onfoqYm0rxs5VDUHci0cibwKQ8rwuL3ju/vxXI=;
	h=From:To:Cc:Subject:Date:From;
	b=X7VArIDHOQdkuNnM5UraJce7u92OXrMd/6ZWkdyrC7qrmlIdko2E+8HHgsimHkhUO
	 phccjEy0i7KCMh6OT1srIHy080Tx3KDEbmsJesfzo62cTTObx6econD+kRWqmeD0cI
	 5ixnXUD0kLCepuiXmPmJbn1lbdXBWgQ4S7bzXJwulP+6kNdxqoWDiTUYXb9TIrct1+
	 ad7Q3JGQgBUlJ31On9csXUQCCj2/aLzfJzQX6UT/TpGoQwRlUXFQ8IreXQYPVBNLHn
	 /vvorOP/d6pdhAtxn5Ejfy0CiwgfTSls7QopE52GZrFwGG1Ci+7AsYvtRUvhbqG6pv
	 0WmAKuEryjnZw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/312: add git commit ID
Date: Mon,  5 Aug 2024 16:03:47 +0100
Message-ID: <215d39fcaad6f058b0678191df89d0836aa54a90.1722870144.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The corresponding kernel fix was merged into Linus' tree, so specify its
ID in the test.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/312 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/312 b/tests/btrfs/312
index ebecadc6..6945ebc0 100755
--- a/tests/btrfs/312
+++ b/tests/btrfs/312
@@ -23,7 +23,7 @@ _require_btrfs_send_version 2
 _require_test
 _require_scratch
 
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit de9f46cb0044 \
 	"btrfs: fix corrupt read due to bad offset of a compressed extent map"
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
-- 
2.43.0


