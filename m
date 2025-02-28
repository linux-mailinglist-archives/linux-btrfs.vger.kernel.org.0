Return-Path: <linux-btrfs+bounces-11946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF26A49C65
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB197A52A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B802686A0;
	Fri, 28 Feb 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fiq/HzmU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fiq/HzmU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72126E955
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754187; cv=none; b=ngqKU6fP/oGOkA7eDpKaCDkxTulEvpL2T70LKr+1eCuXhYmz9VtAAOkIr8GnBTNt2utU8h6lvNWyiNYwlV8JcUW8yo8VIu9PK4y9M3IQg0iO6+9Av0G+/WRUFN3FgZzZaOdrM1UXKgPaUyImJVXVAW3PH8GDqKSopXFqcMSbzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754187; c=relaxed/simple;
	bh=MYbZm73snthsqnbsIekkmhN+a7OFBXBVvRq9S3QpnHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6Ng3DP9/wFVBGITlXn44sRlkXIhs4Xo2hOGo93cFwy1ggPVZAdC10wPjPLFec1dlt0CA11B0sHhkkrA49CekSmUU7PFTvQTJqEVT3vgyWkzkG0sd9AECpp0tuQezMP1XN1qCOz1cH01sb523yjvGHLfiCpnxHIE0SWdn9AH774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fiq/HzmU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fiq/HzmU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4F801F38F;
	Fri, 28 Feb 2025 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ful1qHwr6ls1KXScQwIFPOdfqbmf3v3+TgxVMpVFRLM=;
	b=fiq/HzmUBnGfb1a5D6H/3lAZwKZDOd+HqQseM71YZsfoW+97pzWjWAOUZX/2oy478oc09H
	9zYV8PYDrz/k+tLnA9kbumtIT2RW40NbHGNyRYszWXCqx2Qa0U/5T6NJGVJNJ31BfR3pAI
	JQzOBmzX3c7rtZ08VRzU7qNOwGSVdlk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="fiq/HzmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ful1qHwr6ls1KXScQwIFPOdfqbmf3v3+TgxVMpVFRLM=;
	b=fiq/HzmUBnGfb1a5D6H/3lAZwKZDOd+HqQseM71YZsfoW+97pzWjWAOUZX/2oy478oc09H
	9zYV8PYDrz/k+tLnA9kbumtIT2RW40NbHGNyRYszWXCqx2Qa0U/5T6NJGVJNJ31BfR3pAI
	JQzOBmzX3c7rtZ08VRzU7qNOwGSVdlk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE89F137AC;
	Fri, 28 Feb 2025 14:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pZNqMgTNwWdqPQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 28 Feb 2025 14:49:40 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: add secure erase mode to CLEAR_FREE ioctl
Date: Fri, 28 Feb 2025 15:49:36 +0100
Message-ID: <696af7c356b7ddae652be8aa997e40a391c170e6.1740753608.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740753608.git.dsterba@suse.com>
References: <cover.1740753608.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D4F801F38F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Add another type of clearing that will do secure erase on the unused
space.

This requires hardware support and works as a regular discard while also
deleting any copied or cached blocks. Same as "blkdiscard --secure".

The unused space ranges may not be aligned to the secure erase block or
be of a sufficient length, the exact result depends on the device.
Some blocks may still contain valid data even after this ioctl.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c     | 3 +++
 include/uapi/linux/btrfs.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6c45625a293a..e38760fbf324 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1253,6 +1253,9 @@ static int btrfs_issue_clear_op(struct block_device *bdev, u64 start, u64 size,
 	unsigned int flags = BLKDEV_ZERO_KILLABLE;
 
 	switch (clear) {
+	case BTRFS_CLEAR_OP_SECURE_ERASE:
+		return blkdev_issue_secure_erase(bdev, start >> SECTOR_SHIFT,
+						 size >> SECTOR_SHIFT, GFP_NOFS);
 	case BTRFS_CLEAR_OP_DISCARD:
 		return blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					    size >> SECTOR_SHIFT, GFP_NOFS);
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 65700c289140..018f0f1bbd5f 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1097,6 +1097,13 @@ enum btrfs_clear_op_type {
 	 * (Same as blkdev_issue_zeroout() with 0 flags).
 	 */
 	BTRFS_CLEAR_OP_ZERO,
+	/*
+	 * Do a secure erase operation on the range. If supported by the
+	 * underlying hardware, this works as regular discard except that all
+	 * copies of the discarded blocks that were possibly created by
+	 * garbage collection must also be erased.
+	 */
+	BTRFS_CLEAR_OP_SECURE_ERASE,
 	BTRFS_NR_CLEAR_OP_TYPES,
 };
 
-- 
2.47.1


