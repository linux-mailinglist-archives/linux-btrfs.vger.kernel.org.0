Return-Path: <linux-btrfs+bounces-19052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A858BC62B99
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CF73AE225
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5193191BF;
	Mon, 17 Nov 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f4WQBjz9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QBthAaYv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661431771B
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364684; cv=none; b=Z1+0TykbHDYtKmxKORwLwtGTiSawpF0e2dSU+qwOnYnVwiIsgXWw6X2sC2IXkWb+JmOpbiVrSRWBwjjVT992QhZibuW561V35LyWhQb/ZivMZqdeH2yxx8rNrQhW/HVgbR99d0gJG1xyIvurSkvw5fJLud+GiyqBrJt27GV28iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364684; c=relaxed/simple;
	bh=OehYOa4o+Te4hIYxzDlDu7BNS3XX6FfB0b5sRi8XHLw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzkNiL83ORI3VwEFHUxMYJ0nnZLitve3iH+nYePgs4eC8Toc3UyBpR+EyruZHwUi7uhYYjPGkyV8V7Ehvue7xH0IWFG+W6rF6zamjqXPA5hamEsnQEBQow6kQemB9mH0kangg0IrkvneAKy+rn0S3hM5PvYwO/a4nKMdD72WF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f4WQBjz9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QBthAaYv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4B8F1F78E
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rd1kQ1UIWecPIxZM0kFp8q+DMRl2CkR3lELdefiBGqA=;
	b=f4WQBjz9K7k0yzdy1gCdQvPlQbck7LJ5Ao9FN8c6NbvvIWH9NQWDlpbhYs+8ze7LwzITL9
	6vo22nx+4VPCMOKWf4ZylXBsM+vl2QFDxEAqJATera6AVFKmd9xQABZosTmHswyytnA6Vt
	y9McSFy70j+WWt3Ua2bTfexTIarS2EA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QBthAaYv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rd1kQ1UIWecPIxZM0kFp8q+DMRl2CkR3lELdefiBGqA=;
	b=QBthAaYvcMxaRSenEnjwnzTk7Cd3ed3D8QLXgknn64SPub1WsMIXNaGBRjbxBEfG+YdwD4
	GMbvWcarFPRQZeL3CtctlPkR2NsxafWdTp0abxyZK+Pb9kAG3I62Zl2eRCQwsTEL0NtPH3
	Iw8mSznv+Cnbe1FcWrYG0Ng4+vSs77w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A9A63EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UCd3Lz/PGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/12] btrfs: add an overview for the btrfs_raid_bio structure
Date: Mon, 17 Nov 2025 18:00:41 +1030
Message-ID: <25445b78325e0fef24af4c57cbf5ef088f77e68d.1763361991.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: C4B8F1F78E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

The structure needs to track both the pages from higher layer bio and
internal pages, thus it can be a little complex to grash.

Add an overview of the structure, especially how we track different
pages from higher layer bios and internal ones, to save some time for
future developers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.h | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 42a45716fb03..87b0c73ee05b 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -24,6 +24,77 @@ enum btrfs_rbio_ops {
 	BTRFS_RBIO_PARITY_SCRUB,
 };
 
+/*
+ * Overview of btrfs_raid_bio.
+ *
+ * One btrfs_raid_bio represents a full stripe of RAID56, including both data
+ * and P/Q stripes.
+ * For now, each data and P/Q stripe is in fixed length (64K).
+ *
+ * One btrfs_raid_bio can have one or more bios from higher layer, covering
+ * part or all of the data stripes.
+ *
+ * [PAGES FROM HIGHER LAYER BIOS]
+ * Higher layer bios are in the btrfs_raid_bio::bio_list.
+ *
+ * Pages from the bio_list are represented like the following.
+ *
+ *
+ * bio_list:	     |<- Bio 1 ->|             |<- Bio 2 ->|  ...
+ * bio_paddrs:	    [0]   [1]   [2]    [3]    [4]    [5]      ...
+ *
+ * If there is a bio covering a sector (one btrfs fs block), the corresponding
+ * pointer in btrfs_raid_bio::bio_paddrs[] will point to the physical address
+ * (with the offset inside the page) of the corresponding bio.
+ *
+ * If there is no bio covering a sector, then btrfs_raid_bio::bio_paddrs[i] will
+ * be INVALID_PADDR.
+ *
+ * The length of each entry in bio_paddrs[] is sectorsize.
+ *
+ * [PAGES FOR INTERNAL USAGES]
+ * For pages not covered by any bio or belonging to P/Q stripes, they are stored
+ * in btrfs_raid_bio::stripe_pages[] and stripe_paddrs[], like the following:
+ *
+ * stripe_pages:       |<- Page 0 ->|<- Page 1 ->|  ...
+ * stripe_paddrs:     [0]    [1]   [2]    [3]   [4] ...
+ *
+ * stripe_pages[] array stores all the pages covering the full stripe, including
+ * data and P/Q pages.
+ * stripe_pages[0] is the first page of the first data stripe.
+ * stripe_pages[BTRFS_STRIPE_LEN / PAGE_SIZE] is the first page of the second data stripe.
+ *
+ * Some pointers inside stripe_pages[] can be NULL, e.g. for a full stripe write
+ * (the bio covers all data stripes) there is no need to allocate pages for
+ * data stripes (can grab from bio_paddrs[]).
+ *
+ * If the corresponding page of stripe_paddrs[i] is not allocated, the value of
+ * stripe_paddrs[i] will be INVALID_PADDR.
+ *
+ * The length of each entry in stripe_paddrs[] is sectorsize.
+ *
+ * [LOCATING A SECTOR]
+ * To locating a sector for IO, we need the following info:
+ *
+ * - stripe_nr
+ *   Starts from 0 (representing the first data stripe), ends at
+ *   @nr_data (RAID5, P stripe) or @nr_data + 1 (RAID6, Q stripe).
+ *
+ * - sector_nr
+ *   Starts from 0 (representing the first sector of the stripe), ends
+ *   at BTRFS_STRIPE_LEN / sectorsize - 1.
+ *
+ *   All existing bitmaps are based on sector numbers.
+ *
+ * - from which array
+ *   Whether grabbing from stripe_paddrs[] (aka, internal pages) or from the
+ *   bio_paddrs[] (aka, from the higher layer bios).
+ *
+ * For IO, a physical address is returned, so that we can extract the page and
+ * the offset inside the page for IO.
+ * A special value INVALID_PADDR represents the physical address is invalid,
+ * normally meaning there is no page allocated for the specified sector.
+ */
 struct btrfs_raid_bio {
 	struct btrfs_io_context *bioc;
 
-- 
2.51.2


