Return-Path: <linux-btrfs+bounces-19061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D69C62BCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCF9B4ECF61
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90231986D;
	Mon, 17 Nov 2025 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n4Xb3NWs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n4Xb3NWs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2765319840
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364714; cv=none; b=CvJQ8BR4JfX1NUCnip+bDXkEil4wrHEZRxxavx5h3wO9EL8BjyN7iHhpWhZ0fgDEJePlRDROc4VIkScEPbvOTb1nb8n3HSlT3kWH/wC/6JZPAehaV9tu9b3RhfCK/CM9f1qM/vKLTaMopTvxfJE4UGv++xQMUBhJSXwqdSe+HIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364714; c=relaxed/simple;
	bh=k8U4nO3tCqdL6tNqdKzr8zIKbXgtF7kAplKW+ygXJpM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7GfHcTsQ0S3r/o2ZQBiJC4muc+RKPJ9X8s+QHAByaWCoZQDjTdpO9mETl3wVRvG+r7Pp+7nA0uEpMta2m3D+4CAZOG//TmMk88mrzPcua0HR8UuAf7IBpaOlYpzhd1xyfI1PjIJ/yoL8PymvD+aJkuaRjF2VJl5Eq5ueA6+0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n4Xb3NWs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n4Xb3NWs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B57B21210
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MT8Gv+4uwJSX9V8a35iCRIkI4zq+kBv0qOxigZiT2LY=;
	b=n4Xb3NWsNVU8VToeWNnqOck4YAM1WfVkh3AEtifzzmIYQTbLW5CXa/DWtUr0JIUjUISVH1
	vFgvM2+P13UoNJnkUjUtJZGToQ1jpo8nIvKk6dDySFmk7CEbOgCHuMZa5S0EtVnuQhx/Ie
	Xzd+xoHTJBtHL8BlvQ3lqSgRnWTbVJM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MT8Gv+4uwJSX9V8a35iCRIkI4zq+kBv0qOxigZiT2LY=;
	b=n4Xb3NWsNVU8VToeWNnqOck4YAM1WfVkh3AEtifzzmIYQTbLW5CXa/DWtUr0JIUjUISVH1
	vFgvM2+P13UoNJnkUjUtJZGToQ1jpo8nIvKk6dDySFmk7CEbOgCHuMZa5S0EtVnuQhx/Ie
	Xzd+xoHTJBtHL8BlvQ3lqSgRnWTbVJM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74C623EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OAK4DUzPGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/12] btrfs: enable bs > ps support for raid56
Date: Mon, 17 Nov 2025 18:00:51 +1030
Message-ID: <8aeabb3ab32d2b3c2da3baece4903791ff891dcd.1763361991.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763361991.git.wqu@suse.com>
References: <cover.1763361991.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c |  6 ------
 fs/btrfs/raid56.c  | 11 ++++++-----
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0df81a09a3d1..fe62f5a244f5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3258,12 +3258,6 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 			   PAGE_SIZE, fs_info->sectorsize);
 		return -EINVAL;
 	}
-	if (fs_info->sectorsize > PAGE_SIZE && btrfs_fs_incompat(fs_info, RAID56)) {
-		btrfs_err(fs_info,
-		"RAID56 is not supported for page size %lu with sectorsize %u",
-			  PAGE_SIZE, fs_info->sectorsize);
-		return -EINVAL;
-	}
 
 	/* This can be called by remount, we need to protect the super block. */
 	spin_lock(&fs_info->super_lock);
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index d8d3af2c4db5..ec6427565f25 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1070,8 +1070,12 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	const unsigned int sector_nsteps = fs_info->sectorsize / step;
 	struct btrfs_raid_bio *rbio;
 
-	/* PAGE_SIZE must also be aligned to sectorsize for subpage support */
-	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->sectorsize));
+	/*
+	 * For bs <= ps cases, ps must be aligned to bs.
+	 * For bs > ps cases, bs must be aligned to ps.
+	 */
+	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->sectorsize) ||
+	       IS_ALIGNED(fs_info->sectorsize, PAGE_SIZE));
 	/*
 	 * Our current stripe len should be fixed to 64k thus stripe_nsectors
 	 * (at most 16) should be no larger than BITS_PER_LONG.
@@ -3013,9 +3017,6 @@ void raid56_parity_cache_data_folios(struct btrfs_raid_bio *rbio,
 	unsigned int foffset = 0;
 	int ret;
 
-	/* We shouldn't hit RAID56 for bs > ps cases for now. */
-	ASSERT(fs_info->sectorsize <= PAGE_SIZE);
-
 	/*
 	 * If we hit ENOMEM temporarily, but later at
 	 * raid56_parity_submit_scrub_rbio() time it succeeded, we just do
-- 
2.51.2


