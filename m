Return-Path: <linux-btrfs+bounces-11430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416A9A33373
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443943A8613
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D7325E47C;
	Wed, 12 Feb 2025 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bssBHY5e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A72209F47;
	Wed, 12 Feb 2025 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403319; cv=none; b=BN3lQsnekMT3xZYuLgzmpQWHFg8jIL6MMUM+j+o+WD9z7TnkUnJVUB9Lt4JNiETYAsQqaDLh5z/Uvl7LKdzW8RtctDZImWemAQGzaG565r8aW2BP2Y15tTpGMpcAINx8TRFfhsJVmJPl9yiLmF1IvbJk5KnQz8ZN46aT7pol3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403319; c=relaxed/simple;
	bh=exydtoSr3R4bULzA95T6rznMexFiiJKDUKLRXqVuk7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ+4aVYxS2n8DlfDl1hYfXR6TXtapBtWz6dvL5IVd//g1Fvw6SFNzRub+qvH89RSSnLq/jYd8c0bHzn+LkkB6X0M2N9rjk0TXq9AcbNpRwMdgj2V/65E2RUnc7g8KQSrdjog682BYh/S4A+gVEfNjQGPHcUd/2pBFuPkyy32BlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bssBHY5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFD5C4CEE4;
	Wed, 12 Feb 2025 23:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739403318;
	bh=exydtoSr3R4bULzA95T6rznMexFiiJKDUKLRXqVuk7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bssBHY5ecCmObmRlKvg4IlEkR/m0Xko2Sr4TAB3YF5g0wRB1nCV6eRP8mq5aazWrO
	 grZ4MNxL6ROrzzAl1erJW8ftu78jI/3pTda7M0Sf+ARUpUDWkFZHQLExuNvEKOGKxA
	 4lMtU4s2VaKfXQwJiKZx3E+3IPK/izyKvNMh9hH2zizzKu0UWvBy3rTTrJXVzC5ezW
	 K+C3e1jie+cqybjM/WOGV8T8eYpAggZ1ZvmjJK4abw78u7ka5B3QJFPZx7OzzirYa1
	 XUnSnbdVutKWryePMUEdbqFgQkDdRLvyYdGiom3tgcq7MJINah+RAAALFwhCMvQeyj
	 jHzbDHBPq0dNw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/8] common/btrfs: add a _require_btrfs_no_nodatasum helper
Date: Wed, 12 Feb 2025 23:35:01 +0000
Message-ID: <d6a739c91809127975f2f31dd4a57d5897656ac7.1739403114.git.fdmanana@suse.com>
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

Add a _require_btrfs_no_nodatasum helper to skip a test if the nodatasum
mount option is give, as we do have several tests that fail, for several
reasons, when that mount option is passed.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 5d69ddd8..a3b9c12f 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -134,6 +134,13 @@ _require_btrfs_no_nodatacow()
 	fi
 }
 
+_require_btrfs_no_nodatasum()
+{
+	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "nodatasum"; then
+		_notrun "This test requires no nodatasum enabled"
+	fi
+}
+
 _require_btrfs_free_space_tree()
 {
 	_scratch_mkfs > /dev/null 2>&1
-- 
2.45.2


