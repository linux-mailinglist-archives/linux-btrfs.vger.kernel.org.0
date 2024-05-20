Return-Path: <linux-btrfs+bounces-5122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C48CA2ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 21:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF6AB216EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E80313957B;
	Mon, 20 May 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mYcEH79u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mYcEH79u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9114A8B
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234748; cv=none; b=hvg/ZSYZnazmdvAIRue24t8AlE/SLY0RBXuL3E8ApcKYG8ldHxeCYM0NlHBP9ZloZ0rIz3jHIogyNplq/ao1ibd3ddfA4DVhGEMKofKzZ+EL1J0J6llydMRX5ee+6vPke4rJQhow1Sch3tHjtwwmBB0bL3KoFtkAGi0CVBwa4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234748; c=relaxed/simple;
	bh=1fG3QvwBNmfSaEdj/CcVR+aFzLhT8Q08M0BncEmFccw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab6bqsEstza1gmqrY668bjfOQVzwBVoLZ+keAoRcdqFuvFcXJN2XR2gOLH4fyrD4Pcuohoye0UORnbUqSy677h/P+kTnZ79UnNgWcbkDZSGpVVhiTd6ugiH1o84fpMyPdB1XTyprFOkl8o0Vc+mVWiYXHODtVk3qFFCpQpXf1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mYcEH79u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mYcEH79u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E3C520F86;
	Mon, 20 May 2024 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnXCaL96VqCxOhtNnS6KlQGDyBm9uUYC2J7bh4iPKGY=;
	b=mYcEH79urJXjNwe+6l0WXTHuY8MnlNWjT6zPxEBa+4TEV704lbjIKqBdzfA50Fj31P9TKU
	DUZaIBtt4MhvFqlG+Uv/+Qn+QYR6UDgyM7Ic1INzzB/33nDGIZlVsbdKRWbUHh6w2haJtZ
	uM0gwp8aZzmTcPF86ThFBt33fA0dMHs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnXCaL96VqCxOhtNnS6KlQGDyBm9uUYC2J7bh4iPKGY=;
	b=mYcEH79urJXjNwe+6l0WXTHuY8MnlNWjT6zPxEBa+4TEV704lbjIKqBdzfA50Fj31P9TKU
	DUZaIBtt4MhvFqlG+Uv/+Qn+QYR6UDgyM7Ic1INzzB/33nDGIZlVsbdKRWbUHh6w2haJtZ
	uM0gwp8aZzmTcPF86ThFBt33fA0dMHs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 980A513A6B;
	Mon, 20 May 2024 19:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S2cbJfipS2Y3RQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 20 May 2024 19:52:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/6] btrfs: rename macro local variables that clash with other variables
Date: Mon, 20 May 2024 21:52:20 +0200
Message-ID: <816e099dd10923724c6ead6661542987c2f6de52.1716234472.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716234472.git.dsterba@suse.com>
References: <cover.1716234472.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Spam-Level: 
X-Spamd-Result: default: False [-0.21 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.41)[77.89%];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

Fix variable names in two macros where there's a local function variable
of the same name.  In subpage_calc_start_bit() it's in several callers,
in btrfs_abort_transaction() it's only in replace_file_extents().
Found by 'make W=2'.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/subpage.c     | 8 ++++----
 fs/btrfs/transaction.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 54736f6238e6..9127704236ab 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -242,12 +242,12 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 
 #define subpage_calc_start_bit(fs_info, folio, name, start, len)	\
 ({									\
-	unsigned int start_bit;						\
+	unsigned int __start_bit;						\
 									\
 	btrfs_subpage_assert(fs_info, folio, start, len);		\
-	start_bit = offset_in_page(start) >> fs_info->sectorsize_bits;	\
-	start_bit += fs_info->subpage_info->name##_offset;		\
-	start_bit;							\
+	__start_bit = offset_in_page(start) >> fs_info->sectorsize_bits;	\
+	__start_bit += fs_info->subpage_info->name##_offset;		\
+	__start_bit;							\
 })
 
 void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 4e451ab173b1..90b987941dd1 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -229,11 +229,11 @@ bool __cold abort_should_print_stack(int error);
  */
 #define btrfs_abort_transaction(trans, error)		\
 do {								\
-	bool first = false;					\
+	bool __first = false;					\
 	/* Report first abort since mount */			\
 	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
 			&((trans)->fs_info->fs_state))) {	\
-		first = true;					\
+		__first = true;					\
 		if (WARN(abort_should_print_stack(error),	\
 			KERN_ERR				\
 			"BTRFS: Transaction aborted (error %d)\n",	\
@@ -246,7 +246,7 @@ do {								\
 		}						\
 	}							\
 	__btrfs_abort_transaction((trans), __func__,		\
-				  __LINE__, (error), first);	\
+				  __LINE__, (error), __first);	\
 } while (0)
 
 int btrfs_end_transaction(struct btrfs_trans_handle *trans);
-- 
2.45.0


