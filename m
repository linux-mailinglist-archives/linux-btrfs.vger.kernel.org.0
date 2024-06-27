Return-Path: <linux-btrfs+bounces-6014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E334191A2F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 11:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125B11C21FE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C47513AD38;
	Thu, 27 Jun 2024 09:47:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D24D5BD;
	Thu, 27 Jun 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481658; cv=none; b=WAh/nGMZX8lyEQltzWt9QARjMbcFo8FdyoNgz/F7hbEHl6p5JmzOPIMsFBjgwPJcQUid98hgTOZ/GfnRgGSOqugNOQTmL2h0usVEPWGEaj76kiNNC0uexw6MLyXDszN3bAyXar35jtXEQ9aULC4TfCF74V2CZ8UP0w1FRsYDaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481658; c=relaxed/simple;
	bh=qcwOjmTZn9qH7uXi0uBn2NQPjOHRl4KZN03Ah5mwmzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qK3Nr4SWoT4gNkM/vEJN06BPsWfuECPjsCh2uQfn7uDDbwbe7zwmfEs4VyaKscYbllgDPQuKGBYLNGFmn4QBmeYB47+lZf3XwSnDspJvQOD5XKHyS1o1cAi4ihKbHMDVqExP4CdP4aUAaaGBSs2DCRMfPkvXQ2F8eWQUDs/2744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a72988749f0so103638066b.0;
        Thu, 27 Jun 2024 02:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719481654; x=1720086454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHPW/mTdP4Dua1klHIhVgL/6So15e1V6dW1LMyavx3s=;
        b=ZaCWJSWGFTotsAT6agiWUANuVjedAUadIBOSfLrvq6O/nTil+1EXrM84uSE9gUlEZG
         CzIqno2UnrRSKk9IjGWZgRgO8oe8Z3m7rvB12hzyYObBBY+GUw+m2AVN3OLW9gaLqjST
         ctR2ghrkYxQCrvWe5cGMewOSq22agFJ1H7Ej/bhw/aCwA6CaIixs8vzyPy+vMuixqb2C
         8WjQ4ausenuL6TfVCQR1RbvuCAtCciQzw/RvvNV5bu5EIiY26E+WbWRQzbKFe3bVzb3s
         Pt1kl+t/qgSgiUIT/joimIE1+JwKCTbw1oQ3s9S/BDfuV03tdjdRcFtWtb8bq21ydnDV
         WnJA==
X-Forwarded-Encrypted: i=1; AJvYcCUQkz7Il0ajM3D4QXpEZVO2vqcH8HilcFRN1RNKvlD9O8OKO1rrJBYHciZmOs934hjH1gBtEvL4dpLfzBZ1ySW+YA6Rvz7OPw==
X-Gm-Message-State: AOJu0Yx0YaZgtS0qvppwLVJ6vqcL3TTeevTnPdvAvE937a/eGlW10aus
	rjA+cDgNEGl5+1TEw6PM2FONWiQ2QTsT0AG5/wnWQabpoxX2/GCXYrp0Aw==
X-Google-Smtp-Source: AGHT+IHlpzh0mRxhRZwzqIG1ahBSoqmpzfRTb+Fsc4ra5+nLecJBG79Gj593rCh/NFFiJGr/bQJ3kA==
X-Received: by 2002:a17:906:f0c8:b0:a6f:4fc8:266b with SMTP id a640c23a62f3a-a7245b4cab8mr873833966b.3.1719481654052;
        Thu, 27 Jun 2024 02:47:34 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7415600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f741:5600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7b4388sm42328666b.153.2024.06.27.02.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 02:47:33 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	Zorro Lang <zlang@redhat.com>,
	fstests@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: update golden output of RST test cases
Date: Thu, 27 Jun 2024 11:47:22 +0200
Message-ID: <20240627094722.24192-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Update the golden output of the RAID stripe tree test cases after the
on-disk format and print format changes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/304.out |  9 +++------
 tests/btrfs/305.out | 24 ++++++++----------------
 tests/btrfs/306.out | 18 ++++++------------
 tests/btrfs/307.out | 15 +++++----------
 tests/btrfs/308.out | 39 +++++++++++++--------------------------
 5 files changed, 35 insertions(+), 70 deletions(-)

diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
index 39f56f32274d..97ec27455b01 100644
--- a/tests/btrfs/304.out
+++ b/tests/btrfs/304.out
@@ -12,8 +12,7 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
 			stripe 0 devid 1 physical XXXXXXXXX
 total bytes XXXXXXXX
 bytes used XXXXXX
@@ -30,8 +29,7 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
-			encoding: RAID1
+	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
@@ -49,8 +47,7 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
index 7090626c3036..02642c904b1e 100644
--- a/tests/btrfs/305.out
+++ b/tests/btrfs/305.out
@@ -14,14 +14,11 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
 			stripe 0 devid 1 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
 			stripe 0 devid 1 physical XXXXXXXXX
-	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
 			stripe 0 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
 bytes used XXXXXX
@@ -40,12 +37,10 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
-			encoding: RAID1
+	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
-			encoding: RAID1
+	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
@@ -65,16 +60,13 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
 			stripe 0 devid 3 physical XXXXXXXXX
 			stripe 1 devid 4 physical XXXXXXXXX
 total bytes XXXXXXXX
diff --git a/tests/btrfs/306.out b/tests/btrfs/306.out
index 25065674c77b..954567db7623 100644
--- a/tests/btrfs/306.out
+++ b/tests/btrfs/306.out
@@ -14,11 +14,9 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
 			stripe 0 devid 1 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
 			stripe 0 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
 bytes used XXXXXX
@@ -37,12 +35,10 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
-			encoding: RAID1
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
-			encoding: RAID1
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
@@ -62,12 +58,10 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
 			stripe 0 devid 3 physical XXXXXXXXX
 			stripe 1 devid 4 physical XXXXXXXXX
 total bytes XXXXXXXX
diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
index 2815d17d7f03..e2f1d3d84a68 100644
--- a/tests/btrfs/307.out
+++ b/tests/btrfs/307.out
@@ -12,11 +12,9 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
 			stripe 0 devid 1 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
 			stripe 0 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
 bytes used XXXXXX
@@ -33,8 +31,7 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
-			encoding: RAID1
+	item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
@@ -52,12 +49,10 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
 			stripe 0 devid 3 physical XXXXXXXXX
 			stripe 1 devid 4 physical XXXXXXXXX
 total bytes XXXXXXXX
diff --git a/tests/btrfs/308.out b/tests/btrfs/308.out
index 23b31dd32959..75e010d54252 100644
--- a/tests/btrfs/308.out
+++ b/tests/btrfs/308.out
@@ -16,20 +16,15 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
 			stripe 0 devid 1 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
 			stripe 0 devid 1 physical XXXXXXXXX
-	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
 			stripe 0 devid 2 physical XXXXXXXXX
-	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
 			stripe 0 devid 1 physical XXXXXXXXX
-	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 24
-			encoding: RAID0
+	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
 			stripe 0 devid 1 physical XXXXXXXXX
 total bytes XXXXXXXX
 bytes used XXXXXX
@@ -50,16 +45,13 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
-			encoding: RAID1
+	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
-			encoding: RAID1
+	item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
-			encoding: RAID1
+	item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
@@ -81,24 +73,19 @@ checksum stored <CHECKSUM>
 checksum calced <CHECKSUM>
 fs uuid <UUID>
 chunk uuid <UUID>
-	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
 			stripe 0 devid 3 physical XXXXXXXXX
 			stripe 1 devid 4 physical XXXXXXXXX
-	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
-	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
-			encoding: RAID10
+	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
 			stripe 0 devid 1 physical XXXXXXXXX
 			stripe 1 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
-- 
2.43.0


