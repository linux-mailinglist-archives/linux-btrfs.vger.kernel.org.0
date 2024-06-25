Return-Path: <linux-btrfs+bounces-5951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C068C915DF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 07:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2401C221F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 05:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C9B1448F6;
	Tue, 25 Jun 2024 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jpOmgBrq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jpOmgBrq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D2143890
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292087; cv=none; b=FwR3/ojzw3f7nEkvVk9vCTr45yTgYXLp4AeeELvT6/o6uw2qUoz7t3NxjsS3oPWSi5/3wRZHax9pQCL6d8v3kdVsyKdbT0Zv9B+Js/ewDYZzajfBVkgxN/raORi14tW2nYxZq5EyHObnCjxSGrRN9s3c459+rd0VCRQQu3ZZ3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292087; c=relaxed/simple;
	bh=MsXfub5zhmU5wQKzQO19fvSw5awOSW9jNG1nd8jscS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXWrutpc1+70X6+qJsn8SHw1+j9/6mvFwDr4btDNqkzY6vCwpXIV2ZDbTHjk63wgaXP7I0/gbK+61Qw+4DP0aMQC5new5XerG8JbdsjPBPgqDayYeFQNYgw5/+9pCrJtCEXmwgijEdYx7ZBtNG1c9KsNqx2ZyOWaJFnGWQvsg+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jpOmgBrq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jpOmgBrq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26D04219A0
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719292078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GT6Z73B/0OpuFH1c08BhUqpfsJDHBPKnDQHVFws/m4=;
	b=jpOmgBrqtBPD3u6cVvGcUHMwPbQXIGczYWUInTOY17g7Ag1suXoxjcZM7TywGQ8wWaPzgH
	lp69rXqLGMuiPgGbnQyr68YSqDTxBTwzJ9sbEuk5/VvVoBJQ328me9eL+Yr/kgLE3IR2IU
	MvMdct4yKVrycflJa4xZyrnwKLx63hw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jpOmgBrq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719292078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GT6Z73B/0OpuFH1c08BhUqpfsJDHBPKnDQHVFws/m4=;
	b=jpOmgBrqtBPD3u6cVvGcUHMwPbQXIGczYWUInTOY17g7Ag1suXoxjcZM7TywGQ8wWaPzgH
	lp69rXqLGMuiPgGbnQyr68YSqDTxBTwzJ9sbEuk5/VvVoBJQ328me9eL+Yr/kgLE3IR2IU
	MvMdct4yKVrycflJa4xZyrnwKLx63hw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4160E1384C
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qClOOqxQembqdgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: fix the ram_bytes assignment for truncated ordered extents
Date: Tue, 25 Jun 2024 14:37:29 +0930
Message-ID: <0bd7715ef04abbfca4b97137b5b197333f2eb227.1719291793.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719291793.git.wqu@suse.com>
References: <cover.1719291793.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 26D04219A0
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[BUG]
After adding extra checks on btrfs_file_extent_item::ram_bytes to
tree-checker, running fsstress with multiple threads can lead to
tree-checker warning at write time, as we created file extent items with
ram_bytes.

All those offending file extents have offset 0, and ram_bytes matching
num_bytes, and smaller than disk_num_bytes.

This would also trigger the recently enhanced btrfs-check, which would
catch such mismatch and report them as minor errors.

[CAUSE]
When a folio/page is invalidated and it is part of a submitted OE, we
mark the OE truncated just to the beginning of the folio/page.

And for truncated OE, we insert the file extent item with incorrect
value for ram_bytes (using num_bytes instead of the usual value).

This is not a big deal for end users, as we do not utilize the ram_bytes
field for regular non-compressed extents.
This mismatch is just a small violation against on-disk format.

[FIX]
Fix it by removing the override on btrfs_file_extent_item::ram_bytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d6c43120c5d3..45f77ae8963f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3018,10 +3018,8 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi,
 						   oe->disk_num_bytes);
 	btrfs_set_stack_file_extent_offset(&stack_fi, oe->offset);
-	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags)) {
+	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags))
 		num_bytes = oe->truncated_len;
-		ram_bytes = num_bytes;
-	}
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
-- 
2.45.2


