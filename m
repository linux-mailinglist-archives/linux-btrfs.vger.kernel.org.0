Return-Path: <linux-btrfs+bounces-21559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP3POEUVimlrGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21559-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:11:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCCC112E8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9965F301D943
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832E385EC9;
	Mon,  9 Feb 2026 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZeoesEu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268AC37A496
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657074; cv=none; b=uWaou/J+OeYi4Jwyms+ifS0DLgn8X6LAPV8ngg90kSy2KieexSDgbg+ihYZ2dSTVTebFytaC/ghS1AkrsOWyw2X0vcvxurCk2jId9naJPYAT4HcrscFEBGZZsY77tpxC+KBrw/do4AgcrX3UXC9T13s7SoqEp737BgaDuarHqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657074; c=relaxed/simple;
	bh=xctYUJyV6qirmHvv+d2XSmcEIj8xkX0B2YkSvCLBRUw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdXV7MPww5mjMzoZdrnXV6Y4FdOnZfd4vYk6FsdUjJgOobJqJ8ombO9ZI2S7tNwra7bhk5xQlccWwpb9M4Z5oADg5M0OCJ1pdEqRHmS20a8tcy5irycs1a0mjkiHt2LFNSy29qaTydQbKnHQ+aODjW8Lk0XqgDnmSINyeErDQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZeoesEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C65DC16AAE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770657074;
	bh=xctYUJyV6qirmHvv+d2XSmcEIj8xkX0B2YkSvCLBRUw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WZeoesEuHOTqi00e3nEXnN0dQcOPzPVof41hVlg5g+tZcyKPZfQyk3nzxZRT0jVKI
	 64tYHTXHgAbbn3dllRchBgvZzsgQN2MSXHMTYcVcovbo9ZyCwhxXOP5w1DHp+AQjbq
	 Nx7+O+2cfLWOunExAb0h85ja4bUljw2iC0bqqpGXVYSMooE3O6Wz9XoWfQ4O9fVmDs
	 I7tFqJN0Oql+1kDl9s0nwWpIxAyif6IxGXifd/m54cpSuj7wJnMPrjAAMv40dn+q5K
	 ni45DL9NY32M9DasmOYJPcFfvK3D18VXUppfXOlwPgxpdxXxks62RkaBmRV2n5v7pz
	 hmGqswBqm5RwQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: remove redundant warning message in btrfs_check_uuid_tree()
Date: Mon,  9 Feb 2026 17:11:06 +0000
Message-ID: <8ba546dec411609cf2b4a6cec9a56c1e49d936f8.1770656691.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770656691.git.fdmanana@suse.com>
References: <cover.1770656691.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21559-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 4BCCC112E8C
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

If we fail to start the uuid rescan kthread, btrfs_check_uuid_tree() logs
an error message and returns the error to the single caller, open_ctree().

This however is redundant since the caller already logs an error message,
which is also more informative since it logs the error code. Some remove
the warning message from btrfs_check_uuid_tree() as it doesn't add any
value.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 040c9577e737..cb0bca3f6a05 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2962,7 +2962,6 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
 	task = kthread_run(btrfs_uuid_rescan_kthread, fs_info, "btrfs-uuid");
 	if (IS_ERR(task)) {
 		/* fs_info->update_uuid_tree_gen remains 0 in all error case */
-		btrfs_warn(fs_info, "failed to start uuid_rescan task");
 		up(&fs_info->uuid_tree_rescan_sem);
 		return PTR_ERR(task);
 	}
-- 
2.47.2


