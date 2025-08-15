Return-Path: <linux-btrfs+bounces-16082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0171B27C41
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 11:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AC416CA95
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26796261585;
	Fri, 15 Aug 2025 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlnN7tjT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE9320C469
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248619; cv=none; b=hp/WSBYsPzp6Sm8YoQCN/8vX2DNbossFFcAXGqct5FOWsIIby8QVTb0pNiJ/gquqDewC0n+kmIlG6aPhgFs53oaBFzskwlUk4Dpsb5AkpjUg3QogJO0PZJ+BG9a/VtSbeRSVlpZgAEJFz5lC9feSKZW+KAub4+B3lhV3abylXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248619; c=relaxed/simple;
	bh=IztLXmC3ry80Sahl8RFInV4VFQyWW/MYt+MMXEYZ5tM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SaHsqdgZpWeospxer65bE8CX8VJhrZfCXVJJz4mxANJ3Fzc98uiGGB7L01XQBC8W2kTFkyMKPagVdlVOkcUJaE5N9KwIe5SQ8T2xPK90HijblydgJjcAPXY/qN2RB36XwWGjVpxRc3C05dsLw/iztOC/d/y8USxRETfXUpFiGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlnN7tjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4137BC4CEEB
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 09:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755248617;
	bh=IztLXmC3ry80Sahl8RFInV4VFQyWW/MYt+MMXEYZ5tM=;
	h=From:To:Subject:Date:From;
	b=OlnN7tjTJFvgwGx4hIjq+zLfWZxgt6V6GpCke7517FFaJSIFxDIaecCEMWH8V1lIE
	 o5DcUFJUye2FAGXVza/AtaeovwniCJW57O81hHwlmQq7SCHwiNSLAINLAQCSPZb7Xl
	 RQHSe6XWLJRi8ACvgjdyCWcpzA8Rm9vtR60jA8UrzUeZ7fja2JHa77doFs1T1wINmY
	 078TosO5XSKvwr0F8BYRCoNegbHicCmUIisXDvLrdXykgjS+qKE+p0U6KdcwP5ko9p
	 aAHn5CMmOl0hOT+Lt5Gxnxn86Tvzpe9oUbLdKOysR+1Vp/YFP76Sau3CW8zxdrfNYP
	 8a4BJVVILWsDg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: stop checking for NULL transaction when pinning log tree
Date: Fri, 15 Aug 2025 10:03:21 +0100
Message-ID: <4629b5fcab544101e9b6f935a7856428abe2f56d.1755248327.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At process_one_buffer(), if we are pinning a log tree we don't need to
check if the transaction is NULL or not, since when pinning we have always
have a transaction, so we can stop doing the NULL checks and always call
btrfs_abort_transaction() when an error happens. So remove the checks and
assert the transaction is not NULL.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

This is meant to be folded into:

  "btrfs: abort transaction in the process_one_buffer() log tree walk callback"

 fs/btrfs/tree-log.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 654d6912eb46..74ade535b5b3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -372,24 +372,18 @@ static int process_one_buffer(struct btrfs_root *log,
 	}
 
 	if (wc->pin) {
+		ASSERT(trans != NULL);
 		ret = btrfs_pin_extent_for_log_replay(trans, eb);
 		if (ret) {
-			if (trans)
-				btrfs_abort_transaction(trans, ret);
-			else
-				btrfs_handle_fs_error(fs_info, ret, NULL);
+			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
 
 		if (btrfs_buffer_uptodate(eb, gen, 0) &&
 		    btrfs_header_level(eb) == 0) {
 			ret = btrfs_exclude_logged_extents(eb);
-			if (ret) {
-				if (trans)
-					btrfs_abort_transaction(trans, ret);
-				else
-					btrfs_handle_fs_error(fs_info, ret, NULL);
-			}
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 	}
 	return ret;
-- 
2.47.2


