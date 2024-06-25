Return-Path: <linux-btrfs+bounces-5949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EEC915DF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 07:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B666283D09
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 05:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518A144315;
	Tue, 25 Jun 2024 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h2ddFoxL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eIDvX2xU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9F1442FD
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292085; cv=none; b=m8jenQZ0vUbAu3VlzS5OkYU+SznPA+BZp6yZxCRVSPS1G4lRM8UF4KdNqeStBp/ZfXRMNvnGbePsCMZwD6VBUcwyjzQP71WqCSZl4oyLmjBMRxh0ytqBJi3+cXVXlXl3/YMNSn2PAWTuSIfVQzxq5APhvZhqOB+mHFOOVo4m+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292085; c=relaxed/simple;
	bh=i4iE9i6insNomRMpTZdw22lqaWT/4gPrXSLkyw4GjkM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Peic9iUNsyesHsO4bcOoAB+kE3PnJnBIfeIJ7tFYZmOkoKJUpne9yzGQFnTcReFmhyffIM7rp6MKSh4DqnnM0WnLiUVWmxGvu0pVOalKlI9MsO4/PGoZ3f9yCG1Fh5735GLENeMpsiQlSZIU8HznKNhm/EBjtmFqhEIvuaw3w64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h2ddFoxL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eIDvX2xU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0BD31F844
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719292082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/JgymkJZYfnB/W/oe5lw1OdWA4qZNWoe9SGXOaM3Ac=;
	b=h2ddFoxL5RcNlnVBHmfx9ABnlec0qAxbmOIIAAsliHcdc91LyQhGAkrlyO2lR4B3m0X5yH
	pVbnjcOHnTnHRiynnZUXe/XuuomNmJRF3qvwA3MDlBuTwVCPcH+maRmI84TFxPfUGkcDa4
	bOlpe4okKtbuSORCwJ5bhZkip/ZvDoM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eIDvX2xU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719292081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/JgymkJZYfnB/W/oe5lw1OdWA4qZNWoe9SGXOaM3Ac=;
	b=eIDvX2xU24Vt15HfLTzooWf02fH21mD4uSvVzFFQjden9EdbYOtDWWgw8ooeSWq76GKxIk
	WGK8f7dUHTYjbJcu3OeBGCprLTMcLmGXxJW5PtoFn47QeBzymNPlouSd4Z3AH95LdnSV3x
	nwBEy5uKW1Xtvs+ErU2BAquoJbXNguY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 425591384C
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OMO4Ga5QembqdgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: tree-checker: add extra ram_bytes and disk_num_bytes check
Date: Tue, 25 Jun 2024 14:37:30 +0930
Message-ID: <75a7f80c92184ced08a904dc3ce0d43518d399a5.1719291793.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719291793.git.wqu@suse.com>
References: <cover.1719291793.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D0BD31F844
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

This is to ensure non-compressed file extents (both regular and
prealloc) should have matching ram_bytes and disk_num_bytes.

This is only for CONFIG_BTRFS_DEBUG and CONFIG_BTRFS_ASSERT case,
furthermore this will not return error, but just a kernel warning to
inform developers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a2c3651a3d8f..cddabd9a0e37 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -340,6 +340,25 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		}
 	}
 
+	/*
+	 * For non-compressed data extents, ram_bytes should match its disk_bytenr.
+	 * However we do not really utilize ram_bytes in this case, so this check
+	 * is only optional for DEBUG+ASSERT builds for developers to catch the
+	 * unexpected behaviors.
+	 */
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG) && IS_ENABLED(CONFIG_BTRFS_ASSERT) &&
+	    btrfs_file_extent_compression(leaf, fi) == BTRFS_COMPRESS_NONE &&
+	    btrfs_file_extent_disk_bytenr(leaf, fi)) {
+		if (unlikely(btrfs_file_extent_ram_bytes(leaf, fi) !=
+			     btrfs_file_extent_disk_num_bytes(leaf, fi))) {
+			file_extent_err(leaf, slot,
+"mismatch ram_bytes (%llu) and disk_num_bytes (%llu) for non-compressed extent",
+					btrfs_file_extent_ram_bytes(leaf, fi),
+					btrfs_file_extent_disk_num_bytes(leaf, fi));
+			WARN_ON(1);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.45.2


