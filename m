Return-Path: <linux-btrfs+bounces-21541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBKsOPm/iWneBQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21541-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 12:07:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D41C10E826
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 12:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9CB3018774
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D4536C0D4;
	Mon,  9 Feb 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OebyS9U2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87D36C0CA
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635235; cv=none; b=jH+ui5jzvJ0+b8aosmI8yT2JgJaj7cB+bcWGtvwc4Odv2JWMOZ4qJ2FL3/7ryYnHgULZItr/7FEVYESWE1C38pUQH8ywWywGMZXphzwEIGPxZ3pChmrabjdl6hzUZbmr3ghvqQOuzradRY33iHkgcWMnJUmhQ+SRHUSEB6um3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635235; c=relaxed/simple;
	bh=ot88tsdhSLQetS6f0EeQEHeR5NahW6uxc4zfLArbqFI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW5/knLQqPm6tisQlYMNpzKQ+WTS4RyvW+94PuV5iIv4ud/9tO2F9dLw13439J9OMxhwV7P0ws34+SawMo7XGL4uvDZWEhjxDguY/UzkpZ/4VfaJRlAGHH5s/RzXfHNiUrcm+KFuhY7hDFgJYuTv71u0pVGR6WXknoZq4BpZbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OebyS9U2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A996C16AAE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770635235;
	bh=ot88tsdhSLQetS6f0EeQEHeR5NahW6uxc4zfLArbqFI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OebyS9U2dFrxHQIa2k6BqRkW8codW48FMFxqTkO+LW1bwp/60dwfHh5hXbE/dm90l
	 qTGNY8nDsH9DaftyytQsRba+y8+gLA7WVQIibJm/2Ofggkh2TWURUywsMcLP8PVceh
	 fXrKcxFZCVhgj+bwssc6rlGvSYP2sbWz6Xd6ZjxL1D7NngApksJ4M3AwzxihPcYmz+
	 ObvJC+epHY7U9+rZ0MHM8rx5TT47WAzcWLdu/x/dyHx1Q2+k9H9pe0YF9pvLXvNwD1
	 DkPzRCEr7eAeTesLZvzTC9WsZ/cflXDs583pPLTOdhjzuZQZs8Ezzs5Nw/jUbLVV/4
	 QIesUM644n1yw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: use the helper extent_buffer_uptodate() everywhere
Date: Mon,  9 Feb 2026 11:07:10 +0000
Message-ID: <730f548e95e914bdbf4e7672e718761dedddbd06.1770634919.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770634919.git.fdmanana@suse.com>
References: <cover.1770634919.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-21541-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D41C10E826
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Instead of open coding testing the uptodate bit on the extent buffer's
flags, use the existing helper extent_buffer_uptodate() (which is even
shorter to type). Also change the helper's return value from int to bool,
since we always use it in a boolean context.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 fs/btrfs/extent_io.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3df399dc8856..11faecb66109 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3858,7 +3858,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_bio *bbio;
 
-	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
+	if (extent_buffer_uptodate(eb))
 		return 0;
 
 	/*
@@ -3879,7 +3879,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 	 * started and finished reading the same eb.  In this case, UPTODATE
 	 * will now be set, and we shouldn't read it in again.
 	 */
-	if (unlikely(test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))) {
+	if (unlikely(extent_buffer_uptodate(eb))) {
 		clear_extent_buffer_reading(eb);
 		return 0;
 	}
@@ -3916,7 +3916,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
 		return ret;
 
 	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_READING, TASK_UNINTERRUPTIBLE);
-	if (unlikely(!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags)))
+	if (unlikely(!extent_buffer_uptodate(eb)))
 		return -EIO;
 	return 0;
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 73571d5d3d5a..6409dda947f1 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -298,7 +298,7 @@ static inline int __pure num_extent_folios(const struct extent_buffer *eb)
 	return num_extent_pages(eb);
 }
 
-static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
+static inline bool extent_buffer_uptodate(const struct extent_buffer *eb)
 {
 	return test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 }
-- 
2.47.2


