Return-Path: <linux-btrfs+bounces-13340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14240A995D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682147A93C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7E28937A;
	Wed, 23 Apr 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sHJVyk5i";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sHJVyk5i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFEC288CA0
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427262; cv=none; b=I7OrjXmdDaq4a+YKDhywzuWPLktj5Jzlqrugmd67G67KbwvtZmzUmz+WWaiUWN329rl1uOv7HB1CJIo/XLHDRj3e/NU/lpKN+nLWeOJG6PzuZhiADHuqu3d4rDbCyEtJXzxVIGzBp9H6Cjoj+xtaPBvrc8NB3omr8j32PCaNxr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427262; c=relaxed/simple;
	bh=UMvh53l3az6TLlHBiqvfuMaop56qSOjs4FC267GDd64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBUD0eyp2z+XUuRj1pcZvQMq0lBRkxMHSvx6L4kagnFKaxxw8R7OzKAVIjTFG3U+vovtiwJ2RMvZex3sZFpemKjhC4zkr842HGmEXsWX86Wfd2qeDAg7OriyVMCc4RXVCnxSXgiKjV+GDSA1xfh0248tXHBnLujGnQeTSGVn8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sHJVyk5i; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sHJVyk5i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 764F821186;
	Wed, 23 Apr 2025 16:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745427257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtxWaz5oom+/jwXHncd7ujZFSxsuANOw3yYoxJ4LN6c=;
	b=sHJVyk5in4sACUcG6J8+U7w9HmisMufO9bWknmkD04M7KRhB/8JDXsF22zLYBvPXAVxoi/
	vYlkwSbzyGh3t+LCuXVUDHOF+enYM2tfx4aVDw8O3iBvIZcwHSp+shxw9znSGy05qX8+Jr
	kOdfFiGGsFBaUQwP7m6tiWDVREitalQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sHJVyk5i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745427257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtxWaz5oom+/jwXHncd7ujZFSxsuANOw3yYoxJ4LN6c=;
	b=sHJVyk5in4sACUcG6J8+U7w9HmisMufO9bWknmkD04M7KRhB/8JDXsF22zLYBvPXAVxoi/
	vYlkwSbzyGh3t+LCuXVUDHOF+enYM2tfx4aVDw8O3iBvIZcwHSp+shxw9znSGy05qX8+Jr
	kOdfFiGGsFBaUQwP7m6tiWDVREitalQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ED1A13A3D;
	Wed, 23 Apr 2025 16:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JG8LGzkbCWhNGQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 16:54:17 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: switch int dev_replace_is_ongoing variables/parameters to bool
Date: Wed, 23 Apr 2025 18:53:58 +0200
Message-ID: <eb4edd395b6535a00c517aeee21413403d31c120.1745426584.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745426584.git.dsterba@suse.com>
References: <cover.1745426584.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 764F821186
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Both the variable and the parameter are used as logical indicators so
convert them to bool.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c120f82dccdf59..5aa16f5016a9dd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6079,7 +6079,7 @@ static int btrfs_read_rr(const struct btrfs_chunk_map *map, int first, int num_s
 
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct btrfs_chunk_map *map, int first,
-			    int dev_replace_is_ongoing)
+			    bool dev_replace_is_ongoing)
 {
 	const enum btrfs_read_policy policy = READ_ONCE(fs_info->fs_devices->read_policy);
 	int i;
@@ -6687,7 +6687,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	int num_copies;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
-	int dev_replace_is_ongoing = 0;
+	bool dev_replace_is_ongoing = false;
 	u16 num_alloc_stripes;
 	u64 max_len;
 
-- 
2.49.0


