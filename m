Return-Path: <linux-btrfs+bounces-19055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E2C62BA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C58AC35B97C
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB0B318143;
	Mon, 17 Nov 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vCFA1LVn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vCFA1LVn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70DB3191AC
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364694; cv=none; b=olj2h3+dFM5ePSdHa0ale2Uw/UETmLZM7ZwPvFQ1siACrQirSrP3h9KUV4BIUoEgS8ug1nqGxxLAjiFtdEDLZOaF5EHRAmMbyRYxgn6eck/9RYKa5ohlz7YSAd5pSMjr0g9EzmC03XqsN1ydJVxjz8lv9dZX4NuCQaqmdW2YWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364694; c=relaxed/simple;
	bh=/TsgQnTG7kNp7HONfu8z9KJutuN938+c0vzaqTW71f8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+PC8EKQBQKSCfvPclBwVqkszVoEl6mJK4uMr60f6BClx7hEgxCDj9MWl/utEDO9cpj/ZTt+tVOx0/Hym5/iEQXtSeTBrUOW2e6q8c8rGeekChZCC79zBkZ3YZF6Z1VxJDE0LAZDgAEJC/LYaJNk/O1LLAHaL8KKMWsnUXYweO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vCFA1LVn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vCFA1LVn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CB752120B
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5df41I03aeLB6YYblivxtTFEdhC5Q9J+K64owjetwaM=;
	b=vCFA1LVnCIGbD5cW04UJ2Ct40sq48maOqVwroVCkkaPd8zL62LDOIi1JHLtE1qLUQSd6bw
	nxrzKPaAfz1eYJT5iZCVKPaaoJKUWJpkd4GS1oJ2dP2IHhigDWpQnygkzLxs1gn8DbBEly
	KpL+JhgKc2+zLdA3UMP1sprGwRFELQ8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=vCFA1LVn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5df41I03aeLB6YYblivxtTFEdhC5Q9J+K64owjetwaM=;
	b=vCFA1LVnCIGbD5cW04UJ2Ct40sq48maOqVwroVCkkaPd8zL62LDOIi1JHLtE1qLUQSd6bw
	nxrzKPaAfz1eYJT5iZCVKPaaoJKUWJpkd4GS1oJ2dP2IHhigDWpQnygkzLxs1gn8DbBEly
	KpL+JhgKc2+zLdA3UMP1sprGwRFELQ8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 761023EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iEQMDkfPGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/12] btrfs: prepare set_bio_pages_uptodate() to support bs > ps cases
Date: Mon, 17 Nov 2025 18:00:47 +1030
Message-ID: <5d8841e483fb683eac8cb4bd447f0df296830213.1763361991.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3CB752120B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

The function set_bio_pages_uptodate() assume each fs block can be mapped by
one page, blocking bs > ps support for raid56.

Prepare it for bs > ps cases by:

- Update find_stripe_sector_nr() to check only the first step paddr
  We don't need to check each paddr, as the bios are still aligned to fs
  block size, thus checking the first step is enough.

- Use step size to iterate the bio
  This means we only need to find the sector number for the first step
  of each fs block, and skip the remaining part.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 6d9d9d494721..820bdc7f6dbe 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1588,7 +1588,7 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
 static int find_stripe_sector_nr(struct btrfs_raid_bio *rbio, phys_addr_t paddr)
 {
 	for (int i = 0; i < rbio->nr_sectors; i++) {
-		if (rbio->stripe_paddrs[i] == paddr)
+		if (rbio->stripe_paddrs[i * rbio->sector_nsteps] == paddr)
 			return i;
 	}
 	return -1;
@@ -1600,17 +1600,23 @@ static int find_stripe_sector_nr(struct btrfs_raid_bio *rbio, phys_addr_t paddr)
  */
 static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
-	const u32 blocksize = rbio->bioc->fs_info->sectorsize;
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	const u32 step = min(sectorsize, PAGE_SIZE);
+	u32 offset = 0;
 	phys_addr_t paddr;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 
-	btrfs_bio_for_each_block_all(paddr, bio, blocksize) {
-		int sector_nr = find_stripe_sector_nr(rbio, paddr);
+	btrfs_bio_for_each_block_all(paddr, bio, step) {
+		/* Hitting the first step of a sector.*/
+		if (IS_ALIGNED(offset, sectorsize)) {
+			int sector_nr = find_stripe_sector_nr(rbio, paddr);
 
-		ASSERT(sector_nr >= 0);
-		if (sector_nr >= 0)
-			set_bit(sector_nr, rbio->stripe_uptodate_bitmap);
+			ASSERT(sector_nr >= 0);
+			if (sector_nr >= 0)
+				set_bit(sector_nr, rbio->stripe_uptodate_bitmap);
+		}
+		offset += step;
 	}
 }
 
-- 
2.51.2


