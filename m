Return-Path: <linux-btrfs+bounces-16173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC9B2D5E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 10:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A050A02388
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761422D8DC0;
	Wed, 20 Aug 2025 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKp5nRkV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC322D6E56;
	Wed, 20 Aug 2025 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677737; cv=none; b=YAmkf9xpiMc3ITTV3lN91SznkXKkfnItxwZkYfnFv+j8sjOAEWAwWwE4H4pY5RWeRiAegSV1NO1id0f167GK+aOayoy3HlJMN6030gr+JY4KzIm/Fs+NclC0zuLvEBEo4WwB+Ehy/fJKfbzUpWqT0xN9HBnVW/J/Ynglwd6V308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677737; c=relaxed/simple;
	bh=rACd51mNVbkuRkfh2fJO2L8LHU5ZTIVCjqAmTcvKC4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ODS4qeMw4GiZp7o742gG+n+102X9hrBZv4/oBYTzk3tHgXZ2mGNeHicpP77TD5tx2mcxqn3ikw+vo9b14dEh6uxO+XAgAREE7Av05jVZECfAELJ2KNrYL84tjriHIHZabF+GxBpmHdyGjaxOb9Pc15eqo9WrqD7jADmtRmPrrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKp5nRkV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-245f19a324bso3057165ad.0;
        Wed, 20 Aug 2025 01:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755677735; x=1756282535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suCvx5ht8ZqvJ37siOzoHvha9vLPfC7ke/o5kq/iu4c=;
        b=fKp5nRkVMwPip/W6TUAdgCaMdXUxzaFXlkhGPRht7aQZlWOSJ5bBI+8poFG5f7EtEX
         fO2Cf3n0YfKY4YIZD59x4J9h2R1KOto/tEya73ORkzhGD7QxqzGPhZVIg7epHo+c6IgB
         MAKYdSX9Vt3jecxx55WOFXO+p/e2Sn5JKG/h631hJfCSFOzdjpIykMRDwag/KCeZ3tdY
         aWA5TgJ0mjOgxHclwh2NpoW8E2SXHFlNlPNlxwzuz6pVF3WZv+I51/p7lc1/ecH73+dH
         RqCLgxlUWrilWcgkZLCoIYM/ecRsdaCJhO7uor/vVA8fnUZiYBQy9Z20F6as96XgrwJ5
         v6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677735; x=1756282535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suCvx5ht8ZqvJ37siOzoHvha9vLPfC7ke/o5kq/iu4c=;
        b=H7XHlg/u8W5dpcsecv7fQGdkwXFxAfyA5DKdHcVUMAad1irHBVZyFKHxwtBATygE/K
         rbiInG7GjqBAbG6G5xxqffqXDAb7fleV2ZHgYVHiq0tq3YeOaL3W4bT6vjXF+Wh/K0q9
         fJ3Tz4hiBxoDULLOBi7x7QUun3/Gt57nI6m/+XKMgm4JeZq8sozGkdNKqOZQDLZ6104c
         2NuJqfpwHwLKD3BdX/6kwf7FMqS315GvT/U4WJQl1Av7vT8sj3cHIaMwsuG2ZvYwuPv6
         ME/DOI46PkQnWOIU9XhUokhroQaQBgx9x4QUXDSC6x3ppKC0gvs1/KgenPVrMdoBPXv9
         WXVA==
X-Gm-Message-State: AOJu0YzQm5esyFF+RAw9ff7sWmWxdXmr4JpSJJEF5PbtOxTp4fZApMXZ
	7viuByzYj7w0+ExUzqfcXRJXWch/4sR/ftzDyD1OmvLDFMb3awEJHSqliVnXmg==
X-Gm-Gg: ASbGncshgcdnAB0VnnU1zY54xpHoaliaKwK05lNUOUbtXGDnli3QxRmZ3Zh0aZvRhi5
	Bq53jAqt/BrPd7fWtVDj0ozh+UmQfPSzHw+dcLRtAKnsF47nukpNpwUSjFmLZ0AM2yCa8O+amtW
	FqKg2W2lShfvhz2aNZyo1MNzoLw61RD8X1QD8Doq6UYLhwgIM/fBlIY5fuM/rQT3EBH1iIn0K+6
	BcjfHBSbP0BBmzwP1FoYFza3aIOphPR9Hp/lfpagEN1if/yy06/OIMpremPGW/MWnUtH6syxufK
	FSb4W1y44iniGcr0sN/UXTD6V2yKeH1wIeaRF5D3E5DueJwPduNETSLYE+MCMj04IDAGp8UdInv
	QxcyxaXji/oGzw08Q6+5CjsfXbQ==
X-Google-Smtp-Source: AGHT+IEw6qvttmnLf4JzYmEz8HFVDIIW9xUf94/bah262806zHRWc8gNXJq+GE/TS8HqKgRTYiE5kw==
X-Received: by 2002:a17:902:fc85:b0:23f:f96f:9de7 with SMTP id d9443c01a7336-245ef249cd1mr23718325ad.51.1755677735190;
        Wed, 20 Aug 2025 01:15:35 -0700 (PDT)
Received: from citest-1.. ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed517beesm18848935ad.134.2025.08.20.01.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:15:34 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com,
	quwenruo.btrfs@gmx.com
Subject: [PATCH v3 2/4] generic/274: Make the pwrite block sizes and offsets to 64k
Date: Wed, 20 Aug 2025 08:15:05 +0000
Message-Id: <1110f20bb5d26b4bef5596a00d69c3459709ab65.1755677274.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test was written with 4k block size in mind and it fails with
64k block size when tested with btrfs.
The test first does pre-allocation, then fills up the
filesystem. After that it tries to fragment and fill holes at offsets
of 4k(i.e, 1 fsblock) - which works fine with 4k block size, but with
64k block size, the test tries to fragment and fill holes within
1 fsblock(of size 64k). This results in overwrite of 64k fsblocks
and the write fails. The reason for this failure is that during
overwrite, there is no more space available for COW.
Fix this by changing the pwrite block size and offsets to 64k
so that the test never tries to punch holes or overwrite within 1 fsblock
and the test becomes compatible with all block sizes.

For non-COW filesystems/files, this test should work even if the
underlying filesytem block size > 64k.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/274 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/274 b/tests/generic/274
index 916c7173..f6c7884e 100755
--- a/tests/generic/274
+++ b/tests/generic/274
@@ -40,8 +40,8 @@ _scratch_unmount 2>/dev/null
 _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
-# Create a 4k file and Allocate 4M past EOF on that file
-$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc -k 4k 4m" $SCRATCH_MNT/test \
+# Create a 64k file and Allocate 64M past EOF on that file
+$XFS_IO_PROG -f -c "pwrite 0 64k" -c "falloc -k 64k 64m" $SCRATCH_MNT/test \
 	>>$seqres.full 2>&1 || _fail "failed to create test file"
 
 # Fill the rest of the fs completely
@@ -63,7 +63,7 @@ df $SCRATCH_MNT >>$seqres.full 2>&1
 echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
 for i in `seq 1 2 1023`; do
 	echo -n "$i " >> $seqres.full
-	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
+	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
 		>>$seqres.full 2>/dev/null || _fail "failed to write to test file"
 done
 _scratch_sync
@@ -71,7 +71,7 @@ echo >> $seqres.full
 echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
 for i in `seq 2 2 1023`; do
 	echo -n "$i " >> $seqres.full
-	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
+	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
 		>>$seqres.full 2>/dev/null || _fail "failed to fill test file"
 done
 _scratch_sync
-- 
2.34.1


