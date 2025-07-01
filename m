Return-Path: <linux-btrfs+bounces-15169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E981AEFE9A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D86188E3A7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104DB27AC24;
	Tue,  1 Jul 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbhgHMFM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5697727A92E
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384548; cv=none; b=D99pARHddDoGBBxDPQjpHdDNPvxSjZWr6Wvq9RyzklbJVeMmOMs3x8tp9SKaPEhw8HYLYYw4Q0ccOgLksp+rvjmy1wh5itHF5Nr30efZHeqy+BI/qRDj4go8UQlP6cPLNCW6R1b5XtRcHpX+nfpcbKWoD8Kuyn5wrBo6jGPZwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384548; c=relaxed/simple;
	bh=x7pKDrRBzrsdiRMReM5VqMbGih1iJQD88FJP/7wU5dc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov4uDFS67U+QRRrAZTF3K4qzaxZvEYI2GeBuIQOkZ6n4jc2E3QzU8eNxPGqkPyS4s3FWT1i6lwk+1SBAA/Kcl7ygeICvwZUZBgI4Zifm1bQSjGpnnYkb+L3Lrar2XnemdqlPyZqr0FdfLrJW4VUBn1ciQJ/Qws/bRzdNOsZN+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbhgHMFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5404EC4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751384547;
	bh=x7pKDrRBzrsdiRMReM5VqMbGih1iJQD88FJP/7wU5dc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SbhgHMFMKdp3rhzIOmThw5+5AMReebYEqk0SeJXUWHdNM3KNh6LstCEYG4JD6y/rE
	 uIYOeLuxAskgG5NCwqBppiIYK16KPndjdfSHZDF+qi9zN4Jw0Gzm14vjXaMnwSU+QL
	 nNYwgD53pbzqXOaQdTQVUUP9RsGlRS1rHKMgtvb8Wxc1cBW8n6CXiNXaO+fAqVP76A
	 BdDBiN5bjakeBjaL3GZgNagpP5uesF7JK/dvJIN609esZYzIq5eepYiIZlFWN2/u8v
	 YjlrFIP2WtYVrwGn3K8VSBvyEY8VueV89vviNgYgDR70xUZ+thfIokks26pb+Rlwrs
	 qWldZBY22pnow==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: qgroup: set quota enabled bit if quota disable fails flushing reservations
Date: Tue,  1 Jul 2025 16:42:20 +0100
Message-ID: <6f75859e2d0736e332a568d0babf05abc4ec46ed.1751383079.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1751383079.git.fdmanana@suse.com>
References: <cover.1751383079.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Before waiting for the rescan worker to finish and flushing reservations,
we clear the BTRFS_FS_QUOTA_ENABLED flag from fs_info. If we fail flushing
reservations we leave with the flag not set which is not correct since
quotas are still enabled - we must set back the flag on error paths, such
as when we fail to start a transaction, except for error paths that abort
a transaction. The reservation flushing happens very early before we do
any operation that actually disables quotas and before we start a
transaction, so set back BTRFS_FS_QUOTA_ENABLED if it fails.

Fixes: af0e2aab3b70 ("btrfs: qgroup: flush reservations during quota disable")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 42d3cfb84318..eb1bb57dee7d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1334,11 +1334,14 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 
 	/*
 	 * We have nothing held here and no trans handle, just return the error
-	 * if there is one.
+	 * if there is one and set back the quota enabled bit since we didn't
+	 * actually disable quotas.
 	 */
 	ret = flush_reservations(fs_info);
-	if (ret)
+	if (ret) {
+		set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 		return ret;
+	}
 
 	/*
 	 * 1 For the root item
-- 
2.47.2


