Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66FB49D378
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiAZUcZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 15:32:25 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:59406 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230413AbiAZUcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 15:32:22 -0500
Received: from venice.bhome ([78.14.151.50])
        by michael.mail.tiscali.it with 
        id nYYG2600e15VSme01YYMMr; Wed, 26 Jan 2022 20:32:21 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 7/7] Add /sys/fs/btrfs/features/allocation_hint
Date:   Wed, 26 Jan 2022 21:32:14 +0100
Message-Id: <fc071577620c4fa8355d09d334fa95f8035a5c59.1643228177.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643228177.git.kreijack@inwind.it>
References: <cover.1643228177.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643229141; bh=Bg8phRthP2z1QRlZ+UGcO8P2mq2f87aWiAEmus/xuXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=pDFYOtcL+beWcoTntrZT+0vPa/jGzrqO/arAN3QBfV9IoW9tDDEZqSsDKJd5YxsS2
         3Nr46b7RkBM37zZ6SZ2KdsDZ/T2cJhZiE/c1iAo5ms6tmd77seXkn27kEdBNhb0CV6
         NizS9FhK6q3bGb6KFf31b7esJCvMlg+KlfHhADfc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add a new feature sysfs file to simplify the allocation_hit feature
availability check.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index dee23669a00f..0f4a7ab79fe5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -403,6 +403,20 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 BTRFS_ATTR(static_feature, supported_sectorsizes,
 	   supported_sectorsizes_show);
 
+static ssize_t allocation_hint_show(struct kobject *kobj,
+					  struct kobj_attribute *a,
+					  char *buf)
+{
+	ssize_t ret;
+
+	/* Only sectorsize == PAGE_SIZE is now supported */
+	ret = sysfs_emit(buf, "1\n");
+
+	return ret;
+}
+BTRFS_ATTR(static_feature, allocation_hint,
+	   allocation_hint_show);
+
 /*
  * Features which only depend on kernel version.
  *
@@ -415,6 +429,7 @@ static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	BTRFS_ATTR_PTR(static_feature, send_stream_version),
 	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
 	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
+	BTRFS_ATTR_PTR(static_feature, allocation_hint),
 	NULL
 };
 
-- 
2.34.1

