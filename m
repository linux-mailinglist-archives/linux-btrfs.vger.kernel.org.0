Return-Path: <linux-btrfs+bounces-18953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD8C594A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 18:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E676156507A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A6335F8BC;
	Thu, 13 Nov 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf9YDYCE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353135B12E
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053007; cv=none; b=A74cIWrgNt7gHskkaqWIPMBXmdL62RTlMM3ePgf+F/VZpwDfIl/fhz2ei3THUUFeozjPRkrnZy6g1fhVxvagPszRE3PrxE4KxkWAbGpL4jmNJo109pnykduGyFKBAmON0HzMFaVGICNwfWLlysL6vQbYQc53gl3W6f1H5k1RImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053007; c=relaxed/simple;
	bh=SIbJOrutrclUz4yXfzSRERWzrckMSVpSonSZxbtQUHM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpzK2bUGVpNeI8Ewj+fOS97BF9bCRSS76Nsg9u6fkIwfGYL1BdzSGfw5BIjOPvni4qEAgtwKmuBPYqkhEZkv5HPSL41taiOc4txp9u+lzTDxA/9cS02FXVOOHWhXEFE2qnv9T8FPUoLIlrsXBSUv+L32C57/fHafxL7ezg+3BOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf9YDYCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA5EC2BC9E
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053006;
	bh=SIbJOrutrclUz4yXfzSRERWzrckMSVpSonSZxbtQUHM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Jf9YDYCEeIpK0DxhVJdDRwWqSp26dGDr4rZJi5oegMKvX7Suz0hWnki9MxixzEy9N
	 cEti0EO2XFNwR2nfzDdU7pY/LVWyrHjbDL4lc2VN4IUDbeyYjaFFUWpoRfH/MlEwh9
	 bcFOE+PYQqYgsHnk08XHqyVxHTVawVYgxNUp8oJoOOshgqf869KI3hWypEywxpi5M4
	 tNwpWIxZaNk61WRA3a1c0lKtEjTJ0u2k8Rn0KAXyUtDRFLXDfehsSLmwdv4zAECudR
	 EHxxB7UHAUp0KK0GVtfmSN3RcPZNFhhnMl9s8eCDZhx1dGPRnABggqDXeh4UIZtpIY
	 RCrzhLZk0JzMQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: add unlikely to critical error in btrfs_extend_item()
Date: Thu, 13 Nov 2025 16:56:34 +0000
Message-ID: <82113b28bc788e474ce5c33ed02fb7444846b4d1.1763052647.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763052647.git.fdmanana@suse.com>
References: <cover.1763052647.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's not expected to get a data size less than the leaf's free space,
which would lead to a leaf dump and BUG(), so tag the if statement's
expression as unlikely, hinting the compiler to potentially generate
better code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e683f961742a..b5cf1b6f5adc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4106,7 +4106,7 @@ void btrfs_extend_item(struct btrfs_trans_handle *trans,
 	nritems = btrfs_header_nritems(leaf);
 	data_end = leaf_data_end(leaf);
 
-	if (btrfs_leaf_free_space(leaf) < data_size) {
+	if (unlikely(btrfs_leaf_free_space(leaf) < data_size)) {
 		btrfs_print_leaf(leaf);
 		BUG();
 	}
-- 
2.47.2


