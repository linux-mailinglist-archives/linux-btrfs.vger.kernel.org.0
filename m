Return-Path: <linux-btrfs+bounces-8700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA7F996DD4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2841C22927
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9E3BBEB;
	Wed,  9 Oct 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="trCCO63U";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="trCCO63U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983621DA3D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484268; cv=none; b=qkvNEEl8KO2uHKDF0+fLRwDuFgUkH+aMDkw96z/vGtMKewx2IWv8QdjYMtF8XjLyHH5/EXJ7Ldr3iuQTkWA4i3NWoglK4RhbGobS6hZR71AU315tnR7w+nipf+zSU5fKkWgnZWKzfVSPR/k3rverr/DSaFwg/K1ZrlpRGNBUd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484268; c=relaxed/simple;
	bh=PnkoJ88wfNp3gh+vU8Cu5cBJNIYFsqHTitr78B4ggE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctbD7M3QJ9amDZJApzAlvM80NemFD7pC9ekr627cl+rOWoYSughLo3tYt+1ssBXPb88GhwhmAjl2lkrBWhSE5zcoevl3l/D+zeeP5cdPkD/JNdLI286Inf4eBpknNGzml1MbPtWaQsqAwVoN2MGzNQ2BC2HwNzfCJX6SXxGhvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=trCCO63U; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=trCCO63U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C66A221F7F;
	Wed,  9 Oct 2024 14:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=150E4DP/ooZ92HbmB0vRSYAFGPufRw12OdkI21ANTco=;
	b=trCCO63UM7DefJoBY660FO1qFDkRkHQvNkCUN5YWhYiN1y3kt+K9a9/wZAcBI0CqRazSKu
	V9j0myKZsHt+dgYuvwKvdm3P9ourOiNtq1dW77rapx8zCjztphSNuLXn1PYLlpgqljxa3p
	tOmYMEk5puVKqxhI5BcvyOHqVc/skaY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=150E4DP/ooZ92HbmB0vRSYAFGPufRw12OdkI21ANTco=;
	b=trCCO63UM7DefJoBY660FO1qFDkRkHQvNkCUN5YWhYiN1y3kt+K9a9/wZAcBI0CqRazSKu
	V9j0myKZsHt+dgYuvwKvdm3P9ourOiNtq1dW77rapx8zCjztphSNuLXn1PYLlpgqljxa3p
	tOmYMEk5puVKqxhI5BcvyOHqVc/skaY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFB63136BA;
	Wed,  9 Oct 2024 14:31:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kxvLLqiTBmcGRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:04 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/25] btrfs: drop unused parameter fs_info from do_reclaim_sweep()
Date: Wed,  9 Oct 2024 16:31:04 +0200
Message-ID: <9a515e1d2702b971d21b591ccb2bc3111f452e4e.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The parameter is unused and we can get it from space info if needed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/space-info.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3c7ccb3935cf..255e85f78313 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1983,8 +1983,7 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
 	return unalloc < data_chunk_size;
 }
 
-static void do_reclaim_sweep(const struct btrfs_fs_info *fs_info,
-			     struct btrfs_space_info *space_info, int raid)
+static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 {
 	struct btrfs_block_group *bg;
 	int thresh_pct;
@@ -2080,6 +2079,6 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
 		if (!btrfs_should_periodic_reclaim(space_info))
 			continue;
 		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
-			do_reclaim_sweep(fs_info, space_info, raid);
+			do_reclaim_sweep(space_info, raid);
 	}
 }
-- 
2.45.0


