Return-Path: <linux-btrfs+bounces-10546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9D9F6208
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BB51691E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E051A19CC3D;
	Wed, 18 Dec 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YWZ+htrn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YWZ+htrn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18B19D072
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514941; cv=none; b=m3J5q7nvFqvUJzWKS3B42QOU0jLMBn4781+CIcFuxsPBOTRJlJ7lE1oY+pjOH8hon91PB8DXmqChmxJoO17zzrRZpSU+JJSW+EthC3b29T3K0bRA58LXPSR1oNkhHPPPtpaJ9PsKy3MTTQF22BRmKKHaTzFXeEcvlR4BrHbe4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514941; c=relaxed/simple;
	bh=Du+ounKbe1okLsJlZYl3tDHcVh3Sg9wT0MwoI9juol4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMhnp5h2p0i5oryzaJxJx8akg0esHZ84X7z/pZ2R51xBVpAUCQCAfgpIuZuIx+HGgcS/ipTw//VhTk4XQtIOAwydsvSN9GPKGFhD+t/twHC+YwpneCkGQZ72lS85o4adA/ZK9zvRNXIisVJeUAsWLFVdvHCzat7j8meNDZRfWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YWZ+htrn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YWZ+htrn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64E971F444
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlfEGzdIj9bj0xdehleaefrLv/FvPvCAxxJsVwuuO1M=;
	b=YWZ+htrnDsd31qlKz2oZmDxn54vQKZzqzXcwl6vGCERzfNA8NPp2DbqchqXQIqZ5yUPQMO
	IxGlwOkPYWAeWTRiR2xWFMUhLuSmXhJT7iygOi0+0mUWwGlmz/llX7PawFL7u/mOKtNCpY
	sYD7pz2BToteORIA0pE/Gs3fQ15LPHw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlfEGzdIj9bj0xdehleaefrLv/FvPvCAxxJsVwuuO1M=;
	b=YWZ+htrnDsd31qlKz2oZmDxn54vQKZzqzXcwl6vGCERzfNA8NPp2DbqchqXQIqZ5yUPQMO
	IxGlwOkPYWAeWTRiR2xWFMUhLuSmXhJT7iygOi0+0mUWwGlmz/llX7PawFL7u/mOKtNCpY
	sYD7pz2BToteORIA0pE/Gs3fQ15LPHw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91355132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MK+oE/iYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 18/18] btrfs: migrate the ioctl interfaces to use block size terminology
Date: Wed, 18 Dec 2024 20:11:34 +1030
Message-ID: <bbf3aa03fb4b4089d00b945e34a6eb7cbf50e0a0.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This rename really only affects btrfs_ioctl_fs_info_args structure, but
since we're here, also update the comments in the ioctl header.

To keep compatibility for old programs which may still access
btrfs_ioctl_fs_info_args::sectorsize, use a union so @blocksize and
@sectorsize can both access the same @blocksize value.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c           |  2 +-
 include/uapi/linux/btrfs.h | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 888f7b97434c..bbaac3d8a36d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2781,7 +2781,7 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 
 	memcpy(&fi_args->fsid, fs_devices->fsid, sizeof(fi_args->fsid));
 	fi_args->nodesize = fs_info->nodesize;
-	fi_args->sectorsize = fs_info->blocksize;
+	fi_args->blocksize = fs_info->blocksize;
 	fi_args->clone_alignment = fs_info->blocksize;
 
 	if (flags_in & BTRFS_FS_INFO_FLAG_CSUM_INFO) {
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index d3b222d7af24..16ea8266b26d 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -278,7 +278,16 @@ struct btrfs_ioctl_fs_info_args {
 	__u64 num_devices;			/* out */
 	__u8 fsid[BTRFS_FSID_SIZE];		/* out */
 	__u32 nodesize;				/* out */
-	__u32 sectorsize;			/* out */
+	union {					/* out */
+		/*
+		 * The minimum data block size.
+		 *
+		 * The old name "sectorsize" is no longer recommended,
+		 * only for compatibility usage.
+		 */
+		__u32 blocksize;
+		__u32 sectorsize;
+	};
 	__u32 clone_alignment;			/* out */
 	/* See BTRFS_FS_INFO_FLAG_* */
 	__u16 csum_type;			/* out */
@@ -965,7 +974,7 @@ struct btrfs_ioctl_encoded_io_args {
 	/*
 	 * Offset in file.
 	 *
-	 * For writes, must be aligned to the sector size of the filesystem.
+	 * For writes, must be aligned to the block size of the filesystem.
 	 */
 	__s64 offset;
 	/* Currently must be zero. */
@@ -982,7 +991,7 @@ struct btrfs_ioctl_encoded_io_args {
 	 * Length of the data in the file.
 	 *
 	 * Must be less than or equal to unencoded_len - unencoded_offset. For
-	 * writes, must be aligned to the sector size of the filesystem unless
+	 * writes, must be aligned to the block size of the filesystem unless
 	 * the data ends at or beyond the current end of the file.
 	 */
 	__u64 len;
@@ -1033,10 +1042,10 @@ struct btrfs_ioctl_encoded_io_args {
  */
 #define BTRFS_ENCODED_IO_COMPRESSION_ZSTD 2
 /*
- * Data is compressed sector by sector (using the sector size indicated by the
+ * Data is compressed block by block (using the block size indicated by the
  * name of the constant) with LZO1X and wrapped in the format documented in
- * fs/btrfs/lzo.c. For writes, the compression sector size must match the
- * filesystem sector size.
+ * fs/btrfs/lzo.c. For writes, the compression block size must match the
+ * filesystem block size.
  */
 #define BTRFS_ENCODED_IO_COMPRESSION_LZO_4K 3
 #define BTRFS_ENCODED_IO_COMPRESSION_LZO_8K 4
-- 
2.47.1


