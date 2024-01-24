Return-Path: <linux-btrfs+bounces-1753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8895C83B3BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410DA283492
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AEE135401;
	Wed, 24 Jan 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gBGlsH36";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gBGlsH36"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF141353FD
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131132; cv=none; b=PIHiOgBT42FXwg+jxN8pYtmhQ+r+6blTu0MO5L3X+AcG9vtK7tl5mhNF/DhZZf2X0rTsDjBAKFf8yOfPlcdjNtk94SQPO3zTgLNqFxtqdaDzJRBeWCvJUrIqEa1HLOIB1MHLkdKm+QHFwLo2Y1k6ZXXG4ldNnXJ71VlTcKIiJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131132; c=relaxed/simple;
	bh=bci0zDXK70I1lAALGRTeE5eqx0yYfrWvb8S282qN9zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKMaNipeNmAjAaRurSJPyT8vQvUNf9JSvtvu53dP18/Lhr/OB5NUwXuzWAOhk+9IoJf4gyN6nBUS7GhculoiiT86uuT7PI58qZOCk3BP7s7eqQiih8cx3806z2CEH3CS+pzcHDS1ZYo2PyNJc9MUW0UodWCMYVN9PrtxF9+6aPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gBGlsH36; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gBGlsH36; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8796F1FD85;
	Wed, 24 Jan 2024 21:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaQePcyBMG/Kh1EZM/lxOlg/LJgH7XcCR+BG0iWv3/E=;
	b=gBGlsH36gagUE4/uTramBKFyBpoiFm3G2rnKH5+pRm4BlS5I268Jeirn8HifSZRFYoW7a3
	IObpez+ZzuuuW5U5aXrsn0dKSxeWbT4sD792aAKx3aoIT/sjr0DNQJ+VhRBg0iAN0MLu+V
	rMeQ6GutIxh/CFaKEb8cDu8uy5XxPJU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaQePcyBMG/Kh1EZM/lxOlg/LJgH7XcCR+BG0iWv3/E=;
	b=gBGlsH36gagUE4/uTramBKFyBpoiFm3G2rnKH5+pRm4BlS5I268Jeirn8HifSZRFYoW7a3
	IObpez+ZzuuuW5U5aXrsn0dKSxeWbT4sD792aAKx3aoIT/sjr0DNQJ+VhRBg0iAN0MLu+V
	rMeQ6GutIxh/CFaKEb8cDu8uy5XxPJU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80E0F13786;
	Wed, 24 Jan 2024 21:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q0R1H7l+sWXVdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 11/20] btrfs: change BUG_ON to assertion when checking for delayed_node root
Date: Wed, 24 Jan 2024 22:18:28 +0100
Message-ID: <4d3243a390f390b1570853d9b91994bff26d9b79.1706130791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
References: <cover.1706130791.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

The pointer to root is initialized in btrfs_init_delayed_node(), no need
to check for it again. Change the BUG_ON to assertion.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 0b1701f1b8c9..efe435403b77 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -978,7 +978,7 @@ static void btrfs_release_delayed_inode(struct btrfs_delayed_node *delayed_node)
 
 	if (delayed_node &&
 	    test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
-		BUG_ON(!delayed_node->root);
+		ASSERT(delayed_node->root);
 		clear_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags);
 		delayed_node->count--;
 
-- 
2.42.1


