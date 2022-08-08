Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD058C3F1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 09:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiHHH3Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 03:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHHH3O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 03:29:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836405F67
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 00:29:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 130so7361480pfv.13
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WewKx6ATPOYWhQZm7JhkN1yzRmS/Nyy6eZIqmfAcuxA=;
        b=UoLRFiDgRO2ECLd5dJDcnC8vRgRISCgFp3rFdDqQ4Bik4jTcqtN5oH+0eE5l/jZsrk
         12NdYlwTsCm248F7iHXYAQSl+jrW3fz49k0AF8ZUVV3kTzVCBI8cD72MFxwJMJM8cKwG
         agaEGowuE3qHVxG42x2dyYDmrD6XuR+nJQmQ/Cn1nechxEAurdvtf93/tEEvcIbWNbU3
         H7wqjb3XG9Bg0l4PxRFqr8hAVG2VTaX/XHkeyb9G37Iu8FFPtYdpOVhfS6kKtmt7Uzid
         Qg4GHxq/K0xcTKrQfterdnKTIO5mcXoidh3s0DaV8IxqpjwQpnArCDtPDdcFSvWlmvVp
         CmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WewKx6ATPOYWhQZm7JhkN1yzRmS/Nyy6eZIqmfAcuxA=;
        b=Qu8n0PI+zWEbEuxxEG0x0SiKzM0311a+NoQwzmaI/h4ZtsQsMGMtaNzdKobrRF5pwE
         EFVL/b899tZV3Nnb6M6+8rKFGO4w9+O7y1pJ0qLudDXNNyr/iEvaDw+Uy6j6smi/7WPF
         H4E5d7PhhrWY68cgxd9hnygX8F+nIhRFGecwvz6tlNx1WS6uAi5YFgiVvZNMZHpKiMnO
         QDFNPln1iLP7LZvSyotfPOhS2bZKw08XF2Puy9co7Rub0brKC/F2RR/+R6n57VKiItXl
         tpPxhFuuXlqZuwCta3dcDYjqcjs23HvVEoW3uQXrdz93+K1H+LxEk/yLpgamQ88Mxkd1
         01BA==
X-Gm-Message-State: ACgBeo1w+wCWr+UFku+R/fkeGz0DloRmDSfJEemHMWSyV0xlxwuTKZ6+
        qT0qfXxFt5NpjPRYDFjhqGNO5PhtL5k=
X-Google-Smtp-Source: AA6agR6xyB1D9wc1ZAVQUKynf5N84FEX5LDB8KCtzpWdSXwssDrLwuZbRtROA5SEN0hTFWC+FJV20g==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id h1-20020a056a00218100b0051b560bdd30mr17496817pfi.44.1659943749178;
        Mon, 08 Aug 2022 00:29:09 -0700 (PDT)
Received: from realwakka-vm.. ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id ij23-20020a170902ab5700b0016dbb5bbeebsm7847065plb.228.2022.08.08.00.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 00:29:08 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: doc: Add cross reference for manual
Date:   Mon,  8 Aug 2022 07:28:56 +0000
Message-Id: <20220808072856.5155-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

RST format provides cross reference function that users can navigate
manual pages click. This patch is written by macro that replace old
reference to doc role in RST format.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 Documentation/btrfs-balance.rst              |  6 +-
 Documentation/btrfs-check.rst                |  6 +-
 Documentation/btrfs-convert.rst              |  6 +-
 Documentation/btrfs-device.rst               |  6 +-
 Documentation/btrfs-filesystem.rst           |  6 +-
 Documentation/btrfs-find-root.rst            |  2 +-
 Documentation/btrfs-image.rst                |  2 +-
 Documentation/btrfs-inspect-internal.rst     |  2 +-
 Documentation/btrfs-man5.rst                 | 16 ++---
 Documentation/btrfs-map-logical.rst          |  2 +-
 Documentation/btrfs-property.rst             |  4 +-
 Documentation/btrfs-qgroup.rst               |  6 +-
 Documentation/btrfs-quota.rst                |  8 +--
 Documentation/btrfs-receive.rst              |  4 +-
 Documentation/btrfs-replace.rst              | 10 +--
 Documentation/btrfs-rescue.rst               |  6 +-
 Documentation/btrfs-restore.rst              |  8 +--
 Documentation/btrfs-scrub.rst                |  2 +-
 Documentation/btrfs-send.rst                 |  8 +--
 Documentation/btrfs-subvolume.rst            |  8 +--
 Documentation/btrfs.rst                      | 70 ++++++++++----------
 Documentation/btrfstune.rst                  | 14 ++--
 Documentation/ch-balance-filters.rst         |  2 +-
 Documentation/ch-balance-intro.rst           |  2 +-
 Documentation/ch-convert-intro.rst           |  2 +-
 Documentation/ch-mount-options.rst           |  2 +-
 Documentation/ch-subvolume-intro.rst         |  2 +-
 Documentation/ch-volume-management-intro.rst |  2 +-
 Documentation/fsck.btrfs.rst                 |  4 +-
 Documentation/mkfs.btrfs.rst                 | 18 ++---
 30 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/Documentation/btrfs-balance.rst b/Documentation/btrfs-balance.rst
index 352965bf..5ee4f292 100644
--- a/Documentation/btrfs-balance.rst
+++ b/Documentation/btrfs-balance.rst
@@ -127,7 +127,7 @@ EXAMPLES
 --------
 
 A more comprehensive example when going from one to multiple devices, and back,
-can be found in section *TYPICAL USECASES* of ``btrfs-device(8)``.
+can be found in section *TYPICAL USECASES* of :doc:`btrfs-device(8)<btrfs-device>`.
 
 MAKING BLOCK GROUP LAYOUT MORE COMPACT
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -269,5 +269,5 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
-``btrfs-device(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
+:doc:`btrfs-device(8)<btrfs-device>`
diff --git a/Documentation/btrfs-check.rst b/Documentation/btrfs-check.rst
index 6bf67918..0096bccc 100644
--- a/Documentation/btrfs-check.rst
+++ b/Documentation/btrfs-check.rst
@@ -161,6 +161,6 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
-``btrfs-scrub(8)``,
-``btrfs-rescue(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
+:doc:`btrfs-scrub(8)<btrfs-scrub>`,
+:doc:`btrfs-rescue(8)<btrfs-rescue>`
diff --git a/Documentation/btrfs-convert.rst b/Documentation/btrfs-convert.rst
index 4c7da323..01187c4d 100644
--- a/Documentation/btrfs-convert.rst
+++ b/Documentation/btrfs-convert.rst
@@ -31,7 +31,7 @@ OPTIONS
         set filesystem nodesize, the tree block size in which btrfs stores its metadata.
         The default value is 16KiB (16384) or the page size, whichever is bigger.
         Must be a multiple of the sectorsize, but not larger than 65536. See
-        ``mkfs.btrfs(8)`` for more details.
+        :doc:`mkfs.btrfs(8)<mkfs.btrfs>` for more details.
 -r|--rollback
         rollback to the original ext2/3/4 filesystem if possible
 -l|--label <LABEL>
@@ -42,7 +42,7 @@ OPTIONS
         A list of filesystem features enabled the at time of conversion. Not all features
         are supported by old kernels. To disable a feature, prefix it with *^*.
         Description of the features is in section *FILESYSTEM FEATURES* of
-        ``mkfs.btrfs(8)``.
+        :doc:`mkfs.btrfs(8)<mkfs.btrfs>`.
 
         To see all available features that btrfs-convert supports run:
 
@@ -72,4 +72,4 @@ If any problems happened, 1 will be returned.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`
diff --git a/Documentation/btrfs-device.rst b/Documentation/btrfs-device.rst
index 4b0e716a..75181be4 100644
--- a/Documentation/btrfs-device.rst
+++ b/Documentation/btrfs-device.rst
@@ -242,6 +242,6 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
-``btrfs-replace(8)``,
-``btrfs-balance(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
+:doc:`btrfs-replace(8)<btrfs-replace>`,
+:doc:`btrfs-balance(8)<btrfs-balance>`
diff --git a/Documentation/btrfs-filesystem.rst b/Documentation/btrfs-filesystem.rst
index fe985979..38a1c949 100644
--- a/Documentation/btrfs-filesystem.rst
+++ b/Documentation/btrfs-filesystem.rst
@@ -318,7 +318,7 @@ usage [options] <path> [<path>...]
           block reserve, used for emergency purposes (like deletion on a full
           filesystem)
         * *Multiple profiles* -- what block group types (data, metadata) have
-          more than one profile (single, raid1, ...), see ``btrfs(5)`` section
+          more than one profile (single, raid1, ...), see :doc:`btrfs(5)<btrfs-man5>` section
           *FILESYSTEMS WITH MULTIPLE BLOCK GROUP PROFILES*.
 
         And on a zoned filesystem there are two more lines in the *Device* section:
@@ -448,5 +448,5 @@ further details.
 SEE ALSO
 --------
 
-``btrfs-subvolume(8)``,
-``mkfs.btrfs(8)``
+:doc:`btrfs-subvolume(8)<btrfs-subvolume>`,
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`
diff --git a/Documentation/btrfs-find-root.rst b/Documentation/btrfs-find-root.rst
index b9281021..fe85c50d 100644
--- a/Documentation/btrfs-find-root.rst
+++ b/Documentation/btrfs-find-root.rst
@@ -33,4 +33,4 @@ If any problems happened, 1 will be returned.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`
diff --git a/Documentation/btrfs-image.rst b/Documentation/btrfs-image.rst
index a7b200c1..edc252a3 100644
--- a/Documentation/btrfs-image.rst
+++ b/Documentation/btrfs-image.rst
@@ -62,4 +62,4 @@ If any problems happened, 1 will be returned.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`
diff --git a/Documentation/btrfs-inspect-internal.rst b/Documentation/btrfs-inspect-internal.rst
index 710a34fb..886eac37 100644
--- a/Documentation/btrfs-inspect-internal.rst
+++ b/Documentation/btrfs-inspect-internal.rst
@@ -219,4 +219,4 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`
diff --git a/Documentation/btrfs-man5.rst b/Documentation/btrfs-man5.rst
index 78cff65c..d5d23991 100644
--- a/Documentation/btrfs-man5.rst
+++ b/Documentation/btrfs-man5.rst
@@ -39,11 +39,11 @@ There are several classes and the respective tools to manage the features:
 
 at mkfs time only
         This is namely for core structures, like the b-tree nodesize or checksum
-        algorithm, see ``mkfs.btrfs(8)`` for more details.
+        algorithm, see :doc:`mkfs.btrfs(8)<mkfs.btrfs>` for more details.
 
 after mkfs, on an unmounted filesystem::
         Features that may optimize internal structures or add new structures to support
-        new functionality, see ``btrfstune(8)``. The command **btrfs inspect-internal
+        new functionality, see :doc:`btrfstune(8)<btrfstune>`. The command **btrfs inspect-internal
         dump-super /dev/sdx** will dump a superblock, you can map the value of
         *incompat_flags* to the features listed below
 
@@ -57,7 +57,7 @@ after mkfs, on a mounted filesystem
         in the directory */sys/fs/btrfs/features/*, one file per feature. The value *1*
         means the feature can be enabled.
 
-List of features (see also ``mkfs.btrfs(8)`` section *FILESYSTEM FEATURES*):
+List of features (see also :doc:`mkfs.btrfs(8)<mkfs.btrfs>` section *FILESYSTEM FEATURES*):
 
 big_metadata
         (since: 3.4)
@@ -99,7 +99,7 @@ metadata_uuid
 
         the main filesystem UUID is the metadata_uuid, which stores the new UUID only
         in the superblock while all metadata blocks still have the UUID set at mkfs
-        time, see ``btrfstune(8)`` for more
+        time, see :doc:`btrfstune(8)<btrfstune>` for more
 
 mixed_backref
         (since: 2.6.31)
@@ -167,7 +167,7 @@ supported_rescue_options
         (since: 5.11)
 
         list of values for the mount option *rescue* that are supported by the running
-        kernel, see ``btrfs(5)``
+        kernel, see :doc:`btrfs(5)<btrfs-man5>`
 
 zoned
         (since: 5.12)
@@ -287,7 +287,7 @@ FILESYSTEM WITH MULTIPLE PROFILES
 
 It is possible that a btrfs filesystem contains multiple block group profiles
 of the same type.  This could happen when a profile conversion using balance
-filters is interrupted (see ``btrfs-balance(8)``).  Some **btrfs** commands perform
+filters is interrupted (see :doc:`btrfs-balance(8)<btrfs-balance>`).  Some **btrfs** commands perform
 a test to detect this kind of condition and print a warning like this:
 
 .. code-block:: none
@@ -415,10 +415,10 @@ SEE ALSO
 --------
 
 ``acl(5)``,
-``btrfs(8)``,
+:doc:`btrfs(8)<btrfs>`,
 ``chattr(1)``,
 ``fstrim(8)``,
 ``ioctl(2)``,
-``mkfs.btrfs(8)``,
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
 ``mount(8)``,
 ``swapon(8)``
diff --git a/Documentation/btrfs-map-logical.rst b/Documentation/btrfs-map-logical.rst
index c638f247..16504976 100644
--- a/Documentation/btrfs-map-logical.rst
+++ b/Documentation/btrfs-map-logical.rst
@@ -35,4 +35,4 @@ If any problems happened, 1 will be returned.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`
diff --git a/Documentation/btrfs-property.rst b/Documentation/btrfs-property.rst
index 03c2cc94..964748ab 100644
--- a/Documentation/btrfs-property.rst
+++ b/Documentation/btrfs-property.rst
@@ -55,7 +55,7 @@ Subvolume properties
 
 ro
         read-only flag of subvolume: true or false. Please also see section *SUBVOLUME FLAGS*
-        in ``btrfs-subvolume(8)`` for possible implications regarding incremental send.
+        in :doc:`btrfs-subvolume(8)<btrfs-subvolume>` for possible implications regarding incremental send.
 
 Filesystem properties
 ^^^^^^^^^^^^^^^^^^^^^
@@ -124,6 +124,6 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
 ``lsattr(1)``,
 ``chattr(1)``
diff --git a/Documentation/btrfs-qgroup.rst b/Documentation/btrfs-qgroup.rst
index 24e5dfaa..3ba60ad2 100644
--- a/Documentation/btrfs-qgroup.rst
+++ b/Documentation/btrfs-qgroup.rst
@@ -230,6 +230,6 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
-``btrfs-subvolume(8)``,
-``btrfs-quota(8)``,
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
+:doc:`btrfs-subvolume(8)<btrfs-subvolume>`,
+:doc:`btrfs-quota(8)<btrfs-quota>`,
diff --git a/Documentation/btrfs-quota.rst b/Documentation/btrfs-quota.rst
index da26e754..b12ae484 100644
--- a/Documentation/btrfs-quota.rst
+++ b/Documentation/btrfs-quota.rst
@@ -11,7 +11,7 @@ DESCRIPTION
 
 The commands under **btrfs quota** are used to affect the global status of quotas
 of a btrfs filesystem. The quota groups (qgroups) are managed by the subcommand
-``btrfs-qgroup(8)``.
+:doc:`btrfs-qgroup(8)<btrfs-qgroup>`.
 
 .. note::
         Qgroups are different than the traditional user quotas and designed
@@ -73,6 +73,6 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
-``btrfs-subvolume(8)``,
-``btrfs-qgroup(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
+:doc:`btrfs-subvolume(8)<btrfs-subvolume>`,
+:doc:`btrfs-qgroup(8)<btrfs-qgroup>`
diff --git a/Documentation/btrfs-receive.rst b/Documentation/btrfs-receive.rst
index 86ffdcc6..24c205f4 100644
--- a/Documentation/btrfs-receive.rst
+++ b/Documentation/btrfs-receive.rst
@@ -113,5 +113,5 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
-``btrfs-send(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
+:doc:`btrfs-send(8)<btrfs-send>`
diff --git a/Documentation/btrfs-replace.rst b/Documentation/btrfs-replace.rst
index 1846a6c6..e65ddb6b 100644
--- a/Documentation/btrfs-replace.rst
+++ b/Documentation/btrfs-replace.rst
@@ -58,7 +58,7 @@ start [options] <srcdev>|<devid> <targetdev> <path>
         -K|--nodiscard
                 Do not perform whole device TRIM operation on devices that are capable of that.
                 This does not affect discard/trim operation when the filesystem is mounted.
-                Please see the mount option *discard* for that in ``btrfs(5)``.
+                Please see the mount option *discard* for that in :doc:`btrfs(5)<btrfs-man5>`.
 
 status [-1] <mount_point>
         Print status and progress information of a running device replace operation.
@@ -99,7 +99,7 @@ You can monitor progress via:
 
         btrfs replace status /mnt/my-vault/
 
-After the replacement is complete, as per the docs at ``btrfs-filesystem(8)`` in
+After the replacement is complete, as per the docs at :doc:`btrfs-filesystem(8)<btrfs-filesystem>` in
 order to use the entire storage space of the new drive you need to run:
 
 .. code-block:: bash
@@ -122,6 +122,6 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
-``btrfs-device(8)``,
-``btrfs-filesystem(8)``,
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
+:doc:`btrfs-device(8)<btrfs-device>`,
+:doc:`btrfs-filesystem(8)<btrfs-filesystem>`,
diff --git a/Documentation/btrfs-rescue.rst b/Documentation/btrfs-rescue.rst
index 57feff6d..6d21b43f 100644
--- a/Documentation/btrfs-rescue.rst
+++ b/Documentation/btrfs-rescue.rst
@@ -120,6 +120,6 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
-``btrfs-scrub(8)``,
-``btrfs-check(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
+:doc:`btrfs-scrub(8)<btrfs-scrub>`,
+:doc:`btrfs-check(8)<btrfs-check>`
diff --git a/Documentation/btrfs-restore.rst b/Documentation/btrfs-restore.rst
index a1f03dfd..b51cc97d 100644
--- a/Documentation/btrfs-restore.rst
+++ b/Documentation/btrfs-restore.rst
@@ -14,7 +14,7 @@ restore them into *path* or just list the subvolume tree roots. The filesystem
 image is not modified.
 
 If the filesystem is damaged and cannot be repaired by the other tools
-(``btrfs-check(8)`` or ``btrfs-rescue(8)``), **btrfs restore** could be used to
+(:doc:`btrfs-check(8)<btrfs-check>` or :doc:`btrfs-rescue(8)<btrfs-rescue>`), **btrfs restore** could be used to
 retrieve file data, as far as the metadata are readable. The checks done by
 restore are less strict and the process is usually able to get far enough to
 retrieve data from the whole filesystem. This comes at a cost that some data
@@ -112,6 +112,6 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
-``btrfs-rescue(8)``,
-``btrfs-check(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
+:doc:`btrfs-rescue(8)<btrfs-rescue>`,
+:doc:`btrfs-check(8)<btrfs-check>`
diff --git a/Documentation/btrfs-scrub.rst b/Documentation/btrfs-scrub.rst
index 75079eec..9d500c07 100644
--- a/Documentation/btrfs-scrub.rst
+++ b/Documentation/btrfs-scrub.rst
@@ -127,5 +127,5 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
 ``ionice(1)``
diff --git a/Documentation/btrfs-send.rst b/Documentation/btrfs-send.rst
index 4526532e..29428e25 100644
--- a/Documentation/btrfs-send.rst
+++ b/Documentation/btrfs-send.rst
@@ -33,7 +33,7 @@ the clone sources.
 You must not specify clone sources unless you guarantee that these snapshots
 are exactly in the same state on both sides--both for the sender and the
 receiver. For implications of changed read-write status of a received snapshot
-please see section *SUBVOLUME FLAGS* in ``btrfs-subvolume(8)``.
+please see section *SUBVOLUME FLAGS* in :doc:`btrfs-subvolume(8)<btrfs-subvolume>`.
 
 ``Options``
 
@@ -90,6 +90,6 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
-``btrfs-receive(8)``,
-``btrfs-subvolume(8)``
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
+:doc:`btrfs-receive(8)<btrfs-receive>`,
+:doc:`btrfs-subvolume(8)<btrfs-subvolume>`
diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
index 9cb7faf0..609e590c 100644
--- a/Documentation/btrfs-subvolume.rst
+++ b/Documentation/btrfs-subvolume.rst
@@ -272,8 +272,8 @@ further details.
 SEE ALSO
 --------
 
-``mkfs.btrfs(8)``,
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`,
 ``mount(8)``,
-``btrfs-quota(8)``,
-``btrfs-qgroup(8)``,
-``btrfs-send(8)``
+:doc:`btrfs-quota(8)<btrfs-quota>`,
+:doc:`btrfs-qgroup(8)<btrfs-qgroup>`,
+:doc:`btrfs-send(8)<btrfs-send>`
diff --git a/Documentation/btrfs.rst b/Documentation/btrfs.rst
index fe4349d4..5f38fabb 100644
--- a/Documentation/btrfs.rst
+++ b/Documentation/btrfs.rst
@@ -18,7 +18,7 @@ There are also standalone tools for some tasks like **btrfs-convert** or
 main utility. See section *STANDALONE TOOLS* for more details.
 
 For other topics (mount options, etc) please refer to the separate manual
-page ``btrfs(5)``.
+page :doc:`btrfs(5)<btrfs-man5>`.
 
 COMMAND SYNTAX
 --------------
@@ -43,63 +43,63 @@ COMMANDS
 
 balance
 	Balance btrfs filesystem chunks across single or several devices.
-	See ``btrfs-balance(8)`` for details.
+	See :doc:`btrfs-balance(8)<btrfs-balance>` for details.
 
 check
 	Do off-line check on a btrfs filesystem.
-	See ``btrfs-check(8)`` for details.
+	See :doc:`btrfs-check(8)<btrfs-check>` for details.
 
 device
 	Manage devices managed by btrfs, including add/delete/scan and so
-	on.  See ``btrfs-device(8)`` for details.
+	on.  See :doc:`btrfs-device(8)<btrfs-device>` for details.
 
 filesystem
 	Manage a btrfs filesystem, including label setting/sync and so on.
-        See ``btrfs-filesystem(8)`` for details.
+        See :doc:`btrfs-filesystem(8)<btrfs-filesystem>` for details.
 
 inspect-internal
 	Debug tools for developers/hackers.
-	See ``btrfs-inspect-internal(8)`` for details.
+	See :doc:`btrfs-inspect-internal(8)<btrfs-inspect-internal>` for details.
 
 property
 	Get/set a property from/to a btrfs object.
-	See ``btrfs-property(8)`` for details.
+	See :doc:`btrfs-property(8)<btrfs-property>` for details.
 
 qgroup
 	Manage quota group(qgroup) for btrfs filesystem.
-	See ``btrfs-qgroup(8)`` for details.
+	See :doc:`btrfs-qgroup(8)<btrfs-qgroup>` for details.
 
 quota
 	Manage quota on btrfs filesystem like enabling/rescan and etc.
-	See ``btrfs-quota(8)`` and ``btrfs-qgroup(8)`` for details.
+	See :doc:`btrfs-quota(8)<btrfs-quota>` and :doc:`btrfs-qgroup(8)<btrfs-qgroup>` for details.
 
 receive
 	Receive subvolume data from stdin/file for restore and etc.
-	See ``btrfs-receive(8)`` for details.
+	See :doc:`btrfs-receive(8)<btrfs-receive>` for details.
 
 replace
 	Replace btrfs devices.
-	See ``btrfs-replace(8)`` for details.
+	See :doc:`btrfs-replace(8)<btrfs-replace>` for details.
 
 rescue
 	Try to rescue damaged btrfs filesystem.
-	See ``btrfs-rescue(8)`` for details.
+	See :doc:`btrfs-rescue(8)<btrfs-rescue>` for details.
 
 restore
 	Try to restore files from a damaged btrfs filesystem.
-	See ``btrfs-restore(8)`` for details.
+	See :doc:`btrfs-restore(8)<btrfs-restore>` for details.
 
 scrub
 	Scrub a btrfs filesystem.
-	See ``btrfs-scrub(8)`` for details.
+	See :doc:`btrfs-scrub(8)<btrfs-scrub>` for details.
 
 send
 	Send subvolume data to stdout/file for backup and etc.
-	See ``btrfs-send(8)`` for details.
+	See :doc:`btrfs-send(8)<btrfs-send>` for details.
 
 subvolume
 	Create/delete/list/manage btrfs subvolume.
-	See ``btrfs-subvolume(8)`` for details.
+	See :doc:`btrfs-subvolume(8)<btrfs-subvolume>` for details.
 
 STANDALONE TOOLS
 ----------------
@@ -152,22 +152,22 @@ further details.
 SEE ALSO
 --------
 
-``btrfs(5)``,
-``btrfs-balance(8)``,
-``btrfs-check(8)``,
-``btrfs-convert(8)``,
-``btrfs-device(8)``,
-``btrfs-filesystem(8)``,
-``btrfs-inspect-internal(8)``,
-``btrfs-property(8)``,
-``btrfs-qgroup(8)``,
-``btrfs-quota(8)``,
-``btrfs-receive(8)``,
-``btrfs-replace(8)``,
-``btrfs-rescue(8)``,
-``btrfs-restore(8)``,
-``btrfs-scrub(8)``,
-``btrfs-send(8)``,
-``btrfs-subvolume(8)``,
-``btrfstune(8)``,
-``mkfs.btrfs(8)``
+:doc:`btrfs(5)<btrfs-man5>`,
+:doc:`btrfs-balance(8)<btrfs-balance>`,
+:doc:`btrfs-check(8)<btrfs-check>`,
+:doc:`btrfs-convert(8)<btrfs-convert>`,
+:doc:`btrfs-device(8)<btrfs-device>`,
+:doc:`btrfs-filesystem(8)<btrfs-filesystem>`,
+:doc:`btrfs-inspect-internal(8)<btrfs-inspect-internal>`,
+:doc:`btrfs-property(8)<btrfs-property>`,
+:doc:`btrfs-qgroup(8)<btrfs-qgroup>`,
+:doc:`btrfs-quota(8)<btrfs-quota>`,
+:doc:`btrfs-receive(8)<btrfs-receive>`,
+:doc:`btrfs-replace(8)<btrfs-replace>`,
+:doc:`btrfs-rescue(8)<btrfs-rescue>`,
+:doc:`btrfs-restore(8)<btrfs-restore>`,
+:doc:`btrfs-scrub(8)<btrfs-scrub>`,
+:doc:`btrfs-send(8)<btrfs-send>`,
+:doc:`btrfs-subvolume(8)<btrfs-subvolume>`,
+:doc:`btrfstune(8)<btrfstune>`,
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`
diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
index 47caccc6..e09edd62 100644
--- a/Documentation/btrfstune.rst
+++ b/Documentation/btrfstune.rst
@@ -16,10 +16,10 @@ The common usecase is to enable features that were not enabled at mkfs time.
 Please make sure that you have kernel support for the features.  You can find a
 complete list of features and kernel version of their introduction at
 https://btrfs.wiki.kernel.org/index.php/Changelog#By_feature .  Also, the
-manual page ``mkfs.btrfs(8)`` contains more details about the features.
+manual page :doc:`mkfs.btrfs(8)<mkfs.btrfs>` contains more details about the features.
 
 Some of the features could be also enabled on a mounted filesystem by other
-means.  Please refer to the *FILESYSTEM FEATURES* in ``btrfs(5)``.
+means.  Please refer to the *FILESYSTEM FEATURES* in :doc:`btrfs(5)<btrfs-man5>`.
 
 OPTIONS
 -------
@@ -64,7 +64,7 @@ OPTIONS
         disable it.  A seeding filesystem is forced to be mounted read-only. A
         new device can be added to the filesystem and will capture all writes
         keeping the seeding device intact.  See also section *SEEDING DEVICE*
-        in ``btrfs(5)``.
+        in :doc:`btrfs(5)<btrfs-man5>`.
 
         .. warning::
                 Clearing the seeding flag on a device may be dangerous.  If a
@@ -105,7 +105,7 @@ OPTIONS
 
         All newly created extents will use the new representation. To
         completely switch the entire filesystem, run a full balance of the
-        metadata. Please refer to ``btrfs-balance(8)``.
+        metadata. Please refer to :doc:`btrfs-balance(8)<btrfs-balance>`.
 
 
 EXIT STATUS
@@ -123,6 +123,6 @@ will be declared obsolete and scheduled for removal.
 SEE ALSO
 --------
 
-``btrfs(5)``,
-``btrfs-balance(8)``,
-``mkfs.btrfs(8)``
+:doc:`btrfs(5)<btrfs-man5>`,
+:doc:`btrfs-balance(8)<btrfs-balance>`,
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>`
diff --git a/Documentation/ch-balance-filters.rst b/Documentation/ch-balance-filters.rst
index 2ca141fb..5754a262 100644
--- a/Documentation/ch-balance-filters.rst
+++ b/Documentation/ch-balance-filters.rst
@@ -80,4 +80,4 @@ Profile names, used in *profiles* and *convert* are one of: *raid0*, *raid1*,
 *raid1c3*, *raid1c4*, *raid10*, *raid5*, *raid6*, *dup*, *single*.  The mixed
 data/metadata profiles can be converted in the same way, but it's conversion
 between mixed and non-mixed is not implemented. For the constraints of the
-profiles please refer to ``mkfs.btrfs(8)``, section *PROFILES*.
+profiles please refer to :doc:`mkfs.btrfs(8)<mkfs.btrfs>`, section *PROFILES*.
diff --git a/Documentation/ch-balance-intro.rst b/Documentation/ch-balance-intro.rst
index f885903a..783d3680 100644
--- a/Documentation/ch-balance-intro.rst
+++ b/Documentation/ch-balance-intro.rst
@@ -1,6 +1,6 @@
 The primary purpose of the balance feature is to spread block groups across
 all devices so they match constraints defined by the respective profiles. See
-``mkfs.btrfs(8)`` section *PROFILES* for more details.
+:doc:`mkfs.btrfs(8)<mkfs.btrfs>` section *PROFILES* for more details.
 The scope of the balancing process can be further tuned by use of filters that
 can select the block groups to process. Balance works only on a mounted
 filesystem.  Extent sharing is preserved and reflinks are not broken.
diff --git a/Documentation/ch-convert-intro.rst b/Documentation/ch-convert-intro.rst
index 56d1c7a6..7439bf6a 100644
--- a/Documentation/ch-convert-intro.rst
+++ b/Documentation/ch-convert-intro.rst
@@ -89,7 +89,7 @@ lack of enough work space. This is a soft error leaving the filesystem usable
 but the block group layout may remain unchanged.
 
 Note that balance operation takes a lot of time, please see also
-``btrfs-balance(8)``.
+:doc:`btrfs-balance(8)<btrfs-balance>`.
 
 .. code-block:: bash
 
diff --git a/Documentation/ch-mount-options.rst b/Documentation/ch-mount-options.rst
index f4ff0084..cbe5058c 100644
--- a/Documentation/ch-mount-options.rst
+++ b/Documentation/ch-mount-options.rst
@@ -351,7 +351,7 @@ space_cache, space_cache=<version>, nospace_cache
         *clear_cache,nospace_cache* to do so. If *v2* is enabled, kernels without *v2*
         support will only be able to mount the filesystem in read-only mode.
 
-        The ``btrfs-check(8)`` and ```mkfs.btrfs(8)`` commands have full *v2* free space
+        The :doc:`btrfs-check(8)<btrfs-check>` and `:doc:`mkfs.btrfs(8)<mkfs.btrfs>` commands have full *v2* free space
         cache support since v4.19.
 
         If a version is not explicitly specified, the default implementation will be
diff --git a/Documentation/ch-subvolume-intro.rst b/Documentation/ch-subvolume-intro.rst
index ec762d32..a6f344d6 100644
--- a/Documentation/ch-subvolume-intro.rst
+++ b/Documentation/ch-subvolume-intro.rst
@@ -54,7 +54,7 @@ In addition to that, a plain snapshot will also have last change generation and
 creation generation equal.
 
 Read-only snapshots are building blocks of incremental send (see
-``btrfs-send(8)``) and the whole use case relies on unmodified snapshots where
+:doc:`btrfs-send(8)<btrfs-send>`) and the whole use case relies on unmodified snapshots where
 the relative changes are generated from. Thus, changing the subvolume flags
 from read-only to read-write will break the assumptions and may lead to
 unexpected changes in the resulting incremental stream.
diff --git a/Documentation/ch-volume-management-intro.rst b/Documentation/ch-volume-management-intro.rst
index 814878b5..e0e16445 100644
--- a/Documentation/ch-volume-management-intro.rst
+++ b/Documentation/ch-volume-management-intro.rst
@@ -3,7 +3,7 @@ Devices can be then added, removed or replaced on demand.  Data and metadata are
 organized in allocation profiles with various redundancy policies.  There's some
 similarity with traditional RAID levels, but this could be confusing to users
 familiar with the traditional meaning. Due to the similarity, the RAID
-terminology is widely used in the documentation.  See ``mkfs.btrfs(8)`` for more
+terminology is widely used in the documentation.  See :doc:`mkfs.btrfs(8)<mkfs.btrfs>` for more
 details and the exact profile capabilities and constraints.
 
 The device management works on a mounted filesystem. Devices can be added,
diff --git a/Documentation/fsck.btrfs.rst b/Documentation/fsck.btrfs.rst
index f7c2cfeb..6d7c6efc 100644
--- a/Documentation/fsck.btrfs.rst
+++ b/Documentation/fsck.btrfs.rst
@@ -18,7 +18,7 @@ filesystem was not unmounted cleanly and the log needs to be replayed before
 mount. This is not needed for BTRFS. You should set fs_passno to 0.
 
 If you wish to check the consistency of a BTRFS filesystem or repair a damaged
-filesystem, see ``btrfs-check(8)``. By default filesystem consistency is checked,
+filesystem, see :doc:`btrfs-check(8)<btrfs-check>`. By default filesystem consistency is checked,
 the repair mode is enabled via the *--repair* option (use with care!).
 
 OPTIONS
@@ -47,6 +47,6 @@ FILES
 SEE ALSO
 --------
 
-``btrfs(8)``,
+:doc:`btrfs(8)<btrfs>`,
 ``fsck(8)``,
 ``fstab(5)``
diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index 6112be07..2063262a 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -20,7 +20,7 @@ mount option. See section *MULTIPLE DEVICES* for more details.
 The default block group profiles for data and metadata depend on number of
 devices and possibly other factors. It's recommended to use specific profiles
 but the defaults should be OK and allowing future conversions to other profiles.
-Please see options *-d* and *-m* for further details and ``btrfs-balance(8)`` for
+Please see options *-d* and *-m* for further details and :doc:`btrfs-balance(8)<btrfs-balance>` for
 the profile conversion post mkfs.
 
 OPTIONS
@@ -33,7 +33,7 @@ OPTIONS
 --csum <type>, --checksum <type>
         Specify the checksum algorithm. Default is *crc32c*. Valid values are *crc32c*,
         *xxhash*, *sha256* or *blake2*. To mount such filesystem kernel must support the
-        checksums as well. See *CHECKSUM ALGORITHMS* in ``btrfs(5)``.
+        checksums as well. See *CHECKSUM ALGORITHMS* in :doc:`btrfs(5)<btrfs-man5>`.
 
 -d|--data <profile>
         Specify the profile for the data block groups.  Valid values are *raid0*,
@@ -129,7 +129,7 @@ OPTIONS
 -K|--nodiscard
         Do not perform whole device TRIM operation on devices that are capable of that.
         This does not affect discard/trim operation when the filesystem is mounted.
-        Please see the mount option *discard* for that in ``btrfs(5)``.
+        Please see the mount option *discard* for that in :doc:`btrfs(5)<btrfs-man5>`.
 
 -r|--rootdir <rootdir>
         Populate the toplevel subvolume with files from *rootdir*.  This does not
@@ -238,7 +238,7 @@ devices to scan at the time of mount.
 FILESYSTEM FEATURES
 -------------------
 
-Features that can be enabled during creation time. See also ``btrfs(5)`` section
+Features that can be enabled during creation time. See also :doc:`btrfs(5)<btrfs-man5>` section
 *FILESYSTEM FEATURES*.
 
 mixed-bg
@@ -274,7 +274,7 @@ zoned
         (kernel support since 5.12)
 
         zoned mode, data allocation and write friendly to zoned/SMR/ZBC/ZNS devices,
-        see *ZONED MODE* in ``btrfs(5)``, the mode is automatically selected when
+        see *ZONED MODE* in :doc:`btrfs(5)<btrfs-man5>`, the mode is automatically selected when
         a zoned device is detected
 
 
@@ -290,7 +290,7 @@ quota
         (kernel support since 3.4)
 
         Enable quota support (qgroups). The qgroup accounting will be consistent,
-        can be used together with *--rootdir*.  See also ``btrfs-quota(8)``.
+        can be used together with *--rootdir*.  See also :doc:`btrfs-quota(8)<btrfs-quota>`.
 
 free-space-tree
         (default since btrfs-progs 5.15, kernel support since 4.5)
@@ -544,7 +544,7 @@ further details.
 SEE ALSO
 --------
 
-``btrfs(5)``,
-``btrfs(8)``,
-``btrfs-balance(8)``,
+:doc:`btrfs(5)<btrfs-man5>`,
+:doc:`btrfs(8)<btrfs>`,
+:doc:`btrfs-balance(8)<btrfs-balance>`,
 ``wipefs(8)``
-- 
2.34.1

