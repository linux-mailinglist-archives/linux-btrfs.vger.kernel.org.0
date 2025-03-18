Return-Path: <linux-btrfs+bounces-12379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9436A674C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 14:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB40A3A5466
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A024620C473;
	Tue, 18 Mar 2025 13:17:40 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B9AD2C;
	Tue, 18 Mar 2025 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303860; cv=none; b=POq2ScG39kIzX//97SXqIQ2owSHI+NQSmAzJ4SlrBxbzXzxs7LwBQdi4N8bmcgBXpbWf/ONWgT6SqxhQbJ8Tx79HoImoYr2xic4F2govE67ALaWAafT9xhDPUwuMaKMFwqNriSP7SXbtHyW7aBVVVo0PufvctJ+VOnI8uLEOcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303860; c=relaxed/simple;
	bh=LiXisotlbH8V2pZfZW43SVaYtyPbg2zdgybKBl1FEv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sLmdeEI6arQQPYPFalxLpv/TUMx6Ixy1o6x8qqWUT8vAOVLrBOTSsNkXW0v9ZtotYUHhYZX5LBiKCnSI7SBM2vXz2+a8weKGLL6k/w5mo7oFoH1vQ0kAgIYsQcQDzolVc1c+6HjGGfWWtfJaGGBW1HB3/hT5qUbD65jc2Rs3j8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so24120575e9.2;
        Tue, 18 Mar 2025 06:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303857; x=1742908657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s34+1SuXk/irqSPY20irWhWazm7n1wEru9+2FxBZkcI=;
        b=d45Z/iHoyosFIZ1qTlSVeGHzVOE5I7ac3CWpaJp8JsiiSnmCzTT2P2YFyWpuqF2Sek
         akmHNZ/GBMEPt/pUuzMAZAtV06cvZ+l+4EOfKHg8k3GgY47H8QFbAMPmhcvhZ7UlkDM7
         Vm8w/GHrJZWW/eRRIsytFb3hGhhD62CCEQ6hyw4e1uMFipfwzYO3Q57Yza23aWUHbtu3
         CiCGI0OzpkkxRMPSP2xLgQfMhzjZdHrFD4FOGGJY1sWfxpdykoVc24fHEtd9Kab0HEYf
         cVRCulKT8Y839xrIJnJxmzWK9tHAfBO/V76ru3Y73v4TVMnSq+MUKTREhGCdvIydOm9B
         f3SA==
X-Forwarded-Encrypted: i=1; AJvYcCUPO0ytnuVQMcF2MRBayE2INXXtEdGWA3rYM9cRo3lqY9ZHKM2abhS1S18L8EBilDy0Ih9K5LWLfuAkVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EEt7tOR9UzCxmMmiuynGypTc+HDntpFMQNIJ/ujnTdXLytJV
	gmmIx8bCiaVGPFJZVAf1aB3WHapgmoih3Ol2UiSjl7ikeiTkjes1
X-Gm-Gg: ASbGncvfP7Dt8MF+9o7k2SiypARLaUGN5ouPt56Jx+TqitMkwf6Gf0DcFSvF8oO07s4
	1hPTatW+yPsed3JQcNjICh3c/KZYLhovGPvjTQAkzDgy6DyliztuRYLPg0NxN8YScPpoVRVfTXW
	W/ig1w4qoai/sPy7lVTOQp4yC/TGsmLw0SjnMz1cHiigo2qiV41lTdVDH81BKbLdmjCRsaTy0Xf
	ncEnVlFnU/7HALXouBlgL6XyfQM7mh3boijBRQbBzHQIm25xFrNlE0cJhUWwt5980SMgxMdi900
	cjTnOrF+Enge3wz2XrpbzHdlS/qPY7+IpchCCJzPe09TF2nK0sA4CSWq1fw2mKUd5yvhvVJ5nE0
	YCK2oOwQzIIOOtQ6vPk8WS92RJmA=
X-Google-Smtp-Source: AGHT+IGRtbtaoXaDMMJJf5QrXtXM8l/6oHuCo49POItpPeHDKIXbEWprQMqhFSLmx9PKw5OEQx89wg==
X-Received: by 2002:a05:600c:1914:b0:43c:efae:a73 with SMTP id 5b1f17b1804b1-43d3b98d859mr27440495e9.10.1742303856347;
        Tue, 18 Mar 2025 06:17:36 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f710c800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f710:c800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df31f6sm18039674f8f.6.2025.03.18.06.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:17:35 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Zorro Lang <zlang@redhat.com>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>
Cc: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3] fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch
Date: Tue, 18 Mar 2025 14:17:26 +0100
Message-ID: <05f928908a7949fb1787680176840b5ab23fde0b.1742303818.git.jth@kernel.org>
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
Changes to v2:
- Filter SCRATCH_MNT in golden output
Changes to v1:
- Add test description
- Don't redirect stderr to $seqres.full
- Use xfs_io instead of dd
- Use $SCRATCH_MNT instead of hardcoded mount path
- Check that 1st balance command actually fails as it's supposed to
---
 tests/btrfs/329     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329.out |  7 +++++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..5496866ac325
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,62 @@
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
+$BTRFS_UTIL_PROG balance start -mconvert=raid1 $SCRATCH_MNT 2>&1 |\
+	_filter_scratch
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
index 000000000000..e47a2a6ff04b
--- /dev/null
+++ b/tests/btrfs/329.out
@@ -0,0 +1,7 @@
+QA output created by 329
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+ERROR: error during balancing 'SCRATCH_MNT': Input/output error
+There may be more info in syslog - try dmesg | tail
+System, DUP
+Metadata, DUP
-- 
2.43.0


