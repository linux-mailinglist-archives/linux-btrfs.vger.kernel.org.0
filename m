Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311B1195FE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 21:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgC0UhC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 16:37:02 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:44198 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgC0UhC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 16:37:02 -0400
Received: from [2a02:a31c:853f:a300::4] (helo=valinor.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1jHvip-0003J6-Va; Fri, 27 Mar 2020 21:36:59 +0100
Received: from kilobyte by valinor.angband.pl with local (Exim 4.93)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1jHvio-0009RF-N6; Fri, 27 Mar 2020 21:36:54 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Fri, 27 Mar 2020 21:36:52 +0100
Message-Id: <20200327203652.36238-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:a31c:853f:a300::4
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=8.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_PASS=-0.001 autolearn=no autolearn_force=no languages=en
Subject: [PATCH] btrfs-progs: lots of typo fixes (codespell)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 CHANGES                                           | 2 +-
 Documentation/btrfs-man5.asciidoc                 | 6 +++---
 check/mode-lowmem.c                               | 6 +++---
 ci/gitlab/kernel_build.sh                         | 2 +-
 ci/gitlab/setup_image.sh                          | 2 +-
 cmds/filesystem-du.c                              | 2 +-
 common/format-output.h                            | 2 +-
 common/utils.c                                    | 2 +-
 configure.ac                                      | 2 +-
 convert/common.h                                  | 2 +-
 convert/main.c                                    | 2 +-
 convert/source-reiserfs.c                         | 4 ++--
 crypto/xxhash.c                                   | 2 +-
 crypto/xxhash.h                                   | 2 +-
 ctree.h                                           | 2 +-
 extent-tree.c                                     | 2 +-
 image/main.c                                      | 2 +-
 tests/fsck-tests/042-half-dropped-inode/test.sh   | 2 +-
 tests/fuzz-tests/images/bko-96971-btrfs-image.txt | 2 +-
 tests/misc-tests/034-metadata-uuid/test.sh        | 2 +-
 20 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/CHANGES b/CHANGES
index 6fae3683..f9e9f1b9 100644
--- a/CHANGES
+++ b/CHANGES
@@ -10,7 +10,7 @@ btrfs-progs-5.4 (2019-12-03)
   * mkfs: support new raid1c3 and raid1c4 block group profiles (kernel 5.5)
   * check:
     * --repair delays start with a warning, can be skipped using --force
-    * enhanced detetion of inode types from partial data, more options for
+    * enhanced detection of inode types from partial data, more options for
       repair
   * receive: fix quiet option
   * image: speed up chunk loading
diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index 9195331a..56b1ed58 100644
--- a/Documentation/btrfs-man5.asciidoc
+++ b/Documentation/btrfs-man5.asciidoc
@@ -136,8 +136,8 @@ Both 'zlib' and 'zstd' (since version 5.1) expose the compression level as a
 tunable knob with higher levels trading speed and memory ('zstd') for higher
 compression ratios. This can be set by appending a colon and the desired level.
 Zlib accepts the range [1, 9] and zstd accepts [1, 15]. If no level is set,
-both currently use a default level of 3. The value 0 is an alias for the defaul
-level.
+both currently use a default level of 3. The value 0 is an alias for the
+default level.
 +
 Otherwise some simple heuristics are applied to detect an incompressible file.
 If the first blocks written to a file are not compressible, the whole file is
@@ -635,7 +635,7 @@ SWAPFILE SUPPORT
 
 The swapfile is supported since kernel 5.0. Use `swapon`(8) to activate the
 swapfile. There are some limitations of the implementation in btrfs and linux
-swap subystem:
+swap subsystem:
  
 * filesystem - must be only single device
 * swapfile - the containing subvolume cannot be snapshotted
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 2f76d634..d82ac8a0 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -522,7 +522,7 @@ static int avoid_extents_overwrite(struct btrfs_fs_info *fs_info)
 	}
 
 	printf(
-	"Try to exclude all metadata blcoks and extents, it may be slow\n");
+	"Try to exclude all metadata blocks and extents, it may be slow\n");
 	ret = exclude_metadata_blocks(fs_info);
 out:
 	if (ret) {
@@ -2565,7 +2565,7 @@ static int repair_inode_gen_lowmem(struct btrfs_root *root,
 		error("failed to commit transaction: %m");
 		goto error;
 	}
-	printf("reseting inode generation to %llu for ino %llu\n",
+	printf("resetting inode generation to %llu for ino %llu\n",
 		transid, key.objectid);
 	return ret;
 
@@ -2810,7 +2810,7 @@ out:
 		}
 
 		/*
-		 * For orhpan inode, updating nbytes/size is just a waste of
+		 * For orphan inode, updating nbytes/size is just a waste of
 		 * time, so skip such repair and don't report them as error.
 		 */
 		if (nbytes != extent_size && !is_orphan) {
diff --git a/ci/gitlab/kernel_build.sh b/ci/gitlab/kernel_build.sh
index 230e6745..6f98d662 100755
--- a/ci/gitlab/kernel_build.sh
+++ b/ci/gitlab/kernel_build.sh
@@ -12,7 +12,7 @@ wget https://github.com/kdave/btrfs-devel/archive/misc-next.zip
 unzip -qq  misc-next.zip
 cd btrfs-devel-misc-next/ && make x86_64_defconfig && make kvmconfig
 
-# BTRFS specific entires
+# BTRFS specific entries
 cat <<EOF >> .config
 CONFIG_BTRFS_FS=y
 CONFIG_BTRFS_FS_POSIX_ACL=y
diff --git a/ci/gitlab/setup_image.sh b/ci/gitlab/setup_image.sh
index f046d201..09922ae1 100755
--- a/ci/gitlab/setup_image.sh
+++ b/ci/gitlab/setup_image.sh
@@ -19,7 +19,7 @@ done
 # mount the image file
 mount -o loop $IMG $DIR
 
-# Install required pacakges
+# Install required packages
 debootstrap --arch=amd64  --include=git,autoconf,automake,gcc,make,pkg-config,e2fslibs-dev,libblkid-dev,zlib1g-dev,liblzo2-dev,asciidoc,xmlto,libzstd-dev,python3.5,python3.5-dev,python3-dev,python3-setuptools,python-setuptools,xz-utils,acl,attr stretch $DIR http://ftp.de.debian.org/debian/
 
 ## Setup 9p mount
diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
index 1cea5fcf..fe52c444 100644
--- a/cmds/filesystem-du.c
+++ b/cmds/filesystem-du.c
@@ -134,7 +134,7 @@ static u64 count_unique_bytes(struct rb_root *root, struct shared_extent *n)
 
 	do {
 		/*
-		 * Expand our search window based on the lastest
+		 * Expand our search window based on the last
 		 * overlapping extent. Doing this will allow us to
 		 * find all possible overlaps
 		 */
diff --git a/common/format-output.h b/common/format-output.h
index b73f53ba..bcc2d74d 100644
--- a/common/format-output.h
+++ b/common/format-output.h
@@ -64,7 +64,7 @@ struct format_ctx {
 	/* Nesting of groups like lists or maps (format: json) */
 	int depth;
 
-	/* Array of named output fileds as defined by the command */
+	/* Array of named output fields as defined by the command */
 	const struct rowspec *rowspec;
 
 	char jtype[JSON_NESTING_LIMIT];
diff --git a/common/utils.c b/common/utils.c
index 4ce36836..2cd5fb04 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -949,7 +949,7 @@ again:
 		goto again;
 	}
 
-	/* get the lastest max_id to stay consistent with the num_devices */
+	/* get the last max_id to stay consistent with the num_devices */
 	if (search_key->nr_items == 0)
 		/*
 		 * last tree_search returns an empty buf, use the devid of
diff --git a/configure.ac b/configure.ac
index cf792eb5..0efa3469 100644
--- a/configure.ac
+++ b/configure.ac
@@ -198,7 +198,7 @@ fi
 HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE=0
 AX_CHECK_DEFINE([linux/fiemap.h], [FIEMAP_EXTENT_SHARED], [],
 		[HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE=1
-		 AC_MSG_WARN([no definition of FIEMAP_EXTENT_SHARED found, probably old kernel, will use own defintion, 'btrfs fi du' might report wrong numbers])])
+		 AC_MSG_WARN([no definition of FIEMAP_EXTENT_SHARED found, probably old kernel, will use own definition, 'btrfs fi du' might report wrong numbers])])
 
 if test "x$HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE" == "x1"; then
 AC_DEFINE([HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE], [1], [We defined FIEMAP_EXTENT_SHARED])
diff --git a/convert/common.h b/convert/common.h
index 2f4ea485..44a214c5 100644
--- a/convert/common.h
+++ b/convert/common.h
@@ -16,7 +16,7 @@
 
 /*
  * Defines and function declarations for users of the mkfs API, no internal
- * defintions.
+ * definitions.
  */
 
 #ifndef __BTRFS_CONVERT_COMMON_H__
diff --git a/convert/main.c b/convert/main.c
index a04ec7a3..e83dd588 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -52,7 +52,7 @@
  *      We can a map used space of old fs
  *
  * 1.2) Calculate data chunk layout - this is the hard part
- *      New data chunks must meet 3 conditions using result fomr 1.1
+ *      New data chunks must meet 3 conditions using result from 1.1
  *      a. Large enough to be a chunk
  *      b. Doesn't intersect reserved ranges
  *      c. Covers all the remaining old fs used space
diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
index e3187f23..9fd6b9ab 100644
--- a/convert/source-reiserfs.c
+++ b/convert/source-reiserfs.c
@@ -495,7 +495,7 @@ static int reiserfs_copy_dirent(reiserfs_filsys_t fs,
 	if (ret) {
 		errno = -ret;
 		error(
-	"an error occured while converting \"%.*s\", reiserfs key [%u %u]: %m",
+	"an error occurred while converting \"%.*s\", reiserfs key [%u %u]: %m",
 			(int)len, name, deh_dirid, deh_objectid);
 		return ret;
 	}
@@ -564,7 +564,7 @@ static int reiserfs_copy_meta(reiserfs_filsys_t fs, struct btrfs_root *root,
 	};
 
 	/* The root directory's dirid in reiserfs points to an object
-	 * that doens't exist.  In btrfs it's self-referential.
+	 * that doesn't exist.  In btrfs it's self-referential.
 	 */
 	if (deh_dirid == REISERFS_ROOT_PARENT_OBJECTID)
 		parent = objectid;
diff --git a/crypto/xxhash.c b/crypto/xxhash.c
index 1d2bab5c..c2f1be9f 100644
--- a/crypto/xxhash.c
+++ b/crypto/xxhash.c
@@ -210,7 +210,7 @@ static U32 XXH_read32(const void* memPtr)
 #endif   /* XXH_FORCE_DIRECT_MEMORY_ACCESS */
 
 
-/* ===   Endianess   === */
+/* ===   Endianness   === */
 typedef enum { XXH_bigEndian=0, XXH_littleEndian=1 } XXH_endianess;
 
 /* XXH_CPU_LITTLE_ENDIAN can be defined externally, for example on the compiler command line */
diff --git a/crypto/xxhash.h b/crypto/xxhash.h
index 7533eb29..ce7f85c1 100644
--- a/crypto/xxhash.h
+++ b/crypto/xxhash.h
@@ -343,7 +343,7 @@ struct XXH64_state_s {
  *
  * - 128-bits output type : currently defined as a structure of two 64-bits fields.
  *                          That's because 128-bit values do not exist in C standard.
- *                          Note that it means that, at byte level, result is not identical depending on endianess.
+ *                          Note that it means that, at byte level, result is not identical depending on endianness.
  *                          However, at field level, they are identical on all platforms.
  *                          The canonical representation solves the issue of identical byte-level representation across platforms,
  *                          which is necessary for serialization.
diff --git a/ctree.h b/ctree.h
index bb0cff43..29dbbc2d 100644
--- a/ctree.h
+++ b/ctree.h
@@ -569,7 +569,7 @@ struct btrfs_path {
 	struct extent_buffer *nodes[BTRFS_MAX_LEVEL];
 	int slots[BTRFS_MAX_LEVEL];
 #if 0
-	/* The kernel locking sheme is not done in userspace. */
+	/* The kernel locking scheme is not done in userspace. */
 	int locks[BTRFS_MAX_LEVEL];
 #endif
 	signed char reada;
diff --git a/extent-tree.c b/extent-tree.c
index 7ba80375..59f79a4a 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2624,7 +2624,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
  * Find a block group which starts >= @key->objectid in extent tree.
  *
  * Return 0 for found
- * Retrun >0 for not found
+ * Return >0 for not found
  * Return <0 for error
  */
 static int find_first_block_group(struct btrfs_root *root,
diff --git a/image/main.c b/image/main.c
index bddb4972..13323aa6 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2455,7 +2455,7 @@ static int fixup_dev_extents(struct btrfs_trans_handle *trans)
 
 	dev = btrfs_find_device(fs_info, devid, NULL, NULL);
 	if (!dev) {
-		error("faild to find devid %llu", devid);
+		error("failed to find devid %llu", devid);
 		return -ENODEV;
 	}
 
diff --git a/tests/fsck-tests/042-half-dropped-inode/test.sh b/tests/fsck-tests/042-half-dropped-inode/test.sh
index 1195fa19..3bd60912 100755
--- a/tests/fsck-tests/042-half-dropped-inode/test.sh
+++ b/tests/fsck-tests/042-half-dropped-inode/test.sh
@@ -10,7 +10,7 @@
 # The way to reproduce the image:
 # - Create a lot of regular file extents for one inode
 #   Using direct IO with small block size is the easiy method
-# - Modify kernel to commit transaction more aggresively
+# - Modify kernel to commit transaction more aggressively
 #   Two locations are needed:
 #   * btrfs_unlink():
 #     To make the ORPHAN item reach disk asap
diff --git a/tests/fuzz-tests/images/bko-96971-btrfs-image.txt b/tests/fuzz-tests/images/bko-96971-btrfs-image.txt
index ff85540d..f3ec801c 100644
--- a/tests/fuzz-tests/images/bko-96971-btrfs-image.txt
+++ b/tests/fuzz-tests/images/bko-96971-btrfs-image.txt
@@ -3,7 +3,7 @@ URL: https://bugzilla.kernel.org/show_bug.cgi?id=96971
 
 I've identified some problems in the btrfs code and attached a btrfs-image
 which causes the userland tools to crash and the kernel to immediately freeze
-once the filesystem get's mounted and one of the files is accessed. Putting
+once the filesystem gets mounted and one of the files is accessed. Putting
 the image onto a usb-drive gives you a freeze-on-a-stick :-)
 
 "btrfs check" crashes due to a SIGFPE in count_csum_range(). The culprit is
diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 6ac55b1c..2fa8f3fb 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -50,7 +50,7 @@ check_btrfstune() {
 	# test that having -m|-M on seed device is forbidden
 	run_check_mkfs_test_dev
 	run_check $SUDO_HELPER "$TOP/btrfstune" -S 1 "$TEST_DEV"
-	run_mustfail "Succeded changing fsid on a seed device" \
+	run_mustfail "Succeeded changing fsid on a seed device" \
 		$SUDO_HELPER "$TOP/btrfstune" -m "$TEST_DEV"
 
 	# test that using -U|-u on an fs with METADATA_UUID flag is forbidden
-- 
2.26.0

