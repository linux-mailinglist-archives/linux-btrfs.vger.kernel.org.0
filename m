Return-Path: <linux-btrfs+bounces-6569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06BD937313
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 06:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DA0B21769
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 04:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CBE2BB0D;
	Fri, 19 Jul 2024 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F2mkMA5l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F2mkMA5l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF661B86F8
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721364662; cv=none; b=mWJd9LVcIs+G/Ut/gGnLUFaHjpqXF7L7wCzymnY5oiewiBTPtIzR6wI9zYkqXkYw9aVW7enqa9bPphnG10PrdIjvG+58r4gcD8ElBQ15hhZfGkakn4pIap48/TKrAFdrDKcqOUNCV+kIpuT6Zf4uqwCUbkAUbb7480m2reNsfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721364662; c=relaxed/simple;
	bh=6VuAGcdT6WR94V22aEa0gar94Q4ctrbfqYT99RHcUrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bjsldcvS1GCe0YXIJEY+x59XODLfWatmxylorgFMuPHUSo+6RmVHpIn4lZLm99yGF022STVK6mT7L9c6hyCiKBYGZ5xFC78gaOnUtM1jCkao9J5bRR9LvpliQUtga+g+6d4Ae93xbn+llrDWtlcefkeauZ3BfrqqKCrZ8xCe7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F2mkMA5l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F2mkMA5l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52AB721AAD;
	Fri, 19 Jul 2024 04:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721364658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B3V1KGlmDJVWJh8TvhxNPZ7mqiURBDiIfERb+RJoqpw=;
	b=F2mkMA5l7ZlTZoOBfyF+r4KYFZagM6t5A5shvf24AMRQ8FLLyjA9XAmaLfPvYWwnfBlVBH
	PpIQpmD/sIWAohQVHpMxI5lr8KSSsuZDw47U45KwGuTjt2rhKH7s9VQ8aTZI/lS/1oD5rn
	MwyXOuvsAMPcOthgwX87r7ymHn9692M=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721364658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B3V1KGlmDJVWJh8TvhxNPZ7mqiURBDiIfERb+RJoqpw=;
	b=F2mkMA5l7ZlTZoOBfyF+r4KYFZagM6t5A5shvf24AMRQ8FLLyjA9XAmaLfPvYWwnfBlVBH
	PpIQpmD/sIWAohQVHpMxI5lr8KSSsuZDw47U45KwGuTjt2rhKH7s9VQ8aTZI/lS/1oD5rn
	MwyXOuvsAMPcOthgwX87r7ymHn9692M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CEAE136F7;
	Fri, 19 Jul 2024 04:50:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YajJNLDwmWaMdQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Jul 2024 04:50:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Sam James <sam@gentoo.org>
Subject: [PATCH] btrfs: avoid using fixed char array size for tree names
Date: Fri, 19 Jul 2024 14:20:39 +0930
Message-ID: <09fa6dc7de3c7033d92ec7d320a75038f8a94c89.1721364593.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

[BUG]
There is a bug report that using the latest trunk GCC, btrfs would cause
unterminated-string-initialization warning:

  linux-6.6/fs/btrfs/print-tree.c:29:49: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_TREE"      },
      |
      ^~~~~~~~~~~~~~~~~~

[CAUSE]
To print tree names we have an array of root_name_map structure, which
uses "char name[16];" to store the name string of a tree.

But the following trees have names exactly at 16 chars length:
- "BLOCK_GROUP_TREE"
- "RAID_STRIPE_TREE"

This means we will have no space for the terminating '\0', and can lead
to unexpected access when printing the name.

[FIX]
Instead of "char name[16];" use "const char *" instead.

Since the name strings are all read-only data, and are all NULL
terminated by default, there is not much need to bother the length at
all.

Reported-by: Sam James <sam@gentoo.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/print-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 32dcea662da3..fc821aa446f0 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -14,7 +14,7 @@
 
 struct root_name_map {
 	u64 id;
-	char name[16];
+	const char *name;
 };
 
 static const struct root_name_map root_map[] = {
-- 
2.45.2


