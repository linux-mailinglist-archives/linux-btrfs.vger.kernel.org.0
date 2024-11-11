Return-Path: <linux-btrfs+bounces-9424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526099C3E65
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 13:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8414D1C217A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963519C575;
	Mon, 11 Nov 2024 12:25:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850EF158DC8;
	Mon, 11 Nov 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327916; cv=none; b=sPrHjIvLHDF3o95Djc4VckD/OhW01NDo6PHQUUc2GGXqwZp26JuciqN1yO/vRRqxm+1HMx5tFfWMjDDwTzxQbgx9lCpEWGka5EffwlYDJopmN8JAYKzsZTHi7HcdB5JvkDHSGn5vey8B1DPAz9TFqaOqzoxWZOcoJxxWSHTIzBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327916; c=relaxed/simple;
	bh=pjMCxF+r7GiramXhsZnsxS0Xm6/kcL5W3PfkGy+vijM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Utf7F56gZ8cuZJXooc6LA/9l7Cm6AyJMxr0s3lzYJ8pBqWVLGGhR3CR+hVBFqDDl604iRiY0Xs+qrRLDDxYF/nbRV111rsu2dlrvkTU/ekGG3vbiNDvOixYiJwBNqNV9Grg7j+ELf0SAN2+qDGGTAaQS1raRAOprI7h1V9TsvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so56356175e9.2;
        Mon, 11 Nov 2024 04:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731327913; x=1731932713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrMv3jbYMdm+kZZS2RzhWWLxY0Ijq1dt8GodbAv2kN0=;
        b=jC5xTnugYjTt4/YVtrMdGqqHpMJ/HV/H28R2jNtcBn8ZRTA4hS+D8qbXIxkYE3Xd7x
         yYtKJqNTzeFcY6+BhKg4XsfOJcQZGxM54WQzt7poY91Gr3pFTc+9kolksJ0eu2gy+q04
         NoWPzvQunevFkWNFsaRdvol33woeTrcvq4y5G7cE4bPuc/0yDxn3zHtB8O/Tf98N/sI7
         qbhbhGGAmpFBhzdRKmt0j2xXcm7qOZzQKTV+4IPu+c0IksjIj6bXYtP2KuokU1kGLARm
         cYkxERRa69dfIh8CmKBsArN/0nCh/w75v7PtRTB2Eu1/aqoOB+I3zA1wmRitHLNl1POw
         uHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzoNhKoNOua7zD0ShqBEPe/dlLOBvfEKq/svwlCi0uHNp6pSCv4GVrxW4uj0+kNdh02yA9ffbkMxw4Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlF+jDlqffEQdr6Uvm4jM2dZo3sz3FNbDPfeXjDmThInQjsnaW
	EgoI7HrBkCDRHZ/gCDEb2XVKBNu57CFMUy18WIfOLKB3lMIQ/ynjQ3HTew==
X-Google-Smtp-Source: AGHT+IFQWfGFzz1imMd//hAq/AEnpaKNFfaIE0lRACfmekW8j7qPDsgLIjl3JSfRz2rCY+qZXiYC3w==
X-Received: by 2002:a05:600d:3:b0:432:bb4d:cd77 with SMTP id 5b1f17b1804b1-432bb4dcea1mr117324365e9.19.1731327912698;
        Mon, 11 Nov 2024 04:25:12 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5871sm174761015e9.37.2024.11.11.04.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 04:25:12 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: Zorro Lang <zlang@redhat.com>,
	Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <jth@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] fstests: check for ext3 support in btrfs/136
Date: Mon, 11 Nov 2024 13:24:53 +0100
Message-ID: <4c41adf81241f5d23b5a10251564b1630cabc500.1731327765.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test-case btrfs/136 requires ext3 support, so check for ext3 using
_require_extra_fs.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/136 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/136 b/tests/btrfs/136
index 9b5b3331119f..2a5280fb9bd1 100755
--- a/tests/btrfs/136
+++ b/tests/btrfs/136
@@ -20,6 +20,8 @@ _require_scratch_nocheck
 # ext4 does not support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
 
+_require_extra_fs ext3
+
 _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
 _require_command "$MKFS_EXT4_PROG" mkfs.ext4
 _require_command "$E2FSCK_PROG" e2fsck
-- 
2.43.0


