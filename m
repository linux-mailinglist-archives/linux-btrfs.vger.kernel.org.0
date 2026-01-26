Return-Path: <linux-btrfs+bounces-21055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE+5HrMnd2kUcwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21055-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 09:37:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B16485874
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 09:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15237300A8FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C712701DA;
	Mon, 26 Jan 2026 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="Ig1yLDlR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2BA1A3166
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416611; cv=none; b=ShPERMXRS6dhrlv6J/0zDm6OoXyhEhApmQ/E7ugrY6RcHtaAGaCxbdm+Zan3WeM+x9k95p0zA2lE77lYg2loUPgwMd025eBBbJzh7/QT1hZJty6J8P42HEZvRuR/tGvpmNaDd44/La0kDfpxmEQv4PjlACgssO9ZpkppEbA3rIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416611; c=relaxed/simple;
	bh=3UPhtLFSOwSlL1aL/q/xuPyyYmQbCMVXxeK+uJdtXbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEhJnthB/Yv5/8j0VIdXGd7ZRDsbRPMfsNFgekWQMN1gBpKOy/1HzdnmPoisTlhd23/bp4pZ66qnc9wkrllZkNfNbAcyNA5n9g1GH5zI7TFdwDCQ2OzfJ5Kr87M/9+p5YlDsbXPjjqwCCUFfzHr8LPquQnNmlTlJ0DhJpl5cL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=Ig1yLDlR; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4f022S0bZ6zG9NvNp;
	Mon, 26 Jan 2026 16:36:48 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1769416608; bh=3UPhtLFSOwSlL1aL/q/xuPyyYmQbCMVXxeK+uJdtXbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ig1yLDlRbvFUyhkk5bahYIiwDxvwmDyo5z1tNgwzrNG/o6GE/hxaZBdnRDIasLCR5
	 GmH1jboYfLx04UHzwluEscDBiChtRwrPL5+ZqfuHUd1NSD7h5tk0/YNzorfVymCDcr
	 DXhbLKalesxHmNYlXMmHzEyJfui5+zvW/U5V5bEc=
From: jinbaohong <jinbaohong@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	dsterba@suse.com,
	jinbaohong <jinbaohong@synology.com>,
	Robbie Ko <robbieko@synology.com>
Subject: [PATCH v3 1/2] btrfs: continue trimming remaining devices on failure
Date: Mon, 26 Jan 2026 08:36:38 +0000
Message-Id: <20260126083639.602258-2-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126083639.602258-1-jinbaohong@synology.com>
References: <20260126083639.602258-1-jinbaohong@synology.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
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
	TAGGED_FROM(0.00)[bounces-21055-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: 1B16485874
X-Rspamd-Action: no action

Commit 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle
error better") intended to make device trimming continue even if one
device fails, tracking failures and reporting them at the end. However,
it used 'break' instead of 'continue', causing the loop to exit on the
first device failure.

Additionally, user interrupts (-ERESTARTSYS) were incorrectly counted
as device failures. Interrupts should stop the operation immediately
without being reported as device errors.

Fix this by:
1. Replacing 'break' with 'continue'.
2. Stopping immediately on user interrupt without counting it as a
   device failure, but still setting dev_ret to -ERESTARTSYS so
   the error is properly returned to the caller
3. Converting -EINTR from mutex_lock_interruptible() to -ERESTARTSYS
   for consistent interrupt handling

Fixes: 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle error better")
Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: jinbaohong <jinbaohong@synology.com>
---
 fs/btrfs/extent-tree.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0ce2a7def0f3..b299e369649b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6539,8 +6539,10 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		u64 bytes;
 
 		ret = mutex_lock_interruptible(&fs_info->chunk_mutex);
-		if (ret)
+		if (ret) {
+			ret = -ERESTARTSYS;
 			break;
+		}
 
 		btrfs_find_first_clear_extent_bit(&device->alloc_state, start,
 						  &start, &end,
@@ -6685,10 +6687,14 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		ret = btrfs_trim_free_extents(device, &group_trimmed);
 
 		trimmed += group_trimmed;
+		if (ret == -ERESTARTSYS) {
+			dev_ret = -ERESTARTSYS;
+			break;
+		}
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
-			break;
+			continue;
 		}
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

