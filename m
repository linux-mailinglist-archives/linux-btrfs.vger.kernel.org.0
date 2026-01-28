Return-Path: <linux-btrfs+bounces-21155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JJwC621eWk0ygEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21155-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:07:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9CE9D972
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2383B301983A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 07:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024E0325714;
	Wed, 28 Jan 2026 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="UWF0KYF9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8E316184
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769584019; cv=none; b=GwCSw18wNwIMC+wbU2mVi1CITSD1dGxlttko+kK1e545nEzfjEX38m/TiRC1wcCtV+m3cPDKSqko6/ynuoQeQV6fNON0ZLSzAeZFgLpiqWtvZ0YLWiTr1Mt50pldouvn4wslV+aXz/BqsQTBf7evgawOmTe/6YnJ0BGbVASAnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769584019; c=relaxed/simple;
	bh=Y3FhbbVPPhtMkWlo7omlWpsLEbUeQpZqT2kzHzj4xDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMr1VeeqLN22lCSPRPAmGT4VclUE5Hmqh9UqoTJYyaq8Y5Fd+TDlf9ECfJgIN4aeST9G1VphCsey1YqQGDAIkHJ8CzYMzwDBsN/29UUoWKmCCQGy1O9HKQfvmOrOha7rMQXpqOpEji90FrxPs6G6IBU7iw1tQEJHRMiM3bC4pns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=UWF0KYF9; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4f1Cxr18KmzGCgms8;
	Wed, 28 Jan 2026 15:06:56 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1769584016; bh=Y3FhbbVPPhtMkWlo7omlWpsLEbUeQpZqT2kzHzj4xDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWF0KYF9ayfArNABS1Awt3WpPe3xi9l8GdijR49GVUT47zA5cXM4odjn0U5tmrFF5
	 LHY1Ma41FwfhmG9ph101ooMpqyQZrzmY9MW+ft2GPj5hicGZZ4yEe4el49Ywss/NWC
	 6/TJt+PMyz/X5uUyDhA+rGJGde0+9hGbr6UdikhQ=
From: jinbaohong <jinbaohong@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	dsterba@suse.com,
	jinbaohong <jinbaohong@synology.com>,
	Robbie Ko <robbieko@synology.com>
Subject: [PATCH v4 2/4] btrfs: preserve first error in btrfs_trim_fs
Date: Wed, 28 Jan 2026 07:06:39 +0000
Message-Id: <20260128070641.826722-3-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128070641.826722-1-jinbaohong@synology.com>
References: <20260128070641.826722-1-jinbaohong@synology.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21155-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinbaohong@synology.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,synology.com:email,synology.com:dkim,synology.com:mid]
X-Rspamd-Queue-Id: 7A9CE9D972
X-Rspamd-Action: no action

When multiple block groups or devices fail during trim, preserve the
first error encountered rather than the last one. The first error is
typically more useful for debugging as it represents the original
failure, while subsequent errors may be cascading effects.

Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: jinbaohong <jinbaohong@synology.com>
---
 fs/btrfs/extent-tree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index bd167466b770..6c49465c0632 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6653,7 +6653,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 				ret = btrfs_cache_block_group(cache, true);
 				if (ret) {
 					bg_failed++;
-					bg_ret = ret;
+					if (!bg_ret)
+						bg_ret = ret;
 					continue;
 				}
 			}
@@ -6666,7 +6667,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			trimmed += group_trimmed;
 			if (ret) {
 				bg_failed++;
-				bg_ret = ret;
+				if (!bg_ret)
+					bg_ret = ret;
 				continue;
 			}
 		}
@@ -6674,7 +6676,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	if (bg_failed)
 		btrfs_warn(fs_info,
-			"failed to trim %llu block group(s), last error %d",
+			"failed to trim %llu block group(s), first error %d",
 			bg_failed, bg_ret);
 
 	mutex_lock(&fs_devices->device_list_mutex);
@@ -6687,7 +6689,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		trimmed += group_trimmed;
 		if (ret) {
 			dev_failed++;
-			dev_ret = ret;
+			if (!dev_ret)
+				dev_ret = ret;
 			continue;
 		}
 	}
@@ -6695,7 +6698,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	if (dev_failed)
 		btrfs_warn(fs_info,
-			"failed to trim %llu device(s), last error %d",
+			"failed to trim %llu device(s), first error %d",
 			dev_failed, dev_ret);
 	range->len = trimmed;
 	if (bg_ret)
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

