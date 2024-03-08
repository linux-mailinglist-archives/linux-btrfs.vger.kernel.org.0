Return-Path: <linux-btrfs+bounces-3086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B565875D18
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 05:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0635928295E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 04:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8E2CCB3;
	Fri,  8 Mar 2024 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gOtOBPRt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ra6E1tsZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6D32C1A6
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709871690; cv=none; b=iLDRRB6LhTUXoAsbsY9T96vn7941Nqt978VS1K1Ivx15gxEIsZkpcKEU6pfnLK6evaymLiIpZfseapJseWrRlufnR04fCHdyBB/mhZkHYBmOUuwUnesFf3Y+R9Ald+OEvEZJ+Tki7U4up1FYKisNgH8+FU/YNaU/h2u59MFd/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709871690; c=relaxed/simple;
	bh=0mYwC1OzAdEMPdvCCunogEqz97evBKF3eHaKp4clTk8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j23T9IRvtOt33lV/CNbn2KOa1bavk2CEn9ZlDo6W6G5CEDe3B6yLAm++A7Q71X4W2+53SvBIKO1tFuouZm6BAvlxHKsrbGId7XOCyRGi/WrFl+W7xfRkYuAP3V7OYV4IN+4M7ewpDaWly6NDcf/y6Gw5PlICjrbqrSFNwprg8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gOtOBPRt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ra6E1tsZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC01B5D8CB;
	Fri,  8 Mar 2024 03:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709868382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0X5qbkgJ+5Xs+YLJtN4H9ii7T9pqtu+SDRgXIfQht8=;
	b=gOtOBPRtPOyE8tzWOpOKACPQW5W+KZm0xjbxf23mVWihc2eZc6o8QXhof8wnv8J3GbNJOA
	3n5XU2DfqyeFKbRmZquW+rKsqBKUIvqeQD9D2ctTXK1B52KxpGjrb28TVz5oiRTUPzDjtR
	VjDBMiq/5VYZY1GgClXAJPl9auU4rrU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709868381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0X5qbkgJ+5Xs+YLJtN4H9ii7T9pqtu+SDRgXIfQht8=;
	b=ra6E1tsZ6gAZ38I+BjUi7Gd+vMrZV6X1IiZb/6gswzdjzbgzlI+qWJ05hMYaPpi6pBQN5N
	UGy5DrCJPf+5ve1cjnV9SJSgC9uHKJHQX4sDnKHT8HCx9tfbpC8ioyPCN5k7RQ5d+MmPXQ
	oTQY+zni1gzYyx8t91ryasndRJwqjpo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AB1C71391D;
	Fri,  8 Mar 2024 03:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yLczGlyF6mW6dQAAn2gu4w
	(envelope-from <wqu@suse.com>); Fri, 08 Mar 2024 03:26:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	michel.palleau@gmail.com
Subject: [PATCH 1/2] btrfs: extract the stripe length calculation into a helper
Date: Fri,  8 Mar 2024 13:55:59 +1030
Message-ID: <a811f9535fe4fcac68f1a349dd89e600cc15b691.1709867186.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709867186.git.wqu@suse.com>
References: <cover.1709867186.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ra6E1tsZ
X-Spamd-Result: default: False [1.97 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.72)[98.77%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:dkim];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: 1.97
X-Spam-Level: *
X-Rspamd-Queue-Id: EC01B5D8CB
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Currently there are two location which needs to calculate the real
length of a stripe (which can be at the end of a chunk, and the chunk
size may not always be 64K aligned).

Extract them into a helper as we're going to have a third user soon.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c4bd0e60db59..8a21214eca35 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1648,14 +1648,21 @@ static void scrub_reset_stripe(struct scrub_stripe *stripe)
 	}
 }
 
+static u32 stripe_length(struct scrub_stripe *stripe)
+{
+	ASSERT(stripe->bg);
+
+	return min(BTRFS_STRIPE_LEN,
+		   stripe->bg->start + stripe->bg->length - stripe->logical);
+
+}
+
 static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					    struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
-	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
-				      stripe->bg->length - stripe->logical) >>
-				  fs_info->sectorsize_bits;
+	unsigned int nr_sectors = stripe_length(stripe) >> fs_info->sectorsize_bits;
 	u64 stripe_len = BTRFS_STRIPE_LEN;
 	int mirror = stripe->mirror_num;
 	int i;
@@ -1725,9 +1732,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_bio *bbio;
-	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
-				      stripe->bg->length - stripe->logical) >>
-				  fs_info->sectorsize_bits;
+	unsigned int nr_sectors = stripe_length(stripe) >> fs_info->sectorsize_bits;
 	int mirror = stripe->mirror_num;
 
 	ASSERT(stripe->bg);
-- 
2.44.0


