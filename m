Return-Path: <linux-btrfs+bounces-11732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC70A416C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 09:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B841895482
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7A241681;
	Mon, 24 Feb 2025 08:00:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B741207DF7;
	Mon, 24 Feb 2025 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384001; cv=none; b=VBnyGMaQnHyhuZcqmuvxndPFL+p4u8gUs5gWYdJP5lqockeNEhIG6kQ6LdFF4czrqmb1qpQUY2PxDnPc4c547vlfgb4MjwaxE3udYvEAhkhneGCW7DTv+e2+Wnv+H+/NOpwL6T2HnWO3vrJvnmXKtDKzwI0+19id1YDzCOS+q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384001; c=relaxed/simple;
	bh=03CjEY3oVXOoJ7aw7338nodyXVXPpOxAUbsCIn2BYdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cJRGzYxa20J0p8WYvhwXVjx6lXJdcJcJ0+c64N6sluRzJvUBH2tQgTorQbvZATI4G+0sTg+4fEgWXTuw7wci+YKSm809X2osdWzWDFI4smNzDOpHnXFSa8BRE3sCdGPosJ5FsTABAjtCR9bNYSsHfUjbyx4VqD8k2bqYHyDQ3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowACnr1vqJrxnLXzyDw--.47959S2;
	Mon, 24 Feb 2025 15:59:50 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	fdmanana@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: add a sanity check for btrfs root in btrfs_next_old_leaf()
Date: Mon, 24 Feb 2025 15:59:37 +0800
Message-Id: <20250224075937.2959546-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnr1vqJrxnLXzyDw--.47959S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr43Gr1UGFWkWr48Zr4Utwb_yoWkWrb_GF
	WxZ34UGrW5Gr1fC3yrKwsIvFWDKw4vkrn2ga4qgF98KFyUtFn8Gws2qrsrG34xGa1UXF15
	G390v34I9a1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUp7KsUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

btrfs_next_old_leaf() doesn't check if the target root is NULL or not,
resulting the null-ptr-deref. Add sanity check for btrfs root before
using it in btrfs_next_old_leaf().

Found by code review.

Cc: stable@vger.kernel.org
Fixes: d96b34248c2f ("btrfs: make send work with concurrent block group relocation")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 fs/btrfs/ctree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4e2e1c38d33a..1a3fc3863860 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4794,13 +4794,17 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	int level;
 	struct extent_buffer *c;
 	struct extent_buffer *next;
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info;
 	struct btrfs_key key;
 	bool need_commit_sem = false;
 	u32 nritems;
 	int ret;
 	int i;
 
+	if (!root)
+		return -EINVAL;
+
+	fs_info = root->fs_info;
 	/*
 	 * The nowait semantics are used only for write paths, where we don't
 	 * use the tree mod log and sequence numbers.
-- 
2.25.1


