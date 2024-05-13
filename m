Return-Path: <linux-btrfs+bounces-4936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260F78C45D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 19:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A20282BFA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6020335;
	Mon, 13 May 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8GJ6U06"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41702233E
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620569; cv=none; b=E4tt5eMpvSTbKmy1qs49xpN0IIvcCnqVWQG2HB64LvzgLGgwMyfdCvdSJsxiMM78Ok8kZW2Rp+wsy/cUwCuNLaBwEV5T5+dvYZ3i/2OamA0r98hXQGQKlcYQRCb8G7AwPfy25qgcgeqOK5p5rQhMIGznCuSkgoxtBgjaMYOzx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620569; c=relaxed/simple;
	bh=17XRsaGa/rEZNDJ56lkAHmqPi5iZMqy+5sS/KP+GGOA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LgJvoAD91T5DHYh9g2LrKOcgnnuPLG2R6ejaBix61lu+Ewr6WhaQiu5DkcpSUKBQ/+2yQmYBf68UOyKX9C8MtKAxTErJOsrgI9OhsscYLxZxR3ghqAHePrwXA30RRmDZT3quRTTykle+5+Kg/qaoYx0UXD4QzZJcGg/QQsizKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8GJ6U06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CECC113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715620569;
	bh=17XRsaGa/rEZNDJ56lkAHmqPi5iZMqy+5sS/KP+GGOA=;
	h=From:To:Subject:Date:From;
	b=W8GJ6U06T0ZRAFJzbppdHu04xg8tgq7bz6FIvGJt+vazKvSI9VIAA63G5WycKdcd6
	 Na5kaBe3vfnvJeDLuOzIUcfNx56PtnHzOWGseH1tAy5MYM2E/U0FbHm/K/nPNXsPh2
	 JFtrAnFKGGm8fVTCFcetIL536e4UMLzxJ6haQA8TgB90QWoO5ym+pQ/P5/iZo7GNf7
	 F24Oh5l/9fnM7m6hZVA51BPlX88twiaIlRXg2hLy0XDD9+j9ssw5AJ4PIhyfDAAzRx
	 XH9jGdDXMeAuEOh/DTR6XxbaGkOykwOnA315grE+TZ3QgfaLqNknTl/wfhGphrsWGZ
	 M7ftVPg9FhuNQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix misspelled end IO compression callbacks
Date: Mon, 13 May 2024 18:16:06 +0100
Message-Id: <4a9ef85f3ad20b4a423a695dc90c9fb028135faf.1715620538.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix typo in the end IO compression callbacks, from "comprssed" to
"compression".

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/compression.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6441e47d8a5e..7b4843df0752 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -261,7 +261,7 @@ void btrfs_free_compr_folio(struct folio *folio)
 	folio_put(folio);
 }
 
-static void end_bbio_comprssed_read(struct btrfs_bio *bbio)
+static void end_bbio_compressed_read(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
 	blk_status_t status = bbio->bio.bi_status;
@@ -334,7 +334,7 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
  * This also calls the writeback end hooks for the file pages so that metadata
  * and checksums can be updated in the file.
  */
-static void end_bbio_comprssed_write(struct btrfs_bio *bbio)
+static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
 	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
@@ -383,7 +383,7 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 
 	cb = alloc_compressed_bio(inode, ordered->file_offset,
 				  REQ_OP_WRITE | write_flags,
-				  end_bbio_comprssed_write);
+				  end_bbio_compressed_write);
 	cb->start = ordered->file_offset;
 	cb->len = ordered->num_bytes;
 	cb->compressed_folios = compressed_folios;
@@ -588,7 +588,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	compressed_len = em->block_len;
 
 	cb = alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
-				  end_bbio_comprssed_read);
+				  end_bbio_compressed_read);
 
 	cb->start = em->orig_start;
 	em_len = em->len;
-- 
2.43.0


