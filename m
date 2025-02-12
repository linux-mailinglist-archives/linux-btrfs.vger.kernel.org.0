Return-Path: <linux-btrfs+bounces-11434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C3A33377
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910E43A8514
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966C263C60;
	Wed, 12 Feb 2025 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJP6hA8f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B90263C67;
	Wed, 12 Feb 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403325; cv=none; b=jgeKueQ/wtdIW1f1r4X1bHhhHSQbZQy7IYbSKGm3LZfQDH3FnDWvekiZrUV7SxIK9wLBCr7Qp5GYzbgQtZ5yyDZfsA4bw7vVurQ/DO+fDDqBCuLpIyS2foZeytBrc2K9keuMOTIRr2jnCjWb6iWJvhF6y3UYxMWb00/pF6g4i9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403325; c=relaxed/simple;
	bh=R9zk32eYJmRwZVeXIhnAZ62HN5guLOg9t8RgRLRYI34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoDVhWq3B43cvZawysZqGQBmKqGl2m6tCEYsoSmZ6Z6vbPRiNzDhAoJ8A2Sc/we6g3TID2NbPT7T1GtYXHBNak4+5J3gmx7+N4gUg5Y2fqzrWWY9KBtskD+NegnfV5qKCwaHLwTiaAR45GnIQTgx0V5+y9Iz83QwPuq26xBfqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJP6hA8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57752C4CEE4;
	Wed, 12 Feb 2025 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739403324;
	bh=R9zk32eYJmRwZVeXIhnAZ62HN5guLOg9t8RgRLRYI34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJP6hA8frAzvY+LT0aFH7/89Yzl4e6xaBqD3BiCslnbPqzPHINi5KVhWzhGmq2XH1
	 H7JwjGL10fbMnPLly4dkWTItD02WxxUTVHGqpYh/u0UN8PKW5NeQAHEPbSALST3Tzj
	 45QCi7CZxwyyU/DwxmOW8O7MJVQTOl92xHRWwsXn5dU7NQoHPMU0lNvgY8zVmCXogD
	 Id5T/OEA9qSu/NJBYFzS7Qi3XZo0M9Jw5UdXMwIkM+RBeoUJWa5idyES9OI/8d2BX+
	 hLNN07xGBn6PUSLSmDGwM/8RhmG1zIyMxkE7twK4KaKTTcO25I5tTxG1GakC6OE69O
	 BmRvnX6GG6bHw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v2 7/8] btrfs/281: skip test when running with nodatasum mount option
Date: Wed, 12 Feb 2025 23:35:05 +0000
Message-ID: <313bb218f2c32ce565b6b2e3a9adbda6c68d4d41.1739403114.git.fdmanana@suse.com>
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

The test exercises compression and compression doesn't happen on inodes
with checksums disabled (nodatasum), making the test fail the expectations
if getting compressed extents. So skip the test if nodatasum is present.

Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/281 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/281 b/tests/btrfs/281
index 855dd824..8fb7158a 100755
--- a/tests/btrfs/281
+++ b/tests/btrfs/281
@@ -25,6 +25,8 @@ _require_btrfs_send_version 2
 _require_xfs_io_command "fiemap"
 _require_fssum
 _require_btrfs_no_nodatacow
+# Compression can't happen with nodatasum, so skip the test.
+_require_btrfs_no_nodatasum
 
 _fixed_by_kernel_commit a11452a3709e \
 	"btrfs: send: avoid unaligned encoded writes when attempting to clone range"
-- 
2.45.2


