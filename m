Return-Path: <linux-btrfs+bounces-8708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B9996DE0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E7C1C203BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A881AC8;
	Wed,  9 Oct 2024 14:31:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE818EAD
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484295; cv=none; b=W+YimQAj+XcxSOGSBBpde30IZ5ioUizavv1uzL1IEgDSTJSelnT+3CZlA/OQ1ekdUq4NhzaDh+Uc3zaS2sAm+A6RIwFfKVMb8o2IuAf2c8si8T5q09aMQSuGPfwW8LOnUaaf4OqX9DGnZfdl510+H9toTUBo/IbwVgNBfG7V0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484295; c=relaxed/simple;
	bh=wcG+rpjOmuDKC3qg5wSEAx8J9p5YsFW+JLYW+2gimJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKMa94+0vVzAuktkjnPqHP5J8gpW7+D1z+tCjYH7SQ6W2QZbdvPGs3Bu+TS9XwvFYYwnvsBSA1hHnG9P9nwNwjCIi/HmmTKe/XNBodiRmC924Z/590VVPB7RtcR9BHyS4mD4AbbacY9++1o1s2ezuLaYswIJxPusy9SzpvvREt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5213B1F7C8;
	Wed,  9 Oct 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B3D4136BA;
	Wed,  9 Oct 2024 14:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s5FZEsSTBmcyRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:32 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 13/25] btrfs: drop unused parameter argp from btrfs_ioctl_quota_rescan_wait()
Date: Wed,  9 Oct 2024 16:31:28 +0200
Message-ID: <e7a74999e28efa485d277082148f65fb9af3377c.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5213B1F7C8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

We don't need the user passed parameter, rescan is a filesystem
operation so fs_info is sufficient.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 226c91fe31a7..28b9b7fda578 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4058,8 +4058,7 @@ static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static long btrfs_ioctl_quota_rescan_wait(struct btrfs_fs_info *fs_info,
-						void __user *arg)
+static long btrfs_ioctl_quota_rescan_wait(struct btrfs_fs_info *fs_info)
 {
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -4812,7 +4811,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_QUOTA_RESCAN_STATUS:
 		return btrfs_ioctl_quota_rescan_status(fs_info, argp);
 	case BTRFS_IOC_QUOTA_RESCAN_WAIT:
-		return btrfs_ioctl_quota_rescan_wait(fs_info, argp);
+		return btrfs_ioctl_quota_rescan_wait(fs_info);
 	case BTRFS_IOC_DEV_REPLACE:
 		return btrfs_ioctl_dev_replace(fs_info, argp);
 	case BTRFS_IOC_GET_SUPPORTED_FEATURES:
-- 
2.45.0


