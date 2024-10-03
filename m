Return-Path: <linux-btrfs+bounces-8496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B91098F15D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 16:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C96B21DAB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A319F40B;
	Thu,  3 Oct 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DhB70LMd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A019F100;
	Thu,  3 Oct 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965660; cv=none; b=Mns7AZkslx+KWzvQOvmC8WcbALAXaXyDewSQoL31nxx6Fuf4Nu7TWjS6X6OqmohhgjpU3BTcgzyZ9LlV1IgZkdr/knjeFGSdJj0otL+lvEII1h6ZYHqLp1Xb9nuRPU5mIGOmR0DxbkpiAImauNkDF172VqrzSWIQfIiL5tmqOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965660; c=relaxed/simple;
	bh=TAf22orbtcAXblsY60OwtdehaYrguLKv6cXxhIYrD7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bo/RS9Lye9V1zLUd810qMi+T9bdmQt1++3ZcOoxTrHeOz2UnUpJU774nKtQptLK1uSzxJr9r9KDDzXsc6tadsIz9gbu5J+8TJY5PsyN5gBIpg6wdQiDaGY3S7rznjL/WK+0KWiDvY5pyxLnh0KwNmuVPwVcWnQZD1xbl+kgi/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DhB70LMd; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=FNT8zI8vqYsfj2Pfp2Dia09WY4tRJdlU0kAO1LgX9s8=; b=DhB70LMdXBluVnPN
	vyyrC+LydRW3BslVWLtYsH5ZD/30ZJQL4TjPqiC9OtWTZr+gv5lnN4i0CqLvTPagXT/ZBawq23y/m
	3leOqKdRxrBY1MVtM2PF020JTnApj7r7o7EnBZuEUyDrwQvEss1Xng5YZbGVfYBSxdBtensGAmYQv
	w7bQfRxaCgYEx3TlSjPmGWpmnLhwdKZmxkR+Jciqc2XrqYEqZBWAQgpXfamYwm0ycvzDHaAt2lUj2
	d4EoFuiRCA34znoNtyRHGLyB2fJdE1qztMi+em8pZHsVwZwlnciOC+TaqtPj5No8+iOb2bredllnj
	lS8oZR4lx5lhxf7ABQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1swMng-008fdF-3B;
	Thu, 03 Oct 2024 14:27:29 +0000
From: linux@treblig.org
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	hch@lst.de
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] btrfs: Remove unused btrfs_try_tree_write_lock
Date: Thu,  3 Oct 2024 15:27:27 +0100
Message-ID: <20241003142727.203981-2-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003142727.203981-1-linux@treblig.org>
References: <20241003142727.203981-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

btrfs_try_tree_write_lock() is unused since commit
50b21d7a066f ("btrfs: submit a writeback bio per extent_buffer")

Remove it (and it's associated trace).

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/btrfs/locking.c           | 15 ---------------
 fs/btrfs/locking.h           |  1 -
 include/trace/events/btrfs.h |  1 -
 3 files changed, 17 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 6a0b7abb5bd9..9a7a7b723305 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -161,21 +161,6 @@ int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 	return 0;
 }
 
-/*
- * Try-lock for write.
- *
- * Return 1 if the rwlock has been taken, 0 otherwise
- */
-int btrfs_try_tree_write_lock(struct extent_buffer *eb)
-{
-	if (down_write_trylock(&eb->lock)) {
-		btrfs_set_eb_lock_owner(eb, current->pid);
-		trace_btrfs_try_tree_write_lock(eb);
-		return 1;
-	}
-	return 0;
-}
-
 /*
  * Release read lock.
  */
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 3c15c75e0582..46c8be2afab1 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -180,7 +180,6 @@ static inline void btrfs_tree_read_lock(struct extent_buffer *eb)
 
 void btrfs_tree_read_unlock(struct extent_buffer *eb);
 int btrfs_try_tree_read_lock(struct extent_buffer *eb);
-int btrfs_try_tree_write_lock(struct extent_buffer *eb);
 struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
 struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root);
 struct extent_buffer *btrfs_try_read_lock_root_node(struct btrfs_root *root);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index bf60ad50011e..9b8d41a00234 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2341,7 +2341,6 @@ DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_unlock_blocking);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_set_lock_blocking_read);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_set_lock_blocking_write);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_try_tree_read_lock);
-DEFINE_BTRFS_LOCK_EVENT(btrfs_try_tree_write_lock);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_lock_atomic);
 
 DECLARE_EVENT_CLASS(btrfs__space_info_update,
-- 
2.46.2


