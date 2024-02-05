Return-Path: <linux-btrfs+bounces-2136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C6984AAD2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 00:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F22B28A91E
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 23:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4CF4E1D8;
	Mon,  5 Feb 2024 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NfMA5rMC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NfMA5rMC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E64D5AA
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176781; cv=none; b=NnU15rsoxNIZOrCAGSz3a7L1onA7Bkd/p67KnoW63v1FW5m5uqEd1Yz1KIQQwzJ+cQM6mC2OZ0EecxSaMEno765fAvo4li/9hYJpH2Al/TcW/AD2j0Z/FZzTj4jSGMLmUmYUYWT2rULFUeeM0xf7AqKnf62y6ANvTFNAZER799M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176781; c=relaxed/simple;
	bh=GTaYVBSwVL7mBwUy00Nhvos7SBwRhwyo4CrJw4CH1zE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b74ASXRXO3q3QelbfzPuzzh+eWhxTGvKWkq0Dw36O9N0gYHvzddQ5xsitUYkuwPVethR9j/uH5Ch83/8l3l+QSYz/xtIxsFq2s8sI4qMVNNqM3Q22FJ8LId61T31CWORKDCRqLypsqEoa/DqA91eYdZYEmvCJJzxEnAJLV63pMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NfMA5rMC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NfMA5rMC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 289781F897
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZyfr0GbCkbkOgixPyaFhgV+5z5MGsfDPVkEIdGMY+Q=;
	b=NfMA5rMCDcuBdHBLHI/KXjUIagoawg/bYqdSawZeD8B74chFOcxGFSj8F/W0T6ZaVL59gY
	Osgf4HgzRjOZA9y8ArK9x/27cOT+ykHSteKt6MjaCs8+yGdBnkGeQUdPL2fUoWt9HXfDz0
	FTvwErckP2dn9gKoaPW4eOpArGkTvmo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZyfr0GbCkbkOgixPyaFhgV+5z5MGsfDPVkEIdGMY+Q=;
	b=NfMA5rMCDcuBdHBLHI/KXjUIagoawg/bYqdSawZeD8B74chFOcxGFSj8F/W0T6ZaVL59gY
	Osgf4HgzRjOZA9y8ArK9x/27cOT+ykHSteKt6MjaCs8+yGdBnkGeQUdPL2fUoWt9HXfDz0
	FTvwErckP2dn9gKoaPW4eOpArGkTvmo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65E68136F5
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFV7CkhzwWU0cAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 05 Feb 2024 23:46:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: defrag: sync the new lone extent fine-tunning from kernel
Date: Tue,  6 Feb 2024 10:16:11 +1030
Message-ID: <21518aa2ce59470995e81e0e2fea98eab63cedeb.1707176488.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707176488.git.wqu@suse.com>
References: <cover.1707176488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NfMA5rMC
X-Spamd-Result: default: False [4.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[58.76%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.65
X-Rspamd-Queue-Id: 289781F897
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

This would add the long extent fine-tunning support for defrag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/uapi/btrfs.h | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 34e84b89edf2..7fea5f1bcbe8 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -642,8 +642,14 @@ _static_assert(sizeof(struct btrfs_ioctl_clone_range_args) == 32);
  * Used by:
  * struct btrfs_ioctl_defrag_range_args.flags
  */
-#define BTRFS_DEFRAG_RANGE_COMPRESS 1
-#define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_COMPRESS		(1ULL << 0)
+#define BTRFS_DEFRAG_RANGE_START_IO		(1ULL << 1)
+#define BTRFS_DEFRAG_RANGE_LONE_RATIO		(1ULL << 2)
+#define BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES	(1ULL << 3)
+#define BTRFS_DEFRAG_RANGE_FLAGS_SUPP  (BTRFS_DEFRAG_RANGE_COMPRESS |  \
+					BTRFS_DEFRAG_RANGE_START_IO |  \
+					BTRFS_DEFRAG_RANGE_LONE_RATIO |\
+					BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES)
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
 	__u64 start;
@@ -671,8 +677,22 @@ struct btrfs_ioctl_defrag_range_args {
 	 */
 	__u32 compress_type;
 
+	/*
+	 * If a lone extent (has no adjacent file extent) is utilizing less
+	 * than the ratio (0 means skip this check, while 65536 means 100%) of
+	 * the on-disk space, it would be considered as a defrag target.
+	 */
+	__u32 lone_ratio;
+
+	/*
+	 * If we defrag a lone extent (has no adjacent file extent) can free
+	 * up more space than this value (in bytes), it would be considered
+	 * as a defrag target.
+	 */
+	__u32 lone_wasted_bytes;
+
 	/* spare for later */
-	__u32 unused[4];
+	__u32 unused[2];
 };
 _static_assert(sizeof(struct btrfs_ioctl_defrag_range_args) == 48);
 
-- 
2.43.0


