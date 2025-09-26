Return-Path: <linux-btrfs+bounces-17211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436B3BA2D93
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 09:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3888624B51
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170AA2877F7;
	Fri, 26 Sep 2025 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DdFJWWfy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8F1EC01B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872800; cv=none; b=n/biRRRNFVUrXirgdIePGmfHwWzgckU1C2J32HY6t2ckTJkiXAkD8ejprlLCZ0lnZA73601h+Y6u+n7oKTbKWkq0RQTluP+u+mOLJZBce0ptT7H/fLh7Awxquc/Ug4SHa99jbGYIAo6dp5vjg2czBwlc0gSEmrCa8erQbwojXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872800; c=relaxed/simple;
	bh=6O4UDmOYFlgQss9hMUmj13URvsHTcqWnHmUqkWhSfsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QONaQdQ9QV+lSDmjgiMWeQw8+kunHrw1GGizM8QCFnWQR98WM57Wf8DBx4OzBmI0fyfP8EV7c3q6bDwYYll0Hc6Oxs5ikCMRy4DUQieaMSvbb0UITtIXOLdbxOZaafOqXGOK+M/k/elPsJeK2FP7YZTH3HVTCf8bWXYsJl5lq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DdFJWWfy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758872796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=21M1f7vKrZ6Lv4atYZfvushCM3TQJZysEfiNB2lTWpk=;
	b=DdFJWWfyIyZ4l8oWpKRwgq0I38LKSjqfjA50zNAAooc4TAlLUC2NSJcUa7D/BlbvrebcSq
	HTLCz5hgJRLDc79jwVZ2YQTc8uB9n+XhoWbXtKxa5/SopwCLxfA1e0QhwzjpN5553gObCQ
	/CnqySrWXyhTPs9J3Xugmcbt9vM0mtA=
From: Youling Tang <youling.tang@linux.dev>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] btrfs: Add the nlink annotation in btrfs_inode_item
Date: Fri, 26 Sep 2025 15:45:43 +0800
Message-ID: <20250926074543.585249-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

When I created a directory, I found that its hard link count was
1 (unlike other file system phenomena, including the "." directory,
which defaults to an initial count of 2).

By analyzing the code, it is found that the nlink of the directory
in btrfs has always been kept at 1, which is a deliberate design.

Adding its comments can prevent it from being mistakenly regarded
as a BUG.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 include/uapi/linux/btrfs_tree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index fc29d273845d..b4f7da90fd0e 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -876,6 +876,7 @@ struct btrfs_inode_item {
 	__le64 size;
 	__le64 nbytes;
 	__le64 block_group;
+	/* nlink in directories is fixed at 1 */
 	__le32 nlink;
 	__le32 uid;
 	__le32 gid;
-- 
2.43.0


