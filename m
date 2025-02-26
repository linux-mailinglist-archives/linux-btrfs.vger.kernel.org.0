Return-Path: <linux-btrfs+bounces-11845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A76A45A9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C73172D8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03B2459C2;
	Wed, 26 Feb 2025 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nLeFCvjp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nLeFCvjp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B1238165
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563470; cv=none; b=B8qKvAYbpW5LSOIPuDClwxtAeWmE1G9zWI1BhGX9O98pss65sUranS/XEvoiuzLm1Rw3s3XYYlwOVWIOs+Vx20EWarcnA4EFuzD39blQzmwJt5QtzHloYR0J3ZMVWFJmHZihYjOEBPEmiv7XVwUoaNqZa54FeXoZaXgpt1wd408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563470; c=relaxed/simple;
	bh=qd8mKfcItCaFVhM1vEJTXRutU8VzEjOernSbj6nQBjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFWb76WQRuTR8dS/eMpLYr5KAEdEXuMNW4A/sA9atj/1duxdAvsPlzHAO5BOhHBYpLsPPB/55uAWx8C96zw/ceICu9xdaehc/C073Yu2lR2Rm3bSippfYBVIv4JPftSRUV5/Knxbt9avaA0RTTqc29TnlByKuP7SAdM3U1/NYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nLeFCvjp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nLeFCvjp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC5F421163;
	Wed, 26 Feb 2025 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTIMy3jloZcVzC1LC/GIop4HufeAuXfVlK4c6u9bgkw=;
	b=nLeFCvjpZ8btbuZsFV26pa2hm3pk8DYmNt3U3el7rkWk2/jKBIw1ZjEv5G17JlsJM+cWh9
	cmtJ7w1dCdf8IcizFvGy34alhFhZhK3v8L1OymCyU5FR6EN1eHFsJJLzD2EcD3lbY92rG7
	G93hBFyr9TaHmZZfbza5zc2Rg5c8E8g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nLeFCvjp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTIMy3jloZcVzC1LC/GIop4HufeAuXfVlK4c6u9bgkw=;
	b=nLeFCvjpZ8btbuZsFV26pa2hm3pk8DYmNt3U3el7rkWk2/jKBIw1ZjEv5G17JlsJM+cWh9
	cmtJ7w1dCdf8IcizFvGy34alhFhZhK3v8L1OymCyU5FR6EN1eHFsJJLzD2EcD3lbY92rG7
	G93hBFyr9TaHmZZfbza5zc2Rg5c8E8g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5B9413A53;
	Wed, 26 Feb 2025 09:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4tZzKArkvmcjYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:06 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_run_dev_replace()
Date: Wed, 26 Feb 2025 10:51:06 +0100
Message-ID: <9f6ff1cec3e541f715e3f8129d1d397ab74ecd29.1740562070.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: AC5F421163
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/dev-replace.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 147c5494adf9..1a82e88ec5c1 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -341,7 +341,7 @@ int btrfs_run_dev_replace(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret;
 	struct btrfs_root *dev_root = fs_info->dev_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *eb;
 	struct btrfs_dev_replace_item *ptr;
@@ -360,16 +360,15 @@ int btrfs_run_dev_replace(struct btrfs_trans_handle *trans)
 	key.offset = 0;
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!path)
+		return -ENOMEM;
+
 	ret = btrfs_search_slot(trans, dev_root, &key, path, -1, 1);
 	if (ret < 0) {
 		btrfs_warn(fs_info,
 			   "error %d while searching for dev_replace item!",
 			   ret);
-		goto out;
+		return ret;
 	}
 
 	if (ret == 0 &&
@@ -390,7 +389,7 @@ int btrfs_run_dev_replace(struct btrfs_trans_handle *trans)
 			btrfs_warn(fs_info,
 				   "delete too small dev_replace item failed %d!",
 				   ret);
-			goto out;
+			return ret;
 		}
 		ret = 1;
 	}
@@ -403,7 +402,7 @@ int btrfs_run_dev_replace(struct btrfs_trans_handle *trans)
 		if (ret < 0) {
 			btrfs_warn(fs_info,
 				   "insert dev_replace item failed %d!", ret);
-			goto out;
+			return ret;
 		}
 	}
 
@@ -435,8 +434,6 @@ int btrfs_run_dev_replace(struct btrfs_trans_handle *trans)
 		dev_replace->cursor_right);
 	dev_replace->item_needs_writeback = 0;
 	up_write(&dev_replace->rwsem);
-out:
-	btrfs_free_path(path);
 
 	return ret;
 }
-- 
2.47.1


