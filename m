Return-Path: <linux-btrfs+bounces-16589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B3B3FCE1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 12:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765B13AC4DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6D2EF643;
	Tue,  2 Sep 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="jDPXcYAD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B12F363A
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809666; cv=none; b=mWN/Ujd/WTkJRUQ8f3pzYk3TqE514ispIQwoElIOtIpo5e6Qo509JH1j/YQsTETfA4YsTCx21w468utitRMJtPuQHtXhx3y3+L0I6+99NYGHwGSLgkPAzaeZMYcaTb5SdXgvSTzh6kaFBO0BTukndzoM062L0Or09HysR4hEIc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809666; c=relaxed/simple;
	bh=EwhIxgPHKKwQJWF9as8lZ/9D+CBLP+wKp4uu/DNs490=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=mDSLCO6Mec/JYtOUumGVSMty+kwsPpuKCEUqYEl0PK7SNKT33jAzz4i2FhA5un+9tsNi8T2QkZAO2vT3QLLOpHSKNOZJlZ9oG3BezeYvOH48o+mF+s7BHIVGiBb4+A1qXsALfqMI2jJqlLDdgmC2DHpXtaK9KiGegOd8TgGoPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=jDPXcYAD; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 76BFB2B0FA8;
	Tue,  2 Sep 2025 11:34:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1756809263;
	bh=74wM9m13BWc88sNmI5obLpAo4Xl8/w7swe1oi67aTiM=;
	h=From:To:Cc:Subject:Date;
	b=jDPXcYADWFqeEwJAuMkF7+r9rlr2zjayaXrYEXz07x1VU9HVw2eOaU5r5v/VtVlnX
	 KQ3+hxquC6gu0zv4NwtO3cepVb/Ayib8HETd+tRmD6PFt/lWYmhoOlw0y7Co8+369U
	 SUjuOUIlskSQfdwVpgW0C9l+JuzM6uZeEEo1lPyc=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2] btrfs: don't allow adding block device of less than 1 MB
Date: Tue,  2 Sep 2025 11:34:10 +0100
Message-ID: <20250902103421.19479-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 15ae0410 in btrfs-progs inadvertently changed it so that if the
BLKGETSIZE64 ioctl on a block device returned a size of 0, this was no
longer seen as an error condition.

Unfortunately this is how disconnected NBD devices behave, meaning that
with btrfs-progs 6.16 it's now possible to add a device you can't
remove:

~ # btrfs device add /dev/nbd0 /root/temp
~ # btrfs device remove /dev/nbd0 /root/temp
ERROR: error removing device '/dev/nbd0': Invalid argument

This check should always have been done kernel-side anyway, so add a
check in btrfs_init_new_device() that the new device doesn't have a size
less than BTRFS_DEVICE_RANGE_RESERVED (i.e. 1 MB).

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/volumes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 63b65f70a2b3..77a371f92ec0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2726,6 +2726,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		goto error;
 	}
 
+	if (bdev_nr_bytes(file_bdev(bdev_file)) <= BTRFS_DEVICE_RANGE_RESERVED) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	if (fs_devices->seeding) {
 		seeding_dev = true;
 		down_write(&sb->s_umount);
-- 
2.49.1


