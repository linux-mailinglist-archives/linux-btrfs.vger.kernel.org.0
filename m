Return-Path: <linux-btrfs+bounces-6057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C48691D989
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 10:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2593E283F6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BE35C614;
	Mon,  1 Jul 2024 08:01:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6DDDF42;
	Mon,  1 Jul 2024 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820881; cv=none; b=jnIlTuZhQDqZT9MEe4vaYK57AM+/3+U9cjmNq08xkySupc61Pbi0k525tDhpVyGuf7PYSyFFNexIPdkOAmtXNpYXyp1MaQ/V0xF/JyqLFFmVsesDej+p4nzkxkwDuWd9VlQ+lhp+1c92Tj1Vj+6yhuqQ4Lziy5Auw0fsT+YVcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820881; c=relaxed/simple;
	bh=5h0fcntknDju7NDT4EVa6FfTx3PQZMhzcVkXe0wVIfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNSuecyeEL4u7Crlsq54qQsiYfgZbXsQKbLgQhmTpVN3w6Xh3B/1TULpZIYj7VoS+p6Ld8Jj+xw4EMRTrtwZNBlp1jwfujf1dpvRD8Z6Y5+dQmb6oqvAHRGjSD2TMt562rCESkvZiGKbLfmpUmQq1k3IhpaWprBYw0xwNWGFV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a72585032f1so296851366b.3;
        Mon, 01 Jul 2024 01:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719820878; x=1720425678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USM3vxUNNrRsAPiK2DpGZeOBw77DH43wgOeDeD8fyDc=;
        b=sllEg1i43rL+BNxe1S45WKeXIWj2RhPbtFYns7DPct6E7IDRlX0f5bdHV5tDQ0lqkE
         qjAXazzHW1bzNXRqOmbYgWG2yOQa0bmQ/To1x6QaTwWugxNkbTAz1pVNG0Uswd/HXYid
         DYfLnb+4nMNLs8hqbA4fYFkb1p89HoeP+GKfOXblw3w91ndOxOFToF4a9STZG89S+ZX7
         M5XiFSS9MJWQayYZeBh0vq0+7seq9mpiUudY6tt8IHRoDGJTT2A+80nDqNlcwSLrdVb+
         TaDg7Afzv7ntf2cZnxcopOCIohuy49Mq4DOKTbMTljlBocdeg2U+O1K3vNa1xGZDEH4+
         X9fw==
X-Forwarded-Encrypted: i=1; AJvYcCV6U2or4gMpOiZXVI2DMT7ljSSGmPeAMxBN8ESr5/0244D5+aM7WeloSaqp3OOaA3hq979hpxMPt0oelK2C63sWgYDbya55Sw==
X-Gm-Message-State: AOJu0YxzLLK/5mulvBunhYV7l63s8qk+uEolCIcP1IbRSJHSAdhr6QBB
	gC6QX0YagZUcx1tlHW4Avyjp4aXkxj81IN5N3nRCt4yrjI2Dc4ajCoMdgw==
X-Google-Smtp-Source: AGHT+IFR/MeXEWxyRH+/BOnpYUWXxq9s9CoW1IAwm2gooNP46Ec0TaIPIeHuFAGTh804vdEShJ7lEA==
X-Received: by 2002:a17:907:7d89:b0:a6f:50ae:e0a with SMTP id a640c23a62f3a-a751443876cmr382099266b.37.1719820877349;
        Mon, 01 Jul 2024 01:01:17 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1b569sm306597066b.1.2024.07.01.01.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:01:16 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	Zorro Lang <zlang@redhat.com>,
	fstests@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: update golden output of RST test cases
Date: Mon,  1 Jul 2024 10:01:09 +0200
Message-ID: <20240701080109.20673-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Starting with kernel patch "btrfs: remove raid-stripe-tree
encoding field from stripe_extent" and btrfs-progs commit
7c549b5f7cc0 ("btrfs-progs: remove raid stripe encoding"), the on-disk
format of the raid stripe tree got changed.

As the feature is still experimental and not to be used in production, it
is OK to do a on-disk format change.

Update the golden output of the RAID stripe tree test cases after the
on-disk format and print format changes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

Changes to v1:
- Mention the kernel and btrfs-progs changes mandating this change.


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


