Return-Path: <linux-btrfs+bounces-11726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C3FA41254
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 00:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C711B172423
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 23:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3FA20469E;
	Sun, 23 Feb 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tXnMMc7h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tXnMMc7h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363020013A
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740354424; cv=none; b=heJPYiI/RePbw8qbU8/lG6aRkDqYTWthYbuDxp8YnYAEIQ4/67xV/Rj04R/iAbrOtbdgCNTTAUmszL70cCS3OvfHUoylJhWWCrphO8iCrsOpbQQCzfV83wXyylZvLaSj90VM4teBfBjkm5Lg6EOXgqCZOTrSFggWoPpPo0HOOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740354424; c=relaxed/simple;
	bh=U74dwjd6hRkxRHQzqUXvKQ62REXR7Ay8C9J6n17JAog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JckRYOH6DVTV9/xLWUsTA3UpuyekdODJKIgik4EzyjfiOJ1B8nVWQ2BZtRsXw04WPh14SFeoN+I1hvGVjetaxOnQkA23dQnKzDg6u6l8y+T6NMjtDVKFczYn5TuZmtNtzVNbPNh3JPFUk9VlNAlCqnLzcNEsCvqgzZhckYlEfRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tXnMMc7h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tXnMMc7h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41F0421174
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=im/0VwaIl9ZzbAkiZuz2ZCfjVukEp+eKztzRaVYUtJI=;
	b=tXnMMc7he0Wvycv0aNKQ1LDmUFBA0Q/dOut2kK61j9UL466FyHxuUSo2P04/2nz09L/utP
	ao3oGTURwrsGtZQBkQp8QYN4aEEjTgPXxAiiq9dMJ8lkpp3LzurW1dYwxbxlFwu8sWHQAB
	yZ7Mu2OMqpUkXzyQBerJ0P8T59AX+hw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=im/0VwaIl9ZzbAkiZuz2ZCfjVukEp+eKztzRaVYUtJI=;
	b=tXnMMc7he0Wvycv0aNKQ1LDmUFBA0Q/dOut2kK61j9UL466FyHxuUSo2P04/2nz09L/utP
	ao3oGTURwrsGtZQBkQp8QYN4aEEjTgPXxAiiq9dMJ8lkpp3LzurW1dYwxbxlFwu8sWHQAB
	yZ7Mu2OMqpUkXzyQBerJ0P8T59AX+hw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76EC813A42
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sG/hDWmzu2euTgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: remove the subpage related warning message
Date: Mon, 24 Feb 2025 10:16:22 +1030
Message-ID: <7d10ddfc206a73909763f8a9addfef1e10e5fccf.1740354271.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740354271.git.wqu@suse.com>
References: <cover.1740354271.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
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
X-Spam-Score: -2.80
X-Spam-Flag: NO

Since the initial enablement of block size < page size support for
btrfs in v5.15, we have hit several milestones for block size < page
size (subpage) support:

- RAID56 subpage support
  In v5.19

- Refactored scrub support to support subpage better
  In v6.4

- Block perfect (previously requires page aligned ranges) compressed write
  In v6.13

- Various error handling fixes involving subpage
  In v6.14

Finally the only missing feature is the pretty simple and harmless
inlined data extent creation, just done in previous patches.

Now btrfs has all of its features ready for both regular and subpage
cases, there is no reason to output a warning about the experimental
subpage support, and we can finally remove it now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a799216aa264..c0b40dedceb5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3414,11 +3414,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	fs_info->max_inline = min_t(u64, fs_info->max_inline, fs_info->sectorsize);
 
-	if (sectorsize < PAGE_SIZE)
-		btrfs_warn(fs_info,
-		"read-write for sector size %u with page size %lu is experimental",
-			   sectorsize, PAGE_SIZE);
-
 	ret = btrfs_init_workqueues(fs_info);
 	if (ret)
 		goto fail_sb_buffer;
-- 
2.48.1


