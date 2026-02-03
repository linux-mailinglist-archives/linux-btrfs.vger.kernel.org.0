Return-Path: <linux-btrfs+bounces-21346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMZcBEuHgmnDVwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21346-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:39:55 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A4DFCAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C1E130DAB21
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 23:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE8032C925;
	Tue,  3 Feb 2026 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkaEBNsS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4B32C326
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161947; cv=none; b=TrTLREr22iTB8APzAJZ/g928RyZK5qlE6txie1/bj2D44tJZfeBLr5IMGDfi7QyCuTB5awTzn8hqnxQLf+VVNQmJf7QcqoJaZkbF2YnJzgrlJsu9Ky1cgF0eVwxwWm4gwnyaoL1RJnJrYWvJdzGOOe+iWfV4kiOAKITr2+BTGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161947; c=relaxed/simple;
	bh=DlNgDipoFREjna5v1D+H2Bs0oDzRNW8D1X2caSwiRCI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CThA7EvnYWMbaC7UIUTgvvB/5XaX/XaKEOe4Lf5nEGrCh50chVyQ5bzvcF9cpJwpQlqO5LNeEitsRA/qQelETfYdU+P3s2/ziYqX5B62I2YyKvc9ccTu4GXXIsR6ANaNjJqj1ROswztVlkFW7FwVak5YDNPT1c5yfOSj9OHCrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkaEBNsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FE4C19422
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 23:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770161947;
	bh=DlNgDipoFREjna5v1D+H2Bs0oDzRNW8D1X2caSwiRCI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pkaEBNsSwvS45ziUB4aYxRpVT5GaRfrKhUhzXolaK9F74F+JwZPuv9ajua52uLPjG
	 6D4qaXvE/bgs+thcmrs/b36GfKny+Mg2mlxg5cw7w0BJRa8RvP4EbVneLLsd9OKyvG
	 8S7ifQzf6EGOJvgs/m4lfaHQ99KtPmnZp9Skk1nZUabxH6Rz3SKDwA1Hqqk1nZSMaH
	 sebfIODG3/luMQEBx5Egye5bHeIfWneH4GYASzv8lFJIbbLwpn11c7FtbpT4FPzCkW
	 l5R6yExNBdubQpVxRPnp5NfZTb61RPoLbVimC7I6erjAtqHrJYnB/TRmsVEp01ecYl
	 zE6oAZOn9b79Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: update comment for BTRFS_RESERVE_NO_FLUSH
Date: Tue,  3 Feb 2026 23:39:01 +0000
Message-ID: <8990fb15015c4df073fc70890ba94f0507e87500.1770161798.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770161798.git.fdmanana@suse.com>
References: <cover.1770161798.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21346-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D1A4DFCAF
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

The comment is incomplete as BTRFS_RESERVE_NO_FLUSH is used for more
reasons than currently holding a transaction handle open. Update the
comment with all the other reasons and give some details.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0703f24b23f7..6f96cf48d7da 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -21,7 +21,24 @@ struct btrfs_block_group;
  * The higher the level, the more methods we try to reclaim space.
  */
 enum btrfs_reserve_flush_enum {
-	/* If we are in the transaction, we can't flush anything.*/
+	/*
+	 * Used when we can't flush or don't need:
+	 *
+	 * 1) We are holding a transaction handle open, so we can't flush as
+	 *    that could deadlock.
+	 *
+	 * 2) For a nowait write we don't want to block when reserving delalloc.
+	 *
+	 * 3) Joining a transaction or attaching a transaction, we don't want
+	 *    to wait and we don't need to reserve anything (any needed space
+	 *    was reserved before in a dedicated block reserve, or we rely on
+	 *    the global block reserve, see btrfs_init_root_block_rsv()).
+	 *
+	 * 4) Starting a transaction when we don't need to reserve space, as
+	 *    we don't need it because we previously reserved in a dedicated
+	 *    block reserve or rely on the global block reserve, like the above
+	 *    case.
+	 */
 	BTRFS_RESERVE_NO_FLUSH,
 
 	/*
-- 
2.47.2


