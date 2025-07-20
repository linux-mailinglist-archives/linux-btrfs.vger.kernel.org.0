Return-Path: <linux-btrfs+bounces-15574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B69EAB0B3C9
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 08:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445873B9E57
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 06:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560631C3F0C;
	Sun, 20 Jul 2025 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cP2WVNbA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cP2WVNbA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB219CD0B
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752992991; cv=none; b=gdM9vRydcBdpyiu5jP/tBAtWNqPz8Lifqy0zSTdr1b8qIjQPEGb5Zqtf250mX8T/3Stor7KEJ6ivfIxDS9IYrSY5FRPT3fXC0OZf4sy7BKDG+/OlbjJJsLu8MTWlR/C76p7Ol3PN320tubC0FrTsllaO0ALF0W5GgFVo3mqkeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752992991; c=relaxed/simple;
	bh=r928D0vP9tJovvJRkwDUHmnm1lnme5UqLbUIF7lPAiE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qt6eLadw6DXtHEQcTi3D8jfHoMBcfwPsHTU+Kzox2Iv3HRBhD03iUgMsw8doQrZnuqgrz1fJvTwP2fh5K2qS/uh6DeJKvMsLPeKn4L1dmsih0EiXRTnQPSo9pRdKMwGOkLHE4wDQEDSUusGJ8Uwfyu+/TOI00tQEW3QC/0CzCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cP2WVNbA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cP2WVNbA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A6F51F38D
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752992972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqlVqURmq16BjKtLLbOZDy3VPk6fI1wvI5LGKMQCFGo=;
	b=cP2WVNbAedtoAlS/lw4H5YQOlWxxsYgG6yHwq0UiOOPPVas2sCXIH4WX8eXMEawTb8DcGf
	qhg0waRga/kLMPzW2JOVgFrhdEvCQKvdAlz3CsgFyICEq9xsdT6hvCjEOhYkDT8DWTyYM0
	kDAIQVpAECEY8FDRY1XsXf7vHvSPKso=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752992972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqlVqURmq16BjKtLLbOZDy3VPk6fI1wvI5LGKMQCFGo=;
	b=cP2WVNbAedtoAlS/lw4H5YQOlWxxsYgG6yHwq0UiOOPPVas2sCXIH4WX8eXMEawTb8DcGf
	qhg0waRga/kLMPzW2JOVgFrhdEvCQKvdAlz3CsgFyICEq9xsdT6hvCjEOhYkDT8DWTyYM0
	kDAIQVpAECEY8FDRY1XsXf7vHvSPKso=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB0A313A1E
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iA8vG8uMfGjJfQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: make btrfs_cleanup_ordered_extents() to support large folios
Date: Sun, 20 Jul 2025 15:59:10 +0930
Message-ID: <73ff1bee04330a931e235a6100390dbf7c0af00e.1752992367.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752992367.git.wqu@suse.com>
References: <cover.1752992367.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

When hitting a large folio, btrfs_cleanup_ordered_extents() will get the
same large folio multiple times, and clearing the same range again and
again.

Thankfully this is not causing anything wrong, just inefficiency.

This is caused by the fact that we're iterating folios using the old
page index, thus can hit the same large folio again and again.

Enhance it by increasing @index to the index of the folio end, and only
increase @index by 1 if we failed to grab a folio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fc47e234b729..5259bb8ec430 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -404,10 +404,12 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 
 	while (index <= end_index) {
 		folio = filemap_get_folio(inode->vfs_inode.i_mapping, index);
-		index++;
-		if (IS_ERR(folio))
+		if (IS_ERR(folio)) {
+			index++;
 			continue;
+		}
 
+		index = folio_end(folio) >> PAGE_SHIFT;
 		/*
 		 * Here we just clear all Ordered bits for every page in the
 		 * range, then btrfs_mark_ordered_io_finished() will handle
-- 
2.50.0


