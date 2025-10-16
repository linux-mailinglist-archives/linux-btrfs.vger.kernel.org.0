Return-Path: <linux-btrfs+bounces-17879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3445ABE278F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 11:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78AF94FDC0A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D8431815D;
	Thu, 16 Oct 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ALTiqOuE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ALTiqOuE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718A3074BC
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607789; cv=none; b=IAAfYSdJhDALZkC30Ytsp/G2COlvnw2H3YPKHuJ/D6HNFsipblJNSRq0IOv47NWAcqT0NmX6X/M9SeSEqhtbRGagaRzazDWHKRO7sQzZXPFim5jacq3YpepvV8NBjhB3qwAtNEN2eX/PCcXhOjE5F/RSnnkI/f+dpOIX1lM3p+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607789; c=relaxed/simple;
	bh=1zEolLG0Qo1zoV9CQLCqJFFaKvrFzGR2v6M3FunUFwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpA/oFVIpbFtec4I8ZLPeoLXmYPvLPAbLAD8ninJto7GqyXfTo8hVO3oNuYF1k4C5lRnT4uRRj9ybCZGFVGh5llQevIMB+YPAUIh9xDeYtOZJIs+xuuNyFI3Rw4kHzO+ogtoIcRmFHAULgFo/xgc48h1+YAZCHCVIHnPN1vp7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ALTiqOuE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ALTiqOuE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C46C721DBE;
	Thu, 16 Oct 2025 09:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760607778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djjIHGouGLXr2JPA5V2LixtjXkm4o5JTP2Ka5Nvcf3w=;
	b=ALTiqOuE4EY/p8P1Q5vfAHARQmEiSNOe93UuZnUjtsGlNx+Ek9SO700kcU5KV7+oGM50mG
	vtqQGfg9NXkt0DxtgH0c2gG7YjpYNS5IHXIvKCXIldLb15zKG8CinN5Vz7AJQMIlEQ82H4
	t09xtsZ2siXq0ymE0pagziylHoMFJuM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760607778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djjIHGouGLXr2JPA5V2LixtjXkm4o5JTP2Ka5Nvcf3w=;
	b=ALTiqOuE4EY/p8P1Q5vfAHARQmEiSNOe93UuZnUjtsGlNx+Ek9SO700kcU5KV7+oGM50mG
	vtqQGfg9NXkt0DxtgH0c2gG7YjpYNS5IHXIvKCXIldLb15zKG8CinN5Vz7AJQMIlEQ82H4
	t09xtsZ2siXq0ymE0pagziylHoMFJuM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE49E1340C;
	Thu, 16 Oct 2025 09:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2AtTHiG+8GgjYQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 16 Oct 2025 09:42:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 1/3] btrfs: scrub: add cancel/pause/removed bg checks for raid56 parity stripes
Date: Thu, 16 Oct 2025 20:12:36 +1030
Message-ID: <ceb3bb43d52ddea6f7d7d91e2441b3611d487f6e.1760607566.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760607566.git.wqu@suse.com>
References: <cover.1760607566.git.wqu@suse.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

For raid56, data and parity stripes are handled differently.

For data stripes they are handled just like regular RAID1/RAID10 stripes,
going through the regular scrub_simple_mirror().

But for parity stripes we have to read out all involved data stripes and
do any needed verification and repair, then scrub the parity stripe.

This process will take a much longer time than a regular stripe, but
unlike scrub_simple_mirror(), we do not check if we should cancel/pause
or the block group is already removed.

Aligned the behavior of scrub_raid56_parity_stripe() to
scrub_simple_mirror(), by adding:

- Cancel check
- Pause check
- Removed block group check

Since those checks are the same from the scrub_simple_mirror(), also
update the comments of scrub_simple_mirror() by:

- Remove too obvious comments
  We do not need extra comments on what we're checking, it's really too
  obvious.

- Remove a stale comment about pausing
  Now the scrub is always queuing all involved stripes, and submit them
  in one go, there is no more submission part during pausing.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index fe266785804e..c3e7e543d350 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2091,6 +2091,20 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 	ASSERT(sctx->raid56_data_stripes);
 
+	if (atomic_read(&fs_info->scrub_cancel_req) ||
+	    atomic_read(&sctx->cancel_req))
+		return -ECANCELED;
+
+	if (atomic_read(&fs_info->scrub_pause_req))
+		scrub_blocked_if_needed(fs_info);
+
+	spin_lock(&bg->lock);
+	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags)) {
+		spin_unlock(&bg->lock);
+		return 0;
+	}
+	spin_unlock(&bg->lock);
+
 	/*
 	 * For data stripe search, we cannot reuse the same extent/csum paths,
 	 * as the data stripe bytenr may be smaller than previous extent.  Thus
@@ -2261,18 +2275,15 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		u64 found_logical = U64_MAX;
 		u64 cur_physical = physical + cur_logical - logical_start;
 
-		/* Canceled? */
 		if (atomic_read(&fs_info->scrub_cancel_req) ||
 		    atomic_read(&sctx->cancel_req)) {
 			ret = -ECANCELED;
 			break;
 		}
-		/* Paused? */
-		if (atomic_read(&fs_info->scrub_pause_req)) {
-			/* Push queued extents */
+
+		if (atomic_read(&fs_info->scrub_pause_req))
 			scrub_blocked_if_needed(fs_info);
-		}
-		/* Block group removed? */
+
 		spin_lock(&bg->lock);
 		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags)) {
 			spin_unlock(&bg->lock);
-- 
2.51.0


