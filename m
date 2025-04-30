Return-Path: <linux-btrfs+bounces-13561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17366AA520B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 18:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086EF4A4A5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1C5262D00;
	Wed, 30 Apr 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DldzxMB2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DldzxMB2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2A1684B4
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031829; cv=none; b=Z6CtYfNfpOgMUeUy77eQwReVu3JIDTikWaI/4haHuXLS4v5YYrfGCfVg6RPxdxs8x+hFlMeHvgPfjt1ZSA4CAA+tHirM6ZwvvYZMkltsklmgrL98/enjXTfygmv630LjDR5MqLqfbBPbOpEAcgtGwo3xZEorrH4s/QUrlaCn/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031829; c=relaxed/simple;
	bh=Ku6/a9/iNri6sYGD3NRvjOcuUxcn2adYbu3yEM1AGMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwIJYsjHdmGJOudq+SwVsB3/dRqECLn7//qQUeZnoFWGul8d9ECF5DkV1gWdSi0m6bWVIKO0upciYPhpmdw+DYNLSA0YyLelMyUElXJmm0NB8hWDAkx0g2vHZUx63ex6Em0EA/VLhVvU6169RAe077lF9lds5SEaPAYUeqpXzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DldzxMB2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DldzxMB2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 299781F394;
	Wed, 30 Apr 2025 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746031817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+x+AD8Fh0xW82/q3TF0jjSoWIN2HYl7pICPG/qjtfpc=;
	b=DldzxMB2ZCojzyomEPERl8k5ngrW2BgwVR4XNz+XsMbPK3RP5LM61E+VFNxYo7Xgw28B8e
	F8G+PdIY0z9nWWupIdgj0+9EXkVAU+xdLjJ3JVrGTXq3fk3RI+ICzMeEdZENRuL5hlhG+U
	yoigC7WZGydB9Q9MZXvbvvg2fcS5u/g=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746031817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+x+AD8Fh0xW82/q3TF0jjSoWIN2HYl7pICPG/qjtfpc=;
	b=DldzxMB2ZCojzyomEPERl8k5ngrW2BgwVR4XNz+XsMbPK3RP5LM61E+VFNxYo7Xgw28B8e
	F8G+PdIY0z9nWWupIdgj0+9EXkVAU+xdLjJ3JVrGTXq3fk3RI+ICzMeEdZENRuL5hlhG+U
	yoigC7WZGydB9Q9MZXvbvvg2fcS5u/g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 214BF139E7;
	Wed, 30 Apr 2025 16:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uOIeCMlUEmgRNAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 30 Apr 2025 16:50:17 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: move transaction aborts to the error site in add_to_free_space_tree()
Date: Wed, 30 Apr 2025 18:45:21 +0200
Message-ID: <28545fbbdf3126ac09889df38414ef17f5c85284.1746031378.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746031378.git.dsterba@suse.com>
References: <cover.1746031378.git.dsterba@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Transaction aborts should be done next to the place the error happens,
which was not done in add_to_free_space_tree().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index ffe98bea6927f9..0c573d46639ae9 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1045,6 +1045,7 @@ int add_to_free_space_tree(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
@@ -1052,18 +1053,19 @@ int add_to_free_space_tree(struct btrfs_trans_handle *trans,
 	if (!block_group) {
 		DEBUG_WARN("no block group found for start=%llu", start);
 		ret = -ENOENT;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
 	mutex_lock(&block_group->free_space_lock);
 	ret = __add_to_free_space_tree(trans, block_group, path, start, size);
 	mutex_unlock(&block_group->free_space_lock);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
 
 	btrfs_put_block_group(block_group);
 out:
 	btrfs_free_path(path);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
 	return ret;
 }
 
-- 
2.49.0


