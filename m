Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32FE65FB93
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jan 2023 07:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjAFGnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Jan 2023 01:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjAFGnp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Jan 2023 01:43:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D06E433
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 22:43:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E24F13FCE6
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Jan 2023 06:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672987422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v34q52Y0gdJbUPaglYlQtZk8Af4TKrK8FScua1IF5ug=;
        b=mKTchQwXcv7nrs/xEg2OwDRCn0VDicPw9RYCfPDTInTcyVo6cERTNDG5XS8lu6I5Q/J9Yj
        QKHYsvWbSwQt3/qtWb6FsrQu7ShCpIwfgGThBvE0TTS20U7E6t2sAFLCkSpOTVcvtChDsf
        vyfbNIaT/Z40ABlHUrIZloa1nWTaLZw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C478213596
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Jan 2023 06:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zmJ/Ix3Dt2MrIgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Jan 2023 06:43:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: docs: add sysfs doc
Date:   Fri,  6 Jan 2023 14:43:39 +0800
Message-Id: <7634ce2b8d9f2e7e0b6c927e9f49f5f12c93b085.1672987414.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will add a dedicated section for btrfs sysfs interfaces.

It will include:

- Directory layout explanation
  Including:
  * Description
  * Introduced in which kernel version

- Files explanation
  Including:
  * RW/RO type
  * Description
  * Introduced in which kernel version

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-man5.rst |   5 +
 Documentation/ch-sysfs.rst   | 233 +++++++++++++++++++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 Documentation/ch-sysfs.rst

diff --git a/Documentation/btrfs-man5.rst b/Documentation/btrfs-man5.rst
index fee5054f1aa2..3d0f782a8249 100644
--- a/Documentation/btrfs-man5.rst
+++ b/Documentation/btrfs-man5.rst
@@ -191,6 +191,11 @@ COMPRESSION
 
 .. include:: ch-compression.rst
 
+SYSFS INTERFACE
+---------------
+
+.. include:: ch-sysfs.rst
+
 FILESYSTEM EXCLUSIVE OPERATIONS
 -------------------------------
 
diff --git a/Documentation/ch-sysfs.rst b/Documentation/ch-sysfs.rst
new file mode 100644
index 000000000000..32772af9dfab
--- /dev/null
+++ b/Documentation/ch-sysfs.rst
@@ -0,0 +1,233 @@
+Btrfs has a sysfs interface to provide extra knobs.
+
+The top level path is `/sys/fs/btrfs/`, and the main directory layout is the following:
+
+=============================  ===================================  ========
+Relative Path                  Description                          Version
+=============================  ===================================  ========
+features/                      All supported features               3.14+
+<UUID>/                        Mounted fs UUID                      3.14+
+<UUID>/allocation/             Space allocation info                3.14+
+<UUID>/features/               Features of the filesystem           3.14+
+<UUID>/devices/<DEVID>/        Softlink to each block device sysfs  5.6+
+<UUID>/devinfo/<DEVID>/        Btrfs specific info for each device  5.6+
+<UUID>/qgroups/                Global qgroup info                   5.9+
+<UUID>/qgroups/<LEVEL>_<ID>/   Info for each qgroup                 5.9+
+=============================  ===================================  ========
+
+For `/sys/fs/btrfs/features/` directory, each file means a supported feature
+for the current kernel.
+
+For `/sys/fs/btrfs/<UUID>/features/` directory, each file means an enabled
+feature for the mounted filesystem.
+
+The features shares the same name in section *FILESYSTEM FEATURES*.
+
+
+Files in `/sys/fs/btrfs/<UUID>/` directory are:
+
+bg_reclaim_threshold
+        (RW, since: 5.19)
+
+        Used space percentage to start auto block group claim.
+        Mostly for zoned devices.
+
+checksum
+        (RO, since: 5.5)
+
+        The checksum used for the mounted filesystem.
+        This includes both the checksum type (see section *CHECKSUM ALGORITHMS*)
+        and the implemented driver (mostly shows if it's hardware accelerated).
+
+clone_alignment
+        (RO, since: 3.16)
+
+        The bytes alignment for *clone* and *dedupe* ioctls.
+
+commit_stats
+        (RW, since: 6.0)
+
+        The performance statistics for btrfs transaction commitment.
+        Mostly for debug purposes.
+
+        Writing into this file will reset the maximum commit duration to
+        the input value.
+
+exclusive_opeartion
+        (RO, since: 5.10)
+
+        Shows the running exclusive operation.
+        Check section *FILESYSTEM EXCLUSIVE OPERATIONS* for details.
+
+generation
+        (RO, since: 5.11)
+
+        Show the generation of the mounted filesystem.
+
+label
+        (RW, since: 3.14)
+
+        Show the current label of the mounted filesystem.
+
+metadata_uuid
+        (RO, since: 5.0)
+
+        Shows the metadata uuid of the mounted filesystem.
+        Check `metadata_uuid` feature for more details.
+
+nodeisze
+        (RO, since: 3.14)
+
+        Show the nodesize of the mounted filesystem.
+
+quota_override
+        (RW, since: 4.13)
+
+        Shows the current quota override status.
+        0 means no quota override.
+        1 means quota override, quota can ignore the existing limit settings.
+
+read_policy
+        (RW, since: 5.11)
+
+        Shows the current balance policy for reads.
+        Currently only "pid" (balance using pid value) is supported.
+
+sectorsize
+        (RO, since: 3.14)
+
+        Shows the sectorsize of the mounted filesystem.
+
+
+Files and directories in `/sys/fs/btrfs/<UUID>/allocations` directory are:
+
+global_rsv_reserved
+        (RO, since: 3.14)
+
+        The used bytes of the global reservation.
+global_rsv_size
+        (RO, since: 3.14)
+
+        The total size of the global reservation.
+
+`data/`, `metadata/` and `system/` directories
+        (RO, since: 5.14)
+
+        Space info accounting for the 3 chunk types.
+        Mostly for debug purposes.
+
+Files in `/sys/fs/btrfs/<UUID>/devinfo/<DEVID>` directory are:
+
+error_stats:
+        (RO, since: 5.14)
+
+        Shows all the history error numbers of the device.
+
+fsid:
+        (RO, since: 5.17)
+
+        Shows the fsid which the device belongs to.
+        It can be different than the `<UUID>` if it's a seed device.
+
+in_fs_metadata
+        (RO, since: 5.6)
+
+        Shows whether we have found the device.
+        Should always be 1, as if this turns to 0, the `<DEVID>` directory
+        would get removed automatically.
+
+missing
+        (RO, since: 5.6)
+
+        Shows whether the device is missing.
+
+replace_target
+        (RO, since: 5.6)
+
+        Shows whether the device is the replace target.
+        If no dev-replace is running, this value should be 0.
+
+scrub_speed_max
+        (RW, since: 5.14)
+
+        Shows the scrub speed limit for this device. The unit is Bytes/s.
+        0 means no limit.
+
+writebale
+        (RO, since: 5.6)
+
+        Show if the device is writeable.
+
+Files in `/sys/fs/btrfs/<UUID>/qgroups/` directory are:
+
+enabled
+        (RO, since: 6.1)
+
+        Shows if qgroup is enabled.
+        Also, if qgroup is disabled, the `qgroups` directory would
+        be removed automatically.
+
+inconsistent
+        (RO, since: 6.1)
+
+        Shows if the qgroup numbers are inconsistent.
+        If 1, it's recommended to do a qgroup rescan.
+
+drop_subtree_threshold
+        (RW, since: 6.1)
+
+        Shows the subtree drop threshold to automatically mark qgroup inconsistent.
+
+        When dropping large subvolumes with qgroup enabled, there would be a huge
+        load for qgroup accounting.
+        If we have a subtree whose level is larger than or equal to this value,
+        we will not trigger qgroup account at all, but mark qgroup inconsistent to
+        avoid the huge workload.
+
+        Default value is 8, where no subtree drop can trigger qgroup.
+
+        Lower value can reduce qgroup workload, at the cost of extra qgroup rescan
+        to re-calculate the numbers.
+
+Files in `/sys/fs/btrfs/<UUID>/<LEVEL>_<ID>/` directory are:
+
+exclusive
+        (RO, since: 5.9)
+
+        Shows the exclusively owned bytes of the qgroup.
+
+limit_flags
+        (RO, since: 5.9)
+
+        Shows the numeric value of the limit flags.
+        If 0, means no limit implied.
+
+max_exclusive
+        (RO, since: 5.9)
+
+        Shows the limits on exclusively owned bytes.
+
+max_referenced
+        (RO, since: 5.9)
+
+        Shows the limits on referenced bytes.
+
+referenced
+        (RO, since: 5.9)
+
+        Shows the referenced bytes of the qgroup.
+
+rsv_data
+        (RO, since: 5.9)
+
+        Shows the reserved bytes for data.
+
+rsv_meta_pertrans
+        (RO, since: 5.9)
+
+        Shows the reserved bytes for per transaction metadata.
+
+rsv_meta_prealloc
+        (RO, since: 5.9)
+
+        Shows the reserved bytes for preallocated metadata.
-- 
2.39.0

