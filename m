Return-Path: <linux-btrfs+bounces-11854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD1CA45ABA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53C73A64EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C526FA4B;
	Wed, 26 Feb 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iU8nCZsb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iU8nCZsb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6012459C3
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563500; cv=none; b=SI0XqtxrdQflN+2Q97aw+8g1cAZIGEQ6MY8I7y636jd5k8WBlGkeCKxAjWKAQ9mbgZc1Jhqa9cPJ71jrnXgO01JgBddZBKVY7YTF0wmEDNCE+XF4+k3sHxQ/74GBy3Coei7xu2IlOmVJ4ff0jHD611WohchHNDdhvU00aozTPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563500; c=relaxed/simple;
	bh=wZG/e8nzUP/Qzj9bDy1bHzYMUbzowPPCIbRvOM6wPaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNSoWazjS5oanPNxxebdpDHvP+DST9u0O8UEBiPfQKLCF2YWwYHcOUnCm9oURbc2bZGxuQmpdGFJPy8LSy1wexZuKrl7SIoQRz4iJKpNsV2uMkcRIm1FOLAs42vNMFSpHB14PwrhY79svOJFPpv7vkILiV/NK0BEe7JOmOQof1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iU8nCZsb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iU8nCZsb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D5BD1F453;
	Wed, 26 Feb 2025 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wj0aoRaLL9AEdDzNElrG39FLbv0T/M/GnybviHJ3TRg=;
	b=iU8nCZsbVp6tYKyD6Hvh9DzIMrGmBdLhUlQyb61I+0Mc5lPYb7iBW1L45gTdpuI9kTg6DK
	zrbTNj0xoEZWCA/kIv8FU94zShXcKWUvDjJvgrYYDTtL6FKC9Y/ZyMpweF17kYIF7/9zsM
	SG6vlms5qu40eeJvEoUk7aCPjxVWAtg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wj0aoRaLL9AEdDzNElrG39FLbv0T/M/GnybviHJ3TRg=;
	b=iU8nCZsbVp6tYKyD6Hvh9DzIMrGmBdLhUlQyb61I+0Mc5lPYb7iBW1L45gTdpuI9kTg6DK
	zrbTNj0xoEZWCA/kIv8FU94zShXcKWUvDjJvgrYYDTtL6FKC9Y/ZyMpweF17kYIF7/9zsM
	SG6vlms5qu40eeJvEoUk7aCPjxVWAtg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4736813A53;
	Wed, 26 Feb 2025 09:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id paRgEQjkvmcdYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:04 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_init_dev_replace()
Date: Wed, 26 Feb 2025 10:51:03 +0100
Message-ID: <60fba2d433647c3cdc156a7b043fd21a44bf288e.1740562070.git.dsterba@suse.com>
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
 fs/btrfs/dev-replace.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f86fbea0b3de..147c5494adf9 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -76,7 +76,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 	struct extent_buffer *eb;
 	int slot;
 	int ret = 0;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	int item_size;
 	struct btrfs_dev_replace_item *ptr;
 	u64 src_devid;
@@ -85,10 +85,8 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		return 0;
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!path)
+		return -ENOMEM;
 
 	key.objectid = 0;
 	key.type = BTRFS_DEV_REPLACE_KEY;
@@ -103,8 +101,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		if (btrfs_find_device(fs_info->fs_devices, &args)) {
 			btrfs_err(fs_info,
 			"found replace target device without a valid replace item");
-			ret = -EUCLEAN;
-			goto out;
+			return -EUCLEAN;
 		}
 		ret = 0;
 		dev_replace->replace_state =
@@ -123,7 +120,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		dev_replace->tgtdev = NULL;
 		dev_replace->is_valid = 0;
 		dev_replace->item_needs_writeback = 0;
-		goto out;
+		return ret;
 	}
 	slot = path->slots[0];
 	eb = path->nodes[0];
@@ -226,8 +223,6 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		break;
 	}
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.47.1


