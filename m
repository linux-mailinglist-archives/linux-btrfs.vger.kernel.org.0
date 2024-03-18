Return-Path: <linux-btrfs+bounces-3350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7355287E92E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 13:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335BD1F23328
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 12:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3917638387;
	Mon, 18 Mar 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1/grPR0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56626381CD
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764101; cv=none; b=g/GV9PUYCNy6CaXdyTRov20CtdbOWoirRI0EDXsSZmTZPcamPoIajPytf7+jhxWEakkSf/8I3VK2rKh2znrare/OmozdaD20+L8NJuIFElrqDBCFsWtBQ3L7CIZJLp4RrRkN1XCSp/tNEBExJ/dnHaODdb0QGj4uL/gHQDsVf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764101; c=relaxed/simple;
	bh=RH71WcPEamHSx6e7r6FxnRbbIvtTCwEcEhYWJBznk1s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JySVzAdxL8l1UJBnEaQLKmvQKETvRWhbUegLq/5QL7UrJmGFRjy6AQyIFSxgECDcfq/wEYmFGlJzgI4nZ058H+EQOdakeSJv1drFLD2hJB8o457lIKVy3MYSSE/82SipifcYIH7hLxI5Olgh3CSPqJP+jWP0DJYiu0cgcZAWvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1/grPR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A555BC433C7
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710764101;
	bh=RH71WcPEamHSx6e7r6FxnRbbIvtTCwEcEhYWJBznk1s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y1/grPR0QaZlpymefpUCxB3rEZKoWiQ16im7cjwiAQjFHGF4z95lr4SD7vqGBcFm6
	 6bXP4F8+VdD6xbi4fhDx406FlcYeJfpbYyPAkVLAsEQVX+f0f8Kv5Rt5f4RmZPKg5a
	 BfZOGWNfg1rwncRS0/Jh5TPz1ryXf6MhcbESFLgm88tVR/+ROoO3hO97R8g/rf+twU
	 N1NrfAhq0zFzck/ZHaP9C2bsUXyPgFi5cM7Y7L+LIe6RsXnOYeMJnI0lJC+9tSp4KM
	 bcaPe6xRBSYbrDycW3Z6FulM2LVUldig7mS+xoEbpHDuyMQks0OtdJryMoWNxpE3Lt
	 iZVQIGKeE1Gpg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: remove pointless writepages callback wrapper
Date: Mon, 18 Mar 2024 12:14:56 +0000
Message-Id: <12ee7ad204aa7f76ca28df5d6eb2f0dcdc85ce64.1710763611.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710763611.git.fdmanana@suse.com>
References: <cover.1710763611.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in having a static writepages callback in inode.c that
does nothing besides calling extent_writepages from extent_io.c.
So just remove the callback at inode.c and rename extent_writepages()
to btrfs_writepages().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 3 +--
 fs/btrfs/extent_io.h | 3 +--
 fs/btrfs/inode.c     | 6 ------
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 47a299b0fa2d..4a684251fd96 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2256,8 +2256,7 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 	submit_write_bio(&bio_ctrl, found_error ? ret : 0);
 }
 
-int extent_writepages(struct address_space *mapping,
-		      struct writeback_control *wbc)
+int btrfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
 	int ret = 0;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index eb123b0499e1..818431b37124 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -237,8 +237,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio);
 void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 			       u64 start, u64 end, struct writeback_control *wbc,
 			       bool pages_dirty);
-int extent_writepages(struct address_space *mapping,
-		      struct writeback_control *wbc);
+int btrfs_writepages(struct address_space *mapping, struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
 void btrfs_readahead(struct readahead_control *rac);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e447a4f1d926..1fd2ea80caef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7913,12 +7913,6 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return ret;
 }
 
-static int btrfs_writepages(struct address_space *mapping,
-			    struct writeback_control *wbc)
-{
-	return extent_writepages(mapping, wbc);
-}
-
 /*
  * For release_folio() and invalidate_folio() we have a race window where
  * folio_end_writeback() is called but the subpage spinlock is not yet released.
-- 
2.43.0


