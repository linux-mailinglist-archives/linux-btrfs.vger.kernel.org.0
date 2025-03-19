Return-Path: <linux-btrfs+bounces-12420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFA3A68B35
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 12:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C103B162A2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77F255233;
	Wed, 19 Mar 2025 11:10:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5232566E2;
	Wed, 19 Mar 2025 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382600; cv=none; b=Lr3tjc2kPyUZWCJTv5ixbVA4ZM7Lb0yYvrINbCfe06MfRxz9m2vxsH7/WUj+QvbiTGsyctzEM/8TK48wMUHGdkBAEIFjjHv8AWAJWNJnc/OVK29q3i4DH5mEbgxz7thuHYkg82iUD0dHBXeOkFDrEHxFWqm9VaJZG63RKj/dHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382600; c=relaxed/simple;
	bh=37GMARm6SsZgGyyJ49TH1agrS1XI91mHl8WdB+gcs38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uok2WsewZs7f3xbVm+BXByW56h83m+Xyp1tZaiunMgrY718Sm1qI1gLoegYmgqlJkM2GqmG186F3TDHKUa7M8PTpE6UlYPY9XDQ3c98yd2DawSJnx+Dd/gvW78AArzAjFt36xkJeLJoRGmRjLAa2ybLqk+OPJjZ6j7NSkCCKKqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so43987325e9.3;
        Wed, 19 Mar 2025 04:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382597; x=1742987397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eLAcV8rbjgVs6g5F+NzOMCwmzdyfNTYKDpyQzK/Boc=;
        b=hxJ6QpzYMKS+31lqKJDM8kyDgw8jpH8uCQi8kwbV/c1ezhYYCS+gAm6G2Ow6IrPhxv
         TtTbjlcGKG72yYWMprEYJG6gYIrf+idWwYcl6kY26eEXUgfdeiZElTgCsUypTuKKkuPy
         shEE3fgRiYIiAKrWscrK5o5szCSMi8kEjHWhW5juK/UiAqoMrkwWTD36fyOz8F39yPp0
         gmcnUBs5JI4rLa2CUp3FL/wdQG6TzrvqU5cLNP5qQygfaG4q0sdpmTw6fCWMwzGthoZr
         O9pcSA7rHxbR5UDALR9YIp9pr0Ljgmbr5zQkZ8KJSppK/Bgj3K8PwXuzQ7PjKUq+BU8P
         6KDw==
X-Forwarded-Encrypted: i=1; AJvYcCVgkwoHJN2sMTyVhlHrqB6CfJf7eLRDQ4+ETBXIQerg0b1ffZBX90Tk7V2g/OGNIGHzb5gz9W2ii/icfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92Mr8RbHtSVtqPzCHZiH7uVGo+1UWR/IiO3XejSDs7a7N5qYI
	5bNxvMlEGUOVjH7o2qdaKXyIcs5uOPEQc+wPeiO8pp74qEHjBu0E
X-Gm-Gg: ASbGncvtPrhcRK3cpkvSLYS3Yih0Mo5aH88rp7VjC4ViYy3x8pCzOzw6OKf54uYWlCT
	H54L4vffEBVIOwiYetJBVekAksseR/m7eSrEJSRPeuQMSS3qKO4AuxUAuVw2k0w2c8QG0hpdAQj
	LZjIkDhTjAoqHgpnRoLXL6z3ZIWT1NhxQ4E2pNFNCvu7zRiMI9ITVHzaeUmezCQ2S6jP161spzr
	TQJbVvL29i7blHxKPrA5FFQLiCrr50DTOqlYw+IjiEv/sFFO7s276irSe6ZZ6L8nKhnGnkoBoGd
	RzdKCEGA0OutVodl90zBGhM+7L9zq7RUVQqTz4gP+M4Qe65vLMPHX8cLT+9ngajuY+LMcgbrLPn
	2Zc0df1ppnrx7edQ9XR4nxjdeQZE=
X-Google-Smtp-Source: AGHT+IG+0YdeT9v/2F/PzP0Fy3xMcXYLmBJUnmp1KPaciLbMpW8Xwqda01WPW1LllJ35WWk0RZ8qWw==
X-Received: by 2002:a05:600c:1d8a:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-43d43798a40mr23401915e9.10.1742382596838;
        Wed, 19 Mar 2025 04:09:56 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f710c800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f710:c800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3ba44e63sm31357785e9.1.2025.03.19.04.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:09:56 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Zorro Lang <zlang@redhat.com>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>
Cc: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4] fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch
Date: Wed, 19 Mar 2025 12:09:47 +0100
Message-ID: <8390a7748c1e2005fb7b9dbc1f5e6bd38ea22506.1742382386.git.jth@kernel.org>
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
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
Changes to v3:
- Limit number of dirtied zones to 64
Changes to v2:
- Filter SCRATCH_MNT in golden output
Changes to v1:
- Add test description
- Don't redirect stderr to $seqres.full
- Use xfs_io instead of dd
- Use $SCRATCH_MNT instead of hardcoded mount path
- Check that 1st balance command actually fails as it's supposed to
---
 tests/btrfs/329     | 68 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329.out |  7 +++++
 2 files changed, 75 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..24d34852db1f
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,68 @@
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
+
+nzones=$($BLKZONE_PROG report ${devs[1]} | wc -l)
+if [ $nzones -gt 64 ]; then
+	nzones=64
+fi
+
+zones=$($BLKZONE_PROG report ${devs[1]} | $AWK_PROG '/em/ { print $2 }' |\
+	sed 's/,//' | head -n $nzones)
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


