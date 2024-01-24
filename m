Return-Path: <linux-btrfs+bounces-1670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A4783A050
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 04:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C0D1C24062
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 03:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F1BBE61;
	Wed, 24 Jan 2024 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cC+46f//";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cC+46f//"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1826FBB
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706068758; cv=none; b=IQM8vDGyDmL+WEyhPkpTkiQ2THvtScSquic/N5TkpB99POuudKEbX49ZymAnUl9FLA1hNjDdbOKTVHmRF6n8Er4FiC3DfVEuuIXtZwLDV9zKmOuH6SPOAHj35wnaZM9EBnboswM9ImLJ2ZOAvwp2RIoKkt3z+Sfl67EPz5qeBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706068758; c=relaxed/simple;
	bh=VBu7zON8y2koFrYH7PDw6UwYx6s/3ZoJ1u/7uGfmqYM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFuNfvw1ee/MXsXMhZlHCoECrt0qpWgzpnRNYcGdt+yg4ZxTCWCFekEH5/4D94Lq8+yP8qm7KVRwQpkcSTra4uDuXs0vCoYwqu2MMlcPLXr7Gojp1R4b9fs8P2rzU6sDrRGkUK5TIUAnhbzUAsMxqQdBTGp2taE0otcbK4SG8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cC+46f//; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cC+46f//; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D1781FCFE
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706068754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B79Wb/a88kKQDsHb0Rzog+AsHil/VLQ0EF7Cai/2rcE=;
	b=cC+46f//ORWfiwMXiCRmMDPMfwJVQlgmFjo4n/XtjSp+znQDrox1U5l+80YlbwHQrIkO92
	0cRrziv3K3mmrSi+tbgM/k8ZpwVvvRqF2KmGSOmX6xmW0IynKKYAd5bH+9Qunx5rU1TNC1
	MIJm/xY246kQr/KuIKwuhcu4MGYQ4BI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706068754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B79Wb/a88kKQDsHb0Rzog+AsHil/VLQ0EF7Cai/2rcE=;
	b=cC+46f//ORWfiwMXiCRmMDPMfwJVQlgmFjo4n/XtjSp+znQDrox1U5l+80YlbwHQrIkO92
	0cRrziv3K3mmrSi+tbgM/k8ZpwVvvRqF2KmGSOmX6xmW0IynKKYAd5bH+9Qunx5rU1TNC1
	MIJm/xY246kQr/KuIKwuhcu4MGYQ4BI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39682136F5
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0C/HOBCLsGXVLgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/2] btrfs: introduce cached folio size
Date: Wed, 24 Jan 2024 14:29:07 +1030
Message-ID: <c3592c3fb3f0ab10e2296be285d7cb7f703ec377.1706068026.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706068026.git.wqu@suse.com>
References: <cover.1706068026.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

For the future multipage sectorsize support (sectorsize > PAGE_SIZE), we
want to fully utilize folio interface, thus making every data sector to
be represented by a folio.

However this would lead to a small problem that multipage and subpage
support would have every different folio size expectation.

For subpage, since folio can not be smaller than a page, one folio would
always be page sized.
But for multiplage, each folio would be sector sized.

For callsites directly handling pages/folios (aka, all read/write paths)
we don't want to do such check every time we got a folio.
So instead we cache the data folio size and its shift into
btrfs_fs_info.

This would make later folio conversion easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 11 +++++++++++
 fs/btrfs/fs.h      | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 51c6127508af..429fb95320ec 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2813,6 +2813,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->sectorsize = 4096;
 	fs_info->sectorsize_bits = ilog2(4096);
 	fs_info->stripesize = 4096;
+	fs_info->folio_size = PAGE_SIZE;
+	fs_info->folio_shift = PAGE_SHIFT;
 
 	/* Default compress algorithm when user does -o compress */
 	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
@@ -3306,6 +3308,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
+	if (sectorsize > PAGE_SIZE) {
+		/* For future multi-page sectorsize support */
+		fs_info->folio_size = sectorsize;
+		fs_info->sectorsize_bits = fs_info->sectorsize_bits;
+	} else {
+		fs_info->folio_size = PAGE_SIZE;
+		fs_info->folio_shift = PAGE_SHIFT;
+	}
+
 	/*
 	 * Handle the space caching options appropriately now that we have the
 	 * super block loaded and validated.
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f8bb73d6ab68..52f67bf71ba5 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -750,6 +750,16 @@ struct btrfs_fs_info {
 	u32 csums_per_leaf;
 	u32 stripesize;
 
+	/*
+	 * For future subpage and multipage sectorsize support.
+	 *
+	 * For subpage, all of our data folios would still be PAGE_SIZE.
+	 * But for multipage, those data folios would be sector sized.
+	 * This is the cached result to read/write path to utilize.
+	 */
+	u32 folio_size;
+	u32 folio_shift;
+
 	/*
 	 * Maximum size of an extent. BTRFS_MAX_EXTENT_SIZE on regular
 	 * filesystem, on zoned it depends on the device constraints.
-- 
2.43.0


