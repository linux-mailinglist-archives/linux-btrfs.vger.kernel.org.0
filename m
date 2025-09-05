Return-Path: <linux-btrfs+bounces-16675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA78B45DA5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A761C8083C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8B535CEA6;
	Fri,  5 Sep 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTUoM6wo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266313568F9
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088669; cv=none; b=tEvHeUC2jsgDgCrNMPuq5M/ZXgEoRD63zimqhcB/mGp+hBxlKOvTPbC8psNiDYu+kPNQJNE6kwu42pFSxwkK7amuSuwffbKbQKffqqBrsup1kV1AjcQiG8T9/ERt0uOFKjKFgA17sR9zopX9TccYZokc5rfCJDAXlqsu0TzWud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088669; c=relaxed/simple;
	bh=d/MwSPBEFIvMAMkdova/Hbd1ubKniFSXKHm5MVJOc9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHnrRYwQUqmiFOakfQClsCZz39wxLbeLZiblSnaE6AOOPcMI0ID0JtFT08+z3kYBei1YrBxYURn7P8eTxttMx+S43n7+UdgAzi1MLe8pugIPXNLgLRgGMEJ4Uycz5nOukKLuCCo6NrBNziJfjlWB4a2oYB244pMAYgCO590arRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTUoM6wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799BAC4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088669;
	bh=d/MwSPBEFIvMAMkdova/Hbd1ubKniFSXKHm5MVJOc9I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sTUoM6wob17NXIQ3hFRcnoVuSUaaVERG9meDxPgKM4WUHm8/u1sPt6aCjBN9/igMG
	 JmuuPCQTvY8TYtOl5iW6N6K9n1gsoEXpufMAV5biNLirJRgrWEG1VtgslZvV9gEi3s
	 qAKqogacoZr2Qw09IcWPBDpnu8EjLGTTC8/z6ZAjrVpZehc05QZ9vaQaHuG64tojwP
	 hiGBVp7GQhc9hOtrg2E1jTVjAkSMtz7H/rbgZi30WSqQZx9MjVktYJbRS3TDoi6n7T
	 a0w6Z7s7Rq/gHZMGNECiN+lg4VQrfkaVc7w1DxWIgwmcEEmICjmggA4KovslG8Ler9
	 Ur+bPDQ9i7mJw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 31/33] btrfs: abort transaction if we fail to find dir item during log replay
Date: Fri,  5 Sep 2025 17:10:19 +0100
Message-ID: <1ad0a37a4e4ec28bd6ad829e46bc099613e1bb94.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At __add_inode_ref() if we get an error when trying to lookup a dir item
we don't abort the transaction and propagate the error up the call chain,
so that somewhere else up in the call chain the transaction is aborted.
This however makes it hard to know that the failure comes from looking up
a dir item, so add a transaction abort in case we fail there, so that we
immediately pinpoint where the problem comes from during log replay.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 86c595ef57f4..7b91248b38dc 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1281,7 +1281,9 @@ static inline int __add_inode_ref(struct walk_control *wc,
 	/* look for a conflicting name */
 	di = btrfs_lookup_dir_item(trans, root, wc->subvol_path, btrfs_ino(dir), name, 0);
 	if (IS_ERR(di)) {
-		return PTR_ERR(di);
+		ret = PTR_ERR(di);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
 	} else if (di) {
 		ret = drop_one_dir_item(wc, dir, di);
 		if (ret)
-- 
2.47.2


