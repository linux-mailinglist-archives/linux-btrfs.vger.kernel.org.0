Return-Path: <linux-btrfs+bounces-22121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI21DY6bo2l4IAUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22121-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 02:51:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA61CC044
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 02:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CD1D304FB8B
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 01:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D92DBF40;
	Sun,  1 Mar 2026 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlqJCpTu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53A13B58A;
	Sun,  1 Mar 2026 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328969; cv=none; b=XE0BIyaCoKlHAEqfLqRD78hTSjzL9GwQNaBCXs8BSCwYkJXQIKIhldNijtJtlbBNpQpmjDGSphbocWFnx82VNQXPqQ0SNbhCbjf2Lz0RWJEaTStrlrIpcxg9RSwX4emX3xKKDvZxRWKP7MGBVh4AGNYiIzDtQpzts6IcfXahI+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328969; c=relaxed/simple;
	bh=dHcD7KHIKI1BD3fdlZA9nwFzglclRxSevT+5s2AVgZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ip5h/RP9sfbm6VOIIi7m85ctODU5MTsvic7OZJ3fIfjvWvdtk4MQd4PqtsRHCk1whjyyR1qNAdNBoCS2J/PbcTTaV4NG7qQhiMP7wUZ024WeU0wdQ6Ct4huynG0ukJJEQmeKPWesYZr9n3sQZjgQfBMT2wgXAVFYVo94x9M/Qb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlqJCpTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E889C19421;
	Sun,  1 Mar 2026 01:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328969;
	bh=dHcD7KHIKI1BD3fdlZA9nwFzglclRxSevT+5s2AVgZU=;
	h=From:To:Cc:Subject:Date:From;
	b=nlqJCpTuDpYdatlZl1a8CUoYS7P9HV/6zU4MXKDAUV9KKhTf74kKJuTySFPKmdpcc
	 FtsDAT5bV1FQ9piQcjIEG5jwrBMlBJhZGWeXMxVz7j7z3RvaiS2/Ys3UidOUR44Zae
	 nK9bTBLIR8z4TmJ8s/AHOIWvdEQKRo1uw8UK36qaCNWrEODuW77sbbiVnmXbDTg0Q/
	 9DUlinxg4zhHAw8kWKS+vBvyE6HZKo4LUixWm13XaE4KGT3G7P/nXr6tkfbhhtKKfu
	 GRWPOj0vBvD75UmpCKRuxso+nwBAmLQH++tV652w/WfCrhnizk0s5HDw1QnGkNuPMu
	 C3tPDeyO5K1KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jinbaohong@synology.com
Cc: Qu Wenruo <wqu@suse.com>,
	Robbie Ko <robbieko@synology.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: FAILED: Patch "btrfs: continue trimming remaining devices on failure" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:36:07 -0500
Message-ID: <20260301013607.1695989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22121-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 56AA61CC044
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 912d1c6680bdb40b72b1b9204706f32b6eb842c3 Mon Sep 17 00:00:00 2001
From: jinbaohong <jinbaohong@synology.com>
Date: Wed, 28 Jan 2026 07:06:38 +0000
Subject: [PATCH] btrfs: continue trimming remaining devices on failure

Commit 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle
error better") intended to make device trimming continue even if one
device fails, tracking failures and reporting them at the end. However,
it used 'break' instead of 'continue', causing the loop to exit on the
first device failure.

Fix this by replacing 'break' with 'continue'.

Fixes: 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle error better")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: jinbaohong <jinbaohong@synology.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a91bce05ffb4c..b63296e9abf48 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6688,7 +6688,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
-			break;
+			continue;
 		}
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
-- 
2.51.0





