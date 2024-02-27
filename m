Return-Path: <linux-btrfs+bounces-2839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D6869087
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222FE1F2174D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549551386B7;
	Tue, 27 Feb 2024 12:25:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C813AA4C;
	Tue, 27 Feb 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036737; cv=none; b=TW3BnDAwkEe1xOWOss9EbbS0u55HgAPHRbObtTZQCPkXcM+8cbsztfgoFWyFqtyTvPxhuXOSoHaqiA4u8fJ6AWiQezsRN1J2HSFyOZUFisQhhO4LC9U2t/jQumrqY7bCmRaEdCeuSwhbSrw6grCklCeqpwCn32gpy/zt69JZ+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036737; c=relaxed/simple;
	bh=s/ocJovMVVz66LH8YmsguObW/ovi0MzCtC0l/SvpLzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkhrEGWg0Kty/9/es28Aju6Ri8TkMRRRFZ/dMiLN+KvYiNz+IaKglFStOhJEOq+RO77roKqNKOhSJox4IYTiA9XNavMnBzPY5x+UfaC6kkHz+eb/B6318RkpvdeKiFvCLLNRM6uVtzXnLVllyic4IoiNtINxS6bippKvpMAB8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso574726066b.1;
        Tue, 27 Feb 2024 04:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036734; x=1709641534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpzVidqk0eRWGSDOtuDFjtvaTVT5ktnhlxcnQjxF1yo=;
        b=ON7FHIjGQ7Zha90KSorPB7L+As+BzqaqPfIqeAivTNvqNAWwXy6WXdBeT5/UlCS6wf
         zdVICxBFZJrv8nbqoHqVnZiBITtWjrJFFE/BRHoX8ETQK5G3tVkOFJh6e9WFiWKYkMDY
         pAYKCmTONEzX83zyPDSPxud98nKMTdSQTOLTrDEMWOhbArsP2opZ3/xZy0BNsysVyy4+
         /kwab+LeAJKcxJfWV2i7Hh3pDVw8J1hVw+MGlJj8WiIXl/E7KqqeOFC37otCHbelZyZm
         LjBVG50gWljFlwn6i/4AAEAYtpiv9a/J7ma6uVr2vsdWR3ZLZJ5KSFVFNRpcWLuNZh7B
         5DGA==
X-Forwarded-Encrypted: i=1; AJvYcCXmZgPN5E2w8vpfT2dZBnL9CvczXJu9W72KTIu5KGIIFKqqsoUS4/CFjAdsXvujRxZ5/Us357uxRlv/iyx9TwLD3f8Y2IOs15ighiC6OlOIk2QUbZ+bvCDDTBJrorcEblvZwDms
X-Gm-Message-State: AOJu0YwprCayTzVsSO1ygvYECfQcdY+itxNfviSqlsWZ+Sc3YcFj4eIk
	WgKgjtrVKYaLQesLEmDzFWT3Y5ku+8S7RERjlRSF/HDZObbvKRcSUZxnSIdZA2w=
X-Google-Smtp-Source: AGHT+IHYWrYYerbBpePBbqHqVFRigzPZHBQ/9s78w2bn27T5NlfUFZ2AyFFWaD1Wx68/OJ2cI6JnqQ==
X-Received: by 2002:a17:906:4748:b0:a3f:357b:d995 with SMTP id j8-20020a170906474800b00a3f357bd995mr6483184ejs.1.1709036734308;
        Tue, 27 Feb 2024 04:25:34 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id vo14-20020a170907a80e00b00a4136d18988sm721938ejc.36.2024.02.27.04.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:25:33 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 27 Feb 2024 13:25:31 +0100
Subject: [PATCH v4 3/3] fstests: btrfs: check conversion of zoned
 fileystems
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-balance-fix-v4-3-d22d63972d93@kernel.org>
References: <20240227-balance-fix-v4-0-d22d63972d93@kernel.org>
In-Reply-To: <20240227-balance-fix-v4-0-d22d63972d93@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org, 
 fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Filipe Manana <fdmanana@suse.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Recently we had a bug where a zoned filesystem could be converted to a
higher data redundancy profile than supported.

Add a test-case to check the conversion on zoned filesystems.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/310     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/310.out |  9 +++++++
 2 files changed, 76 insertions(+)

diff --git a/tests/btrfs/310 b/tests/btrfs/310
new file mode 100755
index 00000000..c39f6016
--- /dev/null
+++ b/tests/btrfs/310
@@ -0,0 +1,67 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 310
+#
+# Test that btrfs convert can ony be run to convert to supported profiles on a
+# zoned filesystem
+#
+. ./common/preamble
+_begin_fstest volume raid convert
+
+_fixed_by_kernel_commit XXXXXXXXXX \
+	"btrfs: zoned: don't skip block group profile checks on conv zones"
+
+. common/filter.btrfs
+
+_supported_fs btrfs
+_require_scratch_dev_pool 4
+_require_zoned_device "$SCRATCH_DEV"
+
+devs=( $SCRATCH_DEV_POOL )
+
+# Create and mount single device FS
+_scratch_mkfs -msingle -dsingle 2>&1 > /dev/null
+_scratch_mount
+
+# Convert FS to metadata/system DUP
+_run_btrfs_balance_start -f -mconvert=dup -sconvert=dup $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert
+
+# Convert FS to data DUP, must fail
+_run_btrfs_balance_start -dconvert=dup $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT | _filter_device_add
+
+# Convert FS to data RAID1, must fail
+_run_btrfs_balance_start -dconvert=raid1 $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert | head -1
+
+# Convert FS to data RAID0, must fail
+_run_btrfs_balance_start -dconvert=raid0 $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert | head -1
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[2]} $SCRATCH_MNT | _filter_device_add
+
+# Convert FS to data RAID5, must fail
+_run_btrfs_balance_start -f -dconvert=raid5 $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert | head -1
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[3]} $SCRATCH_MNT | _filter_device_add
+
+# Convert FS to data RAID10, must fail
+_run_btrfs_balance_start -dconvert=raid10 $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert | head -1
+
+# Convert FS to data RAID6, must fail
+_run_btrfs_balance_start -f -dconvert=raid6 $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert | head -1
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
new file mode 100644
index 00000000..cef2e5ab
--- /dev/null
+++ b/tests/btrfs/310.out
@@ -0,0 +1,9 @@
+QA output created by 310
+Done, had to relocate X out of X chunks
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+There may be more info in syslog - try dmesg | tail
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument

-- 
2.35.3


