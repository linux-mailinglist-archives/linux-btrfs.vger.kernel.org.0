Return-Path: <linux-btrfs+bounces-21593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBv4JZsJi2kdPQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21593-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:34:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729F119AD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E551E3058099
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124833168E1;
	Tue, 10 Feb 2026 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piajwFo7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604003164B0
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719610; cv=none; b=tJY9EOv/4DqMt0Umb6Ose7+tl1+Crd7n8oGoI5+DeR5HDtjrRatahriWXncG7DxQa7+RxonREgGkbjR6h4uYDNGdOstO8TSIUNDQDgQfr4SmFbTPeN96hiDNYhAOR6+EmQzZgjVKNjW2qmCUjilXD16ltk9qAOu64Aqe9cRn01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719610; c=relaxed/simple;
	bh=odugkj3f6DzcGb1eKRpo2Cs+0//d2TtIMRK4Oqgefoc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AP4gyCkZZBINXXOjuMAMEDljcN4/UepIw59cp0QuW+DCuiZ+L8hmKaa6LUZqFsOG6kBJlsSxLPf01zCmrHjjhU8c1aDAC1Lg4mrNj+Z/f6j1bLlhYmCTX85LUYNtwvslBky2yRpynH9LtCHWZwaDgH9iVw7BCfcoUSYxyT/+zAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piajwFo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826A6C16AAE
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770719610;
	bh=odugkj3f6DzcGb1eKRpo2Cs+0//d2TtIMRK4Oqgefoc=;
	h=From:To:Subject:Date:From;
	b=piajwFo7VbKeN/hfVulBwrNfJ7126EqPnrbrN1oq4MpXi0a5wWmBlTcFFIKIpltKp
	 GnjX0etKO33XQVJn0lO3BkC0mf2RfF+LMCbWwBMNY4aLi+1pvN7kdH26XJE4SX8LeQ
	 TIyYLxY//sVKaxUxVQ5gBNAIAJ5cSF0QXrc34fX+4aercv5kvc5wCk7tFO1uQ/FnzI
	 MPqY6lv5KEDPfm/+/QSnZc8QfW6UksDZCT67GhCY2VmsBUlp9LI7Tos4FERfA3i5Hw
	 YrSPAiSTsIeDtAiynF6K1S9RTCD2L2jLccy91fPi1mN4ZAcjOhSd0Xo0wVpfPVdRjJ
	 ZS3xoGJ3Hm/kQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: convert log messages to error level in btrfs_replay_log()
Date: Tue, 10 Feb 2026 10:33:27 +0000
Message-ID: <fdf43710fac61ba7efd4933dd8c3832f95fbd9a2.1770719576.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21593-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3729F119AD4
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

We are logging messages as warnings but they should really have an error
level instead, as if the respective conditions are met the mount will
fail. So convert them to error level and also log the error code returned
by read_tree_block().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ccf540646b60..99ce7c1ca53a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2004,7 +2004,7 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 	int level = btrfs_super_log_root_level(disk_super);
 
 	if (unlikely(fs_devices->rw_devices == 0)) {
-		btrfs_warn(fs_info, "log replay required on RO media");
+		btrfs_err(fs_info, "log replay required on RO media");
 		return -EIO;
 	}
 
@@ -2018,9 +2018,9 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 	check.owner_root = BTRFS_TREE_LOG_OBJECTID;
 	log_tree_root->node = read_tree_block(fs_info, bytenr, &check);
 	if (IS_ERR(log_tree_root->node)) {
-		btrfs_warn(fs_info, "failed to read log tree");
 		ret = PTR_ERR(log_tree_root->node);
 		log_tree_root->node = NULL;
+		btrfs_err(fs_info, "failed to read log tree with error: %d", ret);
 		btrfs_put_root(log_tree_root);
 		return ret;
 	}
-- 
2.47.2


