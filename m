Return-Path: <linux-btrfs+bounces-3899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A146897C71
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 01:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C341C20929
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 23:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A47159575;
	Wed,  3 Apr 2024 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TCXSPcEG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5515920B
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187740; cv=none; b=u1n3rxBWVRyYps/TGt7TRMiEn3jSzBXSoh0mjt21vnTiQjTvXObD5d2nz7A1OE998QZnZR04VBaq1wLqdqNtlrG70agF4hIFz9oM7+SgJXFe+QO0u1sRceyDPPxDSPw95y39XNC7Gv1IXaXqhGt/9T/nQvLSjSFEC26byUKHgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187740; c=relaxed/simple;
	bh=Ro7hE4VUsJPLfFkiXY8/dnlqWKCOzAOmItOzA+J0UmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwjAHjtzggn1RKM+S/VykVAug1ifu1nfWFOxCeAUmkQhV9785CzBrkbVsxApWNpndMBe4YWqqil95WCc6KEcYqykfFeQZtxhUWX6RqUcxq/wXpbqmGkTz6IMtawo/g0BX6OZzcDzAcC5yVkLUESGb5b2wqQKy7ldWjL4uT8tXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TCXSPcEG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 812295D2E9
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712187736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewwPa6FpyyaCp0GPc93wSPwcCdvCNpINfOlw2+4tJl4=;
	b=TCXSPcEGcqE0dh3MJuJKdImjlTvvRw84e7UrAVFL07J0afBZgR5/YHS9OGo+vzzfVEjGfV
	+u1ZLnJzbdOY7noAT4h56qYqa3uZRK3lNL4Ha4m6Rw/H34QRQBqvqfxAt7QAnQf0Bia4pp
	AfKjD+DR/5BZ+O4P1QW83MxlgZqjPJ0=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AB4431331E
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WE+RF1fpDWalfQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 03 Apr 2024 23:42:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: add extra comments on extent_map members
Date: Thu,  4 Apr 2024 10:11:59 +1030
Message-ID: <98da90ba55445f69030a7664ae5029d710e4efbd.1712187452.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712187452.git.wqu@suse.com>
References: <cover.1712187452.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.77
X-Spamd-Result: default: False [1.77 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_SPAM_SHORT(0.87)[0.289];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Flag: NO

The extent_map structure is very critical to btrfs, as it is involved
for both read and write paths.

Unfortunately the structure is not properly explained, making it pretty
hard to understand nor to do further improvement.

This patch adds extra comments explaining the major members based on
my code reading.
Hopefully we can find more members to cleanup in the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.h | 54 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 10e9491865c9..82768288c6da 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -35,19 +35,71 @@ enum {
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
+	 * offsetof(struct , disk_bytenr) thus
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
+	 *
+	 * For non-compressed extents, this matches orig_block_len.
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


