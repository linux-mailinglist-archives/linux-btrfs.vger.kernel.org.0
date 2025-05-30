Return-Path: <linux-btrfs+bounces-14330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B47AC935C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F1E1C06DAD
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC82E19F464;
	Fri, 30 May 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r0ARmnAk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r0ARmnAk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709671A5B91
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621910; cv=none; b=JPc0v5e1ZGbX0L+v+YT3N8f9Nf+eSoDoW9eZlxSvd2SWMWtJFSWBMa03HjNE2HGnGyV7jBD4ywsar9yvZ89XgX45G6CGpWuirXJ0PpmoWcGHJUHgUPSMqrt5KwdDWnvjbtAMgtmsqWsdvvGnMkHSrHRwey26jO8AVda78io7iC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621910; c=relaxed/simple;
	bh=yS5KF/4wGVpTpZMEfSGfHwSSd21FhTJ3/siHYf1EmU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpIEtn/BmXVhIMwNaELMg7R3+xWFbarURzxjc19jEBwL6kxzsch8hT2+m4fEsnoBs1Kv19/QSDLIqVT+7Zbchra9ALlIHKiqa7Y59U1YzMcM4iz5KaCJVnAMuqmzwKCeXSoQjFjzPdTBYe+NEnqvzWY1qt1L2ADd7oRJlxvzSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r0ARmnAk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r0ARmnAk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E516121A4C;
	Fri, 30 May 2025 16:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9Pqd8590XvVXyli94+Fil4D1Lz+7kua5uKgPCEtsMw=;
	b=r0ARmnAkBx+cQ0rb/OOlXarK7QYz9VOp8wowpM7MyO1onH5aNAKS0wlLwiBPXjVwKRDxvZ
	mxjgRMv8Zt0fCe94+Vy2VJvRCgQe/LDvPvQV1R46p78gasDXwKrmcQXu8O1//aZKr+0l9k
	p71dx6wueVPIoy3XRfW47tQ4xoE6Pzc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9Pqd8590XvVXyli94+Fil4D1Lz+7kua5uKgPCEtsMw=;
	b=r0ARmnAkBx+cQ0rb/OOlXarK7QYz9VOp8wowpM7MyO1onH5aNAKS0wlLwiBPXjVwKRDxvZ
	mxjgRMv8Zt0fCe94+Vy2VJvRCgQe/LDvPvQV1R46p78gasDXwKrmcQXu8O1//aZKr+0l9k
	p71dx6wueVPIoy3XRfW47tQ4xoE6Pzc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF72813889;
	Fri, 30 May 2025 16:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2AeLNlLaOWjIZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:18:26 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 12/22] btrfs: rename err to ret in btrfs_init_inode_security()
Date: Fri, 30 May 2025 18:18:18 +0200
Message-ID: <fef75f1ce5d8721b8646e7be191a33fbbd70cf90.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 36a11a832528..0a2357f979f3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -423,18 +423,18 @@ static int btrfs_dirty_inode(struct btrfs_inode *inode);
 static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
 				     struct btrfs_new_inode_args *args)
 {
-	int err;
+	int ret;
 
 	if (args->default_acl) {
-		err = __btrfs_set_acl(trans, args->inode, args->default_acl,
+		ret = __btrfs_set_acl(trans, args->inode, args->default_acl,
 				      ACL_TYPE_DEFAULT);
-		if (err)
-			return err;
+		if (ret)
+			return ret;
 	}
 	if (args->acl) {
-		err = __btrfs_set_acl(trans, args->inode, args->acl, ACL_TYPE_ACCESS);
-		if (err)
-			return err;
+		ret = __btrfs_set_acl(trans, args->inode, args->acl, ACL_TYPE_ACCESS);
+		if (ret)
+			return ret;
 	}
 	if (!args->default_acl && !args->acl)
 		cache_no_acl(args->inode);
-- 
2.47.1


