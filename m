Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6E25ABDC8
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiICIT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 04:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiICITz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 04:19:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACE8326E0
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 01:19:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 47B8F1F95E
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662193191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RByrAnpd61EQxfnkbHaJyJO7fT1eiw1QRi28vl6Og8s=;
        b=XNBL7Y2DE8/45f/6IE6urf4RqzDkgg0iJNK9XverI+hr5aEqF+Q9Pi3sxW3hkKoP+FOdyH
        KHGOoJIHvUBgPY0B+hf/in/GEcPEwmObjAYkOJQtxEokmUYTn6GKLrondfTZLanuK+7pEl
        kla2ilxCh0yYqk+oi5qlUktdx8d3pHg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B614E139F9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OMR/HyUOE2OzagAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Sep 2022 08:19:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 1/9] btrfs: introduce BTRFS_IOC_SCRUB_FS family of ioctls
Date:   Sat,  3 Sep 2022 16:19:21 +0800
Message-Id: <e37ae2c85731ec307869e7c8f87c10d36d51846f.1662191784.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662191784.git.wqu@suse.com>
References: <cover.1662191784.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new ioctls are to address the disadvantages of the existing
btrfs_scrub_dev():

a One thread per-device
  This can cause multiple block groups to be marked read-only for scrub,
  reducing available space temporarily.

  This also causes higher CPU/IO usage.
  For scrub, we should use the minimal amount of CPU and cause less
  IO when possible.

b Extra IO for RAID56
  For data stripes, we will cause at least 2x IO if we run "btrfs scrub
  start <mnt>".
  1x from scrubbing the device of data stripe.
  The other 1x from scrubbing the parity stripe.

  This duplicated IO should definitely be avoided

c Bad progress report for RAID56
  We can not report any repaired P/Q bytes at all.

The a and b will be addressed by the new one thread per-fs
btrfs_scrub_fs ioctl.

While c will be addressed by the new btrfs_scrub_fs_progress structure,
which has better comments and classification for all errors.

This patch is only a skeleton for the new family of ioctls, will return
-EOPNOTSUPP for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c           |   6 ++
 include/uapi/linux/btrfs.h | 173 +++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fe0cc816b4eb..3df3bcdf06eb 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5508,6 +5508,12 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_scrub_cancel(fs_info);
 	case BTRFS_IOC_SCRUB_PROGRESS:
 		return btrfs_ioctl_scrub_progress(fs_info, argp);
+	case BTRFS_IOC_SCRUB_FS:
+		return -EOPNOTSUPP;
+	case BTRFS_IOC_SCRUB_FS_CANCEL:
+		return -EOPNOTSUPP;
+	case BTRFS_IOC_SCRUB_FS_PROGRESS:
+		return -EOPNOTSUPP;
 	case BTRFS_IOC_BALANCE_V2:
 		return btrfs_ioctl_balance(file, argp);
 	case BTRFS_IOC_BALANCE_CTL:
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7ada84e4a3ed..795ed33843ce 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -191,6 +191,174 @@ struct btrfs_ioctl_scrub_args {
 	__u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
 };
 
+struct btrfs_scrub_fs_progress {
+	/*
+	 * Fatal errors, including -ENOMEM, or csum/extent tree search errors.
+	 *
+	 * Normally after hitting such fatal errors, we error out, thus later
+	 * accounting will no longer be reliable.
+	 */
+	__u16	nr_fatal_errors;
+
+	/*
+	 * All super errors, from invalid members and IO error all go into
+	 * nr_super_errors.
+	 */
+	__u16	nr_super_errors;
+
+	/* Super block accounting. */
+	__u16	nr_super_scrubbed;
+	__u16	nr_super_repaired;
+
+	/*
+	 * Data accounting in bytes.
+	 *
+	 * We only care about how many bytes we scrubbed, thus no
+	 * accounting for number of extents.
+	 *
+	 * This accounting includes the extra mirrors.
+	 * E.g. for RAID1, one 16KiB extent will cause 32KiB in @data_scrubbed.
+	 */
+	__u64	data_scrubbed;
+
+	/* How many bytes can be recovered. */
+	__u64	data_recoverable;
+
+	/*
+	 * How many bytes are uncertain, this can only happen for NODATASUM
+	 * cases.
+	 * Including NODATASUM, and no extra mirror/parity to verify.
+	 * Or has extra mirrors, but they mismatch with each other.
+	 */
+	__u64	data_nocsum_uncertain;
+
+	/*
+	 * For data error bytes, these means determining errors, including:
+	 *
+	 * - IO failure, including missing dev.
+	 * - Data csum mismatch
+	 *   Csum tree search failure must go above case.
+	 */
+	__u64	data_io_fail;
+	__u64	data_csum_mismatch;
+
+	/*
+	 * All the unmentioned cases, including data matching its csum (of
+	 * course, implies IO suceeded) and data has no csum but matches all
+	 * other copies/parities, are the expected cases, no need to record.
+	 */
+
+	/*
+	 * Metadata accounting in bytes, pretty much the same as data.
+	 *
+	 * And since metadata has mandatory csum, there is no uncertain case.
+	 */
+	__u64	meta_scrubbed;
+	__u64	meta_recoverable;
+
+	/*
+	 * For meta, the checks are mostly progressive:
+	 *
+	 * - Unable to read
+	 *   @meta_io_fail
+	 *
+	 * - Unable to pass basic sanity checks (e.g. bytenr check)
+	 *   @meta_invalid
+	 *
+	 * - Pass basic sanity checks, but bad csum
+	 *   @meta_bad_csum
+	 *
+	 * - Pass basic checks and csum, but bad transid
+	 *   @meta_bad_transid
+	 *
+	 * - Pass all checks
+	 *   The expected case, no special accounting needed.
+	 */
+	__u64 meta_io_fail;
+	__u64 meta_invalid;
+	__u64 meta_bad_csum;
+	__u64 meta_bad_transid;
+
+	/*
+	 * Parity accounting.
+	 *
+	 * NOTE: for unused data sectors (but still contributes to P/Q
+	 * calculation, like the following case), they don't contribute
+	 * to any accounting.
+	 *
+	 * Data 1:	|<--- Unused ---->| <<<
+	 * Data 2:	|<- Data extent ->|
+	 * Parity:	|<--- Parity ---->|
+	 */
+	__u64 parity_scrubbed;
+	__u64 parity_recoverable;
+
+	/*
+	 * This happens when there is not enough info to determine if the
+	 * parity is correct, mostly happens when vertical stripes are
+	 * *all* NODATASUM sectors.
+	 *
+	 * If there is any sector with checksum in the vertical stripe,
+	 * parity itself will be no longer uncertain.
+	 */
+	__u64 parity_uncertain;
+
+	/*
+	 * For parity, the checks are progressive too:
+	 *
+	 * - Unable to read
+	 *   @parity_io_fail
+	 *
+	 * - Mismatch and any veritical data stripe has csum and
+	 *   the data stripe csum matches
+	 *   @parity_mismatch
+	 *   We want to repair the parity then.
+	 *
+	 * - Mismatch and veritical data stripe has csum, and data
+	 *   csum mismatch. And rebuilt data passes csum.
+	 *   This will go @data_recoverable or @data_csum_mismatch instead.
+	 *
+	 * - Mismatch but no veritical data stripe has csum
+	 *   @parity_uncertain
+	 *
+	 */
+	__u64 parity_io_fail;
+	__u64 parity_mismatch;
+
+	/* Padding to 256 bytes, and for later expansion. */
+	__u64 __unused[15];
+};
+static_assert(sizeof(struct btrfs_scrub_fs_progress) == 256);
+
+/*
+ * Readonly scrub fs will not try any repair (thus *_repaired member
+ * in scrub_fs_progress should always be 0).
+ */
+#define BTRFS_SCRUB_FS_FLAG_READONLY	(1ULL << 0)
+
+/*
+ * All supported flags.
+ *
+ * From the very beginning, scrub_fs ioctl would reject any unsupported
+ * flags, making later expansion much simper.
+ */
+#define BTRFS_SCRUB_FS_FLAG_SUPP	(BTRFS_SCRUB_FS_FLAG_READONLY)
+
+struct btrfs_ioctl_scrub_fs_args {
+	/* Input, logical bytenr to start the scrub */
+	__u64 start;
+
+	/* Input, the logical bytenr end (inclusive) */
+	__u64 end;
+
+	__u64 flags;
+	__u64 reserved[8];
+	struct btrfs_scrub_fs_progress progress; /* out */
+
+	/* pad to 1K */
+	__u8 unused[1024 - 24 - 64 - sizeof(struct btrfs_scrub_fs_progress)];
+};
+
 #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS	0
 #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_AVOID	1
 struct btrfs_ioctl_dev_replace_start_params {
@@ -1137,5 +1305,10 @@ enum btrfs_err_code {
 				    struct btrfs_ioctl_encoded_io_args)
 #define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
 				     struct btrfs_ioctl_encoded_io_args)
+#define BTRFS_IOC_SCRUB_FS	_IOWR(BTRFS_IOCTL_MAGIC, 65, \
+				      struct btrfs_ioctl_scrub_fs_args)
+#define BTRFS_IOC_SCRUB_FS_CANCEL _IO(BTRFS_IOCTL_MAGIC, 66)
+#define BTRFS_IOC_SCRUB_FS_PROGRESS _IOWR(BTRFS_IOCTL_MAGIC, 67, \
+				       struct btrfs_ioctl_scrub_fs_args)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.37.3

