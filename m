Return-Path: <linux-btrfs+bounces-13616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00699AA6FA8
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725D83A88E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916882441A0;
	Fri,  2 May 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok7fME8T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80BE23C511
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181837; cv=none; b=g0cFYOcUi2rxNdl8G378cPDjjPe37myUd3bYmyHC+soiU1SKSuw/w3AtMEgsEiYEiSwFElSN8AhsDe+fo0BZsr+TawMBWSN3RRhlHcKboF1yvPEh9xkednHt7rGCaYuMQxyTgCGsN7yb/ZHT7r74NLVwGy55htuFaHeFcmGzUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181837; c=relaxed/simple;
	bh=FgqXQ6HKJeMXPT+jKvqYA39U80tNhqmbfQN6e4rVirc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UY9D6MMbMnE3zIel4HhR9NxagfcTq+lu1tssV4dBWms42HwDOfE3bTgqznZwC5odaLEErK44tmO+3+7cnY9vKX1r+gDay//Tc3RYlzXe1Idhadh9J19bLyHbjfjAHV40tprEk7zuzzYU2e1zLwpO88YJA6AOejxhWtPoIFqO2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok7fME8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79C4C4CEEF
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746181837;
	bh=FgqXQ6HKJeMXPT+jKvqYA39U80tNhqmbfQN6e4rVirc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ok7fME8TdxnuP+1KeWPf5EcgzSXi3c21iw+XVXUrn7GH1vXfTRJKP0QMVpo/+xlHQ
	 uErjIsoVLx68tXl9kGb3P2upwyzp8387/3nVPG910ZROd23/HCUQUtolgHomv7SldV
	 JfsVQYt0p//hgjGfsyDSZxSX+hZeq5b46NohUfpRX8JC6jCXiEY6yC3B1UtnY7JGR3
	 CP61+yp/a4ehwuE22M2wQ6f04vsa+G889ybgm6rQwIcM0XTamyLxcSB+Lx505nK8dA
	 jeY8ZKVUP8BzXU1rnmy0Qy2AcaIE8PnCpq0OZfTbftRbH5eTf5kl2EY3m+Pvhkx4b8
	 BUgXPkz533o4w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: simplify extracting delayed node at btrfs_first_delayed_node()
Date: Fri,  2 May 2025 11:30:25 +0100
Message-Id: <97a76c60e98f1fe028370611aed865d0c009bf99.1746181528.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746181528.git.fdmanana@suse.com>
References: <cover.1746181528.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of grabbing the next pointer from the list and then doing a
list_entry() call, we can simply use list_first_entry(), removing the need
for list_head variable.

Also there's no need to check if the list is empty before attempting to
extract the first element, we can use list_first_entry_or_null(), removing
the need for a special if statement and the 'out' label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 206d39e5ce57..a1ac35bc789a 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -216,17 +216,13 @@ static void btrfs_dequeue_delayed_node(struct btrfs_delayed_root *root,
 static struct btrfs_delayed_node *btrfs_first_delayed_node(
 			struct btrfs_delayed_root *delayed_root)
 {
-	struct list_head *p;
-	struct btrfs_delayed_node *node = NULL;
+	struct btrfs_delayed_node *node;
 
 	spin_lock(&delayed_root->lock);
-	if (list_empty(&delayed_root->node_list))
-		goto out;
-
-	p = delayed_root->node_list.next;
-	node = list_entry(p, struct btrfs_delayed_node, n_list);
-	refcount_inc(&node->refs);
-out:
+	node = list_first_entry_or_null(&delayed_root->node_list,
+					struct btrfs_delayed_node, n_list);
+	if (node)
+		refcount_inc(&node->refs);
 	spin_unlock(&delayed_root->lock);
 
 	return node;
-- 
2.47.2


