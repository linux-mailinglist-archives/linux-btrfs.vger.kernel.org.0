Return-Path: <linux-btrfs+bounces-11985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F4DA4C3ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA63918959E2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B790213E61;
	Mon,  3 Mar 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oyoxlSI3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oyoxlSI3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E4202F9F
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013747; cv=none; b=Qwt7rxdGJ7irO2QPq9NS1VIPwOwUt5VXzdMZgh4w9osXEWNF6koIR1EZm2lYxczKgN0RAFQyqNXfvyqYaYXfuypiIa9qeW09VZx4T9EmnkGYJEYaulGC3UY2YYvjlIq87npKOlf1oPFw+12rK7R6ED93qhfbrrYLwLpAcGLEJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013747; c=relaxed/simple;
	bh=k6eR/sZeNXp4KKYTUKp0kmGsZ8eXCBixENXM9hlx2Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfATD6i9jPSUurOQmERKBXUfriOg1wpnRMn63f6nQFnsFDyXlLEOv39oIskd6htK+qkrl/pFI/qCYCn7KWHqoqODlv6W/O5yaiNDbH0dQZbuA6gtoihqHBzeChFre0M9fcG/AtilwEMEeu3iyZ7ZT0oXf+Gfapeo5a6UKTYH3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oyoxlSI3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oyoxlSI3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52DC01F444;
	Mon,  3 Mar 2025 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSnwHoFdpgtr2o2XRTNaPpzvhfNHCAqRpcpAa/PkWFQ=;
	b=oyoxlSI3dbrIqJG4Iaub0WFMU5ONPq6pLSJa2UgYA6d6bLnPHaTnS7SYZpx83+r4ILnlDY
	wkI0PDzxN9rnm6w3McjyHhIQNqR+44SOz1stAf4RGQtb4/EclZCoM6xEqxdtCLCm75dcVy
	utAWcz2MMTlN7+TTlJbPzrpwkgNF/Ag=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oyoxlSI3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSnwHoFdpgtr2o2XRTNaPpzvhfNHCAqRpcpAa/PkWFQ=;
	b=oyoxlSI3dbrIqJG4Iaub0WFMU5ONPq6pLSJa2UgYA6d6bLnPHaTnS7SYZpx83+r4ILnlDY
	wkI0PDzxN9rnm6w3McjyHhIQNqR+44SOz1stAf4RGQtb4/EclZCoM6xEqxdtCLCm75dcVy
	utAWcz2MMTlN7+TTlJbPzrpwkgNF/Ag=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C61613939;
	Mon,  3 Mar 2025 14:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mTalEuvCxWdaAwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 03 Mar 2025 14:55:39 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 6/7] btrfs: pass struct to btrfs_ioctl_subvol_getflags()
Date: Mon,  3 Mar 2025 15:55:34 +0100
Message-ID: <1fd9b50f8426d992bec2e0d5977dc2c7b26f06d3.1741012265.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1741012265.git.dsterba@suse.com>
References: <cover.1741012265.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52DC01F444
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Pass a struct btrfs_inode to btrfs_ioctl_subvol_getflags() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a7aff4769a58..188fb7ec32d1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1337,15 +1337,15 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 	return ret;
 }
 
-static noinline int btrfs_ioctl_subvol_getflags(struct inode *inode,
+static noinline int btrfs_ioctl_subvol_getflags(struct btrfs_inode *inode,
 						void __user *arg)
 {
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret = 0;
 	u64 flags = 0;
 
-	if (btrfs_ino(BTRFS_I(inode)) != BTRFS_FIRST_FREE_OBJECTID)
+	if (btrfs_ino(inode) != BTRFS_FIRST_FREE_OBJECTID)
 		return -EINVAL;
 
 	down_read(&fs_info->subvol_sem);
@@ -5243,7 +5243,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_SNAP_DESTROY_V2:
 		return btrfs_ioctl_snap_destroy(file, argp, true);
 	case BTRFS_IOC_SUBVOL_GETFLAGS:
-		return btrfs_ioctl_subvol_getflags(inode, argp);
+		return btrfs_ioctl_subvol_getflags(BTRFS_I(inode), argp);
 	case BTRFS_IOC_SUBVOL_SETFLAGS:
 		return btrfs_ioctl_subvol_setflags(file, argp);
 	case BTRFS_IOC_DEFAULT_SUBVOL:
-- 
2.47.1


