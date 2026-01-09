Return-Path: <linux-btrfs+bounces-20317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFDCD07350
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 06:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DFE2301918D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 05:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D11DE8BF;
	Fri,  9 Jan 2026 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oAIhWjcx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oAIhWjcx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417B78F3E
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767936704; cv=none; b=So7J7o//Dm2XKkyQEjYWS0Kx+EmgAQ6hAO/YbN0BJjKs6oTzfiRdkNta3weBcCoLBmoKWuxq+fNJm2LBIgmQsSSVCaizajfAenN85fl/CkwztJlT0d/UzQJWEKiWDDWDWj0y+73WGF72k9tn9O51mDc8TSXRGSG10q44CTm1bWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767936704; c=relaxed/simple;
	bh=ZrwN4nt+xgrtmMUDQD29/OJd+gH8blsG8maMkx9Nxjw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbpPCfyKIoFDqwCGXkVXiOLi/RKynL6ntqViqMo54Qej5/ZI/cAgXR0J6f76bAmZZKZd09b/DXxukS/6rwf3EFN0yuNGtbAJWraxILgw3eKMznDlmDMbiqWqKxw+kZcx5LrrjLEGjo6PtvV79QqpmmKESp2ugRioy4FezDmWvR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oAIhWjcx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oAIhWjcx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEDAE346C8
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 05:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767936695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYNhxNdsTgPK8Y8EsNA7OeXyPCJj792SAFjKt4dySYI=;
	b=oAIhWjcxTLkwj7CxoMRooUewP6hoCrfD6RsO922hLqPUUDbtOA5Wgmv/w1yUpEF2HTxCRB
	ka18FAratp5eCe5WWjnoIKoTMVHsBx3ISIP90KSXXUWjCYRze2GEYq9bIBhOHgLlcybU0a
	mRsLOBatxniJ/qd6pXCFCSdo1SJKF30=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767936695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYNhxNdsTgPK8Y8EsNA7OeXyPCJj792SAFjKt4dySYI=;
	b=oAIhWjcxTLkwj7CxoMRooUewP6hoCrfD6RsO922hLqPUUDbtOA5Wgmv/w1yUpEF2HTxCRB
	ka18FAratp5eCe5WWjnoIKoTMVHsBx3ISIP90KSXXUWjCYRze2GEYq9bIBhOHgLlcybU0a
	mRsLOBatxniJ/qd6pXCFCSdo1SJKF30=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12EFC3EA63
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 05:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cF9FMbaSYGk9IQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 05:31:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: mkfs: discard the logical range in one search
Date: Fri,  9 Jan 2026 16:01:14 +1030
Message-ID: <3a3f321e6476636f00835b7c50dcb634488b0555.1767936141.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767936141.git.wqu@suse.com>
References: <cover.1767936141.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Currently for discard_logical_range() if the profile have multiple
mirrors, e.g. DUP, then we will call btrfs_map_block() multiple times,
and each call just return one mirror, and we submit discard for the
returned mirror.

This means we need to call btrfs_map_block() twice for DUP, but we can
use WRITE flag for btrfs_map_block(), which will return multiple mirrors
in one go, reduce the frequency for btrfs_map_block().

With that we do not even need the extra mirror number loop, and can
use discard_logical_range_mirror() to replace discard_logical_range().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index f99e5486521d..ce85d34f077a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -635,23 +635,27 @@ out:
 	return ret;
 }
 
-static int discard_logical_range_mirror(struct btrfs_fs_info *fs_info, int mirror,
-					u64 start, u64 len)
+static int discard_logical_range(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 {
-	struct btrfs_multi_bio *multi = NULL;
 	int ret;
 	u64 cur_offset = 0;
 	u64 cur_len;
 
 	while (cur_offset < len) {
+		struct btrfs_multi_bio *multi = NULL;
 		struct btrfs_device *device;
 
 		cur_len = len - cur_offset;
-		ret = btrfs_map_block(fs_info, READ, start + cur_offset, &cur_len,
-				      &multi, mirror, NULL);
+		ret = btrfs_map_block(fs_info, WRITE, start + cur_offset, &cur_len,
+				      &multi, 0, NULL);
 		if (ret)
 			return ret;
 
+		if (multi->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+			free(multi);
+			return 0;
+		}
+
 		cur_len = min(cur_len, len - cur_offset);
 
 		for (int i = 0; i < multi->num_stripes; i++) {
@@ -674,22 +678,6 @@ static int discard_logical_range_mirror(struct btrfs_fs_info *fs_info, int mirro
 		multi = NULL;
 		cur_offset += cur_len;
 	}
-
-	return 0;
-}
-
-static int discard_logical_range(struct btrfs_fs_info *fs_info, u64 start, u64 len)
-{
-	int ret, num_copies;
-
-	num_copies = btrfs_num_copies(fs_info, start, len);
-
-	for (int i = 0; i < num_copies; i++) {
-		ret = discard_logical_range_mirror(fs_info, i + 1, start, len);
-		if (ret < 0)
-			return ret;
-	}
-
 	return 0;
 }
 
-- 
2.52.0


