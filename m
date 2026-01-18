Return-Path: <linux-btrfs+bounces-20660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A85D392E9
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 06:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC07301E1B4
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 05:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670E17B425;
	Sun, 18 Jan 2026 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="afgZluFP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="afgZluFP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B51D6AA
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768714244; cv=none; b=SDAUxhbyFKbAgwxnS7NO36Vf75Z9HOA7vdfran86zsweIUfPDYswyQOOACd6UYV7uY0TkCW8E+eJt2LkChmUEKbnqjgGjDVQZKxyfEWjpBl+t6A9u19FydRsPaxrEGHDBpZixLhmp3ApfmcnDidzuaSIoVXVtW2Bou5ddDG6fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768714244; c=relaxed/simple;
	bh=7GEWBsq4EVhEZ1SMneCR9nx1B6Vx06e7AZNBDpcEyIY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tww7/mAVke8cyNPJuecwQJnIHlffUtK8AsneQsZ0Mi+afKMeR0qUS7Ws/MDjCiBcVLeHJmN7+QTMATVzm+weWAboUpkz/u4S0QU9b+bUqkGQNPY0s8N6fHbM75rN20H23K3qn0yEOr4vralc1kPGzjY+2/awkMjgv/rkDT8BeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=afgZluFP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=afgZluFP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5B185BCC5
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768714228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Azmoo4Pr3NVJwVXLJhYLqLhuu7okKeWsjb0KLxqvN3E=;
	b=afgZluFPAMFIDcpDpdupO5h0r2/xkWnu99tNyD5oQVHi8qmCYn6WhSdrqiI2ltSccN8Yu0
	QlmmbZv6osw1EaeseZxlzn7DVyPaAFLKhwdzRnPEziyHUfn8eQb+iWdMiIMj8t9j7+z3R3
	zkV321GBz0Mxyu5fnbE0E7qZRQgY8LM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=afgZluFP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768714228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Azmoo4Pr3NVJwVXLJhYLqLhuu7okKeWsjb0KLxqvN3E=;
	b=afgZluFPAMFIDcpDpdupO5h0r2/xkWnu99tNyD5oQVHi8qmCYn6WhSdrqiI2ltSccN8Yu0
	QlmmbZv6osw1EaeseZxlzn7DVyPaAFLKhwdzRnPEziyHUfn8eQb+iWdMiIMj8t9j7+z3R3
	zkV321GBz0Mxyu5fnbE0E7qZRQgY8LM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C85EF3EA63
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4Be4HfNvbGnScQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: add strict extent map alignment checks
Date: Sun, 18 Jan 2026 16:00:00 +1030
Message-ID: <dd1a7815d7993344949f5dda84f44ac083ea349b.1768714131.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768714131.git.wqu@suse.com>
References: <cover.1768714131.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.01
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C5B185BCC5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Currently we do not check the alignment of extent_map structure.

One of the reason is, the existing self tests for inode and extent-map
will not pass.

However that test failure comes from two reasons:

- We have invalid cases in the self tests
  Those cases will be rejected by tree-checkers, and no one is really
  bothering removing the those cases, due to how hard to modify the test
  cases.

- Some test cases is always 4K block sized based but the fs_info is not
  properly initialized to reflect that

Thankfully those legacy problems are properly addressed by previous
patches, now we can finally put the alignment checks into
validate_extent_map().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 7e38c23a0c1c..07a7bd426c84 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -319,8 +319,15 @@ static void dump_extent_map(struct btrfs_fs_info *fs_info, const char *prefix,
 /* Internal sanity checks for btrfs debug builds. */
 static void validate_extent_map(struct btrfs_fs_info *fs_info, struct extent_map *em)
 {
+	const u32 blocksize = fs_info->sectorsize;
+
 	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
 		return;
+
+	if (!IS_ALIGNED(em->start, blocksize) ||
+	    !IS_ALIGNED(em->len, blocksize))
+		dump_extent_map(fs_info, "unaligned shared members", em);
+
 	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
 		if (em->disk_num_bytes == 0)
 			dump_extent_map(fs_info, "zero disk_num_bytes", em);
@@ -334,6 +341,11 @@ static void validate_extent_map(struct btrfs_fs_info *fs_info, struct extent_map
 			dump_extent_map(fs_info,
 		"ram_bytes mismatch with disk_num_bytes for non-compressed em",
 					em);
+		if (!IS_ALIGNED(em->disk_bytenr, blocksize) ||
+		    !IS_ALIGNED(em->disk_num_bytes, blocksize) ||
+		    !IS_ALIGNED(em->offset, blocksize) ||
+		    !IS_ALIGNED(em->ram_bytes, blocksize))
+			dump_extent_map(fs_info, "unaligned members", em);
 	} else if (em->offset) {
 		dump_extent_map(fs_info, "non-zero offset for hole/inline", em);
 	}
-- 
2.52.0


