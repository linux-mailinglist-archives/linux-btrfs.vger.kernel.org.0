Return-Path: <linux-btrfs+bounces-6942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DF8944407
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 08:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9441F20F5D
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 06:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B51917F5;
	Thu,  1 Aug 2024 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CB2TEqVj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CB2TEqVj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE21917D9
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492790; cv=none; b=NUbz/a6P8rkM7dYP1367SWr9kKpOU35+B939P3MfJCGLuH8uqBAs9o5BPTXpbqvG0xDd0ztgHf2stuejsvNmhi5u0vOmrsTwsExGGB9O0PUDg911Gi8SD+Z8TzuN0jdu70YW/wEWbaywTi1X2KQfgrLMSAMc49DUD74gnzGlQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492790; c=relaxed/simple;
	bh=PJo0n92KqEpn5494jBTTlHIcI5OtjV1wjXLHFKSbaz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pP++TeRx6gTzrd/iaCatIgkpX0trcG6umQdkj1j2kCY6V1r0AY+4YwBpnWpw7R1sp1Zvyr1lYzHkS/p1Ra+jtMrj4JDjWXK1SrqIAQmee5d/ZvrOQJv50t+sJUzyc3vVM23qPCQavtVLPfWYb8U/r/DU9mgyqQ/r2gbEtM2TOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CB2TEqVj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CB2TEqVj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52CA01F7D4;
	Thu,  1 Aug 2024 06:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722492785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkToLYaTgyReIkoSVqccMTBwqHKWc95Tvt91pkGPBjo=;
	b=CB2TEqVjrP59wVZbBKsbVScKPlM4X3hqHmrix9Gwg0lz7dfK1xx5VZdrFpxr09PMluqrvl
	U+yPmpBLtySWryrBNptUnv6pD/uLhxV6vLlUuAxwCjdhGQRERIgh3ZJaybB1lcOaBxRjP9
	PfyCsX7Gvgud2dzySft1xTf7UB9hB/U=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722492785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkToLYaTgyReIkoSVqccMTBwqHKWc95Tvt91pkGPBjo=;
	b=CB2TEqVjrP59wVZbBKsbVScKPlM4X3hqHmrix9Gwg0lz7dfK1xx5VZdrFpxr09PMluqrvl
	U+yPmpBLtySWryrBNptUnv6pD/uLhxV6vLlUuAxwCjdhGQRERIgh3ZJaybB1lcOaBxRjP9
	PfyCsX7Gvgud2dzySft1xTf7UB9hB/U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3238E13946;
	Thu,  1 Aug 2024 06:13:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QEFRN28nq2ZkaQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 01 Aug 2024 06:13:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v2 1/5] btrfs-progs: constify the name parameter of btrfs_add_link()
Date: Thu,  1 Aug 2024 15:42:36 +0930
Message-ID: <fe9b4e30843d521343a8913ddd360f2d681cb213.1722492491.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722492491.git.wqu@suse.com>
References: <cover.1722492491.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.40

The name is never touched, thus it should be const.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.h | 2 +-
 kernel-shared/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 7761b3f6fb1b..b8f7a19b64b4 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1210,7 +1210,7 @@ int btrfs_new_inode(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_change_inode_flags(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 ino, u64 flags);
 int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
-		   u64 ino, u64 parent_ino, char *name, int namelen,
+		   u64 ino, u64 parent_ino, const char *name, int namelen,
 		   u8 type, u64 *index, int add_backref, int ignore_existed);
 int btrfs_unlink(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		 u64 ino, u64 parent_ino, u64 index, const char *name,
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 5927af041dbf..265d62988fd0 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -167,7 +167,7 @@ out:
  * Currently only supports adding link from an inode to another inode.
  */
 int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
-		   u64 ino, u64 parent_ino, char *name, int namelen,
+		   u64 ino, u64 parent_ino, const char *name, int namelen,
 		   u8 type, u64 *index, int add_backref, int ignore_existed)
 {
 	struct btrfs_path *path;
-- 
2.45.2


