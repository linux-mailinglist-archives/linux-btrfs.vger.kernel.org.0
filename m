Return-Path: <linux-btrfs+bounces-7582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBD696198D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD96528527C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FCF1D4169;
	Tue, 27 Aug 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="efnuQLJB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="efnuQLJB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E271D415B
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795730; cv=none; b=YII/dY5xDw1mqknwQ4gPEKMi9SMR86tyNdoOnVHi6+cEMb/iyq98LJoiqxepAGI00VJTDfwAuHCML7thfIanKi8ut1tOZkvpM9eaTYFX4k3T6i7ahRjE6SWWUY4Q7DSQB9WvdWOc0HsEuTkxWt7jYYhbyuFUj+84tbi2biiOGP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795730; c=relaxed/simple;
	bh=B0w8AViltyKKA+Kdo4rEerz9W/4LXz41frMiR4JyDoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxcIZD37MSIsjlwRTfQMSUL6Ff7GRaSNmqGq6wQL4LEL07RgOQ7p34Fj/xiXjqlGqsQsCWGl8tEkqS7Rq9YLS7LrhgU/vu3rs/XU4U/imvs+jzUGKa+6KkCDCRy+DbxUOxlDnQlzvfbxhdYIo+AZ4MyKTerljR1pJEbssb3hfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=efnuQLJB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=efnuQLJB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E1FD1FB92;
	Tue, 27 Aug 2024 21:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0NDsgXaH9JrC7FVCUqgqfTasKcdaBCUwsl/TI5kpWQ=;
	b=efnuQLJBbGdV+HdZg17HJBvGbSvDxmsFR9ra8kx4AAWEHLKOuiZQf7DN90ZtH2AIbTVe3r
	M5MQW29BBwkREXSPiyBXL6NH9DIpKr27y7oxP/SwN/RFUgbu+glYTj+PkT9rObwGFQJeJW
	o0lOow8ycg3Q1EdIR02ApkR1Uv/Bw/o=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0NDsgXaH9JrC7FVCUqgqfTasKcdaBCUwsl/TI5kpWQ=;
	b=efnuQLJBbGdV+HdZg17HJBvGbSvDxmsFR9ra8kx4AAWEHLKOuiZQf7DN90ZtH2AIbTVe3r
	M5MQW29BBwkREXSPiyBXL6NH9DIpKr27y7oxP/SwN/RFUgbu+glYTj+PkT9rObwGFQJeJW
	o0lOow8ycg3Q1EdIR02ApkR1Uv/Bw/o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 179BB13A20;
	Tue, 27 Aug 2024 21:55:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +QLBBU9LzmaKGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:27 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/12] btrfs: rename __compare_inode_defrag() and drop double underscores
Date: Tue, 27 Aug 2024 23:55:26 +0200
Message-ID: <6f799faaf6cf515d0bd0c1825e15d3cdce201a4a.1724795624.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724795623.git.dsterba@suse.com>
References: <cover.1724795623.git.dsterba@suse.com>
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

The function does not follow the pattern where the underscores would be
justified, so rename it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index f6dbda37a361..e2949f630584 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -45,7 +45,7 @@ struct inode_defrag {
 	u32 extent_thresh;
 };
 
-static int __compare_inode_defrag(struct inode_defrag *defrag1,
+static int compare_inode_defrag(struct inode_defrag *defrag1,
 				  struct inode_defrag *defrag2)
 {
 	if (defrag1->root > defrag2->root)
@@ -83,7 +83,7 @@ static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
 		parent = *p;
 		entry = rb_entry(parent, struct inode_defrag, rb_node);
 
-		ret = __compare_inode_defrag(defrag, entry);
+		ret = compare_inode_defrag(defrag, entry);
 		if (ret < 0)
 			p = &parent->rb_left;
 		else if (ret > 0)
@@ -189,7 +189,7 @@ static struct inode_defrag *btrfs_pick_defrag_inode(
 		parent = p;
 		entry = rb_entry(parent, struct inode_defrag, rb_node);
 
-		ret = __compare_inode_defrag(&tmp, entry);
+		ret = compare_inode_defrag(&tmp, entry);
 		if (ret < 0)
 			p = parent->rb_left;
 		else if (ret > 0)
@@ -198,7 +198,7 @@ static struct inode_defrag *btrfs_pick_defrag_inode(
 			goto out;
 	}
 
-	if (parent && __compare_inode_defrag(&tmp, entry) > 0) {
+	if (parent && compare_inode_defrag(&tmp, entry) > 0) {
 		parent = rb_next(parent);
 		if (parent)
 			entry = rb_entry(parent, struct inode_defrag, rb_node);
-- 
2.45.0


