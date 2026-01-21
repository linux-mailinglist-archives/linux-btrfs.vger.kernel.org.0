Return-Path: <linux-btrfs+bounces-20852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKlWHrEdcWmodQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20852-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:40:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D151C5B683
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43F0370F24B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5AF4968EE;
	Wed, 21 Jan 2026 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8WRXwKZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD274495531
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013061; cv=none; b=Wv3LdHr1Z9J06iGTelEARTnoDhnOwSkOe8Bm8assu8DdHeZwjr2d7NDZiErzKx47VSn6qvi7OiLFjpE4PtM5nY5JNawy3TXgeSmXuxZk2IQS8SybApvi/2b3rpllZlxf+57WUxsN2qF4PoVPNNW5Ugwu6usqj7nYwSgKuk1RXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013061; c=relaxed/simple;
	bh=suTwCAFgDk2lL8k2VMZTz9GlxQ1RmB2hmMQ0mGE34jk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0F+o+MI3Dmka6p/t7/HzfXyShV0bNWS3qJ6NeOLgeOcwZ7rZvFcfP9cEF/mVP5G0hOSpvDJaTQ3NMgUnawbOb8BMs9HiEuPOhzSpmwy50/DgEvGQ/+SWBoUVUZglPthqfYZQiEZn5M5rJU8z33whh/GyZulzIa+dEmuc7ZOglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8WRXwKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAA8C4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013061;
	bh=suTwCAFgDk2lL8k2VMZTz9GlxQ1RmB2hmMQ0mGE34jk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y8WRXwKZ4GxsNR6trlKWbwNE8PI0sURBNYEvxzafa0P37Aup9JJIBoLTiaPcdZfaB
	 gKyumznTYB14Faf8QZBMdc9fF0JZmDHQ/3edwN5MUPMJ8fWlNYhSgPqxty6r8X993t
	 5cG53p40aynF/tvkqPeGjBzJaFTUGB6h3T0egS3yJz7zWTlBltO3tq2TiK5IS+50z3
	 CZjPZ4coliVIrYSf0KQF979finnsF5J+UmQPZEPjWAm+wQ86keJFg9kjGVSWrigv7i
	 hZiOdBXez3sOxT6y0b3LK9hXDiWGtQ6g1Qh9Gd8ZRwg1bQe8p9LTeC7FimJ0KLQhea
	 VR4ekJddOv5AQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 14/19] btrfs: remove out label in lzo_decompress()
Date: Wed, 21 Jan 2026 16:30:40 +0000
Message-ID: <e1a07a769732443ccd6b9688273cea8f26569257.1769012877.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1769012876.git.fdmanana@suse.com>
References: <cover.1769012876.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20852-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D151C5B683
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'ret' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/lzo.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 83c106ca1c14..e15f7a778ed8 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -486,7 +486,7 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 	size_t in_len;
 	size_t out_len;
 	size_t max_segment_len = workspace_buf_length(fs_info);
-	int ret = 0;
+	int ret;
 
 	if (unlikely(srclen < LZO_LEN || srclen > max_segment_len + LZO_LEN * 2))
 		return -EUCLEAN;
@@ -497,10 +497,8 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 	data_in += LZO_LEN;
 
 	in_len = read_compress_length(data_in);
-	if (unlikely(in_len != srclen - LZO_LEN * 2)) {
-		ret = -EUCLEAN;
-		goto out;
-	}
+	if (unlikely(in_len != srclen - LZO_LEN * 2))
+		return -EUCLEAN;
 	data_in += LZO_LEN;
 
 	out_len = sectorsize;
@@ -512,19 +510,18 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 		"lzo decompression failed, error %d root %llu inode %llu offset %llu",
 			  ret, btrfs_root_id(inode->root), btrfs_ino(inode),
 			  folio_pos(dest_folio));
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 
 	ASSERT(out_len <= sectorsize);
 	memcpy_to_folio(dest_folio, dest_pgoff, workspace->buf, out_len);
 	/* Early end, considered as an error. */
 	if (unlikely(out_len < destlen)) {
-		ret = -EIO;
 		folio_zero_range(dest_folio, dest_pgoff + out_len, destlen - out_len);
+		return -EIO;
 	}
-out:
-	return ret;
+
+	return 0;
 }
 
 const struct btrfs_compress_levels  btrfs_lzo_compress = {
-- 
2.47.2


