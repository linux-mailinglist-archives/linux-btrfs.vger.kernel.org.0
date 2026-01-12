Return-Path: <linux-btrfs+bounces-20415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E1AD13F37
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 17:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C79330B6C23
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD1D3659FD;
	Mon, 12 Jan 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="gvd7VrzA";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="a8rpmggg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-1.smtp-out.eu-west-1.amazonses.com (a4-1.smtp-out.eu-west-1.amazonses.com [54.240.4.1])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DBB3659F8
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234644; cv=none; b=Nz0R3gRmgyQvL8lNNmpp6DesWPeqJxQmQc8lXo3GT8XnVSB5+UNnHR/Py3rnskUL6apgf+Xs32h/bnoWGmc0xhcDWoVKp9xFSN/bZc22x7+N/19gzmIXwADtAF6PtKx6ZrFrq6m3lq5gczwgTbhukMErzdo4M7piOHIrj74lypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234644; c=relaxed/simple;
	bh=orA8TN3gP+KRGAtVspxGlV5cmFW6gGBzfiHyM/Ma+UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFu7LoqUiLlU8fT+mEGq9HpU9XUXW0LSM/cHFi+zg2to+NS8J/OWpissmNkv/ErH3/wDnmMYHU6twvygX04NrgrhElSxhiqyG8OiMvmbJUZzN2dUOu0SoMUBoMB5PG6cp4TrfpmjfyID3grpWfZllhieEcGgD59IW+c27/WeCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=gvd7VrzA; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=a8rpmggg; arc=none smtp.client-ip=54.240.4.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1768234638;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=orA8TN3gP+KRGAtVspxGlV5cmFW6gGBzfiHyM/Ma+UI=;
	b=gvd7VrzAIMx51/4U0xX7RuhQeemk9pxk1qH78Z5BZ2kLyptl/ZTn24FU9cZHvQNW
	egYl9L8VkB1tyZVxmWt3OHJAXRKk1FXHQtttXXZcC7gQuxKqQheG/E7Od3x5duP3yt8
	79ksC/EMrtM/CFh8B1fXxDEhZ/OiPSlJrbM+AiHo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768234638;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=orA8TN3gP+KRGAtVspxGlV5cmFW6gGBzfiHyM/Ma+UI=;
	b=a8rpmggg0r9EeM76XkNqzxq6RXtGvSzYUR+ei21+fpUDx02x4E3rmtXk6Fq/LSN2
	JgLiJUEtw/wEbqXphve7j3mSPfDXm3RiunNaSogYJxV8TwHnOvBM4cQ7UVtvQqD8P2Y
	laYakbPfAbxLzC4hf/WhPyQQx0LMMhGn5ESNVbmc=
From: Martin Raiber <martin@urbackup.org>
To: linux-btrfs@vger.kernel.org
Cc: Martin Raiber <martin@urbackup.org>
Subject: [PATCH 6/7] btrfs: Introduce fast path for checking if a block group is done
Date: Mon, 12 Jan 2026 16:17:18 +0000
Message-ID: <0102019bb2ff5d8d-eb7c72aa-7327-4cab-af21-38a804adf477-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260112161549.2786827-1-martin@urbackup.org>
References: <20260112161549.2786827-1-martin@urbackup.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2026.01.12-54.240.4.1

A block group cannot switch away from BTRFS_CACHE_FINISHED
once it enters that state. Therefore we can introduce
a fast path that checks for the likely case
that the block group is already cached, avoiding
a full memory barrier in the likely fast path.

Signed-off-by: Martin Raiber <martin@urbackup.org>
---
 fs/btrfs/block-group.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index cf877747fd56..73bdf7091d49 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -380,6 +380,9 @@ static inline u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
 
 static inline int btrfs_block_group_done(const struct btrfs_block_group *cache)
 {
+	if (likely(cache->cached == BTRFS_CACHE_FINISHED))
+		return 1;
+
 	smp_mb();
 	return cache->cached == BTRFS_CACHE_FINISHED ||
 		cache->cached == BTRFS_CACHE_ERROR;
-- 
2.39.5


