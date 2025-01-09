Return-Path: <linux-btrfs+bounces-10817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04197A0730F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656A13A8667
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A837218E94;
	Thu,  9 Jan 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H0fXeEOW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H0fXeEOW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F2D218ACA
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418244; cv=none; b=e5F+a7FbrWRpukTX+9Cjtrg1sxnYSmz93A0KApfWcHk8YeNWoxSOG0TqQWX+rSBPOw13/U2dhfgEgpBMWsEpMINyaWfqj8BX+Ub7Z4Cg5PYWZkDFL0YDuB0hSjbxkvk39OiwA4X5zXLvwkmNKZ+lIm7cVA5QIWku1ZMZ+sgjHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418244; c=relaxed/simple;
	bh=H6EYBj2FPr9s24RFgqoCQa7ZiHASXIlK0YRchVJY4Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPXi8/7iOD8jbMZXzyYR5ZbfHt5U4RDLScONfbc/PS6FYt75WC4SIRMHTsmk11sLOlRLmyH72aWzl2Nbnu3mfp7iHGQFgFO0m3StILA77o0P/1M5Jt08LDM82gGmerZ3nkpJxTYGEStrSPSkZb4lB/GIhYg+l1KUmO9l7VTT/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H0fXeEOW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H0fXeEOW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DBAE1F385;
	Thu,  9 Jan 2025 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHIQq20xDJLStEt1mfp4bxqMMdd9homXWlFr1lWyv5M=;
	b=H0fXeEOWJ2bMxWLzlobRuxGoYzPv0KnpA9DeQgW2UZBNoYgHHIZKuu9RAvlCzFwFzW2Li9
	iUR+SvkbkI3xlCOFrfPIwbsJDdaXYjr1OGFs/Ajf9PIezdGeShFgCymZRyELYPMcHEhIiI
	ntYa8k1J1l8Ov7tkUQJQBMvcnU5ZsOc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHIQq20xDJLStEt1mfp4bxqMMdd9homXWlFr1lWyv5M=;
	b=H0fXeEOWJ2bMxWLzlobRuxGoYzPv0KnpA9DeQgW2UZBNoYgHHIZKuu9RAvlCzFwFzW2Li9
	iUR+SvkbkI3xlCOFrfPIwbsJDdaXYjr1OGFs/Ajf9PIezdGeShFgCymZRyELYPMcHEhIiI
	ntYa8k1J1l8Ov7tkUQJQBMvcnU5ZsOc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 762C6139AB;
	Thu,  9 Jan 2025 10:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2ZPXHL+jf2cYEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:23:59 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/18] btrfs: drop unused parameter fs_info to btrfs_delete_delayed_insertion_item()
Date: Thu,  9 Jan 2025 11:23:59 +0100
Message-ID: <8a80b0aff2dea034036a53eba24b2850ac15fad2.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
References: <cover.1736418116.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index f9f1a972a6f7..0b4933c6a889 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1555,8 +1555,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_delete_delayed_insertion_item(struct btrfs_fs_info *fs_info,
-					       struct btrfs_delayed_node *node,
+static int btrfs_delete_delayed_insertion_item(struct btrfs_delayed_node *node,
 					       u64 index)
 {
 	struct btrfs_delayed_item *item;
@@ -1614,7 +1613,7 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	if (IS_ERR(node))
 		return PTR_ERR(node);
 
-	ret = btrfs_delete_delayed_insertion_item(trans->fs_info, node, index);
+	ret = btrfs_delete_delayed_insertion_item(node, index);
 	if (!ret)
 		goto end;
 
-- 
2.47.1


