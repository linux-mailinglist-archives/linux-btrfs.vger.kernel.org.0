Return-Path: <linux-btrfs+bounces-5569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB559900F6E
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 06:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9701E281E3A
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 04:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837B0168BD;
	Sat,  8 Jun 2024 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DRqyxYmc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DRqyxYmc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189EDDDA
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 04:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717820040; cv=none; b=ql01Tivbs28Sex7/FYkpBoCkH8ohxPPEDAZ6T560C7f1HM1D1sml59Yhgs4ulyFBsxIkyWRyx6bTfTZ/GHR4r/clITGzlP64LGurpPxoKx6v4Jt0MqEMkPSHnTX7whleaKKwOVk4DRgP+wm7mCWJKdv5d+ukMMbCUDu1ZWCZAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717820040; c=relaxed/simple;
	bh=FTJN2H+sDZM3XB3sfhe3hastPM5faVZxcYDaB9Chzw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgSEt4nB5mIuN5BZP9tSDiNGtA/HudS/eSi9fRLVbCnE3KTdN9gaHJssQn60W/xBLlXMNZlqnuycuTRnRG3b1adw1mVx7NLSliXnd6ghKR/aqF0A32hsSOvP+2nkWJ/Fl8vOnkwwMUgvMm78JmAWnzXYETghhJRf8ltEXGSKcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DRqyxYmc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DRqyxYmc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 06EC01FC84
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 04:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717820037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2sv3nCMEzeD9mkumg5brYfRpauLvfVgMlFeHyndhFQ=;
	b=DRqyxYmcQ42cyg1RxQMR+pXfVxca7/j36LFn0BD1XBlgJr9G5Ch5JbBuY9i8lEENNDjX/l
	BNAF7i/n+laRuTzChV1t+aNpgzo4LdawhlWHm+oB0NlBJWT5tRgueNnAUSzfeeDPqRWkro
	hGQdErw7tQ+0EcwYQF+qVAAMtWgwgzs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717820037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2sv3nCMEzeD9mkumg5brYfRpauLvfVgMlFeHyndhFQ=;
	b=DRqyxYmcQ42cyg1RxQMR+pXfVxca7/j36LFn0BD1XBlgJr9G5Ch5JbBuY9i8lEENNDjX/l
	BNAF7i/n+laRuTzChV1t+aNpgzo4LdawhlWHm+oB0NlBJWT5tRgueNnAUSzfeeDPqRWkro
	hGQdErw7tQ+0EcwYQF+qVAAMtWgwgzs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D55DE13A1E
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 04:13:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MPkYIoPaY2Z6cAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 08 Jun 2024 04:13:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: print-tree: handle all supported flags
Date: Sat,  8 Jun 2024 13:43:25 +0930
Message-ID: <9a1201c209c72e332ab9d25f5036edc847547550.1717819918.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-0.28 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.48)[79.47%];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.28
X-Spam-Flag: NO

Although we already have a pretty good array defined for all
super/compat_ro/incompat flags, we still rely on hand defined mask to do
the print.

This can lead to easy de-sync between the definition and the flags.

Change it to automatically iterate through the array to calculate the
flags, and add the remaining super flags.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index a7018cb724fd..23cd225a9a50 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1950,18 +1950,13 @@ static struct readable_flag_entry super_flags_array[] = {
 	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),
 	DEF_SUPER_FLAG_ENTRY(SEEDING),
 	DEF_SUPER_FLAG_ENTRY(METADUMP),
-	DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
+	DEF_SUPER_FLAG_ENTRY(METADUMP_V2),
+	DEF_SUPER_FLAG_ENTRY(CHANGING_BG_TREE),
+	DEF_SUPER_FLAG_ENTRY(CHANGING_DATA_CSUM),
+	DEF_SUPER_FLAG_ENTRY(CHANGING_META_CSUM),
 };
 static const int super_flags_num = ARRAY_SIZE(super_flags_array);
 
-#define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
-				 BTRFS_HEADER_FLAG_RELOC |\
-				 BTRFS_SUPER_FLAG_CHANGING_FSID |\
-				 BTRFS_SUPER_FLAG_CHANGING_FSID_V2 |\
-				 BTRFS_SUPER_FLAG_SEEDING |\
-				 BTRFS_SUPER_FLAG_METADUMP |\
-				 BTRFS_SUPER_FLAG_METADUMP_V2)
-
 static void __print_readable_flag(u64 flag, struct readable_flag_entry *array,
 				  int array_size, u64 supported_flags)
 {
@@ -1995,26 +1990,34 @@ static void __print_readable_flag(u64 flag, struct readable_flag_entry *array,
 
 static void print_readable_compat_ro_flag(u64 flag)
 {
-	/*
-	 * We know about the FREE_SPACE_TREE{,_VALID} bits, but we don't
-	 * actually support them yet.
-	 */
+	u64 print_flags = 0;
+
+	for (int i = 0; i < compat_ro_flags_num; i++)
+		print_flags |= compat_ro_flags_array[i].bit;
 	return __print_readable_flag(flag, compat_ro_flags_array,
 				     compat_ro_flags_num,
-				     BTRFS_FEATURE_COMPAT_RO_SUPP);
+				     print_flags);
 }
 
 static void print_readable_incompat_flag(u64 flag)
 {
+	u64 print_flags = 0;
+
+	for (int i = 0; i < incompat_flags_num; i++)
+		print_flags |= incompat_flags_array[i].bit;
 	return __print_readable_flag(flag, incompat_flags_array,
 				     incompat_flags_num,
-				     BTRFS_FEATURE_INCOMPAT_SUPP);
+				     print_flags);
 }
 
 static void print_readable_super_flag(u64 flag)
 {
+	int print_flags = 0;
+
+	for (int i = 0; i < super_flags_num; i++)
+		print_flags |= super_flags_array[i].bit;
 	return __print_readable_flag(flag, super_flags_array,
-				     super_flags_num, BTRFS_SUPER_FLAG_SUPP);
+				     super_flags_num, print_flags);
 }
 
 static void print_sys_chunk_array(struct btrfs_super_block *sb)
-- 
2.45.2


