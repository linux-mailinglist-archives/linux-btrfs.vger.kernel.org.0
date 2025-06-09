Return-Path: <linux-btrfs+bounces-14564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15035AD24C1
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232653A360F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807BA21B9FE;
	Mon,  9 Jun 2025 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YNWQ2Zke";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YNWQ2Zke"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC521B9D6
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488986; cv=none; b=XKFSXVfkvhH9QmG9tLcBthr1riT1PxzdcXwNyCNSzttoQj4Ey2B/ZO80FcYFaXxMPF/gzdp3Sqa183u9bqcXqQbR0Uu9I21wkYj39LaowhxdEYPBHK8ENLwyHkH5UQoR2dI4aPvOxqNsJR8xjPyU/UZVLN61ADArv5jt1B++JxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488986; c=relaxed/simple;
	bh=ktO2P3fe9J6kcFdFZ7tYV3nAFBe4f14pXrBflmD6NrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhX5DO77t8Igy2PK9T/wHLdrGvn3uZ+jAr3zZcYee4zIeN/akFOqTzn1rCwcgjTOkqPTtfOlSu3CtR5U+tNKwJcfew5hRCAb23LoC3HG3GWM4ZG9ssZ5Isbb73kQd0yIkFu/+/ZIYA/z11wC15w6NEhnzvwX0lx3O54z4dCWnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YNWQ2Zke; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YNWQ2Zke; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A137E1F78A;
	Mon,  9 Jun 2025 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bumlt/sh+GcqW1WEzHCwA/xEVZ9dK8t0RM9FtHGDnCk=;
	b=YNWQ2ZkeM6MrqZLPR8Pu+0mM3YWk9eNFyJ5IaE+JDCIIt4KxVYup3oDjAWpYttCXYOPJgn
	uMG+I2/glPsebqitcTSVxOuuPm+3oaMM1hbBp8VCRgwFPScNdh9xtMo2PhSQ+OJjD+3FOx
	CLuX1IY0zC4Vae4BsWzAJ7zxYRSzQ2A=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bumlt/sh+GcqW1WEzHCwA/xEVZ9dK8t0RM9FtHGDnCk=;
	b=YNWQ2ZkeM6MrqZLPR8Pu+0mM3YWk9eNFyJ5IaE+JDCIIt4KxVYup3oDjAWpYttCXYOPJgn
	uMG+I2/glPsebqitcTSVxOuuPm+3oaMM1hbBp8VCRgwFPScNdh9xtMo2PhSQ+OJjD+3FOx
	CLuX1IY0zC4Vae4BsWzAJ7zxYRSzQ2A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DB4B137FE;
	Mon,  9 Jun 2025 17:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dFuVIlAVR2iGHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:09:36 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/11] btrfs: open code rcu_string_free() and remove it
Date: Mon,  9 Jun 2025 19:09:21 +0200
Message-ID: <047aa58f496622c52fcc7e39d9238267cbae75a2.1749488829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749488829.git.dsterba@suse.com>
References: <cover.1749488829.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
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
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

The helper is trivial and we can simply use kfree_rcu() if needed. In
our case it's just one place where we rename a device in
device_list_add() and the old name can still be used until the end of
the RCU grace period. The other case is freeing a device and there
nothing should reach the device, so we can use plain kfree().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/rcu-string.h | 6 ------
 fs/btrfs/volumes.c    | 5 +++--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/rcu-string.h b/fs/btrfs/rcu-string.h
index 1c2d7cb1fe6f63..7f35cf75b50ff3 100644
--- a/fs/btrfs/rcu-string.h
+++ b/fs/btrfs/rcu-string.h
@@ -32,12 +32,6 @@ static inline struct rcu_string *rcu_string_strdup(const char *src, gfp_t mask)
 	return ret;
 }
 
-static inline void rcu_string_free(struct rcu_string *str)
-{
-	if (str)
-		kfree_rcu(str, rcu);
-}
-
 #define printk_in_rcu(fmt, ...) do {	\
 	rcu_read_lock();		\
 	printk(fmt, __VA_ARGS__);	\
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ff80ac2ab53377..70821a46bfb358 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -403,7 +403,8 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid)
 static void btrfs_free_device(struct btrfs_device *device)
 {
 	WARN_ON(!list_empty(&device->post_commit_list));
-	rcu_string_free(device->name);
+	/* No need to call kfree_rcu(), nothing is reading the device name. */
+	kfree(device->name);
 	btrfs_extent_io_tree_release(&device->alloc_state);
 	btrfs_destroy_dev_zone_info(device);
 	kfree(device);
@@ -962,7 +963,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-ENOMEM);
 		}
-		rcu_string_free(device->name);
+		kfree_rcu(device->name, rcu);
 		rcu_assign_pointer(device->name, name);
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
 			fs_devices->missing_devices--;
-- 
2.49.0


