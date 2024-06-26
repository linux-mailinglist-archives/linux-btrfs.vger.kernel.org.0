Return-Path: <linux-btrfs+bounces-5981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C49175DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 03:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196AE2828B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F311CABB;
	Wed, 26 Jun 2024 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i1oviwV1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i1oviwV1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BF15EA2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366480; cv=none; b=E8Hv1ywFZwDm8A+s26SUfhWO3+k35ynHQXNo04J1V9GhGhEyltr+7HbEf3ZCWfl/mOw/RjFnGKHcHnrAcHTc1yUoI1tHfVUoPI9JTANxIWASzggYlBmxCG58wTlJSVY5M/WitYlrgFtL+/JFABFZnCT9+cEZzuWU2aQ0d+7noIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366480; c=relaxed/simple;
	bh=pp+A8uiEYDevQniFZ9UeD+Rato/4eaHdHXkAoAskmgY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilyR8Y2ZDEoM6gNbYYUJvHgc8s9nRcmwX23CIS8aeyG4sFYLTnm+sL2HDnKhp/n/oJrbkKEOk5SYPhqeCa2NC0g9y5acYuhmKdCHHTg4lgv3/ZewZYRcYk3v3mAb4Ec3MHn7+h5Xl7DBnEydxN3Wnnji/TeKgGpgrm9oYIg0CGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i1oviwV1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i1oviwV1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B164B1F8C8
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsLI6hWA6UX4P6lAt+UfFDXqutj2w8oYEjDny7F+wn4=;
	b=i1oviwV1Tf83u5/i4GDxHyY5YqLnCA1VSVYctAbHIweCNsjDvmT4w8TAwkfLlAfsH1+Wp/
	SodOztGFGapSXQL4Ol6QIaP+L51mvxmSYJ0Yho6FqCWLA03VHnwZRTsaNqEQoPIaxJzB0n
	B8AaYQmfQl5vtHGwkCavrmFm0j04WQE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=i1oviwV1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsLI6hWA6UX4P6lAt+UfFDXqutj2w8oYEjDny7F+wn4=;
	b=i1oviwV1Tf83u5/i4GDxHyY5YqLnCA1VSVYctAbHIweCNsjDvmT4w8TAwkfLlAfsH1+Wp/
	SodOztGFGapSXQL4Ol6QIaP+L51mvxmSYJ0Yho6FqCWLA03VHnwZRTsaNqEQoPIaxJzB0n
	B8AaYQmfQl5vtHGwkCavrmFm0j04WQE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9D20139C2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eKTIH0pze2ZtbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs: ignore incorrect btrfs_file_extent_item::ram_bytes
Date: Wed, 26 Jun 2024 11:17:30 +0930
Message-ID: <537fc4aabfc15d24166464fe851958b74cb37082.1719366258.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719366258.git.wqu@suse.com>
References: <cover.1719366258.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B164B1F8C8
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Spam-Level: 

[HICCUP]
Kernels can create file extent items with incorrect ram_bytes like this:

	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
		generation 7 type 1 (regular)
		extent data disk byte 13631488 nr 32768
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)

Thankfully kernel can handle them properly, as in that case ram_bytes is
not utilized at all.

[ENHANCEMENT]
Since the hiccup is not going to cause any data-loss and is only a minor
violation of on-disk format, here we only need to ignore the incorrect
ram_bytes value, and use the correct one from
btrfs_file_extent_item::disk_num_bytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2cc61c792ee6..e815fefaffe1 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1306,6 +1306,13 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		if (compress_type != BTRFS_COMPRESS_NONE) {
 			extent_map_set_compression(em, compress_type);
 		} else {
+			/*
+			 * Older kernels can create regular non-hole data
+			 * extents with ram_bytes smaller than disk_num_bytes.
+			 * Not a big deal, just always use disk_num_bytes
+			 * for ram_bytes.
+			 */
+			em->ram_bytes = em->disk_num_bytes;
 			if (type == BTRFS_FILE_EXTENT_PREALLOC)
 				em->flags |= EXTENT_FLAG_PREALLOC;
 		}
-- 
2.45.2


