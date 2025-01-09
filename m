Return-Path: <linux-btrfs+bounces-10832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A8A07327
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E373A8F9A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3D218EA3;
	Thu,  9 Jan 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kvhUmQg5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kvhUmQg5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5C218EA7
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418286; cv=none; b=qAcMWRaTzBRlswNQCery97KdyLWm8KDYeDrXZEOM9tvVQpL/haufTJuGNnhJ5npre/J170MRDPx/Sz6NAYY3r4UXZw2il21BjcVa987JobD+3n9jbiG6xXTHHrGxMmgdtUGsgLYxwDenR5aK4pRZzefwSUWHaoXmKJA+JKnFxnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418286; c=relaxed/simple;
	bh=l68gRZxKmxxxbQUl74SQ/2tarz9n5qH7rLzwPxMjW9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz1bUPggBXKqPHXTOpmj74NF/pQYTFy1Ia4XoDkss9rBRA+xKGRQqm14ZaOuy+HevSc+cqc8O2OZ+y/UJEqapsihhWAvcWqTzyqgAMNVLKiA1J4ew1P5E+ypGh8RBdlh4PyTgqmVALcrrcG14M6n/LoUvbKyC4IHCYTGurzZNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kvhUmQg5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kvhUmQg5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 575C11F393;
	Thu,  9 Jan 2025 10:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoR65wGwjK51mniPedyJ7hw1IKTknq+DkPa0qK7Osas=;
	b=kvhUmQg59Y0CkiYj9+bhNOjypXWyO1nR1k0a9blMVBf0fzEDI9ovOxFEMRhKXKzjsOli4e
	ziUDk02ADTMxL0YU+jNlwLVJ+zjgaFFYGOP2MYv8bHmGD8noZh02NTgaGwh7eceD1n3xYW
	8V88ktPyzBmrvV8jZwBegCEkOi/KJ98=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoR65wGwjK51mniPedyJ7hw1IKTknq+DkPa0qK7Osas=;
	b=kvhUmQg59Y0CkiYj9+bhNOjypXWyO1nR1k0a9blMVBf0fzEDI9ovOxFEMRhKXKzjsOli4e
	ziUDk02ADTMxL0YU+jNlwLVJ+zjgaFFYGOP2MYv8bHmGD8noZh02NTgaGwh7eceD1n3xYW
	8V88ktPyzBmrvV8jZwBegCEkOi/KJ98=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F865139AB;
	Thu,  9 Jan 2025 10:24:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cR5mE+ujf2drEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:43 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 16/18] btrfs: split waiting from read_extent_buffer_pages(), drop parameter wait
Date: Thu,  9 Jan 2025 11:24:43 +0100
Message-ID: <177c5312badc87b2d91fecd7ecd0bba081c65d5f.1736418116.git.dsterba@suse.com>
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
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

There are only 2 WAIT_* values left for wait parameter, we can encode
this to the function name if the waiting functionality is split.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c   |  2 +-
 fs/btrfs/extent_io.c | 27 +++++++++++++++++----------
 fs/btrfs/extent_io.h |  7 ++++---
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 04d68f253940..cec38a192dfd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -226,7 +226,7 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
 
 	while (1) {
 		clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
-		ret = read_extent_buffer_pages(eb, WAIT_COMPLETE, mirror_num, check);
+		ret = read_extent_buffer_pages(eb, mirror_num, check);
 		if (!ret)
 			break;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bc232e990ce9..37f0ad389022 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3477,8 +3477,8 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
 	bio_put(&bbio->bio);
 }
 
-int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
-			     const struct btrfs_tree_parent_check *check)
+int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
+				    const struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_bio *bbio;
 	bool ret;
@@ -3496,7 +3496,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 
 	/* Someone else is already reading the buffer, just wait for it. */
 	if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
-		goto done;
+		return 0;
 
 	/*
 	 * Between the initial test_bit(EXTENT_BUFFER_UPTODATE) and the above
@@ -3536,14 +3536,21 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 		}
 	}
 	btrfs_submit_bbio(bbio, mirror_num);
+	return 0;
+}
 
-done:
-	if (wait == WAIT_COMPLETE) {
-		wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_READING, TASK_UNINTERRUPTIBLE);
-		if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
-			return -EIO;
-	}
+int read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
+			     const struct btrfs_tree_parent_check *check)
+{
+	int ret;
 
+	ret = read_extent_buffer_pages_nowait(eb, mirror_num, check);
+	if (ret < 0)
+		return ret;
+
+	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_READING, TASK_UNINTERRUPTIBLE);
+	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
+		return -EIO;
 	return 0;
 }
 
@@ -4274,7 +4281,7 @@ void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 		return;
 	}
 
-	ret = read_extent_buffer_pages(eb, WAIT_NONE, 0, &check);
+	ret = read_extent_buffer_pages_nowait(eb, 0, &check);
 	if (ret < 0)
 		free_extent_buffer_stale(eb);
 	else
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index ca09fc31e2de..6c5328bfabc2 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -261,10 +261,11 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 					 u64 start);
 void free_extent_buffer(struct extent_buffer *eb);
 void free_extent_buffer_stale(struct extent_buffer *eb);
-#define WAIT_NONE	0
-#define WAIT_COMPLETE	1
-int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
+int read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
 			     const struct btrfs_tree_parent_check *parent_check);
+int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
+				    const struct btrfs_tree_parent_check *parent_check);
+
 static inline void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
 {
 	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_WRITEBACK,
-- 
2.47.1


