Return-Path: <linux-btrfs+bounces-9276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7C9B8A1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 04:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0491E1C21E9A
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 03:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C6145FEB;
	Fri,  1 Nov 2024 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="ol2xBmPp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D544C79;
	Fri,  1 Nov 2024 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730433135; cv=none; b=ODUryCqbT3aUmfYv59FGuGKCxtLU5y1kzlOo6z/YIHM0+ogN6pNFYiiE7CxcNRvrFh8G7cvZIcE6TnhaHzBKjpeoqazB4uBccreLH6WAhvqoN5JFXYfPGb4zGsHRwiDksxR33qXWkriHL0Bc/yKA3OMQjvS9LWmQ3EmalOB0gtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730433135; c=relaxed/simple;
	bh=JpflwicX9fBsBZhasywynZ/y0TYwmbhCSocnbcuYT8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KFexS0hsVpJ+dJemQAilK025CfnNTzdz3rC6PUqCptXsLoFoVfiOwu5o2+EuLkoiiqoF/e1ImFX6rbtd83jOuNuBXTjHgaz6nWVXgP64AVKgrHDCHRF1NqEcIDbLynus11htqe57PO/wzwF9ojOu7RZY8zdTKEqtHtieRNGvZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=ol2xBmPp reason="key not found in DNS"; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=VL6U2qeALI
	oeBGhO9KbfQQvXF5+xanMkAj0oSY2OYdA=; b=ol2xBmPpdecje3+hFbWxb6Y3WY
	6L38i1wKhX2g21+OxTFlcccVbmUP65XZaTYlGaEOT9aTHL+xs1RBc9RYItAFbUp0
	m4rodrEDiNVgWOt4w8/+ursDO2t56PUqrDuMfGGb+7dDSrUVtjN5SJtM2akADtZn
	UjLf4WF8rpj2irtCk=
Received: from s1eepy-QiTianM540-A739.. (unknown [10.130.146.61])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgAX2AFHUCRn5Ya_AA--.11076S2;
	Fri, 01 Nov 2024 11:51:48 +0800 (CST)
From: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com,
	zhenghaoran@buaa.edu.cn,
	21371365@buaa.edu.cn
Subject: [PATCH] btrfs: Fix data race in log_conflicting_inodes
Date: Fri,  1 Nov 2024 11:51:33 +0800
Message-Id: <20241101035133.925251-1-zhenghaoran@buaa.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgAX2AFHUCRn5Ya_AA--.11076S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4DKFy5JFW8CF13tryDtrb_yoW5tFy7pF
	4xWFyUG3y5X34rKF92yw4kWr1agFZxGF4UCry5Cr4xArWUXrnrtrnYvwnrCF15K34xCw1Y
	grWrAF17u3WfArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkF1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kE
	wVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x
	0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF
	7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIec
	xEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 1v1sjjazstiqpexdthxhgxhubq/

The Data Race occurs when the `log_conflicting_inodes()` function is
executed in different threads at the same time. When one thread assigns
a value to `ctx->logging_conflict_inodes` while another thread performs
an `if(ctx->logging_conflict_inodes)` judgment or modifies it at the
same time, a data contention problem may arise.

Further, an atomicity violation may also occur here. Consider the
following case, when a thread A `if(ctx->logging_conflict_inodes)`
passes the judgment, the execution switches to another thread B, at
which time the value of `ctx->logging_conflict_inodes` has not yet
been assigned true, which would result in multiple threads executing
`log_conflicting_inodes()`.

To address this issue, it is recommended to add locks to protect
`logging_conflict_inodes` in the `btrfs_log_ctx` structure, and lock
protection during assignment and judgment. This modification ensures
that the value of `ctx->logging_conflict_inodes` does not change during
the validation process, thereby maintaining its integrity.

Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
---
 fs/btrfs/tree-log.c | 7 +++++++
 fs/btrfs/tree-log.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9637c7cdc0cf..9cdbf280ca9a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2854,6 +2854,7 @@ void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx, struct btrfs_inode *inode)
 	INIT_LIST_HEAD(&ctx->conflict_inodes);
 	ctx->num_conflict_inodes = 0;
 	ctx->logging_conflict_inodes = false;
+	spin_lock_init(&ctx->logging_conflict_inodes_lock);
 	ctx->scratch_eb = NULL;
 }
 
@@ -5779,16 +5780,20 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 				  struct btrfs_log_ctx *ctx)
 {
 	int ret = 0;
+	unsigned long logging_conflict_inodes_flags;
 
 	/*
 	 * Conflicting inodes are logged by the first call to btrfs_log_inode(),
 	 * otherwise we could have unbounded recursion of btrfs_log_inode()
 	 * calls. This check guarantees we can have only 1 level of recursion.
 	 */
+	spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
 	if (ctx->logging_conflict_inodes)
+		spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
 		return 0;
 
 	ctx->logging_conflict_inodes = true;
+	spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
 
 	/*
 	 * New conflicting inodes may be found and added to the list while we
@@ -5869,7 +5874,9 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			break;
 	}
 
+	spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
 	ctx->logging_conflict_inodes = false;
+	spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
 	if (ret)
 		free_conflicting_inodes(ctx);
 
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index dc313e6bb2fa..0f862d0c80f2 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -44,6 +44,7 @@ struct btrfs_log_ctx {
 	struct list_head conflict_inodes;
 	int num_conflict_inodes;
 	bool logging_conflict_inodes;
+	spinlock_t logging_conflict_inodes_lock;
 	/*
 	 * Used for fsyncs that need to copy items from the subvolume tree to
 	 * the log tree (full sync flag set or copy everything flag set) to
-- 
2.34.1


