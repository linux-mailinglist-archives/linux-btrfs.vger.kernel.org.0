Return-Path: <linux-btrfs+bounces-1333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEB3828FEE
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 23:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E75A1F25BE1
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 22:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4713DBBB;
	Tue,  9 Jan 2024 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FXVKCF4A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FXVKCF4A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80C3E460;
	Tue,  9 Jan 2024 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F6661F82F;
	Tue,  9 Jan 2024 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704839332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9kA3CNIaJcNdGiwFWadXfTeLUFgRcipN7L/U+nz1fy0=;
	b=FXVKCF4ApuJ+iZHp80Ja97pYAWbUxWVGUnnu6kbextB0O1D/Jya6SsoPaGDs6rrEq4uq6P
	5doEiK9jEn2+7elS07VBl2BUUVfwsDWCaWEKiZ+kooSmKwtCQWfmoU64/q9AJYXVs5a/yL
	A5x4s0NTmtLPDFAjNrKzO7K7IqC/Jno=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704839332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9kA3CNIaJcNdGiwFWadXfTeLUFgRcipN7L/U+nz1fy0=;
	b=FXVKCF4ApuJ+iZHp80Ja97pYAWbUxWVGUnnu6kbextB0O1D/Jya6SsoPaGDs6rrEq4uq6P
	5doEiK9jEn2+7elS07VBl2BUUVfwsDWCaWEKiZ+kooSmKwtCQWfmoU64/q9AJYXVs5a/yL
	A5x4s0NTmtLPDFAjNrKzO7K7IqC/Jno=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED6BB134E8;
	Tue,  9 Jan 2024 22:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8+GLJKLInWU3DwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 09 Jan 2024 22:28:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args
Date: Wed, 10 Jan 2024 08:58:26 +1030
Message-ID: <0d35011f8afe8bd55c1f0318b0d2515ea10eac7f.1704839283.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ********
X-Spam-Score: 8.20
X-Spamd-Result: default: False [8.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.25%]
X-Spam-Flag: NO

Add extra sanity check for btrfs_ioctl_defrag_range_args::flags.

This is not really to enhance fuzzing tests, but as a preparation for
future expansion on btrfs_ioctl_defrag_range_args.

In the future we're adding new members, allowing more fine tuning for
btrfs defrag.
Without the -ENONOTSUPP error, there would be no way to detect if the
kernel supports those new defrag features.

cc: stable@vger.kernel.org #4.14+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c           | 4 ++++
 include/uapi/linux/btrfs.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a1743904202b..3a846b983b28 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2608,6 +2608,10 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 				ret = -EFAULT;
 				goto out;
 			}
+			if (range.flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
+				ret = -EOPNOTSUPP;
+				goto out;
+			}
 			/* compression requires us to start the IO */
 			if ((range.flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
 				range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7c29d82db9ee..48e9b7ffecf1 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -614,6 +614,8 @@ struct btrfs_ioctl_clone_range_args {
  */
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |\
+					 BTRFS_DEFRAG_RANGE_START_IO)
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
 	__u64 start;
-- 
2.43.0


