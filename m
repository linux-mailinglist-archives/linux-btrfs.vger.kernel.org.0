Return-Path: <linux-btrfs+bounces-19097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4573C6A80D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C25CB349DF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5DD3730DE;
	Tue, 18 Nov 2025 16:01:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E636A00E
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481680; cv=none; b=iZoIM1St2uApgZNqmeqgAW6Exp6xSAdtzXe/a999CUKxfADPBlwEJTPXnhATv6ZQeD5Elf/wExBahQSWwfJlKZo12RxsvBiiA5daw0q5PP8ksxWjGdASDfvHHFW/K+petMdONxZr+22rKyxciqCox/GBUZ7op21jWTw88bEriiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481680; c=relaxed/simple;
	bh=VT9cnG2GvDWxzJ6NpsrMcgVQzdOFSgSmN0wjS0VHRD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXbfqtSGLHiccFqx6tP4a3EK1jsFqh/Xsh6PexTte7nCi7ujzG11pHaJj4mTaD1LH1DwtPdwKs1MXtdfNPFOmC3S7591USCXJO754sJMcEAiM+VLlt9qb21afhHMVJtv+XVIJI/u2bQaZcV+mYWZ75uPCeL6ObRYGnaARU+d3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 237AA21296;
	Tue, 18 Nov 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08B293EA61;
	Tue, 18 Nov 2025 16:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sBylAT2YHGkSWgAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 18 Nov 2025 16:01:01 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Boris Burkov <boris@bur.io>,
	Daniel Vacek <neelx.g@gmail.com>
Subject: [PATCH v7 2/6] btrfs: disable verity on encrypted inodes
Date: Tue, 18 Nov 2025 17:00:37 +0100
Message-ID: <20251118160043.3005684-3-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118160043.3005684-1-neelx@suse.com>
References: <20251118160043.3005684-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 237AA21296
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Right now there isn't a way to encrypt things that aren't either
filenames in directories or data on blocks on disk with extent
encryption, so for now, disable verity usage with encryption on btrfs.

fscrypt with fsverity should be possible and it can be implemented
in the future.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Daniel Vacek <neelx.g@gmail.com>
---
 fs/btrfs/verity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 16f5580cba55..06dfcb461f53 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -578,6 +578,9 @@ static int btrfs_begin_enable_verity(struct file *filp)
 
 	btrfs_assert_inode_locked(inode);
 
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return -EOPNOTSUPP;
+
 	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags))
 		return -EBUSY;
 
-- 
2.51.0


