Return-Path: <linux-btrfs+bounces-5219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6B68CC9D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 01:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8E9B22000
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 23:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB927F7D3;
	Wed, 22 May 2024 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qqLG9Y6c";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qqLG9Y6c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403D14C59C
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421697; cv=none; b=kTdsG5Sm76Xf9Rez3quq/APTxt9sGR4Ywdm5Gdqq56CoIcBbUMpJZ2tvWmQuF3qHlRMbKgLaIOVmxV+weziagad5qio+4WNrNH95nYx0PGyG/9bba0kLRlue+UJld3aarHbxD6J9WEY7gm/DGIhE489ma7MZ4TOXHcJR89oU7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421697; c=relaxed/simple;
	bh=zUahOkCAOb5EtrE5fPSuhJP/sUJvNm6ruMe8apide5U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhMEI+/D+of+idpmmX2J9hGMixO9sF7CInoXgVnSTJt7AD9mug4gpTfQDHffGen+M9e7Us01oyFfBcQsq5opvOU5a4NVJRYWMzyKj7X6eo4/48joBEGyHIoFhPwdZMsCM40xpMEDT2M+1eETWYrA+dcXf86G9JAHjGWf+bp2eew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qqLG9Y6c; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qqLG9Y6c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1211FB9C
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716421693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vf/ab0rZDMvXX51qLkC9PvHoxs4La8lp7AlaCYA/Wb8=;
	b=qqLG9Y6cLTu5VgCi9KQph/IbGAdt3ft9qNg48mP+ASuJL9+f3ZHdzz1opHkeQmJwJNrfNX
	ip30U1uF6KKXVoU768Ll9STVKQF3AgFQ2SwQNo23utJqmMavHA7byUF7tEHhTgBcH2B2j+
	YfM+hqiyDXL9BEhOxEl4GnSex0qXPWI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716421693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vf/ab0rZDMvXX51qLkC9PvHoxs4La8lp7AlaCYA/Wb8=;
	b=qqLG9Y6cLTu5VgCi9KQph/IbGAdt3ft9qNg48mP+ASuJL9+f3ZHdzz1opHkeQmJwJNrfNX
	ip30U1uF6KKXVoU768Ll9STVKQF3AgFQ2SwQNo23utJqmMavHA7byUF7tEHhTgBcH2B2j+
	YfM+hqiyDXL9BEhOxEl4GnSex0qXPWI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F73813A1E
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6LCwCzyETmb6aQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: make extent_range_clear_dirty_for_io() subpage compatible
Date: Thu, 23 May 2024 09:17:46 +0930
Message-ID: <015a4a2c7afb8ed894f4fb734cb886f01b9feb0c.1716421534.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716421534.git.wqu@suse.com>
References: <cover.1716421534.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.13 / 50.00];
	BAYES_HAM(-2.33)[96.88%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.13
X-Spam-Flag: NO

Although the function is never called for subpage ranges, there is no
harm to make it subpage compatible for the future sector perfect subpage
compression support.

And since we're here, also change it to use folio APIs as the subpage
helper is already folio based.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 99be256f4f0e..dda47a273813 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -892,15 +892,20 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 
 static void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 {
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	const u64 len = end + 1 - start;
 	unsigned long index = start >> PAGE_SHIFT;
 	unsigned long end_index = end >> PAGE_SHIFT;
-	struct page *page;
 
+	/* We should not have such large range. */
+	ASSERT(len < U32_MAX);
 	while (index <= end_index) {
-		page = find_get_page(inode->i_mapping, index);
-		BUG_ON(!page); /* Pages should be in the extent_io_tree */
-		clear_page_dirty_for_io(page);
-		put_page(page);
+		struct folio *folio;
+
+		folio = filemap_get_folio(inode->i_mapping, index);
+		BUG_ON(IS_ERR(folio)); /* Pages should have been locked. */
+		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
+		folio_put(folio);
 		index++;
 	}
 }
-- 
2.45.1


