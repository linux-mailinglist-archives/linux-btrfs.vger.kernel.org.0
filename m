Return-Path: <linux-btrfs+bounces-11969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB74A4B97D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570867A749A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8131EDA08;
	Mon,  3 Mar 2025 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tC2D9rgX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tC2D9rgX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B91EB5D0
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990988; cv=none; b=YUubgO74Eic9598QGmgRVGF93TBGyQTsnUlxvtMflmtSc3m7WgV2kVMbDcSpl/TeNczlae1ZPkxJhZRQOZq+wdY7KzgO6j00p4MsmERRQ1Rz0UySR+mQeOftZDPpnnHQOeQw8OcCBnIHkXpW/ajB5CgL96xDbO8vV/j0B0f0ua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990988; c=relaxed/simple;
	bh=TjTxfrFRhEYDIEKZ4++789WB73xgVRnkm+lkL3DWytk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvEXhq3zgVeebGIySmf0Z9gMfKotTxXFqS21P6ohMZPZJK76CBqiHTgLtfpX4o44z4OPVymTp/wy4CIta2bLDaZmcL9mUyRacfNVO9yF+AnLs9msCuvoAogc7hFneaBh9fxX9VizPBZIiO7gtFo3nLgvxjNtmBmz+/z0VipEXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tC2D9rgX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tC2D9rgX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B40761F399;
	Mon,  3 Mar 2025 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3Z5cn3I4QUQ5nbSE8nIWU2dNcopeHABWkKJiYMuIzU=;
	b=tC2D9rgXJlz0Bde5ldFfZ27yxm/5UCMxptEWVCJmv0GZ+ndScDuVCb4NukpkcYV6jMfSEd
	aIl2LcZ0V43DRWgX5ACDZzQ7VHRR8ZAq9NEjHw3zUXyHRAoMoy5VpHkg5ycThmvJtTUgDW
	6GYOJYEb6n2LvqQl7CYu19Wu70InqeA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3Z5cn3I4QUQ5nbSE8nIWU2dNcopeHABWkKJiYMuIzU=;
	b=tC2D9rgXJlz0Bde5ldFfZ27yxm/5UCMxptEWVCJmv0GZ+ndScDuVCb4NukpkcYV6jMfSEd
	aIl2LcZ0V43DRWgX5ACDZzQ7VHRR8ZAq9NEjHw3zUXyHRAoMoy5VpHkg5ycThmvJtTUgDW
	6GYOJYEb6n2LvqQl7CYu19Wu70InqeA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B45F313939;
	Mon,  3 Mar 2025 08:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOdvHeFpxWdybwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Mar 2025 08:35:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 8/8] btrfs: remove the subpage related warning message
Date: Mon,  3 Mar 2025 19:05:16 +1030
Message-ID: <06a7864ebd56d0d3a4678f47b75287210d329d64.1740990125.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740990125.git.wqu@suse.com>
References: <cover.1740990125.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Since the initial enablement of block size < page size support for
btrfs in v5.15, we have hit several milestones for block size < page
size (subpage) support:

- RAID56 subpage support
  In v5.19

- Refactored scrub support to support subpage better
  In v6.4

- Block perfect (previously requires page aligned ranges) compressed write
  In v6.13

- Various error handling fixes involving subpage
  In v6.14

Finally the only missing feature is the pretty simple and harmless
inlined data extent creation, just added in previous patches.

Now btrfs has all of its features ready for both regular and subpage
cases, there is no reason to output a warning about the experimental
subpage support, and we can finally remove it now.

Acked-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 52c2335ef62f..0cb559448933 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3410,11 +3410,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	fs_info->max_inline = min_t(u64, fs_info->max_inline, fs_info->sectorsize);
 
-	if (sectorsize < PAGE_SIZE)
-		btrfs_warn(fs_info,
-		"read-write for sector size %u with page size %lu is experimental",
-			   sectorsize, PAGE_SIZE);
-
 	ret = btrfs_init_workqueues(fs_info);
 	if (ret)
 		goto fail_sb_buffer;
-- 
2.48.1


