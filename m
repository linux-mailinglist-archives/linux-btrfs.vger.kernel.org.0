Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACA13489E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 08:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCYHPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 03:15:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhCYHPB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 03:15:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616656500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9E8K3Y12Jq2/glSKlknqUA+iAYegTQaOKXCivKmjWUY=;
        b=IdFS4C8Ybfuat5BCHTadPd8/Kpr8VVK3yubstpsUCimdlfgsl72e/WfPxBFmkihBN4U38G
        eCFDb3486sJN+CyrKzZFRNy/asjPAwlEOUfGEHm+4wAQXSKtk1E2TtIP9KK8CJBS7Oczcs
        YMPahGMH9750YYJOgCaT+MXtFYUkqZ8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56600AA55
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 07:15:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 01/13] btrfs: add sysfs interface for supported sectorsize
Date:   Thu, 25 Mar 2021 15:14:33 +0800
Message-Id: <20210325071445.90896-2-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
References: <20210325071445.90896-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add extra sysfs interface features/supported_ro_sectorsize and
features/supported_rw_sectorsize to indicate subpage support.

Currently for supported_rw_sectorsize all architectures only have their
PAGE_SIZE listed.

While for supported_ro_sectorsize, for systems with 64K page size, 4K
sectorsize is also supported.

This new sysfs interface would help mkfs.btrfs to do more accurate
warning.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 6eb1c50fa98c..2f9c2639707c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -360,11 +360,26 @@ static ssize_t supported_rescue_options_show(struct kobject *kobj,
 BTRFS_ATTR(static_feature, supported_rescue_options,
 	   supported_rescue_options_show);
 
+static ssize_t supported_sectorsizes_show(struct kobject *kobj,
+					  struct kobj_attribute *a,
+					  char *buf)
+{
+	ssize_t ret = 0;
+
+	/* Only support sectorsize == PAGE_SIZE yet */
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n",
+			 PAGE_SIZE);
+	return ret;
+}
+BTRFS_ATTR(static_feature, supported_sectorsizes,
+	   supported_sectorsizes_show);
+
 static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
 	BTRFS_ATTR_PTR(static_feature, supported_checksums),
 	BTRFS_ATTR_PTR(static_feature, send_stream_version),
 	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
+	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
 	NULL
 };
 
-- 
2.30.1

