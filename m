Return-Path: <linux-btrfs+bounces-21372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLB1JhVyg2mFmwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21372-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 17:21:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A2EA1EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70FC2317DF13
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9766421F06;
	Wed,  4 Feb 2026 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orPM7pR4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47860421A09
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220338; cv=none; b=rVfG9/10859gLPL90oFgW5G8miklIK4p1GqtKLQ8LoviZGaMtVJSCtxzjuw4s/DSKM5BGEqE9Ci4xbh3jwOZSc2VduzUzCLmLlV3Ch9QECQlq8CVoqQsjc8UJ2FLUoniX+v1QCtkmPNzdHWhEqVCxPM78KwIVfnui2nZRoWU4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220338; c=relaxed/simple;
	bh=bPp1WeU0LIwB1ZqVsoiGFFXoaoeNDZOE3cd9v7x35Hc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h87w9VwY82dwjQyIqmu5w24BmHXAK4XpZ4/eKjtLs42EztUJ+RHkFaYbEVfdoSam5/rOhPVYY/MGQXzCRltaouCESCgI3a9LUPZGYDy5Vk/w1hr4t28+hzOUTCLDK+cGeReEfaHsMJF2q+QM7vMfCRv9S30YWShW3xU5VscJGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orPM7pR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9ECC4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770220337;
	bh=bPp1WeU0LIwB1ZqVsoiGFFXoaoeNDZOE3cd9v7x35Hc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=orPM7pR44LQtNOIeyj7iqZF3wUh0s4uQOdfIZ3gmJf4DpXSQXA92sTi7YmPU5hdmq
	 /pag1P3kWdWQY8kV5pcITfD1/DoiU0KLjvD/4RbdYV4PVYQJRHgAUkXMnW/QaQRsSZ
	 dFMBpzRmm0hnQJh++hRwA+F5mLDxHD/7XbwpRceoZhDtiGU9WCd3H3kH/TRasGk9r2
	 wCtNn5YMMKbSWHVDxievCe9AjPNIkArzJvOE8ZZ/82Cn6yv7SlCAxxUTqqjLO/B0ee
	 4xL5jVFMsye5USxU38vzJt4bCwJF6ewQz4GSMOYhv3jrx82iuUSZEgvEsoj+zG+hit
	 cd4Efildf6nBg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: tag error branches as unlikely during super block writes
Date: Wed,  4 Feb 2026 15:52:02 +0000
Message-ID: <c0a49e935633674b99380d04754c0930363108d2.1770212626.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770212626.git.fdmanana@suse.com>
References: <cover.1770212626.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21372-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F04A2EA1EF
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Mark all the unexpected error checks as unlikely, to make it more clear
they are unexpected and to allow the compiler to potentially generate
better code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6e474c2d6b74..19f7927a000d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2580,7 +2580,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	ret = btrfs_validate_super(fs_info, sb, -1);
-	if (ret < 0)
+	if (unlikely(ret < 0))
 		goto out;
 	if (unlikely(!btrfs_supported_super_csum(btrfs_super_csum_type(sb)))) {
 		ret = -EUCLEAN;
@@ -2597,7 +2597,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 out:
-	if (ret < 0)
+	if (unlikely(ret < 0))
 		btrfs_err(fs_info,
 		"super block corruption detected before writing it to disk");
 	return ret;
@@ -3855,7 +3855,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
 		if (ret == -ENOENT) {
 			break;
-		} else if (ret < 0) {
+		} else if (unlikely(ret < 0)) {
 			errors++;
 			if (i == 0)
 				primary_failed = true;
@@ -3877,9 +3877,8 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 	}
 
 	errors += atomic_read(&device->sb_write_errors);
-	if (errors >= BTRFS_SUPER_PRIMARY_WRITE_ERROR)
-		primary_failed = true;
-	if (primary_failed) {
+
+	if (unlikely(primary_failed || errors >= BTRFS_SUPER_PRIMARY_WRITE_ERROR)) {
 		btrfs_err(device->fs_info, "error writing primary super block to device %llu",
 			  device->devid);
 		return -1;
@@ -3930,7 +3929,7 @@ static bool wait_dev_flush(struct btrfs_device *device)
 
 	wait_for_completion_io(&device->flush_wait);
 
-	if (bio->bi_status) {
+	if (unlikely(bio->bi_status)) {
 		set_bit(BTRFS_DEV_STATE_FLUSH_FAILED, &device->dev_state);
 		btrfs_dev_stat_inc_and_print(device, BTRFS_DEV_STAT_FLUSH_ERRS);
 		return true;
@@ -3968,7 +3967,7 @@ static int barrier_all_devices(struct btrfs_fs_info *info)
 	list_for_each_entry(dev, head, dev_list) {
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
 			continue;
-		if (!dev->bdev) {
+		if (unlikely(!dev->bdev)) {
 			errors_wait++;
 			continue;
 		}
@@ -3976,7 +3975,7 @@ static int barrier_all_devices(struct btrfs_fs_info *info)
 		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
 			continue;
 
-		if (wait_dev_flush(dev))
+		if (unlikely(wait_dev_flush(dev)))
 			errors_wait++;
 	}
 
@@ -4051,7 +4050,7 @@ int write_all_supers(struct btrfs_trans_handle *trans, int max_mirrors)
 
 	if (do_barriers) {
 		ret = barrier_all_devices(fs_info);
-		if (ret) {
+		if (unlikely(ret)) {
 			mutex_unlock(
 				&fs_info->fs_devices->device_list_mutex);
 			btrfs_abort_transaction(trans, ret);
@@ -4061,7 +4060,7 @@ int write_all_supers(struct btrfs_trans_handle *trans, int max_mirrors)
 	}
 
 	list_for_each_entry(dev, head, dev_list) {
-		if (!dev->bdev) {
+		if (unlikely(!dev->bdev)) {
 			total_errors++;
 			continue;
 		}
@@ -4096,7 +4095,7 @@ int write_all_supers(struct btrfs_trans_handle *trans, int max_mirrors)
 		}
 
 		ret = write_dev_supers(dev, sb, max_mirrors);
-		if (ret)
+		if (unlikely(ret))
 			total_errors++;
 	}
 	if (unlikely(total_errors > max_errors)) {
@@ -4112,14 +4111,14 @@ int write_all_supers(struct btrfs_trans_handle *trans, int max_mirrors)
 
 	total_errors = 0;
 	list_for_each_entry(dev, head, dev_list) {
-		if (!dev->bdev)
+		if (unlikely(!dev->bdev))
 			continue;
 		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
 		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
 			continue;
 
 		ret = wait_dev_supers(dev, max_mirrors);
-		if (ret)
+		if (unlikely(ret))
 			total_errors++;
 	}
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-- 
2.47.2


