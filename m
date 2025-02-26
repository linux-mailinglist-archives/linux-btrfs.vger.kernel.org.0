Return-Path: <linux-btrfs+bounces-11844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B6EA45A9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD621894E1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D423816C;
	Wed, 26 Feb 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QjX5uJYe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QjX5uJYe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4B238165
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563465; cv=none; b=WJFJC0takdHQfgeYnD7FHNXPd15Mke+jhZBWJsRv6wWIRePfAu1rccy+dJbL6Y+kqZcE54KR/Y2vzGjnqCOLziYreJL+j+TXvI0WVhdOs3hUIO/189judQQheCli//1qUXhQDnr4boHl7Ixml1g3+69bKkVGr8RMvCgubUmSXYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563465; c=relaxed/simple;
	bh=IoNgrX7AsjsTueJsV01r3OXt+er462dbQ/9rReIj5CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhWshNYFpPFBqPAdbzjpSyEek5wAlYOUOMJZxCt+e6snfj/VysV6lo0eur8YvddHNYcOvXjn7xtehPHI7pmfuhNwX5AOabO5oFPw+WVDuj91a+hgu/ztA/AjtTB2aoH8YsnlNem33TpVslzQo5bVUFKYqfz7FIpUyPuddcBtsRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QjX5uJYe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QjX5uJYe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 565551F38A;
	Wed, 26 Feb 2025 09:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkQRV8CRlvLoNvtYR6J/iWwaQHSw/k6hhVMV309dKqM=;
	b=QjX5uJYeV+whmBdJR+2rTWTTJIYAh2PrXXrYWvlvAiH3ACuyqiW2JHdj5UCufkRJsftdxj
	Zbf9MLtvDZwIamtB9S7GzoXPHkULJcXvKYcBK0XUVpsH1Y2FhYnUlkW/FPKVGf7xB7RGRs
	nCLWLOLRHyNfal/wE3WCg8s4HYKzCIs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QjX5uJYe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkQRV8CRlvLoNvtYR6J/iWwaQHSw/k6hhVMV309dKqM=;
	b=QjX5uJYeV+whmBdJR+2rTWTTJIYAh2PrXXrYWvlvAiH3ACuyqiW2JHdj5UCufkRJsftdxj
	Zbf9MLtvDZwIamtB9S7GzoXPHkULJcXvKYcBK0XUVpsH1Y2FhYnUlkW/FPKVGf7xB7RGRs
	nCLWLOLRHyNfal/wE3WCg8s4HYKzCIs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FB7113A53;
	Wed, 26 Feb 2025 09:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JPRyE/zjvmcBYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:50:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_setup_space_cache()
Date: Wed, 26 Feb 2025 10:50:51 +0100
Message-ID: <a84e42979c660f457634932e94b8867f8bfe8adc.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 565551F38A
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
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

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9c689e7982c2..d99e5ed307d5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3303,7 +3303,7 @@ int btrfs_setup_space_cache(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *cache, *tmp;
 	struct btrfs_transaction *cur_trans = trans->transaction;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	if (list_empty(&cur_trans->dirty_bgs) ||
 	    !btrfs_test_opt(fs_info, SPACE_CACHE))
@@ -3320,7 +3320,6 @@ int btrfs_setup_space_cache(struct btrfs_trans_handle *trans)
 			cache_save_setup(cache, trans, path);
 	}
 
-	btrfs_free_path(path);
 	return 0;
 }
 
-- 
2.47.1


