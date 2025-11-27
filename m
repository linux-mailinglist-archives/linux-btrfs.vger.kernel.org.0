Return-Path: <linux-btrfs+bounces-19375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E286C8D1F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 08:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 317D4350A8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5A1487E9;
	Thu, 27 Nov 2025 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MaCSJsxb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MaCSJsxb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7D31A07C
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228828; cv=none; b=V/FUkfoK7wUCJMSm+obWE5Jz2prPM9PQlx/J+J32UCeQRYBOSq+xSjevJLW9q6pqfo6CVF1iT5VMpQGApAQRYxNKrnuBX3GEJ8Zhn8z56BLbLP37jrlyAT6qLDPplNolVDgf3VZZSHdDvkIsSKHNl70vkY6jzmsAVY1eBF4GuSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228828; c=relaxed/simple;
	bh=Fu7nZOl5gZ/ky19Ui69zrcbEDON5kFSQWR58Cl3fXtk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRBUDMUO/FjjhVB43AAd3oGttvMSLEfDX20D0G6aNOolb3omWSMkBaVy/n3QSi8RV+Hm1wowAQK3hz7k4Dibl/qJoeuRmYlI9AZsr6QthKeGK9aTo2o2m3iTMA3PV2h5J2h2pS1GZWApVy45KJgiZEFhozCh9DTEA1S8FQRRRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MaCSJsxb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MaCSJsxb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44F985BD00
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764228819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lc70kxfLl5KS4z5e0Vu1inxAL6iT+Y2Zb1/GHzA+akk=;
	b=MaCSJsxb2f4U1130haBxyiQs5W6y4EMgqt6JIH/EoYclyG34nznBHYy0VrMuOcyalLfw9d
	OUqkWUIyw8UzPxGQJID1i7yZGgXZzP7ZbsUI9ulwp6ze6Tgm//iF1b0tnL4OpN1AjsEbnu
	kVHL69o7ZDBvEBLp+EjX8XqEoHci3tc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MaCSJsxb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764228819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lc70kxfLl5KS4z5e0Vu1inxAL6iT+Y2Zb1/GHzA+akk=;
	b=MaCSJsxb2f4U1130haBxyiQs5W6y4EMgqt6JIH/EoYclyG34nznBHYy0VrMuOcyalLfw9d
	OUqkWUIyw8UzPxGQJID1i7yZGgXZzP7ZbsUI9ulwp6ze6Tgm//iF1b0tnL4OpN1AjsEbnu
	kVHL69o7ZDBvEBLp+EjX8XqEoHci3tc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8446E3EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OEv8EdL+J2nlcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs-progs: add block-group-tree to the default mkfs features
Date: Thu, 27 Nov 2025 18:03:17 +1030
Message-ID: <5b47a8e82ae8f4c1b630f5e14a2176802d9d98b1.1764228560.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764228560.git.wqu@suse.com>
References: <cover.1764228560.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 44F985BD00
X-Rspamd-Action: no action
X-Spam-Flag: NO

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
index 100449675597..fdaf035d8e20 100644
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


