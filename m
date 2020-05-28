Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BCC1E6966
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405882AbgE1SfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 14:35:03 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:39096 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405869AbgE1Se7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 14:34:59 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id eNMjjt6vcLNQWeNMnjtDeb; Thu, 28 May 2020 20:34:57 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590690897; bh=I3afqNPYrT3PRTlHcsNgFKQRiwQgzimU035ThZUYgZo=;
        h=From;
        b=QL8a9syvwKd3WgLOpHbZ3LlqtVgicqgQtY0d0qNhCeHrRHeLbsXTAnM2+QFvZ0YVf
         lwb9otoYyBOLB0QADtP0TSBxXQelNAEM1LjnioMi59m6UHpDj0qwkf26C7N1LXeKB5
         ClvFWO1iexnQOcf+SJa9oDeeraoZoggfooI4q5DvR6TN7y9fKQbTqpG6L0OABKNz71
         vbaE+3FaJujCUbJDyqxJGoRMRYgkK41R5o7UNwMG38S0gO58nd2cFLg/QnuP+96OYU
         oNkbyEtUyHc0yGGJVY0mJkvAtjfD4SpS6WtVgj1BeCPFHlDH8MgQbtXvFCc1ONvJhC
         LdNLzBzKiu5BQ==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=1s11hCFB_oFSRyqhbgYA:9 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/4] Export dev_item.type in sysfs /sys/fs/btrfs/<uuid>/devinfo/<devid>/type
Date:   Thu, 28 May 2020 20:34:50 +0200
Message-Id: <20200528183451.16654-4-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <20200528183451.16654-1-kreijack@libero.it>
References: <20200528183451.16654-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDrXuWwqW9ik1CG+woYMSGvNfWh9IhnmcXwPbE8nfDLRf4NfgySGejXwrgFP7yFQQnItySqGDeTWk+6WpDrHqrs7f5/5Q+dXlaH5VbLUDBl3F059ypjE
 X3Xtq4rMt2ZBHXvPUzalvLQ+8Jl9bHdA69EVN399/ZGPOlgSD1658C0hf9mc6TjEErDwSyLmVwkZFwJBEnzaEngys9yzvq7AKE3802VxIxk4UsesQytgqLkO
 zurn1hiwQZ7sRGSWpGD5ol8FlF4Cp82U+gB/NCojpIkXkxlNIxvdxaSrBTxE6+/JlicmdJZuXrSDO/rtxIvqMBDq+NMOIvkb/7gAbIZCiSzHT5fIpX+ODEkd
 vh0ml1XrsIwk0c5Ul7kzpUZ8CN1l4vFWVIeZPsasJCikVh5lg6hPzSa1ocg6K1a6CyJKBrjQi51gH3ZptvB0l3oc8orHCg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>

---
 fs/btrfs/sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index a39bff64ff24..c189fd7f9afd 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1244,11 +1244,22 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
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
2.27.0.rc2

