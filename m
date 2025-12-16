Return-Path: <linux-btrfs+bounces-19800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D2CC45AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653A730C10E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868DE2D47EF;
	Tue, 16 Dec 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S022BUw2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12A2C1786
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902961; cv=none; b=ppbPdwB3a8rzH+CEAcyaF81Il68Rj0R+bdRmkFBvy8cke/FIrL2qRVnQGaaNjqo2X4QxsneUYEJb4qhhnAy4uAUzC+r6mufiE+/U/dyOMeMhFswafmtm1NuQSNM4SmfPO5B5aEymCKKMnd+0SA4TupostntuEN35j+KKvSuNj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902961; c=relaxed/simple;
	bh=Ro2qCQor5DQ3OjL2yCNelMcgQHOdPdI5R4oQLR/95lg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Lz/JWHwSBMuarw1YO5kiV9TIsa6i6v0kgUfP8cd9hdCnfv8AxfC9egWpgehTAL6REo4vF+Ugdt6jTfpoDwc18iOo8RaOe3B+6c+Q1bKGPRGTR9BFfXQGXWQAbmb4Eukb9smc5lcokA/JSlqya98MY3wf1nLZKn2aearTwIYJqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S022BUw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B00CC4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765902961;
	bh=Ro2qCQor5DQ3OjL2yCNelMcgQHOdPdI5R4oQLR/95lg=;
	h=From:To:Subject:Date:From;
	b=S022BUw2DmAOJoW78O0Eq04LkrHgF0sJRdxI148L4o7zw/tknqE/9uhtQEXML/OjH
	 iW+2Tj16uk51hqMXBuagj+Z5YqrguvyKoIdT6V6FYFfrlWs/WoIahg4PIldPAViKhG
	 xgr+2nrJ5ax+gu1fR+ORNbhI2qAMs8fKu+RVox/fAS6KCOzN6WSH9aA9cKMAcGBXMq
	 I0FDu2NZ08BLVwsRJRynHaB7lRy8VSsKnYmu7YNIG7DtlYbKohvhT4Lt2imz5qc3mK
	 X8U/N5f+ZvNW1uZGwDO2odNra/gt0Ivl/Vuvayc1dNMF559sWxOBbazCaEVKlFx/Yt
	 vhUP/5P7JVOrw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't call btrfs_handle_fs_error() in btrfs_commit_transaction()
Date: Tue, 16 Dec 2025 16:35:59 +0000
Message-ID: <9f7dcc2908682e4f888affa60d0b13db92e2970e.1765902946.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to call btrfs_handle_fs_error() as we are inside a
transaction and if we get an error we jump to the 'scrub_continue' label
and end up calling cleanup_transaction(), which aborts the transaction.

This is odd given that we have a transaction handle and that in the
transaction commit path any error makes us abort the transaction and
it's the only place that calls btrfs_handle_fs_error().

Remove the btrfs_handle_fs_error() call and replace it with an error
message so that if it happens we know what went wrong during the
transaction commit. Also annotate the condition in the if statement
with 'unlikely' since this is not expected to happen.

We've been wanting to remove btrfs_handle_fs_error(), so this removes
one user that does not even needs it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e82ca3f724db..206872d757c8 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2550,9 +2550,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		wake_up_process(fs_info->cleaner_kthread);
 
 	ret = btrfs_write_and_wait_transaction(trans);
-	if (ret) {
-		btrfs_handle_fs_error(fs_info, ret,
-				      "Error while writing out transaction");
+	if (unlikely(ret)) {
+		btrfs_err(fs_info, "error while writing out transaction: %d", ret);
 		mutex_unlock(&fs_info->tree_log_mutex);
 		goto scrub_continue;
 	}
-- 
2.47.2


