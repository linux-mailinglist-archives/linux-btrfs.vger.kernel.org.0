Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3102E2C2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Dec 2020 20:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgLYToF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Dec 2020 14:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgLYToF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Dec 2020 14:44:05 -0500
X-Greylist: delayed 1681 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Dec 2020 11:43:24 PST
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909CC061757
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Dec 2020 11:43:24 -0800 (PST)
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1kssYW-0001Og-Gu; Fri, 25 Dec 2020 20:15:19 +0100
Received: from kilobyte by umbar.angband.pl with local (Exim 4.94)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1kssYV-0006Uv-Ie; Fri, 25 Dec 2020 20:15:15 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Fri, 25 Dec 2020 20:15:11 +0100
Message-Id: <20201225191511.24931-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.73.149.240
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=8.0 tests=ALL_TRUSTED=-1,BAYES_00=-1.9,
        TVD_RCVD_IP=0.001 autolearn=ham autolearn_force=no languages=en
Subject: [PATCH] btrfs-progs: a bunch of typo fixes
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 CHANGES                              | 2 +-
 Documentation/btrfs-balance.asciidoc | 2 +-
 Documentation/btrfs-man5.asciidoc    | 4 ++--
 INSTALL                              | 2 +-
 README.md                            | 2 +-
 cmds/filesystem-usage.c              | 2 +-
 crypto/hash-speedtest.c              | 6 +++---
 kernel-lib/radix-tree.c              | 2 +-
 m4/ax_gcc_version.m4                 | 2 +-
 tests/README.md                      | 2 +-
 10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/CHANGES b/CHANGES
index e974dc58..16da2863 100644
--- a/CHANGES
+++ b/CHANGES
@@ -85,7 +85,7 @@ btrfs-progs-5.6 (2020-04-05)
   * fixes:
     * restore: proper mirror iteration on decompression error
     * restore: make symlink messages less noisy
-    * check: handle holes at the begining or end of file
+    * check: handle holes at the beginning or end of file
     * fix xxhash output on big endian machines
     * receive: fix lookup of subvolume by uuid in case it was already
       received before
diff --git a/Documentation/btrfs-balance.asciidoc b/Documentation/btrfs-balance.asciidoc
index d94719a0..7ba88671 100644
--- a/Documentation/btrfs-balance.asciidoc
+++ b/Documentation/btrfs-balance.asciidoc
@@ -37,7 +37,7 @@ The filters can be used to perform following actions:
 
 The filters can be applied to a combination of block group types (data,
 metadata, system). Note that changing only the 'system' type needs the force
-option. Otherwise 'system' gets automatically converted whenver 'metadata'
+option. Otherwise 'system' gets automatically converted whenever 'metadata'
 profile is converted.
 
 When metadata redundancy is reduced (eg. from RAID1 to single) the force option
diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index 65352009..9016f400 100644
--- a/Documentation/btrfs-man5.asciidoc
+++ b/Documentation/btrfs-man5.asciidoc
@@ -34,7 +34,7 @@ per-subvolume 'nodatacow', 'nodatasum', or 'compress' using mount options. This
 should eventually be fixed, but it has proved to be difficult to implement
 correctly within the Linux VFS framework.
 
-Mount options are processed in order, only the last occurence of an option
+Mount options are processed in order, only the last occurrence of an option
 takes effect and may disable other options due to constraints (see eg.
 'nodatacow' and 'compress'). The output of 'mount' command shows which options
 have been applied.
@@ -868,7 +868,7 @@ refers to what `xfs_io`(8) provides:
 'append only', same as the attribute
 
 *s*::
-'synchronous updates', same as the atribute 'S'
+'synchronous updates', same as the attribute 'S'
 
 *A*::
 'no atime updates', same as the attribute
diff --git a/INSTALL b/INSTALL
index 470ceebd..e2b6c7c3 100644
--- a/INSTALL
+++ b/INSTALL
@@ -14,7 +14,7 @@ For the btrfs-convert utility:
 - e2fsprogs - ext2/ext3/ext4 file system libraries, or called e2fslibs
 - libreiserfscore - reiserfs file system library version >= 3.6.27
 
-Optionally, the checksums based on cryptographic hashes can be implemeted by
+Optionally, the checksums based on cryptographic hashes can be implemented by
 external libraries. Builtin implementations are provided in case the library
 dependencies are not desired.
 
diff --git a/README.md b/README.md
index 5d8e9b55..79421fd4 100644
--- a/README.md
+++ b/README.md
@@ -84,7 +84,7 @@ the patches meet some criteria (often lacking in github contributions):
 
 Source code coding style and preferences follow the
 [kernel coding style](https://www.kernel.org/doc/html/latest/process/coding-style.html).
-You can find the editor settins in `.editorconfig` and use the
+You can find the editor settings in `.editorconfig` and use the
 [EditorConfig](https://editorconfig.org/) plugin to let your editor use that,
 or update your editor settings manually.
 
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index ab60d769..717d436b 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -370,7 +370,7 @@ static void get_raid56_space_info(struct btrfs_ioctl_space_args *sargs,
 			*max_data_ratio = rt;
 
 		/*
-		 * size is the total disk(s) space occuped by a chunk
+		 * size is the total disk(s) space occupied by a chunk
 		 * the product of 'size' and  '*_ratio' is "in average"
 		 * the disk(s) space used by the data
 		 */
diff --git a/crypto/hash-speedtest.c b/crypto/hash-speedtest.c
index 09d309d2..132ca3aa 100644
--- a/crypto/hash-speedtest.c
+++ b/crypto/hash-speedtest.c
@@ -75,9 +75,9 @@ int main(int argc, char **argv) {
 	crc32c_optimization_init();
 	memset(buf, 0, 4096);
 
-	printf("Block size:    %d\n", blocksize);
-	printf("Iterations:    %d\n", iterations);
-	printf("Implementaion: %s\n", CRYPTOPROVIDER);
+	printf("Block size:     %d\n", blocksize);
+	printf("Iterations:     %d\n", iterations);
+	printf("Implementation: %s\n", CRYPTOPROVIDER);
 	printf("\n");
 
 	for (idx = 0; idx < ARRAY_SIZE(contestants); idx++) {
diff --git a/kernel-lib/radix-tree.c b/kernel-lib/radix-tree.c
index 4649f871..f2ade1b0 100644
--- a/kernel-lib/radix-tree.c
+++ b/kernel-lib/radix-tree.c
@@ -506,7 +506,7 @@ int radix_tree_tag_get(struct radix_tree_root *root,
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
 
 		/*
-		 * This is just a debug check.  Later, we can bale as soon as
+		 * This is just a debug check.  Later, we can bail as soon as
 		 * we see an unset tag.
 		 */
 		if (!tag_get(slot, tag, offset))
diff --git a/m4/ax_gcc_version.m4 b/m4/ax_gcc_version.m4
index 63914d55..ab100265 100644
--- a/m4/ax_gcc_version.m4
+++ b/m4/ax_gcc_version.m4
@@ -1,5 +1,5 @@
 dnl @synopsis AX_GCC_VERSION(MAJOR, MINOR, PATCHLEVEL, [ACTION-SUCCESS], [ACTION-FAILURE])
-dnl @summary check wither gcc is at least version MAJOR.MINOR.PATCHLEVEL
+dnl @summary check whether gcc is at least version MAJOR.MINOR.PATCHLEVEL
 dnl @category InstalledPackages
 dnl
 dnl Check whether we are using gcc and, if so, whether its version
diff --git a/tests/README.md b/tests/README.md
index 616bf3e4..7b86716c 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -404,7 +404,7 @@ that file or other tests to get the idea how easy writing a test really is.
     `tests/mkfs-tests-results.txt`), and not printed to the terminal
   * `_log_stdout` - dtto but it is printed to the terminal
 * execution helpers
-  * `run_check` - should be used for basically all commadns, the command and arguments
+  * `run_check` - should be used for basically all commands, the command and arguments
   are stored to the results log for debugging and the return value is checked so there
   are no silent failures even for the "unimportant" commands
   * `run_check_stdout` - like the above but the output can be processed further, eg. filtering
-- 
2.30.0.rc2

