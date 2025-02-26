Return-Path: <linux-btrfs+bounces-11850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A467A45AB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5B97A738B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FFA23817B;
	Wed, 26 Feb 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X4DHdOSD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X4DHdOSD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52426D5B4
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563486; cv=none; b=fIHD7ezg6rejp2+Veg74gkUxakjgVcwl63zAmBk9t8+7ze15u2EM4/6ZtgTYt/27+n25Rh/GYSERjPyGJhMb9n4d+Er2iX3XB6K8Z5JVS3ZvF60KcTJ8CcA4tKWP9sGyKXKdWCUPZi3VVdYrmLKWxu1azprHoOubCIVbtRhUpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563486; c=relaxed/simple;
	bh=kCMDyONR1PSWYW3Oi0g0UlqTyATn/fc98f5n+SAH7tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSmQdIShMArfnTgfy/SW7rotjHZcU60kQCvGsIFwy+VpLen49Lv/af2FBQh70XqTzwoIOt0QHuvH03FEkxfBw94lriTj8KgC51HuXlDyxwTxPkWaqBosLIbCBPuzMo2t4uoj+tpom62IxxNxERC5PtE+Dqd5HGhKgsuEsr4ITBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X4DHdOSD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X4DHdOSD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8126F1F38D;
	Wed, 26 Feb 2025 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02bTQrvo+vrbmDvdoMb5TNn1TbTjxqBPhjlV/nlMD0Y=;
	b=X4DHdOSDq0ece2lIVJIpUrCh16kxxjyYzpB6nEPCm6Qy4+B7OEbSgc+in9nrvjBwQopu2z
	x9/2gMh9ZjHNCjlz708xkV8V9Dy221QwC2LJBtkvmW/pUTg18mG2sHfeMLCDu+1v9V1XKf
	q4ev+mN3EqdbaRxdQOzF3tQbAZ7fDLY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=X4DHdOSD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02bTQrvo+vrbmDvdoMb5TNn1TbTjxqBPhjlV/nlMD0Y=;
	b=X4DHdOSDq0ece2lIVJIpUrCh16kxxjyYzpB6nEPCm6Qy4+B7OEbSgc+in9nrvjBwQopu2z
	x9/2gMh9ZjHNCjlz708xkV8V9Dy221QwC2LJBtkvmW/pUTg18mG2sHfeMLCDu+1v9V1XKf
	q4ev+mN3EqdbaRxdQOzF3tQbAZ7fDLY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AFC113A53;
	Wed, 26 Feb 2025 09:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UGwEHgPkvmcTYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:50:59 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_insert_item()
Date: Wed, 26 Feb 2025 10:50:59 +0100
Message-ID: <ef580915ca88c1ab707865c3fa777a577c34cefe.1740562070.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 8126F1F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
 fs/btrfs/ctree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3dc5a35dd19b..4d02227e9498 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4306,7 +4306,7 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      u32 data_size)
 {
 	int ret = 0;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	unsigned long ptr;
 
@@ -4320,7 +4320,6 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		write_extent_buffer(leaf, data, ptr, data_size);
 		btrfs_mark_buffer_dirty(trans, leaf);
 	}
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.47.1


