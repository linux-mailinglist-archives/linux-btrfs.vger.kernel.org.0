Return-Path: <linux-btrfs+bounces-20824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCFGLkm3cGndZAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20824-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:23:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF2D55F1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 800516883E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4C477E31;
	Wed, 21 Jan 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7DHPRdY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D1481224
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994050; cv=none; b=eAMbMDE51zkEV0vhrJjtwAlsgHUc3QtFYkWQnVhk+yh+ugrkRfdxBfG0AYwvg3mXD4KjPl58A/pQb/fPSO/X3ojyLWXRuPCK1KciDNSywB3SPFHDmTkR/8APP4wVXPhpQJyThAmDjIfIzG4fenvF7lCQHJOBhe+cdRX3AjTMdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994050; c=relaxed/simple;
	bh=RvwV6Za786E1ozrQb+JPPJvA0E7DivWDEDVY1xGUA1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st1w3a4zYiaETIW7ZOMK4FzHz94b5L/HDQHG58uYLVIfWrmXw36taqqSt0nUkBPJdbG8dybOWUYWKXEBiYvKvbdGZbSLUVHqwrTgsWf6NQY57CSKdw9g3/tM1kwxkP60/hGXRu8kDkWp0hq76GmgsAUZ06Y1A5vIamejk6GrcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7DHPRdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17DCC19424
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994049;
	bh=RvwV6Za786E1ozrQb+JPPJvA0E7DivWDEDVY1xGUA1g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V7DHPRdYVtfQnQ1MTDb6zOxdUByHuieTufsDQVvt4Qm/oS6El1b+Gr/aQUE2Z9KPK
	 oxB44D4mRNrigjVpZCYD/M+lORmCplS+EWvqSkBLLxFuxESZ7QmoXeZNnF9aa/XeRM
	 3cXks/xz3JGHbOsZKG0jj0R+0p9BjkLGPmfJ3gunjbmeMaxts+wfSXLEnMo3s8tWlC
	 23iWZoH3H94MfdkCmzLrbI0wFbkQFAzcc4OYnG3isHDn8NRwAMKwJ4XKhA7cKqpVup
	 kRWzck39JXVG+iXWVNRrCtbpxg9JvwZIyMyHKZB1CzFrmSvazR8JilD1h9WFjOllWs
	 t1ZgpE6R/acpQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/19] btrfs: remove out label in lzo_decompress()
Date: Wed, 21 Jan 2026 11:13:48 +0000
Message-ID: <6a11cbe85585c51f7c133914e35fa37e2816834e.1768993725.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768993725.git.fdmanana@suse.com>
References: <cover.1768993725.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20824-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 7CF2D55F1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'ret' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/lzo.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 83c106ca1c14..2c6deed55811 100644
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
@@ -512,8 +510,7 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 		"lzo decompression failed, error %d root %llu inode %llu offset %llu",
 			  ret, btrfs_root_id(inode->root), btrfs_ino(inode),
 			  folio_pos(dest_folio));
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 
 	ASSERT(out_len <= sectorsize);
@@ -523,8 +520,8 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 		ret = -EIO;
 		folio_zero_range(dest_folio, dest_pgoff + out_len, destlen - out_len);
 	}
-out:
-	return ret;
+
+	return 0;
 }
 
 const struct btrfs_compress_levels  btrfs_lzo_compress = {
-- 
2.47.2


