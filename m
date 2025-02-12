Return-Path: <linux-btrfs+bounces-11431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B817AA33374
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48155188B51E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145E6263880;
	Wed, 12 Feb 2025 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGxejPHZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487A262816;
	Wed, 12 Feb 2025 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403320; cv=none; b=E71U8Yijk9gAQNouo4ogo7yNv+G6z15lhN9vN0zb2YUhnIJNlFzX7ix2qC0fZe111aO4CoF9ff+qpKMKXzXydtqSMH3x7lzSmiftihId/mOsAVK0b+iu5pjE4yXQIOORonEgi5c5vLx5io44lSqIRj0QBtT2xA71llGKs/i+mFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403320; c=relaxed/simple;
	bh=D/M2bDEIHntUZizcxNtHZprqPr/6J9o7/5tcxL4VRK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2GAwekBEC0chP8h18hjd3S25xS+LYPFszPYJdo02vuZIRvsDsCMatjD/Xh4ZbIJNRXMKIMXXMaQfPntUwWKN5gq1zZ8Rq22W5xPRbGs5hfEbx2jrpTxB+igmj8fYIQPCqthWNCvgghOgqYy5Bn0mI4r0oJAtdIXJWIQU936hoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGxejPHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE7BC4CEDF;
	Wed, 12 Feb 2025 23:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739403320;
	bh=D/M2bDEIHntUZizcxNtHZprqPr/6J9o7/5tcxL4VRK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGxejPHZFVfuZOGmcbG2Ll+I+76pJ8C/rFKwGBUg4jHf1Y0irEkdLbNnHY59X88zy
	 QauyL5kAOxlmCLWrFI6UCadO4aUHadFbCNtX8dWdjjqfG8YrNWH+4cZ9xyMJeZGApJ
	 uXqOmCi+74GmySuAakKsit20wNyVXzqzbzwnquTnfJun+uo4Fp3YeYvd1D5O3krWrL
	 C3OLYDCLgvNkUKNEXuoOYC1wX6Z07WsAPYctezOYbQRAXsoc15ijR+SYXJCucB30C3
	 cshsrvMtrgg8c/TINHWnO2y8r6+FYKLWMoa2mZWSA+UavtjWqyKm4r0UtnDdgpE4wT
	 aVFu/4pM2gWgw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 4/8] btrfs/333: skip the test when running with nodatacow or nodatasum
Date: Wed, 12 Feb 2025 23:35:02 +0000
Message-ID: <2628714aa1415ca5878bac6414a0eda82d915356.1739403114.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1739403114.git.fdmanana@suse.com>
References: <cover.1739403114.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Encoded writes are reject for inodes with the NODATASUM flag, so we must skip
the test if running with either the nodatasum or nodatacow (which implies
nodatasum) mount options.

So skip the test when under nodatacow and nodatasum mount options.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/333 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/333 b/tests/btrfs/333
index 14cecdbc..6214d7c5 100755
--- a/tests/btrfs/333
+++ b/tests/btrfs/333
@@ -14,6 +14,11 @@ _begin_fstest auto quick compress rw io_uring ioctl
 _require_command src/btrfs_encoded_read
 _require_command src/btrfs_encoded_write
 _require_btrfs_iouring_encoded_read
+# Encoded writes are reject for inodes with the NODATASUM flag, so we must skip
+# the test if running with either the nodatasum or nodatacow (which implies
+# nodatasum) mount options.
+_require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 
 do_encoded_read()
 {
-- 
2.45.2


