Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033C169168D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 03:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjBJCNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 21:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBJCNr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 21:13:47 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B856E889;
        Thu,  9 Feb 2023 18:13:45 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675995223;
        bh=VzlrvAZAWEVQpHCcqQ4qNIrkcDuDoIy5bKPO4pkK36k=;
        h=From:Date:Subject:To:Cc:From;
        b=bO8v2weZou94Tgd/yAFueMF8rEI5P4EWUMtEntRv2ZauFXUpP2l8EqTMCvUPHEs0E
         Pzzxg/dGy69u4d2+0wouVvZHCR1hLMp2eYIGGVeadUceejP/Jh5nTNUV+2T7EUdY6w
         BYWaEmahaTFB72xyxv5TA64p6irJR4xKM9Mr/5Xw=
Date:   Fri, 10 Feb 2023 02:13:40 +0000
Subject: [PATCH] btrfs: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230210-kobj_type-btrfs-v1-1-16d3f33c17be@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFSo5WMC/x2N0QqDMAxFf0XyvELt1If9yhijrYnGSZXEjYn47
 wt7POdyuAcoCqPCrTpA8MPKSzGoLxXkMZYBHffGEHy4+lB791rS9Nz2FV3ahNSRbzrKTWiREli
 VotokseTRuvKeZ5OrIPH3f3N/nOcPbj4zM3YAAAA=
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675995221; l=2540;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=VzlrvAZAWEVQpHCcqQ4qNIrkcDuDoIy5bKPO4pkK36k=;
 b=KACfp2GhJ5mUUVNX03EWUPeIeoGqY/bvZ2sy/EIo8+f41AboWsDiUSO73OsB1fVuhSGjuhSz+
 kBeGIlxyWYwAFztdmzlGCdnGOYA9UWvEf0GL5hwAD9U6DOzYB6YiOP9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/btrfs/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 45615ce36498..95c9028e116a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -702,7 +702,7 @@ static void release_raid_kobj(struct kobject *kobj)
 	kfree(to_raid_kobj(kobj));
 }
 
-static struct kobj_type btrfs_raid_ktype = {
+static const struct kobj_type btrfs_raid_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.release = release_raid_kobj,
 	.default_groups = raid_groups,
@@ -900,7 +900,7 @@ static void space_info_release(struct kobject *kobj)
 	kfree(sinfo);
 }
 
-static struct kobj_type space_info_ktype = {
+static const struct kobj_type space_info_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.release = space_info_release,
 	.default_groups = space_info_groups,
@@ -1259,7 +1259,7 @@ static void btrfs_release_fsid_kobj(struct kobject *kobj)
 	complete(&fs_devs->kobj_unregister);
 }
 
-static struct kobj_type btrfs_ktype = {
+static const struct kobj_type btrfs_ktype = {
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.release	= btrfs_release_fsid_kobj,
 };
@@ -1789,7 +1789,7 @@ static void btrfs_release_devid_kobj(struct kobject *kobj)
 	complete(&device->kobj_unregister);
 }
 
-static struct kobj_type devid_ktype = {
+static const struct kobj_type devid_ktype = {
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = devid_groups,
 	.release	= btrfs_release_devid_kobj,
@@ -2103,7 +2103,7 @@ static void qgroups_release(struct kobject *kobj)
 	kfree(kobj);
 }
 
-static struct kobj_type qgroups_ktype = {
+static const struct kobj_type qgroups_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = qgroups_groups,
 	.release = qgroups_release,
@@ -2173,7 +2173,7 @@ static void qgroup_release(struct kobject *kobj)
 	memset(&qgroup->kobj, 0, sizeof(*kobj));
 }
 
-static struct kobj_type qgroup_ktype = {
+static const struct kobj_type qgroup_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.release = qgroup_release,
 	.default_groups = qgroup_groups,

---
base-commit: e544a07438522ab3688416e6e2e34bf0ee6d8755
change-id: 20230210-kobj_type-btrfs-f046fc425efb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

