Return-Path: <linux-btrfs+bounces-14319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B60AC9348
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3942C4E53D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89771AAA1B;
	Fri, 30 May 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ov8Kl+St";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ov8Kl+St"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05791A5B91
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621834; cv=none; b=eVCG4DyrNNeVdlxJDyCowVDYPxuUMES1ixXhPJ2DB/lxS+a5Dj31CCYrqIyO0v1cnSAmvna3vfn0zgZYuPzT8snnLwXPZHiJsFNNwAqOpjPSRs5LigiOlkCXqcHKIN84pooP3NgUFnRRHoH/KxZQP1aLarExxZUOMp//bznurAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621834; c=relaxed/simple;
	bh=yHWowzfqkMXqiSXGp+Ia7dUbe8WuiazSM1+MXvXTL0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePAcVYo7dL881NN/j7uKdiwtpyvpnGZb2RF7uEmwpyJQHP+KOABX+HPTHskcsg3Z25D0aqY9sXUp800xWKC/4jxLUN9w9a3uWMVizInhYxdW3bin+safao3EhK9voQ5d4yS0yFJUixS18ujaMKNCYUTIna5B3ixu92Sbf6d/UQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ov8Kl+St; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ov8Kl+St; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7852219CB;
	Fri, 30 May 2025 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkVDryFLr4CCnadx5gF2IL4VaMejF8cZ3XJy7AgFQ4I=;
	b=ov8Kl+StY28VIdA4iYH3gWjUOidiMtsqv/r+Bb4gTHC9PV9hXIQeZrqTxdS6Un0QbF289p
	+zWFv3oIApxpzqqF4zV7TUwy18ZxfzEj8vXEv1cGFd9zVwbv0+daRSrrDSHWLWmdsJd/PW
	DE8fsmFgqVsCJUcfC+4lEh4021t0KCU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkVDryFLr4CCnadx5gF2IL4VaMejF8cZ3XJy7AgFQ4I=;
	b=ov8Kl+StY28VIdA4iYH3gWjUOidiMtsqv/r+Bb4gTHC9PV9hXIQeZrqTxdS6Un0QbF289p
	+zWFv3oIApxpzqqF4zV7TUwy18ZxfzEj8vXEv1cGFd9zVwbv0+daRSrrDSHWLWmdsJd/PW
	DE8fsmFgqVsCJUcfC+4lEh4021t0KCU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0FE113889;
	Fri, 30 May 2025 16:17:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hiwbLwXaOWhqZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:17:09 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/22] btrfs: rename err to ret2 in resolve_indirect_refs()
Date: Fri, 30 May 2025 18:17:05 +0200
Message-ID: <d986775f5a216a1b9209d3ad9fe1a78a12283308.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Unify naming of return value to the preferred way, move the variable to
the closest scope.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index a4e0e2c3ea7d..bebef4bd0c65 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -733,7 +733,6 @@ static int resolve_indirect_refs(struct btrfs_backref_walk_ctx *ctx,
 				 struct preftrees *preftrees,
 				 struct share_check *sc)
 {
-	int err;
 	int ret = 0;
 	struct ulist *parents;
 	struct ulist_node *node;
@@ -752,6 +751,7 @@ static int resolve_indirect_refs(struct btrfs_backref_walk_ctx *ctx,
 	 */
 	while ((rnode = rb_first_cached(&preftrees->indirect.root))) {
 		struct prelim_ref *ref;
+		int ret2;
 
 		ref = rb_entry(rnode, struct prelim_ref, rbnode);
 		if (WARN(ref->parent,
@@ -773,18 +773,18 @@ static int resolve_indirect_refs(struct btrfs_backref_walk_ctx *ctx,
 			ret = BACKREF_FOUND_SHARED;
 			goto out;
 		}
-		err = resolve_indirect_ref(ctx, path, preftrees, ref, parents);
+		ret2 = resolve_indirect_ref(ctx, path, preftrees, ref, parents);
 		/*
 		 * we can only tolerate ENOENT,otherwise,we should catch error
 		 * and return directly.
 		 */
-		if (err == -ENOENT) {
+		if (ret2 == -ENOENT) {
 			prelim_ref_insert(ctx->fs_info, &preftrees->direct, ref,
 					  NULL);
 			continue;
-		} else if (err) {
+		} else if (ret2) {
 			free_pref(ref);
-			ret = err;
+			ret = ret2;
 			goto out;
 		}
 
-- 
2.47.1


