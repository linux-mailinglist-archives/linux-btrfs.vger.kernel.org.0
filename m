Return-Path: <linux-btrfs+bounces-21965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP/nKWBZoGl2igQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21965-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:32:00 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2440E1A7960
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7919305B580
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020DE3B5317;
	Thu, 26 Feb 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyyqskuU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33A3B95F1
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116053; cv=none; b=sF2zdu1zg5HmEt0Ow2b2HN7suAoTp+Z7Ctb/kvT8HmNqRIv0WWclY9vX561rbM+ZIrEBFNctMMRHewqrhm1NmOoRgpjezMvKmSCXfLxT3DH3JrdFQThlUe/nQKbFfkf3+lBcYMIsox8Xw2iyz5ihdIeIWxKF8+e5UIn/Ei6kdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116053; c=relaxed/simple;
	bh=1kBFOsyeuGcO+axUYKNBgPLxs1Le5u2nW9qtGUx4q48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEZsFKNMw0oT3whM2PqyP8Vgifgmamew4WssISKqamzk1IIWYgwfoavI95aFcdMW7OJP8eWiIFMSQsFuYrjBU9umhexQf6Pjweagl5ZyMELcYNlcHRl1vJgINQOaqmBer9/Q26Z2gc6GDNe/HVGsVmzTVbM5JT1pecRN6gJmWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyyqskuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACE6C116C6
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116052;
	bh=1kBFOsyeuGcO+axUYKNBgPLxs1Le5u2nW9qtGUx4q48=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fyyqskuUGtQGZP7UMwDz0EDsNsp09p3OtacBnwPXnWD5NKH/57Nh2eIScENzoMqCE
	 LmcQiJieYIPUC8AyJEaIRujRjQN1L+DLoi4IheQP2J9zncYDpVvbSdhPFByPmPpllV
	 ciitcL0R7g5Vuxhi7fBV8Up32gBatXsBJRiV+IQwZ41FtlYOxtlx8tyzRAVz6lMMoU
	 jDpJeUsQXa+pkvFDd3B/pXe5GEpme4xvpO89hUShEwTNxM+3E57q7Jl6/JYnQzg4/S
	 XrjZRYn/e93XPlCF0OTE3Wwxqs1JHgCD7OBc1eXC/czJdLgsHtIxn6yb1OfottKw2K
	 UWg3fRJOKQlyw==
From: Anand Jain <asj@kernel.org>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: derive f_fsid from on-disk fsuuid and dev_t
Date: Thu, 26 Feb 2026 22:27:19 +0800
Message-ID: <fdea3f42827f512fcaa82f4dabe475e191d7ff2f.1772095546.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772095546.git.asj@kernel.org>
References: <cover.1772095546.git.asj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
	TAGGED_FROM(0.00)[bounces-21965-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[asj@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2440E1A7960
X-Rspamd-Action: no action

Currently, f_fsid depends on fs_devices->fsid. For cloned devices, this
value is dynamic and fluctuates across mount cycles. This inconsistency
breaks persistence for subsystems like IMA.

Switch to a stable derivation using the persistent on-disk fsuuid +
root id + devt of the block device for the single device filesystem.
This is consistent as long as the device remains unchanged/replace
(excludes btrfs device replace secnario for now).

Signed-off-by: Anand Jain <asj@kernel.org>
---
 fs/btrfs/super.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 125fca57c164..68473663fe1e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1733,7 +1733,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 total_free_data = 0;
 	u64 total_free_meta = 0;
 	u32 bits = fs_info->sectorsize_bits;
-	__be32 *fsid = (__be32 *)fs_info->fs_devices->fsid;
+	__be32 *fsid;
 	unsigned factor = 1;
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	int ret;
@@ -1819,15 +1819,34 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bsize = fs_info->sectorsize;
 	buf->f_namelen = BTRFS_NAME_LEN;
 
-	/* We treat it as constant endianness (it doesn't matter _which_)
-	   because we want the fsid to come out the same whether mounted
-	   on a big-endian or little-endian host */
+	/*
+	 * fs_devices->fsid is dynamically generated when temp_fsid is active
+	 * to support cloned devices. Use the original on-disk fsid instead,
+	 * as it remains consistent across mount cycles.
+	 */
+	fsid = (__be32 *)fs_info->super_copy->fsid;
+	/*
+	 * We treat it as constant endianness (it doesn't matter _which_)
+	 * because we want the fsid to come out the same whether mounted
+	 * on a big-endian or little-endian host.
+	 */
 	buf->f_fsid.val[0] = be32_to_cpu(fsid[0]) ^ be32_to_cpu(fsid[2]);
 	buf->f_fsid.val[1] = be32_to_cpu(fsid[1]) ^ be32_to_cpu(fsid[3]);
 	/* Mask in the root object ID too, to disambiguate subvols */
 	buf->f_fsid.val[0] ^= btrfs_root_id(BTRFS_I(d_inode(dentry))->root) >> 32;
 	buf->f_fsid.val[1] ^= btrfs_root_id(BTRFS_I(d_inode(dentry))->root);
 
+	/*
+	 * dev_t provides way to differentiate mounted cloned devices keeps
+	 * the statfs fid is consistent and unique.
+	 */
+	if (fs_info->fs_devices->total_devices == 1) {
+		__kernel_fsid_t dev_fsid = \
+	u64_to_fsid(huge_encode_dev(fs_info->fs_devices->latest_dev->bdev->bd_dev));
+		buf->f_fsid.val[0] ^= dev_fsid.val[1];
+		buf->f_fsid.val[1] ^= dev_fsid.val[0];
+	}
+
 	return 0;
 }
 
-- 
2.43.0


