Return-Path: <linux-btrfs+bounces-13560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E7AA520A
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE331189F655
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0722638A2;
	Wed, 30 Apr 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G7i5lpOU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G7i5lpOU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AD1684B4
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031822; cv=none; b=N4Xl3jmgxrjJvKa5U44EBiqfi1REdLAG7TOF16376h57cDBUGlXYUVSfNoq2pJkuLH3Vv/fDqd38kzYgV3lZ1Gtu41Cl4oeIY+LJEVrbMKPmXW4kIb1dbWskEC2OpNfwYmCm+X+AMSmTqY2TY6md+EcmgmwAVPSsCmN7OwZcCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031822; c=relaxed/simple;
	bh=KcW2sP3rYEbjhfZ0uL7Vy5jS9+PhOxHhuaHSv/tYJVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7L/7iqJxhtMoAH00h1ZO4UakBxL5T/QYrbYQkN513J+kXAZfJ2v1YebaRo/83nW73TO1BctS1iDvSfA6OKwu/h0eicPYfBrom4pMFe70PegwS/gt+o/42y7l+rprtK+QScCaMoOO++/EQEHH2Smd56fPtaJYJmM0PKOEZC8t3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G7i5lpOU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G7i5lpOU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E76FF1F395;
	Wed, 30 Apr 2025 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746031814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtTSiK+HELjxfgq3pxQXCqxd1h0lMaOE1ybhxDW6dbo=;
	b=G7i5lpOUfddSQifRY7+xW0XUy7gbsut4Nm8jnK2bPb55ml9W8eu+3lLZDMYl1+5ytpmHBA
	1032Ga9Rfo/PqzBRROgxr6DTtOXSJHf43pXl95cN8JKfxz5pqCkt8WSU2fgnkMYDgB3hff
	XJ2Ncx//8p/F6PJRLNOvANJmt5/WODU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746031814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtTSiK+HELjxfgq3pxQXCqxd1h0lMaOE1ybhxDW6dbo=;
	b=G7i5lpOUfddSQifRY7+xW0XUy7gbsut4Nm8jnK2bPb55ml9W8eu+3lLZDMYl1+5ytpmHBA
	1032Ga9Rfo/PqzBRROgxr6DTtOXSJHf43pXl95cN8JKfxz5pqCkt8WSU2fgnkMYDgB3hff
	XJ2Ncx//8p/F6PJRLNOvANJmt5/WODU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5B30139E7;
	Wed, 30 Apr 2025 16:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EM4nNMZUEmgLNAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 30 Apr 2025 16:50:14 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: move transaction aborts to the error site in remove_from_free_space_tree()
Date: Wed, 30 Apr 2025 18:45:20 +0200
Message-ID: <492f8b26061eeb5e51b2b7085e8df6c03e5c1e02.1746031378.git.dsterba@suse.com>
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

Transaction aborts should be done next to the place the error happens,
which was not done in remove_from_free_space_tree().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index ef39d103443524..ffe98bea6927f9 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -850,6 +850,7 @@ int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
@@ -857,6 +858,7 @@ int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 	if (!block_group) {
 		DEBUG_WARN("no block group found for start=%llu", start);
 		ret = -ENOENT;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
@@ -864,12 +866,12 @@ int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 	ret = __remove_from_free_space_tree(trans, block_group, path, start,
 					    size);
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


