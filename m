Return-Path: <linux-btrfs+bounces-6567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6E937311
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 06:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BB71C20D45
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 04:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968F23BBF0;
	Fri, 19 Jul 2024 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SOKhp4LU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lAdL7YQi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06243D984
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 04:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721364571; cv=none; b=lDzxF2kgu4n4d0EQsxAKRYSOmvxSPzubWZSFGIl/4suCrnI/jzFba/qM9x1NHTo14Ev3VT5a71szGuYc7gVtZQCfS4CqYlZaAB5runovHX/HE5DgDsvARwt3eoUyk2W6M2fNuC3WbMhsn5uCFa4WgT0XpiW2XkJX2VTRk0uV6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721364571; c=relaxed/simple;
	bh=0bU2OqEBFu6aln6VmNENthDJEqSvfpxNGF913GDY22Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVKbfLExrckGImif+a0yT5v3D0c2J96BLjC1L7tq6M+Kl/lHnGNwy/B8k5CcArNyJwcENWaudITCqOM73iJSM9F17Ed+94AG8b8eXWdGgKSqUMwvswrjCPesi4J2cDcZ3UC0H8pYPOJW0ozNYo/MQ6R299KNKh7JBWLTipQGzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SOKhp4LU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lAdL7YQi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D66B91FC85;
	Fri, 19 Jul 2024 04:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721364568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY07DcWxN50w7IDK7157U/gEq6AbKvKvVRXUZwfOC7c=;
	b=SOKhp4LUyfNPz0dAyFVeZBVTGyfb+kR0RfmUuO6OUJCQS/Pq0yDKxzzhSDyev+UgrPHPM/
	3OktJsqNkhbrD2mEC/IQ6CjARwUXTjjUosdPIv65vOGZGRnHhV8eEMgz+I0FxuhKHbCHLF
	VPxDPtYqfJmYN7mXm4ZYkAf6Dm3PBTY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lAdL7YQi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721364567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY07DcWxN50w7IDK7157U/gEq6AbKvKvVRXUZwfOC7c=;
	b=lAdL7YQiaR6kwcT8fOeQS2rFBBMy5Lrf8BJKTHT2p8AP1Uzt/RfULTKfCNLzHcTWrZIsEf
	SnAs7k+Q95XMCAPvBooPp/sH06Vzl1icc4JnL+in5TlLylFDgBhjg+AVj4KkrAcF7Lwb3y
	SZlUAmb+nSF8WnKdWH9TmaiITuNzBXU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71EC0136F7;
	Fri, 19 Jul 2024 04:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QNFHC1bwmWYPdQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Jul 2024 04:49:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [PATCH v5 1/2] btrfs: always uses root memcgroup for filemap_add_folio()
Date: Fri, 19 Jul 2024 14:19:05 +0930
Message-ID: <d408a1b35307101e82a6845e26af4a122c8e5a25.1721363035.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721363035.git.wqu@suse.com>
References: <cover.1721363035.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D66B91FC85

The function filemap_add_folio() would also charge the memory cgroup,
as all filemap folios are controlled by memory cgroup.
This also means, if there is some memory cgroup set, we're only relying
on the __GFP_NOFAIL flag to prevent mem cgroup to return -ENOMEM.

However this is not really that suitable for btrfs btree inode, as the
btree inode is not accessible out of btrfs module, and we do not want
the memory limits on this critical part of btrfs metadata allocation.

So here we just manually set the active memory cgroup to the root one,
which has no memory limits or whatever, before calling
filemap_add_folio(), then restore to the old memcgroup.

By this we avoid the unnecessary memory limits and can later remove the
__GFP_NOFAIL usage.

Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aa7f8148cd0d..cfeed7673009 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2971,6 +2971,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
+	struct mem_cgroup *old_memcg;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
 	struct folio *existing_folio = NULL;
 	int ret;
@@ -2981,8 +2982,17 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	ASSERT(eb->folios[i]);
 
 retry:
+	/*
+	 * Btree inode is a btrfs internal inode, and not exposed to any
+	 * user.
+	 * Furthermore we do not want any cgroup limits on this inode.
+	 * So we always use root_mem_cgroup as our active memcg when attaching
+	 * the folios.
+	 */
+	old_memcg = set_active_memcg(root_mem_cgroup);
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
 				GFP_NOFS | __GFP_NOFAIL);
+	set_active_memcg(old_memcg);
 	if (!ret)
 		goto finish;
 
-- 
2.45.2


