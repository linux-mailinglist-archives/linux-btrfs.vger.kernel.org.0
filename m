Return-Path: <linux-btrfs+bounces-12377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C438A67447
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 13:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0673ABB8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A7620C03C;
	Tue, 18 Mar 2025 12:49:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420420C029;
	Tue, 18 Mar 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302175; cv=none; b=JjkaGNCWLj/ubk0GPDPk6KqX01RJSwsqkKZKVXcDBMtZBF79NYAqO/SLLCpiL/wXcCGoCPMV0FqcXYNIMjtqoqDVaOLpPh+ZGq8V7nj2vHCs9Jy4R7Alft6xhmQFzjYOv+IT0XF8m/6+IV/5rbgJm0Ray0r6iDYJt7BgwRAGjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302175; c=relaxed/simple;
	bh=Q+9dJc3z2+QafkMaOyr52uRSOie7pwFuhpjpT/C6csM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+McFUcdtNgNSfc6Ld2r1S155na9a81cAmps0kWpfeujvoY8C7P/EaZD7JGiC8ZHIj0XAa2pYWWHKeAtyvu79V0OJrjyELyGvzuwxJXs8wqptIX/9EYiMcJZuPSTYjqTsKiKD0vfLJkCNl+mScLyVwDLLT/8VLsAj7ixwKWs+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912c09be7dso3745842f8f.1;
        Tue, 18 Mar 2025 05:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742302171; x=1742906971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFcYnx1smrDfNc7cnnJFeCkTyxXl/NVbpjt5FkXHyGw=;
        b=qHQcnph39pkdzIaC/tlw3fNT70RZQlo4HB9fNk487dgv3jtDdmmpUMndIlMv/GglI/
         d7Al53fugDZaxZfjdhicf3yjFP8S8J/GN1/Juv8oJraUWgjNIvvsgbKcv6gDiBtcnRLb
         xKVLlVoYDJIBH5tA/2da+usJUV3zd6mMQ/TSn4v2KycDobhOvcW1Q0YwGWTs76Ovb1iW
         f7EGP9yTqzxnbQ0HmFEm5hFwXbZytD7G5ByQnw20shwgl9ajVVGsTkuZTKeUb3/0d7hA
         FpQVCvSIfv82DsVICrZUqyfr1sB7iOfZ/X9xSpQGMIl6EbsD6Jfp1g+idj9n5wyx8ItQ
         wyUA==
X-Forwarded-Encrypted: i=1; AJvYcCXBT4PI/xcZDy1KUvNIaJX6xX/5uhzmkBlr0jXeJz7ybNwBLBsWBWQo46lO+wa6CfptoShqidaQcOWbcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFU2rcwTn6E0IAz05FjIQj5b2lo9YwRKKDhOw/wrdCMP3KIgdq
	JUfvCFYNBdeWeoQte8P8C20GWQFzZd2A8VYn16hMXtMcMAvGy3qQ
X-Gm-Gg: ASbGncsO9qzH2p24T9XtPj0/kUdLiLMa2cwKzUrzZ0XEY5DXsQt+1MbakvF4/CDBcaI
	94rVSt8eP8YhAsd3XfB2iFB6Jj5CwCpQf09j9BG01UPj0/Wla7VGML9cst4NEo5vZPXpU8gNQGn
	mwWf/rP/pYol4tW4tcV2830BpTDI0mej7H2zon5npCvjQY3XR+Sw2X+kmGEkbdYcUyi5n04ItcA
	JVLkeulqIIS7bsuLUFW9zt0L22uxS9h30vVmBxgyEZaBreTASh5uhIMmeUhmILVCJpGrJSoPmO+
	ie81L6/BX+MVws9+TG2Ek2ohQVPUv4xNcNHhsZIWhnjRn2XMqI+CZh5HLm5NYy8Pp/Xv7xRI2gK
	gFpChhdq6lscMKbijVQbb9p7bxzo=
X-Google-Smtp-Source: AGHT+IE/ZYOc0jKdXcpxeAe6dnbNQu4Fdx/jXezMpOwpj/Y5vTfBamH3mlZW+sCxmcvQKRf9P+d7Lg==
X-Received: by 2002:a5d:5f4c:0:b0:38f:2856:7d96 with SMTP id ffacd0b85a97d-3971d133830mr15934772f8f.1.1742302171388;
        Tue, 18 Mar 2025 05:49:31 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f710c800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f710:c800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe524ccsm134414355e9.0.2025.03.18.05.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:49:30 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Zorro Lang <zlang@redhat.com>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>
Cc: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch
Date: Tue, 18 Mar 2025 13:49:16 +0100
Message-ID: <d5ae8704427e156eb6dca0b720847e48665a6340.1742302069.git.jth@kernel.org>
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
Changes to v1:
- Add test description
- Don't redirect stderr to $seqres.full
- Use xfs_io instead of dd
- Use $SCRATCH_MNT instead of hardcoded mount path
- Check that 1st balance command actually fails as it's supposed to
---
 tests/btrfs/329     | 61 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329.out |  7 ++++++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..0cc75bc8156d
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Western Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 329
+#
+# Regression test for a kernel crash when converting a zoned BTRFS from
+# metadata DUP to RAID1 and one of the devices has a non 0 write pointer
+# position in the target zone.
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
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+# Write some data to the FS to dirty it
+$XFS_IO_PROG -fc "pwrite 0 128M" $SCRATCH_MNT/test | _filter_xfs_io
+
+# Add device two to the FS
+$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT >> $seqres.full
+
+# Move write pointers of all empty zones by 4k to simulate write pointer
+# mismatch.
+zones=$($BLKZONE_PROG report ${devs[1]} | $AWK_PROG '/em/ { print $2 }' |\
+	sed 's/,//')
+for zone in $zones;
+do
+	# We have to ignore the output here, as a) we don't know the number of
+	# zones that have dirtied and b) if we run over the maximal number of
+	# active zones, xfs_io will output errors, both we don't care.
+	$XFS_IO_PROG -fdc "pwrite $(($zone << 9)) 4096" ${devs[1]} > /dev/null 2>&1
+done
+
+# expected to fail
+$BTRFS_UTIL_PROG balance start -mconvert=raid1 $SCRATCH_MNT >> $seqres.full
+
+_scratch_unmount
+
+$MOUNT_PROG -t btrfs -odegraded ${devs[0]} $SCRATCH_MNT
+
+$BTRFS_UTIL_PROG device remove --force missing $SCRATCH_MNT >> $seqres.full
+$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT >> $seqres.full
+
+# Check that both System and Metadata are back to the DUP profile
+$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT |\
+	grep -o -e "System, DUP" -e "Metadata, DUP"
+
+status=0
+exit
diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
new file mode 100644
index 000000000000..b52b7d90d253
--- /dev/null
+++ b/tests/btrfs/329.out
@@ -0,0 +1,7 @@
+QA output created by 329
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+ERROR: error during balancing '/mnt/scratch': Input/output error
+There may be more info in syslog - try dmesg | tail
+System, DUP
+Metadata, DUP
-- 
2.43.0


