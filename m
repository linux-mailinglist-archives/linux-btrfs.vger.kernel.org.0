Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767F02F94C1
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 19:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbhAQSz0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 13:55:26 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:53633 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728669AbhAQSzV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 13:55:21 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-36.iol.local with ESMTPA
        id 1DCAlJgx8i3tS1DCBlXz6A; Sun, 17 Jan 2021 19:54:39 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1610909679; bh=Zs4SVQELj/p5jjIVbzEgS9Ita9Fj89SLNyxsp3UlN+Y=;
        h=From;
        b=DPkGQEjvSQkCl8VtftDN6N+nPcg6W3JkHnoP0/ecW6TtJR8N4mmXXnakVomI/Tw/6
         FuWzs+c82tABNHqsBvVfRDzYzRMDET2X8qGMEXYNAAgrfDt5nb50F/Aed5WLVs5sEt
         Ui409jpfx1Y04DBWVNMJWjGIB7DT+QSDtXd7h4UqQUpLtf+3bQZ7nhWQRPS4O5U0tN
         lrgjrrEBAejjF28/Ha53MXQ2oJoBXjbU2tvz9gezNfcU1Zvce1fn8CmSw9ewit3UpC
         K/Plsh8kT4LYoOFlPiDT7rT0pgwwWIaW+/RzJnBNiqPOpLFSVQ76aB2iqPch3b8KpN
         TkplknvkWoB4Q==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=600487ef cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=1s11hCFB_oFSRyqhbgYA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/5] Export dev_item.type in sysfs /sys/fs/btrfs/<uuid>/devinfo/<devid>/type
Date:   Sun, 17 Jan 2021 19:54:33 +0100
Message-Id: <20210117185435.36263-4-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117185435.36263-1-kreijack@libero.it>
References: <20210117185435.36263-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOxzuVv6vOXgl1ERwkvz25hNFma0tmqiJOJr+/xS5vrd73p/7znYVfwyKiU+45TTBalP2nklPUvb7qERVXTNoZ4RIFkXVsAxDraVVFsUIfmIsIg80kHv
 6Tw1FTjXmWsxRLfDRnBf4cE+ZtOcJHDL2c0AalQVZE6+UgoVlzcBSwcptHRso/uQOpIB/txy7VJ/YjBo7j5nlZZt19mBTR4O/zdc2GrvScFM+YEp9AohtyxV
 odulQW5GVb9RhdC1W6vzFXQ/rrYEO/lMKDzeg2Af7f0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

---
 fs/btrfs/sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 19b9fffa2c9c..594e8445fe21 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1416,11 +1416,22 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
 
+static ssize_t btrfs_devinfo_type_show(struct kobject *kobj,
+					    struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n",device->type);
+}
+BTRFS_ATTR(devid, type, btrfs_devinfo_type_show);
+
 static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, in_fs_metadata),
 	BTRFS_ATTR_PTR(devid, missing),
 	BTRFS_ATTR_PTR(devid, replace_target),
 	BTRFS_ATTR_PTR(devid, writeable),
+	BTRFS_ATTR_PTR(devid, type),
 	NULL
 };
 ATTRIBUTE_GROUPS(devid);
-- 
2.30.0

