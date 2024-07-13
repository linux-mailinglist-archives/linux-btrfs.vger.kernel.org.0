Return-Path: <linux-btrfs+bounces-6438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204CE9304A7
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2024 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A04B1C21558
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BBB49628;
	Sat, 13 Jul 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N5xLU6+v";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N5xLU6+v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB45339E
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2024 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720861681; cv=none; b=qMcxIow8TZlZUaVY/TiI8HZD6fQXIrPAArb825Mff5btjRt5+BX6K56nxzxY6OM7gm6ZRzhJebrJrhG7gmLWEhXw54I+Komq9V5oU/WQ0eiImO7l760x9HCuiXzkdrVPW4u8rdvxuHoPEM0YD+ojDTlf4x6DJWJNLEBKCdrIJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720861681; c=relaxed/simple;
	bh=Sth9zZ8GZmJ1O4DdALBY0c+ZnOaa2T9MAORJi3NJMqI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NsWeBqTUwYvp0fl47uL7DvPTvLyZUg6tUpRLGveOPZtTIOJpxqXcQebjGOWladHuUUp4XbDyuaT66TkrNOQ/c8ZFv858vMLx8CP7NVJDY8/qnF2JO4XiHWlwHPwdH/ALewfa2+tG0H4jSv3Dap6kGXrDZOJix3ni12XG7JQHnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N5xLU6+v; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N5xLU6+v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C04721AF2
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2024 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720861676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ThHry23pPjk5yHTUi505ngwfOTmVvqUFhNOIXPkTsko=;
	b=N5xLU6+vWA11S6UH5oMTVoLMTNq5K/n+UPK58s4cSce/hcKwEQACrZPMVs3I7wP89Q0Wk1
	fv6rcmp6fhQFAUv/zgQw5yhSzCik5zLDgRTGKiP+GWcXmScdAlOGD4EbEpaFaHvf1p92gV
	geTnrJtluTWeCpcZVSb7p3sIY8xgLag=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N5xLU6+v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720861676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ThHry23pPjk5yHTUi505ngwfOTmVvqUFhNOIXPkTsko=;
	b=N5xLU6+vWA11S6UH5oMTVoLMTNq5K/n+UPK58s4cSce/hcKwEQACrZPMVs3I7wP89Q0Wk1
	fv6rcmp6fhQFAUv/zgQw5yhSzCik5zLDgRTGKiP+GWcXmScdAlOGD4EbEpaFaHvf1p92gV
	geTnrJtluTWeCpcZVSb7p3sIY8xgLag=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEF301340C
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2024 09:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id REcZHutDkmYgAwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2024 09:07:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: change BTRFS_MOUNT_* flags to 64bits
Date: Sat, 13 Jul 2024 18:37:48 +0930
Message-ID: <2fb99f3c249d740925b833dd4b73191abefc9544.1720861661.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C04721AF2
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

Currently the BTRFS_MOUNT_* flags is already reaching 32 bits, and with
the incoming new rescue options, we're going beyond the width of 32
bits.

This is going to cause problems as for quite some 32 bit systems,
1ULL << 32 would overflow the width of unsigned long.

Fix it by moving all the existing flags to 64 bit unsigned long long to
prepare for the incoming new flags.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
The current patch is still based on the latest for-next branch.

But during merge time I will move this before the new rescue options.
---
 fs/btrfs/fs.h | 64 +++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index e911e0a838a2..770b9fa3cedc 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -195,38 +195,38 @@ enum {
  * Note: don't forget to add new options to btrfs_show_options()
  */
 enum {
-	BTRFS_MOUNT_NODATASUM			= (1UL << 0),
-	BTRFS_MOUNT_NODATACOW			= (1UL << 1),
-	BTRFS_MOUNT_NOBARRIER			= (1UL << 2),
-	BTRFS_MOUNT_SSD				= (1UL << 3),
-	BTRFS_MOUNT_DEGRADED			= (1UL << 4),
-	BTRFS_MOUNT_COMPRESS			= (1UL << 5),
-	BTRFS_MOUNT_NOTREELOG   		= (1UL << 6),
-	BTRFS_MOUNT_FLUSHONCOMMIT		= (1UL << 7),
-	BTRFS_MOUNT_SSD_SPREAD			= (1UL << 8),
-	BTRFS_MOUNT_NOSSD			= (1UL << 9),
-	BTRFS_MOUNT_DISCARD_SYNC		= (1UL << 10),
-	BTRFS_MOUNT_FORCE_COMPRESS      	= (1UL << 11),
-	BTRFS_MOUNT_SPACE_CACHE			= (1UL << 12),
-	BTRFS_MOUNT_CLEAR_CACHE			= (1UL << 13),
-	BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED	= (1UL << 14),
-	BTRFS_MOUNT_ENOSPC_DEBUG		= (1UL << 15),
-	BTRFS_MOUNT_AUTO_DEFRAG			= (1UL << 16),
-	BTRFS_MOUNT_USEBACKUPROOT		= (1UL << 17),
-	BTRFS_MOUNT_SKIP_BALANCE		= (1UL << 18),
-	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 19),
-	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 20),
-	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 21),
-	BTRFS_MOUNT_FRAGMENT_METADATA		= (1UL << 22),
-	BTRFS_MOUNT_FREE_SPACE_TREE		= (1UL << 23),
-	BTRFS_MOUNT_NOLOGREPLAY			= (1UL << 24),
-	BTRFS_MOUNT_REF_VERIFY			= (1UL << 25),
-	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 26),
-	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 27),
-	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 28),
-	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
-	BTRFS_MOUNT_NOSPACECACHE		= (1UL << 30),
-	BTRFS_MOUNT_IGNOREMETACSUMS		= (1UL << 31),
+	BTRFS_MOUNT_NODATASUM			= (1ULL << 0),
+	BTRFS_MOUNT_NODATACOW			= (1ULL << 1),
+	BTRFS_MOUNT_NOBARRIER			= (1ULL << 2),
+	BTRFS_MOUNT_SSD				= (1ULL << 3),
+	BTRFS_MOUNT_DEGRADED			= (1ULL << 4),
+	BTRFS_MOUNT_COMPRESS			= (1ULL << 5),
+	BTRFS_MOUNT_NOTREELOG			= (1ULL << 6),
+	BTRFS_MOUNT_FLUSHONCOMMIT		= (1ULL << 7),
+	BTRFS_MOUNT_SSD_SPREAD			= (1ULL << 8),
+	BTRFS_MOUNT_NOSSD			= (1ULL << 9),
+	BTRFS_MOUNT_DISCARD_SYNC		= (1ULL << 10),
+	BTRFS_MOUNT_FORCE_COMPRESS		= (1ULL << 11),
+	BTRFS_MOUNT_SPACE_CACHE			= (1ULL << 12),
+	BTRFS_MOUNT_CLEAR_CACHE			= (1ULL << 13),
+	BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED	= (1ULL << 14),
+	BTRFS_MOUNT_ENOSPC_DEBUG		= (1ULL << 15),
+	BTRFS_MOUNT_AUTO_DEFRAG			= (1ULL << 16),
+	BTRFS_MOUNT_USEBACKUPROOT		= (1ULL << 17),
+	BTRFS_MOUNT_SKIP_BALANCE		= (1ULL << 18),
+	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1ULL << 19),
+	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1ULL << 20),
+	BTRFS_MOUNT_FRAGMENT_DATA		= (1ULL << 21),
+	BTRFS_MOUNT_FRAGMENT_METADATA		= (1ULL << 22),
+	BTRFS_MOUNT_FREE_SPACE_TREE		= (1ULL << 23),
+	BTRFS_MOUNT_NOLOGREPLAY			= (1ULL << 24),
+	BTRFS_MOUNT_REF_VERIFY			= (1ULL << 25),
+	BTRFS_MOUNT_DISCARD_ASYNC		= (1ULL << 26),
+	BTRFS_MOUNT_IGNOREBADROOTS		= (1ULL << 27),
+	BTRFS_MOUNT_IGNOREDATACSUMS		= (1ULL << 28),
+	BTRFS_MOUNT_NODISCARD			= (1ULL << 29),
+	BTRFS_MOUNT_NOSPACECACHE		= (1ULL << 30),
+	BTRFS_MOUNT_IGNOREMETACSUMS		= (1ULL << 31),
 	BTRFS_MOUNT_IGNORESUPERFLAGS		= (1ULL << 32),
 };
 
-- 
2.45.2


