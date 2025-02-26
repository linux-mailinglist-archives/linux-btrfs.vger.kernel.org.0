Return-Path: <linux-btrfs+bounces-11861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D0AA45AC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11EF1896E67
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C8424E002;
	Wed, 26 Feb 2025 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QZvQnMRm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QZvQnMRm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AF2459D3
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563523; cv=none; b=jEvXLj4rR0reWX5loZzVdXF+xiGvv1GtB5/RmL0uaaiCtC91SguUPISHc4uJI4Qx1WQcnQFcRMQVshrb+UTAjjDZ/cZUarcCcJK8KNO6TUP5anzm9N6kS7Y3jPFowHkBFW3EgK6U2+3pye2u5T47Dv0q/Ga+wbZ2tm7ETkQW91w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563523; c=relaxed/simple;
	bh=+HDFNJsf6SSOwByHndi40tdEtkNr+CWfZ8V515KKj3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPyTADHOOa+TqqW5vMV/aTqOBlu1OyQXahXGYHl8qtu18qce3GbcytMvZEINBunNrn4SMoQIT53pvduWSD8BFMTeBJGLqCKjTMOTEtAHnsp0SK1mee1eBsZozsUR57D0K/sRiS01UZzKkbvFVr/EQMpsIiDOM4RmBo9hprdzNNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QZvQnMRm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QZvQnMRm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB05121163;
	Wed, 26 Feb 2025 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trYtsczbWoF1zO646ow6YvjBVX/HCpf8ZGMyBd1Ivc4=;
	b=QZvQnMRmzDuMdcO8Ot+6RAtu8bKNSEwavoBuaN8EQBq+mj1fcMjyXA3OC95SIUA1vOvFcD
	LanEVpg5vWhZUgt9UeW1q19OCiBAPDuWk0rSYM8gEVxFqhiIaTrB9jaWDbm/TWGnpYH4co
	xbaqWwUfieCriVASM747kxOqhUjJaxw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trYtsczbWoF1zO646ow6YvjBVX/HCpf8ZGMyBd1Ivc4=;
	b=QZvQnMRmzDuMdcO8Ot+6RAtu8bKNSEwavoBuaN8EQBq+mj1fcMjyXA3OC95SIUA1vOvFcD
	LanEVpg5vWhZUgt9UeW1q19OCiBAPDuWk0rSYM8gEVxFqhiIaTrB9jaWDbm/TWGnpYH4co
	xbaqWwUfieCriVASM747kxOqhUjJaxw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A444F13A53;
	Wed, 26 Feb 2025 09:51:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pxEZKD3kvmeDYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:57 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 27/27] btrfs: use BTRFS_PATH_AUTO_FREE in load_free_space_tree()
Date: Wed, 26 Feb 2025 10:51:57 +0100
Message-ID: <f78c8e236bf2d9975f033e08f33ce7d088267b11.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 589ff73ed13a..39c6b96a4c25 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1633,9 +1633,8 @@ int load_free_space_tree(struct btrfs_caching_control *caching_ctl)
 {
 	struct btrfs_block_group *block_group;
 	struct btrfs_free_space_info *info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	u32 extent_count, flags;
-	int ret;
 
 	block_group = caching_ctl->block_group;
 
@@ -1652,10 +1651,9 @@ int load_free_space_tree(struct btrfs_caching_control *caching_ctl)
 	path->reada = READA_FORWARD;
 
 	info = search_free_space_info(NULL, block_group, path, 0);
-	if (IS_ERR(info)) {
-		ret = PTR_ERR(info);
-		goto out;
-	}
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
 	extent_count = btrfs_free_space_extent_count(path->nodes[0], info);
 	flags = btrfs_free_space_flags(path->nodes[0], info);
 
@@ -1665,11 +1663,7 @@ int load_free_space_tree(struct btrfs_caching_control *caching_ctl)
 	 * there.
 	 */
 	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS)
-		ret = load_free_space_bitmaps(caching_ctl, path, extent_count);
+		return load_free_space_bitmaps(caching_ctl, path, extent_count);
 	else
-		ret = load_free_space_extents(caching_ctl, path, extent_count);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+		return load_free_space_extents(caching_ctl, path, extent_count);
 }
-- 
2.47.1


