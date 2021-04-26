Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560AC36AC23
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhDZG2z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:28:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhDZG2y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418493; x=1650954493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EgvfzCaTLJz3+RGoOkKZ6Cb8r//5rm/8tKwkYtPqSfA=;
  b=M/b721q8HL3S73/Z3g5anW8cJRRhpSmNiE/ENkxtvRv8zF/zE09u522b
   q7/MxEtpXuWIHwIkBJ+hPjwKTaLe7VIWK5F5amfStZk2r4cOq8AuXJd9i
   wfjZ6/3EjvKQcB3esJnv8vBOhpXVwg03L0x+SpaepN7TYTp60gC+w/I9O
   /hD07kPSdB8NTHtmoawS2woJyOOSswOPgtI2IkSk6WNjXJmF2XCfHMIbM
   nPy8yNTEV5+G/Lywmve+/67Clc2WUkM56y8oRru3CrDUV1UA+GAoOxCwB
   8ds/hmv9SrCZiSOCO9z4LJyoitNcKlnyoWZLw0+781W1DpRGviNPPR5TJ
   A==;
IronPort-SDR: 4Cdqm7f15ude4XCEpNOW2GdmyDbbarvZNEZrOGOPbUSsxHH96/oNm+fIUTRy3wy9D9xl5Vi8U1
 QatUaks1PJVemfS7RVXw904dgjKSiNRnxFkUyjLoByeEtgKtBG4M7+gi3u53G6te4k8PkMXqFE
 hpfFB1mKuGGVvR1N7atBB2BnWxJ7pVmEPPaRkNcJYb/LlEss6Z2725WMS9Ad9JScMPPXNV8Fw4
 xMbN+hD0D3l9Sma1jLKLp2L5cL0qF2I34wRt3YKsE0+1zPS1G7qoegEAlL37GFlB1wxDUb+RAD
 gwE=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788109"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:13 +0800
IronPort-SDR: WYZO6jMh2dYeCapfkorl5j9MA2rV8zImJFualnP2Qkd9+fXgCEnfTKQuEQzao7J5s3XffCzW9/
 /8OKGZSNryK1s/iVIE9D1lhCg2k0DVs/htETaztjebDDUuoqb+OxEVXNxUVgRQQDyQTZ+SUBjw
 CmeShvBZ9Jx+2N/30IMDo5MBB3uQ/d6St8Nbq+1giMUnomMrvVQYNUukLB/oVY60ok+i/Jt+ng
 S42w45lP32VItBD+IetAZhMxLjs/tm8KrDq67Iv37/BGEK1Lhx4ySYUdlt6hWvfXwVlkIykTIT
 1WW3HBHgYpwdYXPOrpcQWgsn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:37 -0700
IronPort-SDR: dcmMJdYBHLLmpmJfOnRTMGRUNPtg15T0VOJKLx2XgoHwMaqN9zzFQ6IBS0F6dhUErqR2vu6oCU
 FquMaCtF/4BFwVPevR0uFdEVhhHWuf4UMZXev5OmkGNDuSANyh+EhVQ7PTCRRqkwGj+cuaTE0r
 BQEDz7woRELAkVl6ieb65bceSRK7wdF2DR0CI6ri/HLO34mrB1yibCFa64IPfI1kX8hcII+Xj8
 YNDeDtelxt5b01Ludg0C0Anq3Tig7LshcQyLg7ehUwe3uiC6uoR6JrAESeUaY7AbqK87ok6ZUw
 S1c=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:13 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 04/26] btrfs-progs: zoned: add new ZONED feature flag
Date:   Mon, 26 Apr 2021 15:27:20 +0900
Message-Id: <c222a684214512e36fc721ee23ded5145bf9d89c.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the zoned feature enabled, a zoned block device-aware btrfs allocates
block groups aligned to the device zones and always write in sequential
zones at the zone write pointer position.

It also supports "emulated" zoned mode on a non-zoned device. In the
emulated mode, btrfs emulates conventional zones by slicing the device with
a fixed size.

We don't support conversion from the ext4 volume with the zoned feature
because we can't be sure all the converted block groups are aligned to zone
boundaries.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/fsfeatures.c        | 8 ++++++++
 common/fsfeatures.h        | 3 ++-
 kernel-shared/ctree.h      | 4 +++-
 kernel-shared/print-tree.c | 1 +
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 569208a9e5b1..c0793339b531 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -100,6 +100,14 @@ static const struct btrfs_feature mkfs_features[] = {
 		NULL, 0,
 		NULL, 0,
 		"RAID1 with 3 or 4 copies" },
+#ifdef BTRFS_ZONED
+	{ "zoned", BTRFS_FEATURE_INCOMPAT_ZONED,
+		"zoned",
+		NULL, 0,
+		NULL, 0,
+		NULL, 0,
+		"support Zoned devices" },
+#endif
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
 };
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 74ec2a21caf6..1a7d7f62897f 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -25,7 +25,8 @@
 		| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 
 /*
- * Avoid multi-device features (RAID56) and mixed block groups
+ * Avoid multi-device features (RAID56), mixed block groups, and zoned
+ * btrfs
  */
 #define BTRFS_CONVERT_ALLOWED_FEATURES				\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF			\
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 7683b8bbf0b4..77a5ad488104 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -495,6 +495,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -519,7 +520,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
+	 BTRFS_FEATURE_INCOMPAT_ZONED)
 
 /*
  * A leaf is full of items. offset and size tell us where to find
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 92df05c15d68..76853aee8634 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1614,6 +1614,7 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
 	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
 	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
+	DEF_INCOMPAT_FLAG_ENTRY(ZONED),
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
-- 
2.31.1

