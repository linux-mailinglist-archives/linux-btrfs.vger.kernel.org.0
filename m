Return-Path: <linux-btrfs+bounces-3945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D08993DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 05:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AE31C21D0C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C551CD23;
	Fri,  5 Apr 2024 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SYcnOB31";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SYcnOB31"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4521A26E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287657; cv=none; b=VqgeIG2i+ga/FAMpET7p2BSH3FACAr3qnglxiu4xCgcH2O0IGTgTWhw/nCyN3kIMUowjYayLeBwvwHahJyHzBvfP+NSu0ljVqo0TliWWrQIVx7EuMb/O7FnPnpKW6+6a8DGZ5ousYelnDF2aO0brI9PUVjqeIusMPbrhdtcgMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287657; c=relaxed/simple;
	bh=id7LKYXYpUjmOi+KLXGHM2f/RKJuOx6r0JcK1fEOVYQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kc/XPKhS4a16JgYcRPqA0etKpTzegvoh16XFONFAND+jghR52gbcKMvEP5wcgqGbWXnuV4X3ypXOCfA4yphRj2xuhV55JeDPUGe+nseTuE8nqvyH6X0pr34KV622pyopxe+JxRhst/4pM0d3RaUfEXCEU6o0TyELuHFwPzuRmzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SYcnOB31; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SYcnOB31; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B3DD1F46E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712287654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeHLC3/1RtcDrmGbRK+C7+IpV09a8iXG8x64UQFPl1U=;
	b=SYcnOB31K4yMhONsecefJQsSohRcXbZOvRw+dJ6nnQiqXwhA45RTECZ533aAOaGtokYNuc
	ApfgwDHWRqLGXPyZdZulr6n6+bQdfHNZg9t6+2gIDzlfpVoa668eksIcxdtY9nyGI3W+Nd
	eFc0lM19OPzaKOIKnLUOauoXHcUvq64=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SYcnOB31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712287654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeHLC3/1RtcDrmGbRK+C7+IpV09a8iXG8x64UQFPl1U=;
	b=SYcnOB31K4yMhONsecefJQsSohRcXbZOvRw+dJ6nnQiqXwhA45RTECZ533aAOaGtokYNuc
	ApfgwDHWRqLGXPyZdZulr6n6+bQdfHNZg9t6+2gIDzlfpVoa668eksIcxdtY9nyGI3W+Nd
	eFc0lM19OPzaKOIKnLUOauoXHcUvq64=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 26E71139E8
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qOSvNqRvD2a+aQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 03:27:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: add extra comments on extent_map members
Date: Fri,  5 Apr 2024 13:57:11 +1030
Message-ID: <261cf7744120a2312ce2cdb22dbbfe439a11268a.1712287421.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712287421.git.wqu@suse.com>
References: <cover.1712287421.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1B3DD1F46E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

The extent_map structure is very critical to btrfs, as it is involved
for both read and write paths.

Unfortunately the structure is not properly explained, making it pretty
hard to understand nor to do further improvement.

This patch adds extra comments explaining the major members based on
my code reading.
Hopefully we can find more members to cleanup in the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.h | 52 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 10e9491865c9..0b938e12cc78 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -35,19 +35,69 @@ enum {
 };
 
 /*
+ * This structure represents file extents and holes.
+ *
  * Keep this structure as compact as possible, as we can have really large
  * amounts of allocated extent maps at any time.
  */
 struct extent_map {
 	struct rb_node rb_node;
 
-	/* all of these are in bytes */
+	/* All of these are in bytes. */
+
+	/* File offset matching the offset of a BTRFS_EXTENT_ITEM_KEY key. */
 	u64 start;
+
+	/*
+	 * Length of the file extent.
+	 *
+	 * For non-inlined file extents it's btrfs_file_extent_item::num_bytes.
+	 * For inline extents it's sectorsize, since inline data starts at
+	 * offsetof(struct btrfs_file_extent_item, disk_bytenr) thus
+	 * btrfs_file_extent_item::num_bytes is not valid.
+	 */
 	u64 len;
+
+	/*
+	 * The file offset of the original file extent before splitting.
+	 *
+	 * This is an in-memory only member, matching
+	 * extent_map::start - btrfs_file_extent_item::offset for
+	 * regular/preallocated extents. EXTENT_MAP_HOLE otherwise.
+	 */
 	u64 orig_start;
+
+	/*
+	 * The full on-disk extent length, matching
+	 * btrfs_file_extent_item::disk_num_bytes.
+	 */
 	u64 orig_block_len;
+
+	/*
+	 * The decompressed size of the whole on-disk extent, matching
+	 * btrfs_file_extent_item::ram_bytes.
+	 */
 	u64 ram_bytes;
+
+	/*
+	 * The on-disk logical bytenr for the file extent.
+	 *
+	 * For compressed extents it matches btrfs_file_extent_item::disk_bytenr.
+	 * For uncompressed extents it matches
+	 * btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset
+	 *
+	 * For holes it is EXTENT_MAP_HOLE and for inline extents it is
+	 * EXTENT_MAP_INLINE.
+	 */
 	u64 block_start;
+
+	/*
+	 * The on-disk length for the file extent.
+	 *
+	 * For compressed extents it matches btrfs_file_extent_item::disk_num_bytes.
+	 * For uncompressed extents it matches extent_map::len.
+	 * For holes and inline extents it's -1 and shouldn't be used.
+	 */
 	u64 block_len;
 
 	/*
-- 
2.44.0


