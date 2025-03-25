Return-Path: <linux-btrfs+bounces-12575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A6A706FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 17:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0B818944EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFA25E476;
	Tue, 25 Mar 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O9V8YbJN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O9V8YbJN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62025BAA9
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920325; cv=none; b=VPadW5mKnjgir1zF0TBG2cPLNjZepoqsEWmJKFRU4YYPaUvL+0lyJNX7IX4c0Lj6BCpPlXJC7FL/89NbtShceHfWT1KwXJKmYYYZC8/z/9AH8MtKZUfmhSPZWFZ2O2Em6fLECvIkjw5Pucp37Epf0hj4bVlC7yP8taXwIN65ClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920325; c=relaxed/simple;
	bh=1lUBDOMjGRWOmxPvFs5znjh0mb0E2PnhADSXXo8+JIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPUUJKDv8v1vjabvzka1eKLFA1104nCHc+6w/HmBrQLzXwkd7zsOOT6vEvYSBCfjVxH3NiEZd95WvO/nXavnccMptj1S3dd2kSv6mLWA+jgLCeqgKEqJYC674S7G7nqHYa9+s+EYmTlqr39hsShI5g1Zee682T1hj3PhBe3+rgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O9V8YbJN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O9V8YbJN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E608E2117A;
	Tue, 25 Mar 2025 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742920313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbrZ4qWuclqXy+jQrZfUmrppCeFvyI6i+H+SgRajnyU=;
	b=O9V8YbJNIQsAyvCEj4tCyQ9W0TOqGwCvLKpJg6Un1jO9Ez+mPM+EXMWj1a7FE27D5Y63p5
	7ByAt80C7QPNX1bhcHOS354JiSwL1cPGl3qMIk/PvpqD9AwjZGh1PTCbmoOYRkG9UoDIaZ
	tcUznQ3C7wNNI7/TvT6LGoQWnCQddOI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742920313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbrZ4qWuclqXy+jQrZfUmrppCeFvyI6i+H+SgRajnyU=;
	b=O9V8YbJNIQsAyvCEj4tCyQ9W0TOqGwCvLKpJg6Un1jO9Ez+mPM+EXMWj1a7FE27D5Y63p5
	7ByAt80C7QPNX1bhcHOS354JiSwL1cPGl3qMIk/PvpqD9AwjZGh1PTCbmoOYRkG9UoDIaZ
	tcUznQ3C7wNNI7/TvT6LGoQWnCQddOI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCECD137AC;
	Tue, 25 Mar 2025 16:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YBh0MXna4meDSQAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 25 Mar 2025 16:31:53 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] btrfs: cleanup EXTENT_BUFFER_READ_ERR flag
Date: Tue, 25 Mar 2025 17:31:36 +0100
Message-ID: <20250325163139.878473-2-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250325163139.878473-1-neelx@suse.com>
References: <20250325163139.878473-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This flag was added by commit 656f30dba7ab ("Btrfs: be aware of btree inode
write errors to avoid fs corruption") but it stopped being used after commit
046b562b20a5 ("btrfs: use a separate end_io handler for read_extent_buffer").

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/extent_io.c | 7 ++-----
 fs/btrfs/extent_io.h | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b168dc354f20b..578195959f7cb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3651,12 +3651,10 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
 	    btrfs_validate_extent_buffer(eb, &bbio->parent_check) < 0)
 		uptodate = false;
 
-	if (uptodate) {
+	if (uptodate)
 		set_extent_buffer_uptodate(eb);
-	} else {
+	else
 		clear_extent_buffer_uptodate(eb);
-		set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
-	}
 
 	clear_extent_buffer_reading(eb);
 	free_extent_buffer(eb);
@@ -3695,7 +3693,6 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 		return 0;
 	}
 
-	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	eb->read_mirror = 0;
 	check_buffer_tree_ref(eb);
 	atomic_inc(&eb->refs);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 2e261892c7bc7..fb3f5815b28e7 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -44,8 +44,6 @@ enum {
 	EXTENT_BUFFER_TREE_REF,
 	EXTENT_BUFFER_STALE,
 	EXTENT_BUFFER_WRITEBACK,
-	/* read IO error */
-	EXTENT_BUFFER_READ_ERR,
 	EXTENT_BUFFER_UNMAPPED,
 	EXTENT_BUFFER_IN_TREE,
 	/* write IO error */
-- 
2.47.2


