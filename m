Return-Path: <linux-btrfs+bounces-4465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F98ABA29
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Apr 2024 09:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A6928142B
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Apr 2024 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213B13FFC;
	Sat, 20 Apr 2024 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ACGsslyx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CnGLdw80"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3236134A0
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Apr 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713599535; cv=none; b=eEkcefggoOVHb8+jVquysR2yEIfkFnunEbc2RVG25mlJAEu71GXy7386t99i2vyZHxnSyYI7/UZOK2mNPYejUjR6LkCd5rIfTR3qKrhW50T5sGiT+WA4GW+WYvAh6P9lrDfvBADQDu2Z+u1wxdlAB85e0A+YuWkN0NkJxJ8d4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713599535; c=relaxed/simple;
	bh=P8cXwWLRvH53cQpR+inhEGNOyoTE/9YNWsTx8TK5ZiE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VAIfLlfZO9uMa9rJTOXkW5E+LWdv+/hsjPs5vWQXFShWgOclGPF5ZBJYK7P8DARwo4xLDazFPX18WNZKwIKg8gsSzrYGXtgOJ9So/TIcpgLl+qUaGvHIYaiRMuJOHzWbsV1FrOb6bp8EZFmJ97g7a9JgJupyaAjtEtFro2omK0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ACGsslyx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CnGLdw80; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 083A25FEAB
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Apr 2024 07:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713599525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PydcwRm5VQJJOc86uF80E/wlKTJtOlGlHeWCfj7zNMk=;
	b=ACGsslyxzcvf+O2czlBiASjFlKqiK1gvnzoIvsMNhxN/IHerc3LACphGGN5yMYDD7Lanpb
	uHHGii9ZbbOq5ujqhtPUzBbmgy+I9xFmtJkM0UELxMEFDw/4D25dcCYJiz8f/NGQE4lRfT
	+eTOu66dr5CjP/DLUTbfDgal3E7XnXM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713599524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PydcwRm5VQJJOc86uF80E/wlKTJtOlGlHeWCfj7zNMk=;
	b=CnGLdw80X+WHF9VDlyf16JNY+J3+/4KiBVUVglKeEPCsqTEW3keGo1sXw7o0bTVZWZJPaM
	h3ObYz/FnnXFa3WJpkSoIIKCPCZ4p0MLwWXkjM/AKiAQw0CXOIJpGHR5lOMBt+l/ocvEbe
	+U+iNdMO8jmQrgAyxx1/WvrcJlM32dM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 740BF13977
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Apr 2024 07:52:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x+QzByJ0I2ZyDwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Apr 2024 07:52:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: do not check qgroup inherit if qgroup is disabled
Date: Sat, 20 Apr 2024 17:20:27 +0930
Message-ID: <bd677611fcbd89c21d60585e22c8d4aed3b90090.1713599418.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.60
X-Spam-Level: 
X-Spamd-Result: default: False [-1.60 / 50.00];
	BAYES_HAM(-1.80)[93.81%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

[BUG]
After kernel commit 86211eea8ae1 ("btrfs: qgroup: validate
btrfs_qgroup_inherit parameter"), user space tool snapper will fail to
create snapshot using its timeline feature.

[CAUSE]
It turns out that, if using timeline snapper would unconditionally pass
btrfs_qgroup_inherit parameter (assigning the new snapshot to qgroup 1/0)
for snapshot creation.

In that case, since qgroup is disabled there would be no qgroup 1/0, and
btrfs_qgroup_check_inherit() would return -ENOENT and fail the whole
snapshot creation.

[FIX]
Just skip the check if qgroup is not enabled.
This is to keep the older behavior for user space tools, as if the
kernel behavior changed for user space, it is a regression of kernel.

Thankfully snapper is also fixing the behavior by detecting if qgroup is
running in the first place, so the effect should not be that huge.

Link: https://github.com/openSUSE/snapper/issues/894
Fixes: 86211eea8ae1 ("btrfs: qgroup: validate btrfs_qgroup_inherit parameter")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9aeb740388ab..2f55a89709b3 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3138,6 +3138,9 @@ int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
 			       struct btrfs_qgroup_inherit *inherit,
 			       size_t size)
 {
+	/* Qgroup not enabled, ignore the inherit parameter. */
+	if (!btrfs_qgroup_enabled(fs_info))
+		return 0;
 	if (inherit->flags & ~BTRFS_QGROUP_INHERIT_FLAGS_SUPP)
 		return -EOPNOTSUPP;
 	if (size < sizeof(*inherit) || size > PAGE_SIZE)
-- 
2.44.0


