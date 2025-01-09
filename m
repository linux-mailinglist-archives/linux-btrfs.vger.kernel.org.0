Return-Path: <linux-btrfs+bounces-10830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE016A07310
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2CE168D4F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08318216E29;
	Thu,  9 Jan 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qDnBSSI9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qDnBSSI9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D149218EA0
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418282; cv=none; b=HGZy0J4iBqT4NThmBv2Jlz4PAhPPYzEZrh3EiBnAOXYUEcQXC+wjEzk3glw8P3Ar2Tip51+lObJhFBBDh5xk4wJ1GIS4/2vyXzzgBvEWo3j/v8Zs7xCNTT1Vw1V7nr1hOKuCGEx2TLxPu4oRm4WfI0hSIZCUpyGR8rqeQq/TTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418282; c=relaxed/simple;
	bh=R9k3UDlbhfd8p/cNeXH5XfXCkdeqrMEHiYee3iMxrBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR0Kj24MMUiE18em+EFWZLqNO3xLZ5IFDLwHLhNNo3AHzcav+ZHQ5lDkJaAjAkJXIK2vL2AaF/ppi9+Cdj7WztvTSmGY7r2btgbPNBdzRTDkDUga7bEd0irDSiTGVYuW0ClXhOT19JuzHUJYHUnS4gu6ysJFiTl29SpADWPLmds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qDnBSSI9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qDnBSSI9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F74821102;
	Thu,  9 Jan 2025 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTtnGsvBmGnhr/KsTjwkFB5iJyhBtpI+UiYvjlDv3vI=;
	b=qDnBSSI9tjbC3RHOkhvzpKcs8EpWiev+Ke6zqAPoSp5rJB4nL8c+6Axsc9j003apwdPw2G
	XUG0zYJzFiUK+S5NKyL4kr/iZEMrXWTe5zD11LGeY+omQZ/yrBkIHQhYsTCmShSY9DQz+a
	OjNGmSsKB1tYloY1bHEsc3FSCHnFbFc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTtnGsvBmGnhr/KsTjwkFB5iJyhBtpI+UiYvjlDv3vI=;
	b=qDnBSSI9tjbC3RHOkhvzpKcs8EpWiev+Ke6zqAPoSp5rJB4nL8c+6Axsc9j003apwdPw2G
	XUG0zYJzFiUK+S5NKyL4kr/iZEMrXWTe5zD11LGeY+omQZ/yrBkIHQhYsTCmShSY9DQz+a
	OjNGmSsKB1tYloY1bHEsc3FSCHnFbFc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88117139AB;
	Thu,  9 Jan 2025 10:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r1I1Ieajf2dlEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:38 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 14/18] btrfs: unwrap folio locking helpers
Date: Thu,  9 Jan 2025 11:24:38 +0100
Message-ID: <47bbb83947ec24aa3d50cf1700b68a4c897e060d.1736418116.git.dsterba@suse.com>
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
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Another conversion to folio API, use the folio locking directly instead
of back and forth page <-> folio conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 86f6a87665f5..bc232e990ce9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3129,7 +3129,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * live buffer and won't free them prematurely.
 	 */
 	for (int i = 0; i < num_folios; i++)
-		unlock_page(folio_page(eb->folios[i], 0));
+		folio_unlock(eb->folios[i]);
 	return eb;
 
 out:
@@ -3153,7 +3153,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	for (int i = 0; i < attached; i++) {
 		ASSERT(eb->folios[i]);
 		detach_extent_buffer_folio(eb, eb->folios[i]);
-		unlock_page(folio_page(eb->folios[i], 0));
+		folio_unlock(eb->folios[i]);
 		folio_put(eb->folios[i]);
 		eb->folios[i] = NULL;
 	}
@@ -3362,12 +3362,12 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 		 * the above race.
 		 */
 		if (subpage)
-			lock_page(folio_page(eb->folios[0], 0));
+			folio_lock(eb->folios[0]);
 		for (int i = 0; i < num_folios; i++)
 			btrfs_folio_set_dirty(eb->fs_info, eb->folios[i],
 					      eb->start, eb->len);
 		if (subpage)
-			unlock_page(folio_page(eb->folios[0], 0));
+			folio_unlock(eb->folios[0]);
 		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
 					 eb->len,
 					 eb->fs_info->dirty_metadata_batch);
-- 
2.47.1


