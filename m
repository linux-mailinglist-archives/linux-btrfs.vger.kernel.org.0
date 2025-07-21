Return-Path: <linux-btrfs+bounces-15599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0FDB0C964
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBCB1C20FE9
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A82E2F0B;
	Mon, 21 Jul 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERh45TW3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263502E2EEB
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118207; cv=none; b=nIvhUL478SN2wjKFwU0N9Go5/ZMhb12HEmTN8SGH/XT5lzt5zGH7X3Z9vvPfIR0DuVGVA4z5ySU6ZWCHb3PM0RA1dDxKTg+eqULsi2RZO5RCsLGGngIPovaR9QR9NioqAMPsVXNhmycDC5QPL5pVIFrnqpR5rvBtIeEKV9DsCjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118207; c=relaxed/simple;
	bh=u4xburbAP8EZ7j1B7YroY0J4yDhxUWpTG5l/QF4Iets=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkEjxRdkwlSepzJAdICjagFS1LR0ZRE8iupYtd8CyZS/iz/rTtwcwb5e8hcAUbt9kxLRkpcur7gaAfl3ehWm15C76AEf4Ja2ZKV7dbBcAa2/utm7fGbjEHJy+9zitm8HgQpi7l35x6wMl4S+cCLsp0ZgzGLxkjwYg1NU66ZDSP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERh45TW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538D5C4CEF4
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118206;
	bh=u4xburbAP8EZ7j1B7YroY0J4yDhxUWpTG5l/QF4Iets=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ERh45TW369tG511ZroLYNW8vsif7AjiSbm9Dp8ZgaD+zaLhiU4fr+N7K/jtymtwXx
	 DO8DYMolpk+UWhzGQqfjdu8Lml+AXlwBTOVSdVu+pSe491M88AUvXBZ3b08ntLc5HA
	 +qigmmTM/EG6i5ulANE/SdWMooiWpYPO9hlPwBhxjcOfX0v7onYpabWxazdgeIEuMi
	 3fEPd8UfjFr/PIx5CFHCJmPGYujqbd5/aLZmuilv/n7BiZT5Xr536WsbGmbJ1V/jmi
	 ADeK7AFkxztdwRJ/mBT56oaOUcpOAN4TcCqyzGalcAJNM30NzkI3gQYyZSMvII1Bak
	 0JlFzyYqtDrWQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs: abort transaction in the process_one_buffer() log tree walk callback
Date: Mon, 21 Jul 2025 18:16:30 +0100
Message-ID: <ab5ae695f70c564ba09d166dfe5b61146f7fd9c1.1753117707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753117707.git.fdmanana@suse.com>
References: <cover.1753117707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In the process_one_buffer() log tree walk callback we return errors to the
log tree walk caller and then the caller aborts the transaction, if we
have one, or turns the fs into error state if we don't have one. While
this reduces code it makes it harder to figure out where exactly an error
came from. So add the transaction aborts after every failure inside the
process_one_buffer() callback, so that it helps figuring out why failures
happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b5b1f38c03a6..5e0c4c0595a7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -348,6 +348,7 @@ static int process_one_buffer(struct btrfs_root *log,
 			      struct extent_buffer *eb,
 			      struct walk_control *wc, u64 gen, int level)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_fs_info *fs_info = log->fs_info;
 	int ret = 0;
 
@@ -362,18 +363,35 @@ static int process_one_buffer(struct btrfs_root *log,
 		};
 
 		ret = btrfs_read_extent_buffer(eb, &check);
-		if (ret)
+		if (ret) {
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(fs_info, ret, NULL);
 			return ret;
+		}
 	}
 
 	if (wc->pin) {
-		ret = btrfs_pin_extent_for_log_replay(wc->trans, eb);
-		if (ret)
+		ret = btrfs_pin_extent_for_log_replay(trans, eb);
+		if (ret) {
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(fs_info, ret, NULL);
 			return ret;
+		}
 
 		if (btrfs_buffer_uptodate(eb, gen, 0) &&
-		    btrfs_header_level(eb) == 0)
+		    btrfs_header_level(eb) == 0) {
 			ret = btrfs_exclude_logged_extents(eb);
+			if (ret) {
+				if (trans)
+					btrfs_abort_transaction(trans, ret);
+				else
+					btrfs_handle_fs_error(fs_info, ret, NULL);
+			}
+		}
 	}
 	return ret;
 }
-- 
2.47.2


