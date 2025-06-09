Return-Path: <linux-btrfs+bounces-14571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B4AD24C9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C949C3B043F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282021D3D6;
	Mon,  9 Jun 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LXllaKKs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LXllaKKs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32E21B90B
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489008; cv=none; b=YAnT87P4890LwtJE22QGXTmW7kbd+ZTrobnFmVP+oCcTiugsie0vl+ZzRDN/l0gOrY7UMwJEM7gOokBZ01GtZ2GlzdtozzgG8SQsnH4UfT0xNznJk2jW/po8B2joHG7cYaPnC0kx8wPKeVQPQOirbR6rJLq0uwwpO5Z1xH3I4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489008; c=relaxed/simple;
	bh=Bw6k/BUgHkeJBMKfiW2lLNGC1euYfwEsUaoHLhqbE14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQxNC9F6p7qnKUEaGkUA+NEva/hrqOO+wIuBOpdT+vPHL0MBPJ9n8vaaDZciZHBM8FfZ0qiPnbTwP3XqHvL2ia5ZGBl1nY9D9bLQBivgfnzzgvBe11E4LuYTDFQm9+rIAIpQCxhk/KB+JjB4/+G2PPAkCNXz9XvSZBdGevqQVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LXllaKKs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LXllaKKs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A5CA211AA;
	Mon,  9 Jun 2025 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749489000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8xgCS5aVc/dZicYC1pGsIuuSCRNShVGndyJ2hKDamc=;
	b=LXllaKKs+C+7yk2e30laTfcZNnxjYCreXWMgHFz1CiO1H2dtM38Zx4D8cyVHdenOtqjKUb
	QipQ0h0uWaygEOjKxnofhby+E1wukze0bZJjBJ+ALX4xP2/DW3Y3+FISksX+bNK3pDP32o
	ecQ6+m2Nxuw6ncfJjwWAqeIsrNiObys=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749489000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8xgCS5aVc/dZicYC1pGsIuuSCRNShVGndyJ2hKDamc=;
	b=LXllaKKs+C+7yk2e30laTfcZNnxjYCreXWMgHFz1CiO1H2dtM38Zx4D8cyVHdenOtqjKUb
	QipQ0h0uWaygEOjKxnofhby+E1wukze0bZJjBJ+ALX4xP2/DW3Y3+FISksX+bNK3pDP32o
	ecQ6+m2Nxuw6ncfJjwWAqeIsrNiObys=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43D2F137FE;
	Mon,  9 Jun 2025 17:10:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QTKNEGgVR2inHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:10:00 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/11] btrfs: switch RCU helper versions to btrfs_debug()
Date: Mon,  9 Jun 2025 19:09:28 +0200
Message-ID: <9563817056fe3696093798ba99c0cd7e4240b287.1749488829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749488829.git.dsterba@suse.com>
References: <cover.1749488829.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

The RCU protection is now done in the plain helpers, we can remove the
"_in_rcu" and "_rl_in_rcu".

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c      |  2 +-
 fs/btrfs/messages.h | 14 --------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index aa970fd41c4b78..50b5fc1c06d7cc 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -433,7 +433,7 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 		ASSERT(btrfs_dev_is_sequential(dev, physical));
 		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
 	}
-	btrfs_debug_in_rcu(dev->fs_info,
+	btrfs_debug(dev->fs_info,
 	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		__func__, bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
 		(unsigned long)dev->bdev->bd_dev, btrfs_dev_name(dev),
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 9d5330ba02534f..659889faec8518 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -77,31 +77,17 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 #define btrfs_debug(fs_info, fmt, args...)				\
 	_dynamic_func_call_no_desc(fmt, btrfs_printk_in_rcu,		\
 				   fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_in_rcu(fs_info, fmt, args...)			\
-	_dynamic_func_call_no_desc(fmt, btrfs_printk_in_rcu,		\
-				   fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...)			\
-	_dynamic_func_call_no_desc(fmt, btrfs_printk_rl_in_rcu,		\
-				   fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_rl(fs_info, fmt, args...)				\
 	_dynamic_func_call_no_desc(fmt, btrfs_printk_rl_in_rcu,		\
 				   fs_info, KERN_DEBUG fmt, ##args)
 #elif defined(DEBUG)
 #define btrfs_debug(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_rl(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #else
 #define btrfs_debug(fs_info, fmt, args...) \
 	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_in_rcu(fs_info, fmt, args...) \
-	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_rl(fs_info, fmt, args...) \
 	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #endif
-- 
2.49.0


