Return-Path: <linux-btrfs+bounces-12339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF1AA6550B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90722177499
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725FB2459E6;
	Mon, 17 Mar 2025 15:05:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12E24502E;
	Mon, 17 Mar 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223911; cv=none; b=Kv66IndyouWhDdrOnM/Hjj1hjyXZ9U5MfDyguPyBXjLOnlT15vXSs27PfV67GzGoKW8IC0lipzS5ZLtHejpJ3mFutOs9rae4MP3Dh/Faqk35fbwtHdHKs36ko+217EOQrrkLlKjNkNBZ3HlusuS4EQKNGMHqRjKsDrjDsV0REDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223911; c=relaxed/simple;
	bh=HvkaUYAwSGQRmxN6FtdFYwAB0gAYl9xsLWmS5BcPCdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jP3MlkRYsKml8oYu/MWpoRS8Q4s3bD/KXRgdDk8nGhieCZU4bQTfHkBmxNReznmP2jLtSUHVUJ/Xu4SxdLB97l+QS8gSNnatHUKcTmES1/hkxutwecmLHJ55Uar5AuvYciHkNPuJWLfZSiCQE93aGsidiLRThgYKlqeatMuh4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394a823036so21391185e9.0;
        Mon, 17 Mar 2025 08:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223908; x=1742828708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQJo0MSVxymkRoO3RuSNUYe6CS6mZn3UMc5QXp0Go4c=;
        b=EYCzODQjOYInBKWft0A24t8QcQ/RrmOAmXcbdZ1wdYbyQm5kymM8DaGyNictRtSe2C
         H1M29W4imzHiyp10ZRJckttWbGBoN/1tABr5a2wOxQhaqCEeyyIVehS6sJkNFUNVXyLi
         hIZLeW6jJMlfaYrzlQUTL0bJehry2si0LhGYE4P7eXUYDHagYJHqYHiLBDJJEWyBTgaj
         t16WUKcH308Us8C8FsNB0rvrt715zEPj8RIK9mOw5/o4HN6J3kVDvP2g5s6idL9um+9E
         s8D0vzyLksQSrE8BNo5/YQ909VoLkeJUwkbuKb7I9j3acFx+eDsmLZYcljxZBzbGXcPf
         /DuQ==
X-Gm-Message-State: AOJu0YwXD7PHHmAJC1SCHM7WWJkr/bUUOLxhJBl1OIh9rdYmgWwBWu5x
	esFUNsc7HuUrjRaEtuoSGow/skYr6of9E4917Owf4jToCJhvKqgZVousNA==
X-Gm-Gg: ASbGncvRYmFYdjhAmgmHdg4j9FqtyVdXb7Xhpc6+QMsVUfWv38OHGOViprkoQj2XS4F
	LkNcdn2jsqopoiJkZECQZ0CDetZMd/GFRXaC/insefOpG/vw+4Tq6CXu5PNvFjVMt2DNVBRtaHd
	7G1xJWyKdipLnZoEXZMTySgPDGH1M6IRydIHpJuUU6IJpaPxbzhxvQBgY/+AOD+Y3No2gJ6dreb
	SPVqu6hNEp7IDfzMHC2GwmRs4+x/UEbJ5WKQXJzJlgZXU5612/0ckRdtCN+epAfX1qWnirRZ2FZ
	J+N1e46rOsz0I/LHdH701Wdeyn7cewQ4RQRKF3Awzo+o8zU7IhjkYOBPCL/DgICnnhut8GxVIj2
	7GN4+vP85MVgank5vXFUKsTtDayA=
X-Google-Smtp-Source: AGHT+IF07X1WQI3MqDaD9RUJM0G/CdW5lmjus5Nd5H0ABOWrzfBkxFuNpooI8H2zYDLA69rJzszD1w==
X-Received: by 2002:a05:600c:c10:b0:43c:f78d:82eb with SMTP id 5b1f17b1804b1-43d3897bc38mr1913885e9.15.1742223907209;
        Mon, 17 Mar 2025 08:05:07 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71d1000fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71d:1000:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc3e72sm106724595e9.18.2025.03.17.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:05:06 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Anand Jain <anand.jain@oracle.com>,
	Zorro Lang <zlang@redhat.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch
Date: Mon, 17 Mar 2025 16:04:58 +0100
Message-ID: <5c6dcd33d98c4d79630748381b2aa3880fd156ac.1742223870.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Recently we had a bug report about a kernel crash that happened when the
user was converting a filesystem to use RAID1 for metadata, but for some
reason the device's write pointers got out of sync.

Test this scenario by manually injecting de-synchronized write pointer
positions and then running conversion to a metadata RAID1 filesystem.

In the testcase also repair the broken filesystem and check if both system
and metadata block groups are back to the default 'DUP' profile
afterwards.

Link: https://lore.kernel.org/linux-btrfs/CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com/
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/329     | 61 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329.out |  3 +++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..441be133e230
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Western Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 329
+#
+# what am I here for?
+#
+. ./common/preamble
+_begin_fstest zone quick volume
+
+. ./common/filter
+
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: zoned: return EIO on RAID1 block group write pointer mismatch"
+
+_require_scratch_dev_pool 2
+declare -a devs="( $SCRATCH_DEV_POOL )"
+_require_zoned_device ${devs[0]}
+_require_zoned_device ${devs[1]}
+_require_command "$BLKZONE_PROG" blkzone
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+# Write some data to the FS to dirty it
+dd if=/dev/zero of=$SCRATCH_MNT/test bs=128k count=1024 >> $seqres.full 2>&1
+
+# Add device two to the FS
+$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT >> $seqres.full 2>&1
+
+# Move write pointers of all empty zones by 4k to simulate write pointer
+# mismatch.
+# 'blkzone report' reports the zone numbers in sectors so we need to convert
+# it to bytes first. Afterwards we need to convert it to 4k blocks for dd.
+zones=$($BLKZONE_PROG report ${devs[1]} | $AWK_PROG '/em/ { print $2 }' |\
+	sed 's/,//')
+for zone in $zones;
+do
+	zone=$(($zone / 8))
+	dd if=/dev/zero of=${devs[1]} seek=$zone bs=4k oflag=direct \
+		count=1 >> $seqres.full 2>&1
+done
+
+# expected to fail
+$BTRFS_UTIL_PROG balance start -mconvert=raid1 $SCRATCH_MNT \
+	>> $seqres.full 2>&1
+
+_scratch_unmount
+
+$MOUNT_PROG -t btrfs -odegraded ${devs[0]} $SCRATCH_MNT
+
+$BTRFS_UTIL_PROG device remove --force missing $SCRATCH_MNT >> $seqres.full 2>&1
+$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT >> $seqres.full 2>&1
+
+# Check that both System and Metadata are back to the DUP profile
+$BTRFS_UTIL_PROG filesystem df /mnt/scratch/ |\
+	grep -o -e "System, DUP" -e "Metadata, DUP"
+
+status=0
+exit
diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
new file mode 100644
index 000000000000..eab11130981d
--- /dev/null
+++ b/tests/btrfs/329.out
@@ -0,0 +1,3 @@
+QA output created by 329
+System, DUP
+Metadata, DUP
-- 
2.43.0


