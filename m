Return-Path: <linux-btrfs+bounces-19369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98018C8CDE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 06:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 899494E371C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 05:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485BD30F55D;
	Thu, 27 Nov 2025 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JUftyuKj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NB1Dznin"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94C8F4A
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764221141; cv=none; b=oY1qBZ81uDcKknVJKpWsn7xQEcS1/WaMevGTwtoDz0pZi9QQtG9qqX6SX64Z71JkOgPp2w+qSuztRyaLYF31s3AsTl8i1xmxuDsp3kPy9lnxDt6MEuar+mnFwnWVXyHCn6UTTEpL4WniqN1MEpwdehGNadA1q0GBkxO+L+GJKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764221141; c=relaxed/simple;
	bh=MVX2Zks/haxGb0+IZMb2a2a0vJ92tfo1/2knLqT/+Qg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uX5BifyP4+moPOI/ms/z1o3UV2HFF8vncbVRJfG1p3iyeY9gDcQEFUBs3gjDjRRU4GSwjOc23tYz4zY/FyQfs0n3G3U+a5cV0NPLKXbrG0dj5XlgQlJuQ/Sz1YmJWCnhRrIzQXKoPMTm4vrn/jiaUVW5FAhne9/ABHzXNHIRd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JUftyuKj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NB1Dznin; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECEBD5BCCC
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764221127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ix/wx2QDkr8lpPjAOIIphPI/aPEkpr37g1GYzcG+cH8=;
	b=JUftyuKjI1VS7u3B4UvOGNP33r7HlqjCoBv46A0HBZLzjYp+2Q+suwqDG7GtH0d2TBD8/m
	gHbXJhDnJ+E/5/svUzZ/LvHEUDcI8Qcg2RvtQk5paUl9m6B6UJu+F+y9kfOME9dVkoiQau
	SvieZlfyYTAnuA6Av4dQExsZ2JWV/08=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764221126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ix/wx2QDkr8lpPjAOIIphPI/aPEkpr37g1GYzcG+cH8=;
	b=NB1DzninKqkmDWV7bBpRQPXNY3O3ayrXIRvYEaaGkkGVBruwpyX3aIgK1v5FbopfEzEDzL
	7A9bteMXJjDt+RibLk/iL0cNkL7DnuSsF94rSixFQ1DnHNlnsEQRSPgjSU7bawi4nJTCoC
	AoglXA87f3TvItSsRH0mp8mF3pTZddo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36DC73EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qOkuOsXgJ2l3fgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: add block-group-tree to the default mkfs features
Date: Thu, 27 Nov 2025 15:55:04 +1030
Message-ID: <89fed6be1ab56ceaf378b87c1f917d2e26f9f105.1764220734.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764220734.git.wqu@suse.com>
References: <cover.1764220734.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

The block-group-tree feature is already considered safe since v6.6
kernels, and btrfs-progs have also improved its off-line conversion
ability (btrfstune --convert-to|from-block-group-tree).

Now it's time to make bgt feature as the default mkfs features.
This affects both mkfs and btrfs-convert.

The target merge window is v6.18.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/mkfs.btrfs.rst | 2 +-
 common/fsfeatures.c          | 2 +-
 common/fsfeatures.h          | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index 7734354fd6da..b4e23cc1fb24 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -424,7 +424,7 @@ free-space-tree
 .. _mkfs-feature-block-group-tree:
 
 block-group-tree
-        (kernel support since 6.1)
+        (default since btrfs-progs v6.19, kernel support since 6.1)
 
         Enable a dedicated b-tree for block group items, this greatly reduces
         mount time for large filesystems due to better data locality that
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 69a1b3934099..389d19b4d416 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -219,7 +219,7 @@ static const struct btrfs_feature mkfs_features[] = {
 		.sysfs_name	= "block_group_tree",
 		VERSION_TO_STRING2(compat, 6,1),
 		VERSION_TO_STRING2(safe, 6,6),
-		VERSION_NULL(default),
+		VERSION_TO_STRING2(default, 6,19),
 		.desc		= "block group tree, more efficient block group tracking to reduce mount time"
 	},
 #if EXPERIMENTAL
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 3559076ba5dc..3ae8d2a5eed7 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -46,7 +46,8 @@ struct btrfs_mkfs_features {
 
 static const struct btrfs_mkfs_features btrfs_mkfs_default_features = {
 	.compat_ro_flags = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
-			   BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
+			   BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |
+			   BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
 	.incompat_flags	 = BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |
 			   BTRFS_FEATURE_INCOMPAT_NO_HOLES |
 			   BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
-- 
2.52.0


