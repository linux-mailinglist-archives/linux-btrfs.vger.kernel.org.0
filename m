Return-Path: <linux-btrfs+bounces-11848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52E3A45AB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A5B7A2899
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0254226BD8A;
	Wed, 26 Feb 2025 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VKHZrO7X";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VKHZrO7X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80F189B91
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563480; cv=none; b=jCGRDnnh8wdKQrWyLwYkaG4IjT2Eut2NWWyWEKKj5jaHkfhmjuQkke+Zs3rkFmUW+taKi6vGazpMAAhtshi2eL+lEXlkdSa/gj4WwxiwPivmA5LCcVPPYz9Aa6Rz7C3gVpEkRU89J+aj2n2gQykY+E0evpFnhFjzLZDCva79jGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563480; c=relaxed/simple;
	bh=goxcNxEpo5eiAzA9rL8zGzEMq0QCtPK5i1XZ51pSEBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRLnoKnyOXJXd8VpRU76WwL/SVsW62knasU/oQ1xhklHczLHuJFmkJTwZQI5h4kTsg/RsZar+ADrijtno+pKQzODFrCekWUoRuTDOBsniVYFE02Dzoeg9HN4u8CAm9TrbphqNtlCG1vfD4s92qcHIU/MTi3/KZWOUWnUgUlgfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VKHZrO7X; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VKHZrO7X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A1971F74C;
	Wed, 26 Feb 2025 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yqhm03BRscF86jWjalX+gK5tzXO9Cavsl39MLcwS78U=;
	b=VKHZrO7XR6YcqyVnxSJ+bYvbFSzJNAgNhbHzqCn+ih6OKfP0jhgOsg5cARw7UHTKF8EL3B
	edx6Bpndng3lN6cOBk7J+WA5HwoDpP7bfO3vFt0IdSgCUpmLEEvXxWylWn5xVA9JStKdb6
	/rTS03aIJbiEKFNjbvPvxtH25eq37+0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yqhm03BRscF86jWjalX+gK5tzXO9Cavsl39MLcwS78U=;
	b=VKHZrO7XR6YcqyVnxSJ+bYvbFSzJNAgNhbHzqCn+ih6OKfP0jhgOsg5cARw7UHTKF8EL3B
	edx6Bpndng3lN6cOBk7J+WA5HwoDpP7bfO3vFt0IdSgCUpmLEEvXxWylWn5xVA9JStKdb6
	/rTS03aIJbiEKFNjbvPvxtH25eq37+0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13A9113A53;
	Wed, 26 Feb 2025 09:50:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WiXKBAHkvmcNYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:50:57 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_write_dirty_block_groups()
Date: Wed, 26 Feb 2025 10:50:56 +0100
Message-ID: <b9cb83eba73e233c56990ac886cfe54a9ad39ab2.1740562070.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 95b14e3351b5..50398aa2fb89 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3507,7 +3507,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 	struct btrfs_transaction *cur_trans = trans->transaction;
 	int ret = 0;
 	int should_put;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct list_head *io = &cur_trans->io_bgs;
 
 	path = btrfs_alloc_path();
@@ -3619,7 +3619,6 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 		btrfs_put_block_group(cache);
 	}
 
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.47.1


