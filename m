Return-Path: <linux-btrfs+bounces-5064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DA8C86FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 15:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CB01F235A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 13:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F3B53E28;
	Fri, 17 May 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URNDkwVS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB08537EF
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951611; cv=none; b=sHhLX4ClUzJNS8XPRF5nc9GmdGtxbIdO1LgsBgMcEYWs9uknh3vchvuZFYGUg41raAlqjXen8HMKcHOrsxSjDlAaHvZ5dR5mR6CvbpRhhm3kogeD9l6o/UDEnm3+P8r5HsDUHUNkwtwTGhXrnGe+0aD+MotM4wddVQdoJzwIzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951611; c=relaxed/simple;
	bh=/pVNjv5or8dDAQgrN2LommAl5yCHdzkdpk299J3kpdk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFFFxQB+hu4rwLYpUeQ9PY109bVBaBkNb2GQoAm1jmXQuvnH9We8Cpbbf8UO8/QBZO8EhCryis7UayJzwOPfRiskoaogEb1zEHIlu+kQTUPUcgNDTDxaSYDgzwOv2ui3foMjOR7LOQJts2nrVa1RNBZJMZXIQB5W3yxfv5ClXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URNDkwVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E973CC2BD11
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715951610;
	bh=/pVNjv5or8dDAQgrN2LommAl5yCHdzkdpk299J3kpdk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=URNDkwVSCoGUWyxMeIM0HEWAMyLwnnKR7xZKQg7reS1TodBVkfdNumYfGQsRH1Xx9
	 JMHJDaPEtYor9CIxe6C7CzeoQ1GH1vcltOsUlPEL91tES7hEna0q3sTTx5mp4hoPDB
	 i6MG3tq3rWIoandQdTUzbenQ79xTz9N/VZDc/hqJ0pazR2fEun2q5YgAtw9jFVjpTf
	 +eZMJ1OKGSlRuLuP+mxxG6qidxPTGZP0UdcnrdjI7XCffkYx5OvuyzVE55D7SViC3J
	 ZNn1xmwvxhomb95V7M6B3zrCHjTJyTaUX0m9+sUW8gYmfDDlFew41HXp2RXxONaLS4
	 5MgXUVHX1kqXg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: always set an inode's delayed_inode with WRITE_ONCE()
Date: Fri, 17 May 2024 14:13:24 +0100
Message-Id: <3ebdf6919047ce1eb6ad4f4058e4084047fe1d6d.1715951291.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715951291.git.fdmanana@suse.com>
References: <cover.1715951291.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we have a couple places using READ_ONCE() to access an inode's
delayed_inode without taking the lock that protects the xarray for delayed
inodes, while all the other places access it while holding the lock.

However we never update the delayed_inode pointer of an inode with
WRITE_ONCE(), making the use of READ_ONCE() pointless since it should
always be paired with a WRITE_ONCE() in order to protect against issues
such as write tearing for example.

So change all the places that update struct btrfs_inode::delayed_inode to
use WRITE_ONCE() instead of simple assignments.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 483c141dc488..6df7e44d9d31 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -106,7 +106,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
 		 */
 		if (refcount_inc_not_zero(&node->refs)) {
 			refcount_inc(&node->refs);
-			btrfs_inode->delayed_node = node;
+			WRITE_ONCE(btrfs_inode->delayed_node, node);
 		} else {
 			node = NULL;
 		}
@@ -161,7 +161,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	ASSERT(xa_err(ptr) != -EINVAL);
 	ASSERT(xa_err(ptr) != -ENOMEM);
 	ASSERT(ptr == NULL);
-	btrfs_inode->delayed_node = node;
+	WRITE_ONCE(btrfs_inode->delayed_node, node);
 	xa_unlock(&root->delayed_nodes);
 
 	return node;
@@ -1312,7 +1312,7 @@ void btrfs_remove_delayed_node(struct btrfs_inode *inode)
 	if (!delayed_node)
 		return;
 
-	inode->delayed_node = NULL;
+	WRITE_ONCE(inode->delayed_node, NULL);
 	btrfs_release_delayed_node(delayed_node);
 }
 
-- 
2.43.0


