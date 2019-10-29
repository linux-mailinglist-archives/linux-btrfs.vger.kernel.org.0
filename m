Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52063E8032
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 07:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfJ2GV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 02:21:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:35488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732446AbfJ2GV5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 02:21:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B4CBB194
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2019 06:21:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH] btrfs: rescue: Introduce new rescue mount option, rescue=skipdatacsum, to skip data csum verification
Date:   Tue, 29 Oct 2019 14:21:49 +0800
Message-Id: <20191029062149.217995-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When btrfs csum tree is corrupted, e.g. one csum tree block get csum
error for all its copies, we will have no chance to read out the data.

  # Hook before we submit a read bio, will fill up the csum buffer
  # for this read
  btrfs_submit_bio_hook()
  |- btrfs_lookup_bio_sums()
     |- __btrfs_lookup_bio_sums()
        |- item = btrfs_lookup_csum();
        |  Failed with -EIO
        |- memset(csum, 0, csum_size);	# Set the csum buffer to 0
        |- goto found;			# Go to next page lookup

  # Now that btrfs_io_bio->csum has 0 filled for failure range

  # Hook after the read bio is completed, will do the csum verification
  btrfs_readpage_end_io_hook()
  |- __readpage_endio_check()
     |- do csum calculation
     |  Since all csum value is set to 0, the csum verification will
     |  fail.
     |- btrfs_print_data_csum_error();

  # We got EIO in user space, without any usable data

The best solution to this problem would be introduce an extra companion
bitmap for csum verification, notifying the caller whether we failed to
read out the csum or the csum is really all 0.

But that solution can be complex and only works for above described
case.

Here we introduce a new rescue= mount option to completely skip data
csum check.
Since data csum check is completely skipped, for profiles with extra
mirrors/copies, it will return the first copy only, which is not
optimized, but should be good enough for rescue usage.

This option only affects data csum verification, doesn't affect data
csum calcuation, so new data write will still be protected by csum (if
it doesn't get affected by csum tree corruption).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This patch needs rescue= mount options patchset.

Reason for RFC:
Need extra feedbacks. I guess users who has experienced data salvage
would like this. But I'm not sure if it's welcomed to add such mount
option.
---
 fs/btrfs/compression.c | 3 ++-
 fs/btrfs/ctree.h       | 1 +
 fs/btrfs/inode.c       | 3 +++
 fs/btrfs/super.c       | 6 ++++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b05b361e2062..08dfc2255490 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -85,7 +85,8 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 	u8 csum[BTRFS_CSUM_SIZE];
 	u8 *cb_sum = cb->sums;
 
-	if (inode->flags & BTRFS_INODE_NODATASUM)
+	if (inode->flags & BTRFS_INODE_NODATASUM ||
+	    btrfs_test_opt(fs_info, SKIP_DATACSUM))
 		return 0;
 
 	shash->tfm = fs_info->csum_shash;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ff24b607bc91..bc64abb42a99 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1191,6 +1191,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_SKIP_BG		(1 << 29)
+#define BTRFS_MOUNT_SKIP_DATACSUM	(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a0546401bc0a..bfd1ee35e2e9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3275,6 +3275,9 @@ static int __readpage_endio_check(struct inode *inode,
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
+	if (btrfs_test_opt(fs_info, SKIP_DATACSUM))
+		return 0;
+
 	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
 
 	kaddr = kmap_atomic(page);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ab61b0364960..e442ef36ac24 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -333,6 +333,7 @@ enum {
 	Opt_usebackuproot,
 	Opt_nologreplay,
 	Opt_rescue_skip_bg,
+	Opt_rescue_skip_datacsum,
 
 	/* Deprecated options */
 	Opt_alloc_start,
@@ -430,6 +431,7 @@ static const match_table_t rescue_tokens = {
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_nologreplay, "nologreplay"},
 	{Opt_rescue_skip_bg, "skipbg"},
+	{Opt_rescue_skip_datacsum, "skipdatacsum"},
 	{Opt_err, NULL},
 };
 
@@ -466,6 +468,10 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, SKIP_BG,
 				"skip mount time block group searching");
 			break;
+		case Opt_rescue_skip_datacsum:
+			btrfs_set_and_info(info, SKIP_DATACSUM,
+				"skip data checksum verification");
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized rescue option '%s'", p);
 			ret = -EINVAL;
-- 
2.23.0

