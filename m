Return-Path: <linux-btrfs+bounces-16473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9E1B3927E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 06:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0739817BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 04:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09D230CD97;
	Thu, 28 Aug 2025 04:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rZvtI7fS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rZvtI7fS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAD258A
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756354616; cv=none; b=cnjVySz/sTfQfNbHnW0+KnlmeW/0u5Bka2ikHuN4OBtTHwIge7AkyWHvIL/n4qHysbqNC/GK3XbjSVQcW8Ebt12Ce3uVhg7zW1x6TY4jwl94aOimRkueDXNMr7N227DFo+IMsRjsFGwGcCFeVsFjByHbPiQ+uRwglvRXv1C/UzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756354616; c=relaxed/simple;
	bh=7/kMx+ZV6jKa+w6UtHKev96looPV61N5Z6ybr1pZ7UE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7VFP9nKdCeyDxEOxswzcQNNusUR97u8cbYCvwW6RFImdrWOxQWD5zbW1CLBObEs4UeGXW/yTKrpyp+z/u4vx+QpS2ZN0y77p0mNV89FYHeZ8WRpYYFN5p3G/NoHpKOBKPiP8dO/yBLwwa5dInUOtO2/h9pspUsk1N+kaUb9ikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rZvtI7fS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rZvtI7fS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3249336E5
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756354611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8oPuaNYM9w8lStZjwwmakoJ9wraK+Nhme77rr23oBY=;
	b=rZvtI7fSKUtoinzq3muspR4NyCuj5lJqhIot2TmuSnOD/M0VmqeRTksM1bhj5H+9KF+LIb
	ScclZV63HRsro3OB0eVpnxYjB3PeAwhZlicXKWThTJhvTNBxU4Jwr/xf3sjs36WZfw6jl2
	PbAy16MyHLqbhkgDqcEmNyvj7DXkM7Q=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rZvtI7fS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756354611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8oPuaNYM9w8lStZjwwmakoJ9wraK+Nhme77rr23oBY=;
	b=rZvtI7fSKUtoinzq3muspR4NyCuj5lJqhIot2TmuSnOD/M0VmqeRTksM1bhj5H+9KF+LIb
	ScclZV63HRsro3OB0eVpnxYjB3PeAwhZlicXKWThTJhvTNBxU4Jwr/xf3sjs36WZfw6jl2
	PbAy16MyHLqbhkgDqcEmNyvj7DXkM7Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E025A13680
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2Ko7KDLYr2hhYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: treat super block write back error more seriously
Date: Thu, 28 Aug 2025 13:46:24 +0930
Message-ID: <3628565fc93b389ab9a68ac39d05ec296858a907.1756353444.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756353444.git.wqu@suse.com>
References: <cover.1756353444.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A3249336E5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Currently btrfs treats super block writebacks pretty loosely.

As long as there is at least one device writes its super block back
correctly, we will call it a day and continue.

However this is too loose, we should treat super block writeback error
more seriously, as the writeback error as the device is missing.
And if we hit a device missing, we should flips the fs RO if the fs can
no longer maintain reliable RW writes.

So here enhance the is_critical_device() handling, and if the failed
device will prevent btrfs from maintaining reliable RW operations,
treat it as a critical error, which will abort the current transaction
and flips the fs RO.

Although this brings some overhead for error handling. Now we call
btrfs_check_rw_degradable(), which depends on the profiles, it may needs
to iterate through all chunk maps to make sure the fs can still maintain
RW operations.

But that only affects error path, I'd say one should not expect full
performance when the device can not handle a critical super block
writeback.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9a8c07a0986d..aa7696a28ac2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3999,7 +3999,7 @@ int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags)
 	return min_tolerated;
 }
 
-static bool is_critical_device(struct btrfs_device *dev)
+static bool is_critical_device(struct btrfs_fs_info *fs_info, struct btrfs_device *dev)
 {
 	/*
 	 * New device primary super block writeback is not tolerated.
@@ -4011,6 +4011,8 @@ static bool is_critical_device(struct btrfs_device *dev)
 	 */
 	if (test_bit(BTRFS_DEV_STATE_NEW, &dev->dev_state))
 		return true;
+	if (!btrfs_check_rw_degradable(fs_info, dev))
+		return true;
 	return false;
 }
 
@@ -4093,7 +4095,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 		ret = write_dev_supers(dev, sb, max_mirrors);
 		if (ret) {
 			total_errors++;
-			if (is_critical_device(dev)) {
+			if (is_critical_device(fs_info, dev)) {
 				btrfs_crit(fs_info,
 					   "failed to write super blocks for device %llu",
 					   dev->devid);
@@ -4125,7 +4127,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 		ret = wait_dev_supers(dev, max_mirrors);
 		if (ret) {
 			total_errors++;
-			if (is_critical_device(dev)) {
+			if (is_critical_device(fs_info, dev)) {
 				btrfs_crit(fs_info,
 					   "failed to wait super blocks for device %llu",
 					   dev->devid);
-- 
2.50.1


