Return-Path: <linux-btrfs+bounces-22122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJleImubo2kwIAUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22122-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 02:50:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 035EA1CBF5A
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 02:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 115C1305EBB1
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 01:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43142E7657;
	Sun,  1 Mar 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCghssT4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E13145A1F;
	Sun,  1 Mar 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329500; cv=none; b=QtWRsJ5JC7WfJRpyirONPVVz7jOqshtSb6igHwtiHymeRiA/XOEDFPaNxIVMmHxbKyvY0MU79xBvgSD5NjeP6knNTNGebgrFwDX8UvTjm4bupqE3sBYxCBH7SQowDlvejAWVOt8E9IZABtGqmaX5lKDlpmvd1PV/KlexjcmExsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329500; c=relaxed/simple;
	bh=3nckLWuFSRzHBV594JQ9BqBzPxV27Bvxy49Nin12i2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+l72PwAIH0pGyOGLT+0sOW/vZJFHdwAquMGkxStIR+8pE2WlLoRtpvFucnCBVdWI/zDo01I9YfVRfoxaEv/dCCFypwhbdSIypTHwvO1oyAYZ4xIeQDX1QFYgmix4h2Wz1mKRYp0Dbf+LO4BRYFM4SgeaNI6And8Vi8bzYPNZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCghssT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397B5C19421;
	Sun,  1 Mar 2026 01:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329500;
	bh=3nckLWuFSRzHBV594JQ9BqBzPxV27Bvxy49Nin12i2g=;
	h=From:To:Cc:Subject:Date:From;
	b=kCghssT499ExZ4PZ4wozJN5lSDR7zWARefeJeuVPkBxvc29cqIrzY5+pOIYJXxmrW
	 KQKQ74NV5kezEN2LkJRskycJqzmAOYOQjqExm5LnjVcK3xV1ZEXFBABkvfiDTB73FP
	 2EIhcIWaT8SCafKGumD3BqkqUAvL9S7+rrj8GKT4u6wJcgfX0G8OxLRItuKzSi04ma
	 WVkzkQsSqJ04gRh2f72eCWLnPWUv3dfbjf2+My/7G4m0N02+gDs2LCEGx2zDvNe2sD
	 zCJQOjQ2YujCAQ+o/oeM17t02JTvAwb5KdOzQmUmZx5t9CyNO1iSgYQozfX7aCA6cb
	 4HdQz0HR6QFpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jinbaohong@synology.com
Cc: Qu Wenruo <wqu@suse.com>,
	Robbie Ko <robbieko@synology.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: FAILED: Patch "btrfs: continue trimming remaining devices on failure" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:44:57 -0500
Message-ID: <20260301014458.1707445-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22122-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synology.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 035EA1CBF5A
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





