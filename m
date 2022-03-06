Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278ED4CED22
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiCFSQs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 13:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiCFSQq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 13:16:46 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Mar 2022 10:15:53 PST
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62BC765D0E
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 10:15:53 -0800 (PST)
Received: from venice.bhome ([78.12.27.75])
        by michael.mail.tiscali.it with 
        id 36El2700C1dDdji016EoHV; Sun, 06 Mar 2022 18:14:48 +0000
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
Subject: [PATCH 2/5] btrfs: export the device allocation_hint property in sysfs
Date:   Sun,  6 Mar 2022 19:14:40 +0100
Message-Id: <aa62c61a0a9858d010d7d3ec67019332bd20d801.1646589622.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646589622.git.kreijack@inwind.it>
References: <cover.1646589622.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1646590488; bh=JjRHIaQBH8Q68/ZAJRphaTfGINGKVAAb0+OMlvGVml4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=0CnVRQIdUNLa+/FrN75RNDTSSm2D0vfKq2ndNsBUHUcqp8B8sDspzet1zL5y3VrFp
         sDRN+wNn9FkBPc9wqKdTv1KMjZsbvsnLpXIJN+hrZM7bkTMJ1NxWqEZJwcFMZEb0Hu
         w2QsoZj9LwSjaR1+UtIr30YooeMSBEO11VOf2a0w=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Export the device allocation_hint property via
/sys/fs/btrfs/<uuid>/devinfo/<devid>/allocation_hint

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/sysfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 17389a42a3ab..59d92a385a96 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1578,6 +1578,36 @@ static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, error_stats, btrfs_devinfo_error_stats_show);
 
+
+struct allocation_hint_name_t {
+	const char *name;
+	const u64 value;
+} allocation_hint_name[] = {
+	{ "DATA_PREFERRED", BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED },
+	{ "METADATA_PREFERRED", BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED },
+	{ "DATA_ONLY", BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY },
+	{ "METADATA_ONLY", BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY },
+};
+
+static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
+					struct kobj_attribute *a, char *buf)
+{
+	int i;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	for (i = 0 ; i < ARRAY_SIZE(allocation_hint_name) ; i++) {
+		if ((device->type & BTRFS_DEV_ALLOCATION_HINT_MASK) !=
+		    allocation_hint_name[i].value)
+			continue;
+
+		return scnprintf(buf, PAGE_SIZE, "%s\n",
+			allocation_hint_name[i].name);
+	}
+	return scnprintf(buf, PAGE_SIZE, "<UNKNOWN>\n");
+}
+BTRFS_ATTR(devid, allocation_hint, btrfs_devinfo_allocation_hint_show);
+
 /*
  * Information about one device.
  *
@@ -1591,6 +1621,7 @@ static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, replace_target),
 	BTRFS_ATTR_PTR(devid, scrub_speed_max),
 	BTRFS_ATTR_PTR(devid, writeable),
+	BTRFS_ATTR_PTR(devid, allocation_hint),
 	NULL
 };
 ATTRIBUTE_GROUPS(devid);
-- 
2.35.1

