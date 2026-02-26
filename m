Return-Path: <linux-btrfs+bounces-21966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHtHImtZoGlPigQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21966-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:32:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C371A796F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4CE730D76F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C03B95E5;
	Thu, 26 Feb 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaIRNjzv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216233B8D57
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116054; cv=none; b=DJxryuE/lJ02d31Y6F+xF6fnZ7590dRIm/E5mTwFVEga1y4AFZ9lHvVLIFT6pM+uaSjFeczYj39gM7vPEagL8DWFcOiYMHBjBhuYGkcSItx6TlAdqa7rIE64+KcNnphz/ff6EvTFu/BCVfPEv/l9bdurFH3clgjD8yfBCfF7Yds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116054; c=relaxed/simple;
	bh=GMns4fGkgqow57Kanf5YYO08LXIXPvfM0vPAJFwP50Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEaNIVo1ovKd+Vk4cTlLVwoCAKd0uhqkXu8iRcZoUj4qk9h31lmd7P3/rnRmz4Cf4oVyoktwMoZ9MYQS7f00XD4o55tQX9zzpplrB1JOjC4X8PLDaaiW0dqujm0YraHrBoPnaAki1oiCGgXOZurkISUZyjK6PnhOAML734Ncv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaIRNjzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545AAC19422
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116053;
	bh=GMns4fGkgqow57Kanf5YYO08LXIXPvfM0vPAJFwP50Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LaIRNjzvz9ZZaf5/ieL7toEqwbWA4wyYLnk1VeFgi7aGivYum/u52zNJQgpjS/68g
	 GQ4gLoOqcQd6bXuqpBJ624xpD1/+lUFlVqTjS8+64GSSqPEOY0JK/Ys7fuBjM3EPMP
	 dvAPx3BK/t4+vJRWV77ClQZklTGKKHyBDPUAm89AOqsmtkFRV23duuXAK8KZLLA1bF
	 A+AnCwKOqv6HASQtUjUsr0plvVhVr6+pYZcnyT84kB/aMwSEEpdKn9tHjmbpQk3xCB
	 EyEdHCzswZ+tlCC0UfTgYhLDYYAoKTnTZcLJhG8lyGu0+XbeLsxL+uMmv8il89qW5x
	 1D9l2uRbxHUJg==
From: Anand Jain <asj@kernel.org>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: use on-disk uuid for s_uuid in temp_fsid mounts
Date: Thu, 26 Feb 2026 22:27:20 +0800
Message-ID: <b19251168bf8309dfa0a323fec0ec15a3d12b1af.1772095546.git.asj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21966-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: 14C371A796F
X-Rspamd-Action: no action

When mounting a cloned filesystem with a temporary fsuuid (temp_fsid),
layered modules like overlayfs require a persistent identifier.

While internal in-memory fs_devices->fsid must remain dynamic to
distinguish the clone from the source, s_uuid should reflect the
original on-disk UUID to provide consistency for upper-layer consumers.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 15c4fdaff3de..98387516ef5b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3443,7 +3443,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	/* Update the values for the current filesystem. */
 	sb->s_blocksize = sectorsize;
 	sb->s_blocksize_bits = blksize_bits(sectorsize);
-	memcpy(&sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
+	/* Copy on-disk uuid, even for temp_fsid mounts */
+	memcpy(&sb->s_uuid, fs_info->super_copy->fsid, BTRFS_FSID_SIZE);
 
 	mutex_lock(&fs_info->chunk_mutex);
 	ret = btrfs_read_sys_array(fs_info);
-- 
2.43.0


