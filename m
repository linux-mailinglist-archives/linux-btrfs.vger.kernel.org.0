Return-Path: <linux-btrfs+bounces-6907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558EA942B06
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769E31C249AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AC91AC43F;
	Wed, 31 Jul 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rFh/duDg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rFh/duDg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C31AB504
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418752; cv=none; b=QqdHIlQ7/G4uRDKqtqOvfvaMPSpASvUVqivqI8aK1NCNZXDgL4GLV9AcCn2FtttJOWQBkj7wnM/8BDEKq+BzT1K3WQbM1UAZhnYu1gc2tdYgtIUAqJIjruwOabkThNtXWB+9GgVrUYqVkQGqiomABcKxPxZOzYG22WX43VQWB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418752; c=relaxed/simple;
	bh=mPqOAAyzdxCjIdE3xqEgDIdIhTjIfpB6CeynijPA3MY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbZCvfion1qoek3JbE4i3WH3ANyg2S+BnjC/ftRcx/cC6riXv/Kjkv1hQUh91pJeFOuqdDTt2pfWx01AHWJCO8RvMALIgYxqlo0N2vVAQNdN+SBRLKyTVudMLM9Q7vT/YHTrAWBooAO1TarvPhX2qHzuHEVowmr1N42J0E0UXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rFh/duDg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rFh/duDg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A95F221D3B
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722418748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZY5hUGh/GbxgASVDUpEacx50gA1Xp/sSSFzfyhSfGI=;
	b=rFh/duDgU5lJv4d+qWWlaItyCuhaVty0TIN2iCc+W9GiTonMWm8aNSfDdEF+lQPupnhMTU
	KvB30sHDy3PGwkPsqsYGouuCZKL39WjsRRngd8Qzs1dl5JCO35ZKEFA6VZ8AywegERExFY
	mAzP9Tg1l5h2B0hr0nqIwzkXFJnc6Oo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="rFh/duDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722418748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZY5hUGh/GbxgASVDUpEacx50gA1Xp/sSSFzfyhSfGI=;
	b=rFh/duDgU5lJv4d+qWWlaItyCuhaVty0TIN2iCc+W9GiTonMWm8aNSfDdEF+lQPupnhMTU
	KvB30sHDy3PGwkPsqsYGouuCZKL39WjsRRngd8Qzs1dl5JCO35ZKEFA6VZ8AywegERExFY
	mAzP9Tg1l5h2B0hr0nqIwzkXFJnc6Oo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB7DD1368F
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2GcIITsGqmZgHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: constify the name parameter of btrfs_add_link()
Date: Wed, 31 Jul 2024 19:08:46 +0930
Message-ID: <05f3ed8b44d546234cf22d2b850d1e9840c1beca.1722418505.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722418505.git.wqu@suse.com>
References: <cover.1722418505.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: A95F221D3B

The name is never touched, thus it should be const.

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


