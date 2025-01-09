Return-Path: <linux-btrfs+bounces-10829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F4BA07322
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE163A82DF
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642EC216E1E;
	Thu,  9 Jan 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uopVmyUp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uopVmyUp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B1215779
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418279; cv=none; b=oRxYfaa46nu6UygcB1ojB+R/DsaAjaHcWVxxVaQH4wxEO9+siaxD0dRsf/h4bdc1qoqxNdnA7gJ5FrH0dOAyT3IX6zixg/PMEVgW1MtmXbU0j2UdocG0dVhKOPHgNFBlCF/i7l/fMMfH91r5cRiRUI+ZnIUgXQxMJ04EF+waOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418279; c=relaxed/simple;
	bh=bmz/9sr79xQe1rwhgTaxijNp2zUoIXBsMXK1XqFBsEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkUXa6HO9QV2YyXLD6vXUxfT02fjx8x/2SJN96yIk5vKIVb9gyT56aSisicS6h+nEuljoJUAllnrGdzWfmY1pXhxZ0qvbvAh5bDDKDxM9dcHAg6MYiEqHtbXgpWtjS0BxGz9XMiKO3BG7o17LNpaCI0L3XpzmwMOZVB6L7h8RcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uopVmyUp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uopVmyUp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3369F1F393;
	Thu,  9 Jan 2025 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1imuzZqKVS1q99DbmkMLxWXv/5vHFR0lTUMpxwmDz4=;
	b=uopVmyUpxKJz2whGKd++3iy/8RNdThvob7mtV+BDiGrX4AOQ75FEAueWdaqrVsqtIHMr6L
	4/Ajs4rNJcLxFRBH6ec98nlhoxc8tM3pBdq44EU3hP9pOHIFtMf/kLoO4SxMJ9iY8CuhOc
	T49vR0Ax/qcuFERa56fTHHVHCDT9zJY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1imuzZqKVS1q99DbmkMLxWXv/5vHFR0lTUMpxwmDz4=;
	b=uopVmyUpxKJz2whGKd++3iy/8RNdThvob7mtV+BDiGrX4AOQ75FEAueWdaqrVsqtIHMr6L
	4/Ajs4rNJcLxFRBH6ec98nlhoxc8tM3pBdq44EU3hP9pOHIFtMf/kLoO4SxMJ9iY8CuhOc
	T49vR0Ax/qcuFERa56fTHHVHCDT9zJY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C150139AB;
	Thu,  9 Jan 2025 10:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NLHACuSjf2dgEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:36 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 13/18] btrfs: change return type to bool type of check_eb_alignment()
Date: Thu,  9 Jan 2025 11:24:35 +0100
Message-ID: <43bc1bd4699aef2764f8475b5b8cb0f73ae4da43.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
References: <cover.1736418116.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The check function pattern is supposed to return true/false, currently
there's only one error code.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ad1e54ab665e..86f6a87665f5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2844,11 +2844,14 @@ static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info, s
 	return NULL;
 }
 
-static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
+/*
+ * Validate alignment constraints of eb at logical address @start.
+ */
+static bool check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 {
 	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
 		btrfs_err(fs_info, "bad tree block start %llu", start);
-		return -EINVAL;
+		return true;
 	}
 
 	if (fs_info->nodesize < PAGE_SIZE &&
@@ -2856,14 +2859,14 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 		btrfs_err(fs_info,
 		"tree block crosses page boundary, start %llu nodesize %u",
 			  start, fs_info->nodesize);
-		return -EINVAL;
+		return true;
 	}
 	if (fs_info->nodesize >= PAGE_SIZE &&
 	    !PAGE_ALIGNED(start)) {
 		btrfs_err(fs_info,
 		"tree block is not page aligned, start %llu nodesize %u",
 			  start, fs_info->nodesize);
-		return -EINVAL;
+		return true;
 	}
 	if (!IS_ALIGNED(start, fs_info->nodesize) &&
 	    !test_and_set_bit(BTRFS_FS_UNALIGNED_TREE_BLOCK, &fs_info->flags)) {
@@ -2871,10 +2874,9 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 "tree block not nodesize aligned, start %llu nodesize %u, can be resolved by a full metadata balance",
 			      start, fs_info->nodesize);
 	}
-	return 0;
+	return false;
 }
 
-
 /*
  * Return 0 if eb->folios[i] is attached to btree inode successfully.
  * Return >0 if there is already another extent buffer for the range,
-- 
2.47.1


