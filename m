Return-Path: <linux-btrfs+bounces-11863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E92A45AC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C6716622C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D924E014;
	Wed, 26 Feb 2025 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kGc//fnX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kGc//fnX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108924DFF6
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563530; cv=none; b=T6agqWIdDdivnjJxAYpEn67JZ2pDC0aFaqJIGju/XtsSgf9/NNlGzsdpfrt67u3ZdPIjd1rLiauSA+D8EpsUZOXuw/OM4U8tl4nf3kSxaUsdYlbLAd1A7HsSWT+yLESp0lLVP/CZHxKrDYw6qG55QnwuQOxf33qZ8waEHdVTFgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563530; c=relaxed/simple;
	bh=ryzNtez5nSnBHwbQ/yL+MZDRGJtx2UrFJW3y49ghlo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X78yp4bJC9HQfI+3bHKZ/YaGr14ekwRs+o6QhmVg+fhOFbCricy+OnQs2I/salbutbMiTBeUIsgsrItNNARtsCvGOVRlJun4/mrtE2ydvg34Mgo7VejuxZMMO5uqi1egSIsn8CWtXN4xRX8ytxvkf/DissrH5HgOB9wNwE9r53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kGc//fnX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kGc//fnX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1F671F460;
	Wed, 26 Feb 2025 09:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OF02yz7ReRsET/3WKQkaDgesRw4aVZ291+D8pQ+Yj8=;
	b=kGc//fnXm0/r5cKdIOcDmBnxXmfqPR7chFPUoD4uV56kYnZmKvTzHxtqTnMQGAQEzv8b9P
	Caqu2zHrlr18laRaHAeWD0yfM+ihH8lWNPaya10jU7ZznuBW9e9wC2LlE1R0WgJifADCKG
	jHaZkMLDKn7+TUxvQcoNA3eqT4EHmho=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OF02yz7ReRsET/3WKQkaDgesRw4aVZ291+D8pQ+Yj8=;
	b=kGc//fnXm0/r5cKdIOcDmBnxXmfqPR7chFPUoD4uV56kYnZmKvTzHxtqTnMQGAQEzv8b9P
	Caqu2zHrlr18laRaHAeWD0yfM+ihH8lWNPaya10jU7ZznuBW9e9wC2LlE1R0WgJifADCKG
	jHaZkMLDKn7+TUxvQcoNA3eqT4EHmho=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB43313A53;
	Wed, 26 Feb 2025 09:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sx3BLR3kvmdEYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:25 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 17/27] btrfs: use BTRFS_PATH_AUTO_FREE in __btrfs_inc_extent_ref()
Date: Wed, 26 Feb 2025 10:51:25 +0100
Message-ID: <8939c1e18e24ebc669659a7931e8ba8f405fad13.1740562070.git.dsterba@suse.com>
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
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f0dbb96651d6..9c1bd8831e83 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1483,7 +1483,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 				  struct btrfs_delayed_ref_node *node,
 				  struct btrfs_delayed_extent_op *extent_op)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_extent_item *item;
 	struct btrfs_key key;
@@ -1504,7 +1504,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 					   node->parent, node->ref_root, owner,
 					   offset, refs_to_add, extent_op);
 	if ((ret < 0 && ret != -EAGAIN) || !ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Ok we had -EAGAIN which means we didn't have space to insert and
@@ -1529,8 +1529,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
-- 
2.47.1


