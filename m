Return-Path: <linux-btrfs+bounces-11847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849F8A45AAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7802F173209
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34132267B82;
	Wed, 26 Feb 2025 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WIRgWNTy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vLkBnkQ/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E624E005
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563478; cv=none; b=tgQthXzy2gaZuiUvDOz0ZB4QecN8ccP9tE32a/Py8eIpitDCGlW1ARK8qKeQ27wQnYLjF9m1Fsor4tg5ZCWCrpuyBR0KT9EkmsMt7qes1m423teGKY6Jc909XUy0joHtAV/8CkDQoAntU65erfGwKQVeLQbcjp79tmNHbzBvhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563478; c=relaxed/simple;
	bh=QMMnnhVpB17iATrsrT4AjKFQTZ5SU2DrMdNynyNzlbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRqweu0E1fsQSybiN0YusWBPX/z0WqS4dI+pqOW1cbp4XDj/GMjuPIMsYbalry39ozpE1c4hHp0lTheY4Nwjz0d+zt2X10MZ0N2q6/XjMIXHguJlM78PrvaMhcJ/WeK7uwxqecLcYvPC592lBLuA5Vu7YvoWIwcWnlhFETDI/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WIRgWNTy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vLkBnkQ/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 151782116B;
	Wed, 26 Feb 2025 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Th7huJXr0O4D7ikDRozr7vlmXvcFD3zhOVrgm+TM4jE=;
	b=WIRgWNTy1aN4LqvakNquaYilzknWZ6udEsfQg2dBJ20GEJtuQP3r6S/0dAVrSU8Ht9kVpj
	8MTnfb/qx5f+eUHgBxLXK7sDrF+6U6wf/ipZrt2VbtWAAHqS4q7sRIZ84LXe8fPv9DliXP
	/oV39Z4u1spmHLkESFA1u1vPXh3JMnY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Th7huJXr0O4D7ikDRozr7vlmXvcFD3zhOVrgm+TM4jE=;
	b=vLkBnkQ//8Vg/MCHRwgrpiE6BlUNXqsPNMvTWXybWm0x8JWe0dUEAGjdeONPp87oPw9jB5
	g3J7QP9VBVXDFDNDI0Y3GXhj/nrjNowwfkZefBxS5wDjvQZ8MM/mJ7dEHMxhZri+pLzIFP
	EcrEFlLvzwpr7z4xWvUnAv57OPtLIac=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F06B13A53;
	Wed, 26 Feb 2025 09:51:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bjaoAw3kvmclYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:09 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_check_dir_item_collision()
Date: Wed, 26 Feb 2025 10:51:08 +0100
Message-ID: <aea90fcbe26379a413d0394036e592db6b1287e2.1740562070.git.dsterba@suse.com>
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
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/dir-item.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index ccf91de29f80..b29cc31a7c4a 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -236,7 +236,7 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 	int data_size;
 	struct extent_buffer *leaf;
 	int slot;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -251,20 +251,17 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
 		/* Nothing found, we're safe */
-		if (ret == -ENOENT) {
-			ret = 0;
-			goto out;
-		}
+		if (ret == -ENOENT)
+			return 0;
 
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	/* we found an item, look for our name in the item */
 	if (di) {
 		/* our exact name was found */
-		ret = -EEXIST;
-		goto out;
+		return -EEXIST;
 	}
 
 	/* See if there is room in the item to insert this name. */
@@ -273,14 +270,11 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 	slot = path->slots[0];
 	if (data_size + btrfs_item_size(leaf, slot) +
 	    sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(root->fs_info)) {
-		ret = -EOVERFLOW;
-	} else {
-		/* plenty of insertion room */
-		ret = 0;
+		return -EOVERFLOW;
 	}
-out:
-	btrfs_free_path(path);
-	return ret;
+
+	/* Plenty of insertion room. */
+	return 0;
 }
 
 /*
-- 
2.47.1


