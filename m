Return-Path: <linux-btrfs+bounces-2234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E984DC3A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42F01C269DE
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594B6BB27;
	Thu,  8 Feb 2024 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ukdVWxs+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ukdVWxs+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37A69E1E
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382836; cv=none; b=RvaHflfEXkFmqt5SiONnfmb/fuCG2+N/OeT5zuLrNU97ki5i3EnxAtU/6Z/kojeQEpj7JJzFx3O9rKY+1P/4YgEI3f+vcDP4m/8JpnLls7ef5C2P2dA6Ij99DgQsQS3yk//fCqdtSd7+HlK0Dbd8STC1+IlzqBB8LfcyAhp6s9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382836; c=relaxed/simple;
	bh=A/ZsPrXigPkg4aU6eyufkVANTx8f+mBR8IBVdhKifdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgSZR1PfVmpJEcRf/0Js1XrlaYTAy9HQnKdqlF2Yn3bE48iKceeMEXEMjxnE+Txu9HYPgv+eRga+NvqdsfsuhJEyIejqvFKDHyPnWKaliXnQbUiJjTEKwPkpsSau42bOQT9KLV31dgMHeA8UolOPfPKePP+EEgylw0bHX9klgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ukdVWxs+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ukdVWxs+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C9AB1FD4F;
	Thu,  8 Feb 2024 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHaUWbHuCE4XPMHWcOIlrQp6LAFSDbmykNs1Sjt4u94=;
	b=ukdVWxs+3AYDFucQ4wiJdkUyePJ8IPNY+NIZuEONTOYndzZ22DrnxG3/cy4K83dtolZa+H
	5Aec69tyI5iC2GCiqZX/VGgDsccIJO8MqYk0H7mJQQ2j/BhA1JfNUUXFEXm1ABzynVKAdA
	2QXyBvYvfNmscB6aUs813YYEVuCW8aM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHaUWbHuCE4XPMHWcOIlrQp6LAFSDbmykNs1Sjt4u94=;
	b=ukdVWxs+3AYDFucQ4wiJdkUyePJ8IPNY+NIZuEONTOYndzZ22DrnxG3/cy4K83dtolZa+H
	5Aec69tyI5iC2GCiqZX/VGgDsccIJO8MqYk0H7mJQQ2j/BhA1JfNUUXFEXm1ABzynVKAdA
	2QXyBvYvfNmscB6aUs813YYEVuCW8aM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 868DE13984;
	Thu,  8 Feb 2024 09:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DCXaIDCYxGWWDgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 08 Feb 2024 09:00:32 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/14] btrfs: change BUG_ONs to assertions in btrfs_qgroup_trace_subtree()
Date: Thu,  8 Feb 2024 09:59:59 +0100
Message-ID: <3a8d00bf5a842f4d54986834be0755386b88529c.1707382595.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707382595.git.dsterba@suse.com>
References: <cover.1707382595.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.22
X-Spamd-Result: default: False [-0.22 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.12)[-0.581];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

The only caller do_walk_down() of btrfs_qgroup_trace_subtree() validates
the value of level and uses it several times before it's passed as an
argument. Same for root_eb that's called 'next' in the caller.

Change both BUG_ONs to assertions as this is to assure proper interface
use rather than real errors.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/qgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5470e1cdf10c..cfe366110a69 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2505,8 +2505,8 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	struct extent_buffer *eb = root_eb;
 	struct btrfs_path *path = NULL;
 
-	BUG_ON(root_level < 0 || root_level >= BTRFS_MAX_LEVEL);
-	BUG_ON(root_eb == NULL);
+	ASSERT(0 <= root_level && root_level < BTRFS_MAX_LEVEL);
+	ASSERT(root_eb != NULL);
 
 	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
-- 
2.42.1


