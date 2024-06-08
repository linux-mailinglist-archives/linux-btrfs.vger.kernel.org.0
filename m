Return-Path: <linux-btrfs+bounces-5568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A484A900F6D
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 06:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5EEB24C0E
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 04:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6A14A8E;
	Sat,  8 Jun 2024 04:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KqtqWAcj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KqtqWAcj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C16AB8
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717820039; cv=none; b=kKxTI0qG4ddQu+W3jsFL1CuP37T6+xOR0FxvoAFCUh2hWyjPVF5q1FjpCATGrWszCOfBqzHr1NViqAgau2XcIAnEv+sRy3jQ7kWaKiLWlMXFHuVb4EgwOv0i3tn0n68W8C6wI/nvhTPiAH43fagXF9K1zrD4HNRQqtukrq4HvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717820039; c=relaxed/simple;
	bh=f2VCpudyVMa1Q45vn0VKihzBvoOLgEZIYMYTHRKjNUA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOe2KM71jbUzQZo2AHz45RlGRXih4P149Fjz4P27mZAUS8jV4YY2ti3P0zcbhnrF4y9wJr+ct0vIoPvPLpemOqMLoP2Vo9HNv6pu827V6mvbEHNQHb/h+IGat7sOVjOGbAEOQGttVxCWwEQQevPNSoDdOsNEeAdpFONKgXInfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KqtqWAcj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KqtqWAcj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 513BC21BA3
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 04:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717820035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpcpLeGCpC7I18JUuFhDGYpE4TZQqKnn5RLq6SJO/yQ=;
	b=KqtqWAcjGXDXTIUeZJ1S0LHBKy91QCR8hTvghQVeqRd1iaolxdZqRts3Ufc6iuoiP7m1kK
	X9B+qAvcwSzvrfuc8RJiEuHvVw5UnOTMtrF2loIW7TffucprGwPySRbZ8aSqtPN9NhfoQJ
	whUaP8z3FswUqVudZIehImqc1G60TkU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KqtqWAcj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717820035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpcpLeGCpC7I18JUuFhDGYpE4TZQqKnn5RLq6SJO/yQ=;
	b=KqtqWAcjGXDXTIUeZJ1S0LHBKy91QCR8hTvghQVeqRd1iaolxdZqRts3Ufc6iuoiP7m1kK
	X9B+qAvcwSzvrfuc8RJiEuHvVw5UnOTMtrF2loIW7TffucprGwPySRbZ8aSqtPN9NhfoQJ
	whUaP8z3FswUqVudZIehImqc1G60TkU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E60D13A1E
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 04:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mHJ3N4HaY2Z6cAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 08 Jun 2024 04:13:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: fix the conflicting super flags
Date: Sat,  8 Jun 2024 13:43:24 +0930
Message-ID: <bd2df0d12b09a29ea39d7a6b1692b0523592002d.1717819918.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1717819918.git.wqu@suse.com>
References: <cover.1717819918.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 513BC21BA3
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email]

[BUG]
There is a bug report that a canceled csum conversion (still
experimental feature) resulted unexpected super flags:

csum_type		0 (crc32c)
csum_size		4
csum			0x14973811 [match]
bytenr			65536
flags			0x1000000001
			( WRITTEN |
			  CHANGING_FSID_V2 )
magic			_BHRfS_M [match]

Meanwhile for a fs under csum conversion it should have either
CHANGING_DATA_CSUM or CHANGING_META_CSUM.

[CAUSE]
It turns out that, due to btrfs-progs keeps its own extra flags inside
its own ctree.h headers, not the shared uapi headers, we have
conflicting super flags:

kernel-shared/uapi/btrfs_tree.h:#define BTRFS_SUPER_FLAG_METADUMP_V2	(1ULL << 34)
kernel-shared/uapi/btrfs_tree.h:#define BTRFS_SUPER_FLAG_CHANGING_FSID	(1ULL << 35)
kernel-shared/uapi/btrfs_tree.h:#define BTRFS_SUPER_FLAG_CHANGING_FSID_V2 (1ULL << 36)
kernel-shared/ctree.h:#define BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM	(1ULL << 36)
kernel-shared/ctree.h:#define BTRFS_SUPER_FLAG_CHANGING_META_CSUM	(1ULL << 37)

Note that CHANGING_FSID_V2 is conflicting with CHANGING_DATA_CSUM.

[FIX]
Cross port the proper updated uapi headers into btrfs-progs, and remove
the definition from ctree.h.

This would change the value for CHANGING_DATA_CSUM and
CHANGING_META_CSUM, but considering they are experimental features, and
kernel would reject them anyway, the damage is not that huge and we can
accept such change before exposing it to end users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.h           | 10 ----------
 kernel-shared/uapi/btrfs_tree.h |  8 ++++++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 444d206e0a2c..1341a418726b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -59,16 +59,6 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 		sizeof(struct btrfs_stripe) * (num_stripes - 1);
 }
 
-#define BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM	(1ULL << 36)
-#define BTRFS_SUPER_FLAG_CHANGING_META_CSUM	(1ULL << 37)
-
-/*
- * The fs is undergoing block group tree feature change.
- * If no BLOCK_GROUP_TREE compat ro flag, it's changing from regular
- * bg item in extent tree to new bg tree.
- */
-#define BTRFS_SUPER_FLAG_CHANGING_BG_TREE	(1ULL << 38)
-
 static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 {
 	return nodesize - sizeof(struct btrfs_header);
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index e2ac228bcccc..23e18e735959 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -758,6 +758,14 @@ struct btrfs_free_space_header {
 #define BTRFS_SUPER_FLAG_CHANGING_FSID	(1ULL << 35)
 #define BTRFS_SUPER_FLAG_CHANGING_FSID_V2 (1ULL << 36)
 
+/*
+ * Those are temporaray flags utilized by btrfs-progs to do offline conversion.
+ * They are rejected by kernel.
+ * But still keep them all here to avoid conflicts.
+ */
+#define BTRFS_SUPER_FLAG_CHANGING_BG_TREE	(1ULL << 38)
+#define BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM	(1ULL << 39)
+#define BTRFS_SUPER_FLAG_CHANGING_META_CSUM	(1ULL << 40)
 
 /*
  * items in the extent btree are used to record the objectid of the
-- 
2.45.2


