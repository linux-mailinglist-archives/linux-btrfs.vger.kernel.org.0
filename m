Return-Path: <linux-btrfs+bounces-16697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFD2B48916
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DB8174248
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7AE2F39CD;
	Mon,  8 Sep 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWH7ExW0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4D1E505
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325213; cv=none; b=HIC3Rv1aBbV/DwhNoJztOkcy95RxgVsmDBitpwBuKlFkWiK+nvrkPrDG/FDR/KeF2LXR7BTRdxPNz/ql8hXKTF8orJTkvAUN6FpNzltYJ2t+F4ydy7l8hzPkgnWzci8fqpilePrUMalwC3vczDaF0PpPUDFQIHrxyB5ZX9RH/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325213; c=relaxed/simple;
	bh=rwnbfINxEY6deZMhj7TGneuNUzMHgCbZad9wPEJ11dk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJ87gbkD43IK5AY8f23C+vF/irDSi8skYf75XMWuIEmtH7VWmqhlbHc2zW8scyHyIyRrCfC/PNlx0GgHE/XIlV4ZJ2wU5Y80nDfZA/VIOgZo6es5lk/i1/h+saY4gz8CZvUkzOWtOkDt2r3ExYqa9exAm1VOTLKmxOp/5PwyS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWH7ExW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567C6C4CEF9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325211;
	bh=rwnbfINxEY6deZMhj7TGneuNUzMHgCbZad9wPEJ11dk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cWH7ExW09Q/Aq3osW6cNeP+idfevDD3yXSKbHwT8U0Dpic1AiKfKn29w+y9la59ZJ
	 1HGpmvUdO2NyoGQ7r5Op6+Nl1AIPXfPceYHOEHzO33NtebyzJvcl5RVmZxPbJfv3r8
	 wNPPV/GqJSHI34Ik23VanK7YoLqAwxhfAPP+2Auo0+jpKnkyqURBaAsAEKFK0fTG9I
	 KxvdU95P3stN3fwMPjt9EiSTAb7Up0h996ZkjCFj0mqwA8n3g2NXxnjl9Q1zl9D9OF
	 i/Oiug2hP0UN9qX280a64BWzKCS9CvkGcYb1KabRRFOyJGnM3O58t+XbukqVK2fux4
	 qLrXAJZFDLWJA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/33] btrfs: fix invalid extref key setup when replaying dentry
Date: Mon,  8 Sep 2025 10:52:55 +0100
Message-ID: <1a76c9506d4b2e0d8e54de14e7db939c3e72a74c.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The offset for an extref item's key is not the object ID of the parent
dir, otherwise we would not need the extref item and would use plain ref
items. Instead the offset is the result of a hash computation that uses
the object ID of the parent dir and the name associated to the entry.
So fix this by setting the key offset at replay_one_name() to be the
result of calling btrfs_extref_hash().

Fixes: 725af92a6251 ("btrfs: Open-code name_in_log_ref in replay_one_name")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b91cc7ac28d8..861f96ef28cf 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2058,7 +2058,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 
 	search_key.objectid = log_key.objectid;
 	search_key.type = BTRFS_INODE_EXTREF_KEY;
-	search_key.offset = key->objectid;
+	search_key.offset = btrfs_extref_hash(key->objectid, name.name, name.len);
 	ret = backref_in_log(root->log_root, &search_key, key->objectid, &name);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
-- 
2.47.2


