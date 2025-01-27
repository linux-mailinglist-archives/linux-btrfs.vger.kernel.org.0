Return-Path: <linux-btrfs+bounces-11077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135EEA1D277
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 09:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703201624D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 08:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E9C1FC7F5;
	Mon, 27 Jan 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EG6J8ych";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZCcli9JO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389678C11
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737967091; cv=none; b=tJK7ztYQY1xhWdmhbYavur+JtNYMaoDOjJOckW5xSCufQM/iiUayrfEzgBAw62VEDpqF+wuf/FG0avWMj2Stgjg7yT+hNEMTTeVQtW4bRpVPKUv6LYPrJGY+/TnJ+4lQX/XvovkBFh6p02jJrjRhxS6jAXK/jVRn611F/B7S898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737967091; c=relaxed/simple;
	bh=sD2j4fysTJu7J9KBpWOA9ESwcWAs/yP+R8YOFnV1WmY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tX6Lusu5LZqhZLayXAOva2CMm5SxKo99BKeEEEYcyGI09N5zESb50rki2D0E9ufzadASzsDsnRhO+qhruN0QY+c7CvTEQYhn5nG/FExmUm3A2pyZUp4HnPN/5T4cqJ+5X6YV3/I1czLDhj8xnasvLIQt/KYo6DuGu17KnFnZx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EG6J8ych; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZCcli9JO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E34121F445
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 08:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737967087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wzt0nKbOija+Zzt4+YhCz/2jnZLzIF3TdEZpeFbdFtk=;
	b=EG6J8ych87U+4n1juberhjCNJxURM22CO8npOvPeKphKcuR++V32j21aNUdTfoTfuAiSkD
	pSGaSYlt3GN/JI2c3sQKDFNCJOvH1UiD7+53BIC3qaIvSKF7Ut30R5OwswhC/jfHytTUE1
	jQXWlE8MxfoNdDmeNj4xJTJtCxOPFMU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737967085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wzt0nKbOija+Zzt4+YhCz/2jnZLzIF3TdEZpeFbdFtk=;
	b=ZCcli9JOblx+QUuDdiXNesMfxYYwSaMf2Pd5eLwmo0LVSIrCswbb232khI0+zdI+Ew6zvD
	LTjqWFE/1DRuhq/pBCgm8fureyjffeJSCxtR0SM7jF7D2dCAaWb3vEse8+78ZiCC9jKQCD
	99MyRjL2cqLzts73aU8cBhQ9CyXOKdo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5A3413715
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 08:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 13xCH+xFl2cCEQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 08:38:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove duplicated metadata folio flag update in end_bbio_meta_read()
Date: Mon, 27 Jan 2025 19:07:38 +1030
Message-ID: <06ecb80cf50feba2a430f5c819376cddd8a9cca9.1737967048.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

In that function we call set_extent_buffer_uptodate() or
clear_extent_buffer_uptodate(), which will already update the uptodate
flag for all the involved extent buffer folios.

Thus there is no need to update the folio uptodate flags again.

Just remove the open-coded part.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5a885da5e35a..1c50d6db454c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3493,10 +3493,7 @@ static void clear_extent_buffer_reading(struct extent_buffer *eb)
 static void end_bbio_meta_read(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
-	struct btrfs_fs_info *fs_info = eb->fs_info;
 	bool uptodate = !bbio->bio.bi_status;
-	struct folio_iter fi;
-	u32 bio_offset = 0;
 
 	/*
 	 * If the extent buffer is marked UPTODATE before the read operation
@@ -3518,19 +3515,6 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
 		set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	}
 
-	bio_for_each_folio_all(fi, &bbio->bio) {
-		struct folio *folio = fi.folio;
-		u64 start = eb->start + bio_offset;
-		u32 len = fi.length;
-
-		if (uptodate)
-			btrfs_folio_set_uptodate(fs_info, folio, start, len);
-		else
-			btrfs_folio_clear_uptodate(fs_info, folio, start, len);
-
-		bio_offset += len;
-	}
-
 	clear_extent_buffer_reading(eb);
 	free_extent_buffer(eb);
 
-- 
2.48.1


