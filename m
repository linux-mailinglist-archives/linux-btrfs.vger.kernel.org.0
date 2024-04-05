Return-Path: <linux-btrfs+bounces-3980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9101489A547
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4598E2844C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F1174EC7;
	Fri,  5 Apr 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="R5+rgcOX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1515F40B
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346987; cv=none; b=QCtr+mXv3vRK5K/IPUWSZvwe+vSj+8qlIuq/VUcQ1/LJj5ituRtdccGk3aC9UYXYfikR4MPRuOsFHEpz0WTiCbQtnMoNozmoURZL3sm9zI08xKcQuagidgjxNz/vfgVKCD9sk53F4WL4bwJBt14v8swrM1hhTyH020Ajng54nN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346987; c=relaxed/simple;
	bh=f7n9wQyvNkyfre4dBDX+1wJDTsB+exwyeh1Cu5coEfk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUyRy28J4P1QKg77LZW8nY4U2PYGaBB+2YDbAymcZ4i2l+siqzZ7WxmT50SBsHdD7ggyLmjhoTFUK/ekxn5gjOR7k77SlIItWQto5jyQMhaa3Rv8dRUlslBp4wwKSWgA2yC6M29NL3Pxw+s0tpV5byhmQKTiE1lzXtmCA/9Fw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=R5+rgcOX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6152088aa81so27621047b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1712346984; x=1712951784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jAQhTkshKgHWtfiyScKAvltEzvkerS8QAtp+/c9zro=;
        b=R5+rgcOXxgl5Aog2REqlDfWiynn08q/QW+O6Bs0QczTidM1O+YgWpunNvKepYyuftx
         0ABwtsE8yWnnGkIEly80lzi6lWj9h3sHL7cIxsy5+tQMvHdkbWv4FcF9kgFT2DOvTmd9
         ETlMEHx5rYKUUxSStv1iPMQw88y74Pvt6nSar9u0g4whdw91r4hiBoIYm3fBlHfdmBLo
         cdXWO+G8sdAXfqvTA+Lc6L2mT8IulwMk26h+BWRo3RlVpxphPZ2bQ4Laj4sA3u6JaZ02
         ihE4S+HJT/CD+lTuLcGSESRDEii7CUauFprwpDSmA7+bl7Hucxvjt5GJgNYKtSx+AvEH
         r2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712346984; x=1712951784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jAQhTkshKgHWtfiyScKAvltEzvkerS8QAtp+/c9zro=;
        b=FddjIve5ezuqcUvGULWLHe7N1ntCq49FHuAUyxw7/dbj/i46A76T/x9XLBbf5vLPN/
         1H5h+NAftNTR6VQz5R/3hlWk2IRHefW/bfteTk6HEDByCher8i8+LL8EBa9sKUJc7Rf1
         Fn4TLVQy30vaBh/M3kdNqHAAb1N7jgfTSpWjt1QKzQQ0bClsbycl6s4+oTnKI2nAD0J3
         +rUrNcBuasoBGpEP9aQjMDYKAhkAUtGj0i0/Ri0fDDAuaT9gr4lW7jy7etarReP3NmI8
         VnXB5R6dGO1FRu0353GTs+x4vNJ/7C0L1SRvXzUxzw8h8Yb7P7a9RTBm05/aNCqOEG+R
         6ZRw==
X-Forwarded-Encrypted: i=1; AJvYcCWx9MnqJe/6WeMdL1sY+FgJwJWTM/KWUfAJwdqpYlPE8N8TNfavRgLXSvs1vun1/Apu/ius5O6MRdX9Wkwc0jzXh9y9muxjYAwWrV0=
X-Gm-Message-State: AOJu0Yy/6rTpfnpw/RxDLZOkxBDELFdXHAlAl0juSO1lpSxk4w5M3GmN
	KwRfVvd8R7hMppJDfWD8bxeYXtyOusg/owalUwFVDvOngf8tg+jZ1vn33zJxXBQ=
X-Google-Smtp-Source: AGHT+IHlxvNbcraq11Ixwrgn9+7FOq4UV97HdVb/zuWGIY6ttwfEZ/vmoA47sHnSaW2/GqaMsDY1CQ==
X-Received: by 2002:a0d:d554:0:b0:615:800d:67b2 with SMTP id x81-20020a0dd554000000b00615800d67b2mr2246292ywd.29.1712346984422;
        Fri, 05 Apr 2024 12:56:24 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fb17-20020a05622a481100b00434383f2518sm1049910qtb.87.2024.04.05.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:56:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 1/3] fstests: change btrfs/197 and btrfs/198 golden output
Date: Fri,  5 Apr 2024 15:56:12 -0400
Message-ID: <88b11129c00fb9b07e36569b4b5fe823c0a98c39.1712346845.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712346845.git.josef@toxicpanda.com>
References: <cover.1712346845.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both btrfs/197 and btrfs/198 check several raid types.  We may not have
support for raid5/6 for our available profiles, but we'd like to be able
to test the other profiles.  In order to enable this, update the golden
output to have no output, and simply have the test check for the device
we removed to see if it still exists in the device list output.  This
will allow us to add a check to skip unsupported raid configurations in
our config.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/197     |  7 +++++--
 tests/btrfs/197.out | 25 +------------------------
 tests/btrfs/198     |  7 +++++--
 tests/btrfs/198.out | 25 +------------------------
 4 files changed, 12 insertions(+), 52 deletions(-)

diff --git a/tests/btrfs/197 b/tests/btrfs/197
index d259fd99..2ce41b32 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -38,7 +38,7 @@ workout()
 	raid=$1
 	device_nr=$2
 
-	echo $raid
+	echo $raid >> $seqres.full
 	_scratch_dev_pool_get $device_nr
 	_spare_dev_get
 
@@ -62,7 +62,9 @@ workout()
 	_mount -o degraded $device_2 $SCRATCH_MNT
 	# Check if missing device is reported as in the .out
 	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
-						_filter_btrfs_filesystem_show
+		_filter_btrfs_filesystem_show > $tmp.output 2>&1
+	cat $tmp.output >> $seqres.full
+	grep -q "$device_1" $tmp.output && _fail "found stale device"
 
 	$BTRFS_UTIL_PROG device remove "$device_1" "$TEST_DIR/$seq.mnt"
 	$UMOUNT_PROG $TEST_DIR/$seq.mnt
@@ -77,5 +79,6 @@ workout "raid6" "4"
 workout "raid10" "4"
 
 # success, all done
+echo "Silence is golden"
 status=0
 exit
diff --git a/tests/btrfs/197.out b/tests/btrfs/197.out
index 79237b85..3bbd3143 100644
--- a/tests/btrfs/197.out
+++ b/tests/btrfs/197.out
@@ -1,25 +1,2 @@
 QA output created by 197
-raid1
-Label: none  uuid: <UUID>
-	Total devices <NUM> FS bytes used <SIZE>
-	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-	*** Some devices missing
-
-raid5
-Label: none  uuid: <UUID>
-	Total devices <NUM> FS bytes used <SIZE>
-	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-	*** Some devices missing
-
-raid6
-Label: none  uuid: <UUID>
-	Total devices <NUM> FS bytes used <SIZE>
-	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-	*** Some devices missing
-
-raid10
-Label: none  uuid: <UUID>
-	Total devices <NUM> FS bytes used <SIZE>
-	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-	*** Some devices missing
-
+Silence is golden
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index 7d23ffce..a326a8ca 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -28,7 +28,7 @@ workout()
 	raid=$1
 	device_nr=$2
 
-	echo $raid
+	echo $raid >> $seqres.full
 	_scratch_dev_pool_get $device_nr
 
 	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
@@ -46,7 +46,9 @@ workout()
 	_mount -o degraded $device_2 $SCRATCH_MNT
 	# Check if missing device is reported as in the 196.out
 	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
-						_filter_btrfs_filesystem_show
+		_filter_btrfs_filesystem_show > $tmp.output 2>&1
+	cat $tmp.output >> $seqres.full
+	grep -q "$device_1" $tmp.output && _fail "found stale device"
 
 	_scratch_unmount
 	_scratch_dev_pool_put
@@ -58,5 +60,6 @@ workout "raid6" "4"
 workout "raid10" "4"
 
 # success, all done
+echo "Silence is golden"
 status=0
 exit
diff --git a/tests/btrfs/198.out b/tests/btrfs/198.out
index af904a39..cb4c7854 100644
--- a/tests/btrfs/198.out
+++ b/tests/btrfs/198.out
@@ -1,25 +1,2 @@
 QA output created by 198
-raid1
-Label: none  uuid: <UUID>
-	Total devices <NUM> FS bytes used <SIZE>
-	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-	*** Some devices missing
-
-raid5
-Label: none  uuid: <UUID>
-	Total devices <NUM> FS bytes used <SIZE>
-	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-	*** Some devices missing
-
-raid6
-Label: none  uuid: <UUID>
-	Total devices <NUM> FS bytes used <SIZE>
-	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-	*** Some devices missing
-
-raid10
-Label: none  uuid: <UUID>
-	Total devices <NUM> FS bytes used <SIZE>
-	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-	*** Some devices missing
-
+Silence is golden
-- 
2.43.0


