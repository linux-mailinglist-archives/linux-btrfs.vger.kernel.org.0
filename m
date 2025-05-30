Return-Path: <linux-btrfs+bounces-14328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60E3AC9354
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8C84A17CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813E91A23B5;
	Fri, 30 May 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zi1hrHLP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zi1hrHLP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258EA2E401
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621886; cv=none; b=lrsWCTkZAtdUgPVKAC+18UI2bnfdeEasJm7ilxPWIHFPpl/fAVqmU2cRFJNJWsPcGP/sh2eN4ZZLEQ7Nl0cjRTOSKsJEVdq/BEefrBr2xyL+gvO9HGotgq3R1mSWo8t6xH9JKc7WRHXft+3zk3LfuQ9Ezh/eG0rePvTT/Af8RnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621886; c=relaxed/simple;
	bh=B4lGqjSZf5EEB8YL2rcsGtca+JzO0wSLOmxVvPxERpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZkUqMOLE9GijfpNhqRQQRlYVh9Djf8+74Ie379mX4SsbE4DdjkGyApfF8l8+kw/5nZ7CdG3qMXV9LyYfri9iu3LrMXCB6K/31kAYrCnTow/M1SoGw7iEEi0qOff8SRScBUe7HiA+y/XkrWpWryjygt/o7+nQc2XpgoT4JaqLOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zi1hrHLP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zi1hrHLP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DF6C1FC04;
	Fri, 30 May 2025 16:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAeDoLU7VY6yuVR/4zuN9Y1G0ijGRKAGpAJYhhfQdZ8=;
	b=Zi1hrHLPQOZxoOwG/UhuEpSAeT9wNkVBSoos0jBCesSg7OLZHuc+e3vtmQD1PjSSKUP2jb
	ezP1m1PUC/8djLaJ0y2yv2Q5R62crOv7yFgYdM3ERr4ZIDzkBEgUq8k10yV1leSQHyDfcm
	B1U7ToyLjXDB2EiMTvgCtNaSDZsYpqY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAeDoLU7VY6yuVR/4zuN9Y1G0ijGRKAGpAJYhhfQdZ8=;
	b=Zi1hrHLPQOZxoOwG/UhuEpSAeT9wNkVBSoos0jBCesSg7OLZHuc+e3vtmQD1PjSSKUP2jb
	ezP1m1PUC/8djLaJ0y2yv2Q5R62crOv7yFgYdM3ERr4ZIDzkBEgUq8k10yV1leSQHyDfcm
	B1U7ToyLjXDB2EiMTvgCtNaSDZsYpqY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26A3B13889;
	Fri, 30 May 2025 16:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 23xsCTfaOWivZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:17:59 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/22] btrfs: rename err to ret in btrfs_lock_extent_bits()
Date: Fri, 30 May 2025 18:17:58 +0200
Message-ID: <b22f8e3fff000f66ff80a907d4c2df4e566d2657.1748621715.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
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
X-Spam-Flag: NO
X-Spam-Score: -6.80

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 0f4c0b234573..84da01996336 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1903,21 +1903,21 @@ int btrfs_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, u32
 			   struct extent_state **cached_state)
 {
 	struct extent_state *failed_state = NULL;
-	int err;
+	int ret;
 	u64 failed_start;
 
-	err = set_extent_bit(tree, start, end, bits, &failed_start,
+	ret = set_extent_bit(tree, start, end, bits, &failed_start,
 			     &failed_state, cached_state, NULL);
-	while (err == -EEXIST) {
+	while (ret == -EEXIST) {
 		if (failed_start != start)
 			btrfs_clear_extent_bit(tree, start, failed_start - 1,
 					       bits, cached_state);
 
 		wait_extent_bit(tree, failed_start, end, bits, &failed_state);
-		err = set_extent_bit(tree, start, end, bits, &failed_start,
+		ret = set_extent_bit(tree, start, end, bits, &failed_start,
 				     &failed_state, cached_state, NULL);
 	}
-	return err;
+	return ret;
 }
 
 /*
-- 
2.47.1


