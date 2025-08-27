Return-Path: <linux-btrfs+bounces-16434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16AAB38000
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 12:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED6D2073A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94D02874FA;
	Wed, 27 Aug 2025 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="zTX2Ur/h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931EE28688E
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291063; cv=none; b=HXVXFmWLt8YhXbm2lX76nr1nzRme7FYpq4Pjyrhlcf0fZhW7kwkwXBnhkg/SDPrX2zh4pWvhGJMUz557uucuVh6Z2VRoHK98HcrF/1IbX/Zz0tCZn1xvNrnOT8n1MfZpJBpcX1rVVZsWldSy46CyFFnimp6LN6MNA17Ahz3KC3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291063; c=relaxed/simple;
	bh=7cmdJmMTNRP6d3xmmRN7J8aYrPr11ka+KXMcvYFnxmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=pZ2kjOJ/VD6YI+O5+H+rb6pFENf0wmaa+2Qt5J2n/iH4enXhBH/d3CaQc/VASvtaTU7kLyWXWZJ6F2TdECrCUZVBSR/S3PL8s3h4bo6GfBga8F5G/ZQNPrn3YGkVZqxMTaSWB86cR9TtN58p7lmHZzNejMrYUxwxcmUPc7KhkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=zTX2Ur/h; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id F00CF2AE0F1;
	Wed, 27 Aug 2025 11:37:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1756291047;
	bh=+FLLvUftAHqeADrM0ibjIeNdjnpDc1Fo8orRKo6MuUM=;
	h=From:To:Cc:Subject:Date;
	b=zTX2Ur/hqMFIPf86T0GJuM+5WUS39ohnekzbwMTjvMoMOJpok9D1V2Gzk4kkwmPgO
	 YU/DcQ8wssQocTjldghRZvZmAk4PACeUSGYIiJw88sIKP1DFV4EQ4F0JRR706J6+5u
	 JaIrvM0CveINZkfW4feVNYlEngm34ner7GOUYgh4=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: don't allow adding block device with 0 bytes
Date: Wed, 27 Aug 2025 11:37:12 +0100
Message-ID: <20250827103725.19637-1-mark@harmstone.com>
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
of 0.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/volumes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 63b65f70a2b3..0757a546ff5c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2726,6 +2726,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		goto error;
 	}
 
+	if (bdev_nr_bytes(file_bdev(bdev_file)) == 0) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	if (fs_devices->seeding) {
 		seeding_dev = true;
 		down_write(&sb->s_umount);
-- 
2.49.1


