Return-Path: <linux-btrfs+bounces-10825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A05A0731C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32583A9BBB
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9E6218E92;
	Thu,  9 Jan 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KJ1tjLF9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KJ1tjLF9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190A216E01
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418266; cv=none; b=JGzRyMudum2EyTy95KNRE+UuGPttB5enXchxdyUC7uCE6/Jr7j3JXgVdn73AaueJb8rRGzRuAQlpmYaHZdViFUrbiQbFTOm2GuDr+fkmmkKb13VxgLS/yxYPDnefv2fjD8HR/71aIoV3RoXyKAoKVc2tyuO50BIWQpW6OvR9Epo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418266; c=relaxed/simple;
	bh=Po2pcW8VUbNPj3vTlpgsX7M9W+m2MvdFLfAcxafZfeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHlYI7LQVtZ+5T9tEl80WlTscnuQmRS1SBOX+c23U4Z9pNjDnK1/KZ9t6XH94UAVLx9t93qfJ1POes3B0LFWCnHY9BRqNbjZ2KYY2uMMpVvmgGB7QdJGPBC0BQ6xNyzFnNLmkJ5FppCMyJBfnqsWPVNTPxjzWfYOD9t9IdTlNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KJ1tjLF9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KJ1tjLF9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D37D1F393;
	Thu,  9 Jan 2025 10:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/8GW5XkYbgTmNaUZLydhGsK1/GlYAfGHRT/9+Ov2kU=;
	b=KJ1tjLF9xwrdDOoyW7bkQCkP5EzvPCaxtrrisdQm/s4FzxTsTlYHLqW+AU1So9wC85NEpP
	Iluh7bbC9S/HA/EFOpMRzHvH3lqwLAn296UPgwkPBGp572VWsQ/l3xVOrf1LUY6NsUZrMD
	wsQ1br83ycG5g4QdM6z3C2X97oRx8ZI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KJ1tjLF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/8GW5XkYbgTmNaUZLydhGsK1/GlYAfGHRT/9+Ov2kU=;
	b=KJ1tjLF9xwrdDOoyW7bkQCkP5EzvPCaxtrrisdQm/s4FzxTsTlYHLqW+AU1So9wC85NEpP
	Iluh7bbC9S/HA/EFOpMRzHvH3lqwLAn296UPgwkPBGp572VWsQ/l3xVOrf1LUY6NsUZrMD
	wsQ1br83ycG5g4QdM6z3C2X97oRx8ZI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 962A5139AB;
	Thu,  9 Jan 2025 10:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eoinJNajf2dAEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:22 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/18] btrfs: drop one time used local variable in end_bbio_meta_write()
Date: Thu,  9 Jan 2025 11:24:22 +0100
Message-ID: <ed75e3aa5d534697ca528efde499fafb6f764e7b.1736418116.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 9D37D1F393
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4f71877f9b76..6466f74bd2bb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1658,11 +1658,10 @@ static void end_bbio_meta_write(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	bool uptodate = !bbio->bio.bi_status;
 	struct folio_iter fi;
 	u32 bio_offset = 0;
 
-	if (!uptodate)
+	if (bbio->bio.bi_status != BLK_STS_OK)
 		set_btree_ioerr(eb);
 
 	bio_for_each_folio_all(fi, &bbio->bio) {
-- 
2.47.1


