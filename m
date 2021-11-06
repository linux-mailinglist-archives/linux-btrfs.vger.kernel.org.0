Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED8447108
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Nov 2021 01:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhKGACu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Nov 2021 20:02:50 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:38870 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhKGACt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Nov 2021 20:02:49 -0400
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mjVZH-009M8u-KT; Sun, 07 Nov 2021 00:57:54 +0100
Received: from [2a02:a31c:8245:f980::4] (helo=valinor.angband.pl)
        by barad-dur.angband.pl with esmtp (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mjVZG-0007Sz-8K; Sun, 07 Nov 2021 00:57:50 +0100
Received: from kilobyte by valinor.angband.pl with local (Exim 4.95)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1mjVZC-0003bm-Ue;
        Sun, 07 Nov 2021 00:57:46 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Sun,  7 Nov 2021 00:57:42 +0100
Message-Id: <20211106235742.13854-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.73.149.240
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_HELO_NONE=0.001,SPF_PASS=-0.001,TVD_RCVD_IP=0.001,
        URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no languages=en
Subject: [PATCH] btrfs-progs: fix a bunch of typos
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These have been detected by lintian and codespell.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 CHANGES                                         | 4 ++--
 Documentation/CmdLineConventions                | 2 +-
 Documentation/btrfs-convert.asciidoc            | 2 +-
 Documentation/btrfs-convert.rst                 | 2 +-
 Documentation/btrfs-device.asciidoc             | 2 +-
 Documentation/btrfs-device.rst                  | 2 +-
 Documentation/btrfs-man5.asciidoc               | 2 +-
 Documentation/btrfs-man5.rst                    | 2 +-
 Documentation/mkfs.btrfs.asciidoc               | 2 +-
 Documentation/mkfs.btrfs.rst                    | 2 +-
 cmds/device.c                                   | 2 +-
 cmds/filesystem.c                               | 2 +-
 cmds/restore.c                                  | 2 +-
 common/utils.c                                  | 4 ++--
 tests/fsck-tests.sh                             | 2 +-
 tests/fsck-tests/042-half-dropped-inode/test.sh | 2 +-
 16 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/CHANGES b/CHANGES
index e48912e9..047f1e1c 100644
--- a/CHANGES
+++ b/CHANGES
@@ -88,7 +88,7 @@ btrfs-progs-5.13.1 (2021-07-30)
 * build: fix build on musl libc due to missing definition of NAME_MAX
 * check:
   * batch more work into one transaction when clearing v1 free space inodes
-  * detect directoris with wrong number of links
+  * detect directories with wrong number of links
 * libbtrfsutil: fix race between subvolume iterator and deletion
 * mkfs: be more specific about supported profiles for zoned device
 * other:
@@ -193,7 +193,7 @@ btrfs-progs-5.10 (2021-01-18)
     * print percentage of progress
     * add size unit options
   * fi usage: also print free space from statfs
-  * convert: copy full 64 bit timestamp from ext4 if availalble
+  * convert: copy full 64 bit timestamp from ext4 if available
   * check:
     * add ability to repair extent item generation
     * new option to remove leftovers from inode number cache (-o inode_cache)
diff --git a/Documentation/CmdLineConventions b/Documentation/CmdLineConventions
index f62c67b0..409ac731 100644
--- a/Documentation/CmdLineConventions
+++ b/Documentation/CmdLineConventions
@@ -41,7 +41,7 @@
 * unix commands do one thing and say nothing, we may diverge a bit from that
 * default output is one line shortly describing the action
  * why: running commands from scripts or among many other commands should be
-   noticeable due to progres tracking or for analysis if something goes wrong
+   noticeable due to progress tracking or for analysis if something goes wrong
  * there's a global option to make the commands silent `btrfs -q subcommand`,
    this can be easily scripted eg. storing the global verbosity option in a
    variable, `btrfs $quiet subcommand` and then enabling or disabling as needed
diff --git a/Documentation/btrfs-convert.asciidoc b/Documentation/btrfs-convert.asciidoc
index b32e0844..ea617295 100644
--- a/Documentation/btrfs-convert.asciidoc
+++ b/Documentation/btrfs-convert.asciidoc
@@ -46,7 +46,7 @@ machines).
 **BEFORE YOU START**
 
 The source filesystem must be clean, eg. no journal to replay or no repairs
-needed. The respective 'fsck' utility must be run on the source filesytem prior
+needed. The respective 'fsck' utility must be run on the source filesystem prior
 to conversion. Please refer to the manual pages in case you encounter problems.
 
 For ext2/3/4:
diff --git a/Documentation/btrfs-convert.rst b/Documentation/btrfs-convert.rst
index 3445c7b5..e597a816 100644
--- a/Documentation/btrfs-convert.rst
+++ b/Documentation/btrfs-convert.rst
@@ -45,7 +45,7 @@ machines).
 **BEFORE YOU START**
 
 The source filesystem must be clean, eg. no journal to replay or no repairs
-needed. The respective **fsck** utility must be run on the source filesytem prior
+needed. The respective **fsck** utility must be run on the source filesystem prior
 to conversion. Please refer to the manual pages in case you encounter problems.
 
 For ext2/3/4:
diff --git a/Documentation/btrfs-device.asciidoc b/Documentation/btrfs-device.asciidoc
index 048a54d0..30f9761f 100644
--- a/Documentation/btrfs-device.asciidoc
+++ b/Documentation/btrfs-device.asciidoc
@@ -185,7 +185,7 @@ available in the physical space provided by the device, eg. after a device shrin
 group type (Data, Metadata, System) and profile (single, RAID1, ...) allocated
 on the device
 * 'Data,RAID0/3' -- in particular, striped profiles RAID0/RAID10/RAID5/RAID6 with
-the number of devices on which the stripes are allocated, multiple occurences
+the number of devices on which the stripes are allocated, multiple occurrences
 of the same profile can appear in case a new device has been added and all new
 available stripes have been used for writes
 * 'Unallocated' -- remaining space that the filesystem can still use for new
diff --git a/Documentation/btrfs-device.rst b/Documentation/btrfs-device.rst
index dda712bb..95fd4c6e 100644
--- a/Documentation/btrfs-device.rst
+++ b/Documentation/btrfs-device.rst
@@ -186,7 +186,7 @@ usage [options] <path> [<path>...]::
           RAID1, ...) allocated on the device
         * *Data,RAID0/3* -- in particular, striped profiles
           RAID0/RAID10/RAID5/RAID6 with the number of devices on which the
-          stripes are allocated, multiple occurences of the same profile can
+          stripes are allocated, multiple occurrences of the same profile can
           appear in case a new device has been added and all new available
           stripes have been used for writes
         * *Unallocated* -- remaining space that the filesystem can still use
diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index 9f970059..b7637b91 100644
--- a/Documentation/btrfs-man5.asciidoc
+++ b/Documentation/btrfs-man5.asciidoc
@@ -884,7 +884,7 @@ There are two ways to detect incompressible data:
 * actual compression attempt - data are compressed, if the result is not smaller,
   it's discarded, so this depends on the algorithm and level
 * pre-compression heuristics - a quick statistical evaluation on the data is
-  peformed and based on the result either compression is performed or skipped,
+  performed and based on the result either compression is performed or skipped,
   the NOCOMPRESS bit is not set just by the heuristic, only if the compression
   algorithm does not make an improvent
 
diff --git a/Documentation/btrfs-man5.rst b/Documentation/btrfs-man5.rst
index 0fafc84c..3931e509 100644
--- a/Documentation/btrfs-man5.rst
+++ b/Documentation/btrfs-man5.rst
@@ -876,7 +876,7 @@ There are two ways to detect incompressible data:
 * actual compression attempt - data are compressed, if the result is not smaller,
   it's discarded, so this depends on the algorithm and level
 * pre-compression heuristics - a quick statistical evaluation on the data is
-  peformed and based on the result either compression is performed or skipped,
+  performed and based on the result either compression is performed or skipped,
   the NOCOMPRESS bit is not set just by the heuristic, only if the compression
   algorithm does not make an improvent
 
diff --git a/Documentation/mkfs.btrfs.asciidoc b/Documentation/mkfs.btrfs.asciidoc
index 7ced7672..f7cf3693 100644
--- a/Documentation/mkfs.btrfs.asciidoc
+++ b/Documentation/mkfs.btrfs.asciidoc
@@ -69,7 +69,7 @@ changed in version 5.15 to be always 'dup'.
 
 Note that the rotational status can be arbitrarily set by the underlying block
 device driver and may not reflect the true status (network block device, memory-backed
-SCSI devices, real block device behind some additonal device mapper layer,
+SCSI devices, real block device behind some additional device mapper layer,
 etc). It's recommended to always set the options '--data/--metadata' to avoid
 confusion and unexpected results.
 
diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index f1ae7aac..5130cf64 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -65,7 +65,7 @@ OPTIONS
 
                 Note that the rotational status can be arbitrarily set by the underlying block
                 device driver and may not reflect the true status (network block device, memory-backed
-                SCSI devices, real block device behind some additonal device mapper layer,
+                SCSI devices, real block device behind some additional device mapper layer,
                 etc). It's recommended to always set the options *--data/--metadata* to avoid
                 confusion and unexpected results.
 
diff --git a/cmds/device.c b/cmds/device.c
index 48067101..7d3febff 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -324,7 +324,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 	"If 'missing' is specified for <device>, the first device that is",	\
 	"described by the filesystem metadata, but not present at the mount",	\
 	"time will be removed. (only in degraded mode)",			\
-	"If 'cancel' is specified as the only device to delete, request cancelation", \
+	"If 'cancel' is specified as the only device to delete, request cancellation", \
 	"of a previously started device deletion and wait until kernel finishes", \
 	"any pending work. This will not delete the device and the size will be", \
 	"restored to previous state. When deletion is not running, this will fail."
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 6a9e46d2..b08295de 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1228,7 +1228,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		} else if (strcmp(argv[optind], "--") == 0) {
 			/* Separator: options -- non-options */
 		} else if (strncmp(argv[optind], "--", 2) == 0) {
-			/* Emulate what getopt does on unkonwn option */
+			/* Emulate what getopt does on unknown option */
 			optind++;
 			usage_unknown_option(cmd, argv);
 		} else {
diff --git a/cmds/restore.c b/cmds/restore.c
index 8f71d6f8..48300ae5 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -955,7 +955,7 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 			do {
 				ret = next_leaf(root, &path);
 				if (ret < 0) {
-					error("search for next leaf faile: %d", ret);
+					error("search for next leaf failed: %d", ret);
 					goto out;
 				} else if (ret > 0) {
 					/* No more leaves to search */
diff --git a/common/utils.c b/common/utils.c
index 29825f6e..1b1ec7df 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -645,7 +645,7 @@ struct mnt_entry {
 };
 
 /*
- * Find first occurence of up an option string (as "option=") in @options,
+ * Find first occurrence of up an option string (as "option=") in @options,
  * separated by comma. Return allocated string as "option=value"
  */
 static char *find_option(const char *options, const char *option)
@@ -818,7 +818,7 @@ static void parse_mntinfo_line(char *line, struct mnt_entry *ent)
  *   37 29 0:32 /vol/dir2 /othermnt ro,relatime - btrfs /dev/sda2 ro,ssd,space_cache,subvolid=256,subvol=/vol
  *
  * If we try to find a mount point only using subvol and subvolid from mount
- * options we would get mislead to belive that /othermnt has the same content
+ * options we would get mislead to believe that /othermnt has the same content
  * as /mnt.
  *
  * But, using mountinfo, we have the pathaname _inside_ the filesystem, so we
diff --git a/tests/fsck-tests.sh b/tests/fsck-tests.sh
index d7150ad7..9633bc3d 100755
--- a/tests/fsck-tests.sh
+++ b/tests/fsck-tests.sh
@@ -64,7 +64,7 @@ run_one_test() {
 			fi
 			_fail "test failed for case $(basename $testname)"
 		fi
-		# These tests have overriden check_image() and their images may
+		# These tests have overridden check_image() and their images may
 		# have intentional unaligned metadata to trigger subpage
 		# warnings (like fsck/018), skip the check for their subpage
 		# warnings.
diff --git a/tests/fsck-tests/042-half-dropped-inode/test.sh b/tests/fsck-tests/042-half-dropped-inode/test.sh
index 3bd60912..356d419e 100755
--- a/tests/fsck-tests/042-half-dropped-inode/test.sh
+++ b/tests/fsck-tests/042-half-dropped-inode/test.sh
@@ -9,7 +9,7 @@
 #
 # The way to reproduce the image:
 # - Create a lot of regular file extents for one inode
-#   Using direct IO with small block size is the easiy method
+#   Using direct IO with small block size is the easy method
 # - Modify kernel to commit transaction more aggressively
 #   Two locations are needed:
 #   * btrfs_unlink():
-- 
2.33.1

