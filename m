Return-Path: <linux-btrfs+bounces-3216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F3878DB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 04:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD85282787
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 03:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D97BE47;
	Tue, 12 Mar 2024 03:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h/3lIk2n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h/3lIk2n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB2B651
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710215875; cv=none; b=NMtCF8JodyMUzWvA22YUGEOuGzs52JJmbdlioF+gXp7D9zzx0rG6050oigU6cQno63mSNLXbs7QvDo0nNIpezKBVTSKFe9n2hWZGBBVIWKasAks9OKsqEGhPNzrP2slYAqg7lTXQejWz5+JAsj9C5JkQA0KTxgXxbPtsmeno75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710215875; c=relaxed/simple;
	bh=NDuhzZ7InJeP1VPFNWFN2cg6XzefIG84vUDKEgVGcB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFwYU5/Pd6xFiAylJcMbAWZdJ5Vb0Y56Y7+6p4XWi2fdwkY0/1JVchpqZMItEYiIxJij04r0r1OJP/Zr6nduCDcQEfRys/zNjlTKDWT/xijsDZHp2dprt1taUTu8TZoCz8ZzUYpMH06eT1xI/EZb90SS1jwM/jgMENA9WlIwX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h/3lIk2n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h/3lIk2n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DEE91FF7E
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710215871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXQsgbWqZcNqrbnLZPEiDkEzI7LtPpr51CXgABqr21U=;
	b=h/3lIk2npUW4ACHkSC7RHPHnzaSzxm9FvLz2ne1NwfPyjotdJ9iR2KWPS6fb0QPfkOS9fQ
	/F22NTPu0OQj/tgm06d/wPxB6sLe76pAdJFyTiWlLBO3kXq6PWyhC8vmnLec4HuV6wJ59d
	xyQ4Uqi9nRvAFPVEinUYoL0r7gw+0+s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710215871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXQsgbWqZcNqrbnLZPEiDkEzI7LtPpr51CXgABqr21U=;
	b=h/3lIk2npUW4ACHkSC7RHPHnzaSzxm9FvLz2ne1NwfPyjotdJ9iR2KWPS6fb0QPfkOS9fQ
	/F22NTPu0OQj/tgm06d/wPxB6sLe76pAdJFyTiWlLBO3kXq6PWyhC8vmnLec4HuV6wJ59d
	xyQ4Uqi9nRvAFPVEinUYoL0r7gw+0+s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E3AE13879
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8NYuFL7S72VNVgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs-progs: defrag: sync the usage ratio/wasted bytes fine-tunning from kernel
Date: Tue, 12 Mar 2024 14:27:30 +1030
Message-ID: <372214e5dcaca169b407682e6e3d2ead49a44709.1710214834.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710214834.git.wqu@suse.com>
References: <cover.1710214834.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.56
X-Spamd-Result: default: False [3.56 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.14)[68.34%]
X-Spam-Flag: NO

This would add the defrag usage ratio and wasted bytes fine-tunning
support for defrag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/uapi/btrfs.h | 39 +++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 34e84b89edf2..b595a8deb0be 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -642,8 +642,15 @@ _static_assert(sizeof(struct btrfs_ioctl_clone_range_args) == 32);
  * Used by:
  * struct btrfs_ioctl_defrag_range_args.flags
  */
-#define BTRFS_DEFRAG_RANGE_COMPRESS 1
-#define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_COMPRESS		(1ULL << 0)
+#define BTRFS_DEFRAG_RANGE_START_IO		(1ULL << 1)
+#define BTRFS_DEFRAG_RANGE_USAGE_RATIO		(1ULL << 2)
+#define BTRFS_DEFRAG_RANGE_WASTED_BYTES		(1ULL << 3)
+#define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |	\
+					 BTRFS_DEFRAG_RANGE_START_IO |	\
+					 BTRFS_DEFRAG_RANGE_USAGE_RATIO |\
+					 BTRFS_DEFRAG_RANGE_WASTED_BYTES)
+
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
 	__u64 start;
@@ -671,8 +678,34 @@ struct btrfs_ioctl_defrag_range_args {
 	 */
 	__u32 compress_type;
 
+	/*
+	 * File extents which has lower usage ratio than this would be defragged.
+	 *
+	 * Valid values are [0, 100].
+	 *
+	 * 0 means no check based on usage ratio.
+	 * 1 means one file extent would be defragged if its referred size
+	 * (file extent num bytes) is smaller than 1% of its on-disk extent size.
+	 * 100 means one file extent would be defragged if its referred size
+	 * (file extent num bytes) is smaller than 100% of its on-disk extent size.
+	 */
+	__u32 usage_ratio;
+
+	/*
+	 * File extents which has more "wasted" bytes than this would be
+	 * defragged.
+	 *
+	 * "Wasted" bytes just means the difference between the file extent size
+	 * (file extent num bytes) against the on-disk extent size
+	 * (file extent disk num bytes).
+	 *
+	 * Valid values are [0, U32_MAX], but values larger than
+	 * BTRFS_MAX_EXTENT_SIZE would not make much sense.
+	 */
+	__u32 wasted_bytes;
+
 	/* spare for later */
-	__u32 unused[4];
+	__u32 unused[2];
 };
 _static_assert(sizeof(struct btrfs_ioctl_defrag_range_args) == 48);
 
-- 
2.44.0


