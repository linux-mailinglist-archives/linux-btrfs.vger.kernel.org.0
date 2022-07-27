Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70AC582949
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 17:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiG0PHC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 11:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiG0PG7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 11:06:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0142C4199C
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 08:06:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6D4C33EA8;
        Wed, 27 Jul 2022 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658934416;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=fEtP/NLcPab52v1yOPgjRWNTlaconryLQNj1ofrit5M=;
        b=SriQO+psfNaph0ZySoGJ2qai+9hB4hF8xYRb732E5Tm6NrJu5MRVJYdTZafi1c3d6to9qT
        Ff3FD9Hm44oVTI+8vFi+sYeQnlAyoNdX7jrndic806LOppn4ofHuaqW9Oei2DM3hHHtanR
        bsWrsg4+nArtBF1uZpmsO1uAOLGVKPY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8315913A8E;
        Wed, 27 Jul 2022 15:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UxwRH5BU4WJAZgAAMHmgww
        (envelope-from <dsterba@suse.com>); Wed, 27 Jul 2022 15:06:56 +0000
Date:   Wed, 27 Jul 2022 17:01:58 +0200
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: auto enable discard=async when possible
Message-ID: <20220727150158.GT13489@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a request to automatically enable async discard for capable
devices. We can do that, the async mode is designed to wait for larger
freed extents and is not intrusive, with limits to iops, kbps or latency.

The status and tunables will be exported in /sys/fs/btrfs/FSID/discard .

The automatic selection is done if there's at least one discard capable
device in the filesystem (not capable devices are skipped). Mounting
with any other discard option will honor that option, notably mounting
with nodiscard will keep it disabled.

Link: https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/disk-io.c | 14 ++++++++++++++
 fs/btrfs/super.c   |  2 ++
 fs/btrfs/volumes.c |  3 +++
 fs/btrfs/volumes.h |  2 ++
 5 files changed, 22 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db85b9dc7ed..0a338311f8e2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1503,6 +1503,7 @@ enum {
 	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
 	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
+	BTRFS_MOUNT_NODISCARD			= (1UL << 31),
 };
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3fac429cf8a4..8f8e33219d4d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3767,6 +3767,20 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
 	}
 
+	/*
+	 * For devices supporting discard turn on discard=async automatically,
+	 * unless it's already set or disabled. This could be turned off by
+	 * nodiscard for the same mount.
+	 */
+	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
+	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
+	      btrfs_test_opt(fs_info, NODISCARD)) &&
+	    fs_info->fs_devices->discardable) {
+		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
+				"auto enabling discard=async");
+	      btrfs_clear_opt(fs_info->mount_opt, NODISCARD);
+	}
+
 	/*
 	 * Mount does not set all options immediately, we can do it now and do
 	 * not have to wait for transaction commit
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4c7089b1681b..1032aaa2c2f4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -915,12 +915,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 				ret = -EINVAL;
 				goto out;
 			}
+			btrfs_clear_opt(info->mount_opt, NODISCARD);
 			break;
 		case Opt_nodiscard:
 			btrfs_clear_and_info(info, DISCARD_SYNC,
 					     "turning off discard");
 			btrfs_clear_and_info(info, DISCARD_ASYNC,
 					     "turning off async discard");
+			btrfs_set_opt(info->mount_opt, NODISCARD);
 			break;
 		case Opt_space_cache:
 		case Opt_space_cache_version:
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 272901514b0c..22bfc7806ccb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -639,6 +639,9 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	if (!bdev_nonrot(bdev))
 		fs_devices->rotating = true;
 
+	if (bdev_max_discard_sectors(bdev))
+		fs_devices->discardable = true;
+
 	device->bdev = bdev;
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	device->mode = flags;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5639961b3626..4c716603449d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -329,6 +329,8 @@ struct btrfs_fs_devices {
 	 * nonrot flag set
 	 */
 	bool rotating;
+	/* Devices support TRIM/discard commands */
+	bool discardable;
 
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
-- 
2.36.1

