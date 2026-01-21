Return-Path: <linux-btrfs+bounces-20881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCvCAKlccWnLGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20881-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 00:09:29 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 778B05F50C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 00:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88AB586340C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1943AA194;
	Wed, 21 Jan 2026 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T+XjM/Yv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T+XjM/Yv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F32359F8F
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036913; cv=none; b=ZPl29LcdhTnJGHpI8JMM7KgnqdACX32YWPHnleNLFMGZZ+UShaTWhBVy3r5KelmpvPkQDofor0+ydn/m3+lciA8H6S/FICpVLs+5XgkR8FNaeUIbrIN8AgrJ90vYCfpayRqISCOwzMsqtCivHXE6WrwFFFUNhw5Bmc/EdeLloYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036913; c=relaxed/simple;
	bh=4QvhS3k2AjjYo5Y5KZjmHWnYEEHJhvvbHXP70glQRvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDVTA0R9gGfz0XyCoVJ6ipkd24IlHcbqdw06F/yklZvk+tlwR3HFugLfFGxP/+mQjfz8DUO7a+G9JVE9EVVpFIQ0FI2GGdjKibj8liKSbQwGQrg9U7+Rfp3MFIUjc9tloGUKKfySeQofTZNF83XaBlx1D+4AyKrP5JP9z2rhwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T+XjM/Yv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T+XjM/Yv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2485D336BE;
	Wed, 21 Jan 2026 23:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769036904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0arvxBPDDm8JaCJSuoLK9sC/U2BLvo906NIXoPFwIc=;
	b=T+XjM/YvAS9D7sKBGW9Ng8N5AWwbu/Lq5gI3KB24rkIQEEviwsZHUgeDob2wahc+bS8Irf
	y32lXhqpEZotogtyMV2WzJ9E1tuEhbQVJ8/XggchdwSSU5rtPaS04Lx4STV8SbeS73BaBc
	78JRJ9hA8pTGqRUymwR5ys5Qg9bS+4w=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769036904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0arvxBPDDm8JaCJSuoLK9sC/U2BLvo906NIXoPFwIc=;
	b=T+XjM/YvAS9D7sKBGW9Ng8N5AWwbu/Lq5gI3KB24rkIQEEviwsZHUgeDob2wahc+bS8Irf
	y32lXhqpEZotogtyMV2WzJ9E1tuEhbQVJ8/XggchdwSSU5rtPaS04Lx4STV8SbeS73BaBc
	78JRJ9hA8pTGqRUymwR5ys5Qg9bS+4w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C37683EA63;
	Wed, 21 Jan 2026 23:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AMPzG2ZccWkiXgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 21 Jan 2026 23:08:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 2/3] btrfs: tests: prepare extent map tests for strict alignment checks
Date: Thu, 22 Jan 2026 09:37:59 +1030
Message-ID: <bcba51233c1847f4670647a6196e923693ff0fa7.1769036831.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769036831.git.wqu@suse.com>
References: <cover.1769036831.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-20881-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 778B05F50C
X-Rspamd-Action: no action

Currently the extent map self tests have the following points that will
cause false alerts for the incoming strict extent map alignment checks:

- Incorrect inlined extent map size

  Which is not following what the kernel is doing for inlined extents,
  as btrfs_extent_item_to_extent_map() always uses the fs block size as
  the length, not the ram_bytes.

  Fix it by using SZ_4K as extent map's length.

- Incorrect btrfs_fs_info::sectorsize

  As we always use PAGE_SIZE, which can be values larger than 4K.
  Meanwhile all the immediate numbers used are based on 4K fs block size
  in the test case.

  Fix it by using fixed SZ_4K fs block size when allocating the dummy
  btrfs_fs_info.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tests/extent-map-tests.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index aabf825e8d7b..811f36d41101 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -173,9 +173,12 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		return -ENOMEM;
 	}
 
-	/* Add [0, 1K) */
+	/*
+	 * Add [0, 1K) which is inlined. And the extent map length must
+	 * be one block.
+	 */
 	em->start = 0;
-	em->len = SZ_1K;
+	em->len = SZ_4K;
 	em->disk_bytenr = EXTENT_MAP_INLINE;
 	em->disk_num_bytes = 0;
 	em->ram_bytes = SZ_1K;
@@ -219,7 +222,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	/* Add [0, 1K) */
 	em->start = 0;
-	em->len = SZ_1K;
+	em->len = SZ_4K;
 	em->disk_bytenr = EXTENT_MAP_INLINE;
 	em->disk_num_bytes = 0;
 	em->ram_bytes = SZ_1K;
@@ -235,7 +238,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		ret = -ENOENT;
 		goto out;
 	}
-	if (em->start != 0 || btrfs_extent_map_end(em) != SZ_1K ||
+	if (em->start != 0 || btrfs_extent_map_end(em) != SZ_4K ||
 	    em->disk_bytenr != EXTENT_MAP_INLINE) {
 		test_err(
 "case2 [0 1K]: ret %d return a wrong em (start %llu len %llu disk_bytenr %llu",
@@ -1131,8 +1134,11 @@ int btrfs_test_extent_map(void)
 	/*
 	 * Note: the fs_info is not set up completely, we only need
 	 * fs_info::fsid for the tracepoint.
+	 *
+	 * And all the immediate numbers are based on 4K blocksize,
+	 * thus we have to use 4K as sectorsize no matter the page size.
 	 */
-	fs_info = btrfs_alloc_dummy_fs_info(PAGE_SIZE, PAGE_SIZE);
+	fs_info = btrfs_alloc_dummy_fs_info(SZ_4K, SZ_4K);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
-- 
2.52.0


