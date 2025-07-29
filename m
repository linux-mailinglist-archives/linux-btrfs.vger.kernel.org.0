Return-Path: <linux-btrfs+bounces-15729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6053AB14825
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 08:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980A616BD88
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 06:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121E5256C9C;
	Tue, 29 Jul 2025 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvvPmoNz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5B262BE;
	Tue, 29 Jul 2025 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770271; cv=none; b=ndNsJuvaQwuHvVhcjiANajGymv/xf6BoB2zTtSwEOx0lpy38tnc2UryqQrTppmXc4B0k16DjI102r2A7coPeKweGH38VXnymDSnURQ1cIdGR7x25bFMb9tgj4CFKaRjkoLxXNWspTXVznCpx1lE6b8XkuunB9HSZbhrxi8gMqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770271; c=relaxed/simple;
	bh=eg2i1UfbRCqPMPnWgTSiSvcg4IswBDkBAJroilJEzlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0a41P9igsDoaA08XpNmsukEUvQbta3WGChk9AsuhT5xPaArGpYJRy2RgRiyhUDRfXNP+EnOnJs1HaaHJN7pQkqNc7hsT9aEyIwg8U7DrnzPK8dAvNrJ9Gi7b+Er1xR+LNFgagUdYFBeB2j4O0iNLhDsrw3/jsaLr4bTrrdCot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvvPmoNz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so6540837a12.3;
        Mon, 28 Jul 2025 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753770269; x=1754375069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8si36GnOZYo85SCiSVV88XYOQ+Dh8rCNIs2VAozTJ8=;
        b=XvvPmoNzp4xnCDvV5ab4HYG413QZNIORez/9WmSoFzTzz8tT5bUw0T7y4qSwWxq1gD
         ThwCQAm37KfmAAxfeX+ubQnOYtgnAl/9PMba/7rK24+2rfhyOZaGBaydKfrlkFU2XZC/
         pqsLRVnpwAkbdyvn1MVuaG1LXXMrnhco9SgwF6/ejI+w1u0bVEH8/a+DeSYcO0EiHpZ/
         YB980tZmOJluFdw/aCkZE1W960ppKIhhdD1EVJoO9yvRa27dmv+woNQJq3kh0JVzF0RY
         OFMVR+bkiz5iyT3B/u8UA8xO8munY7DVDsH6HrIWvWfe1/RyBQyQ3Q3XB60xH7bytM0H
         0qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753770269; x=1754375069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8si36GnOZYo85SCiSVV88XYOQ+Dh8rCNIs2VAozTJ8=;
        b=eWrt1F6o5CJ7TgsRHJPLFEMM8MAn6ygZi5VtWsfU4SgBrr7T8GjZ/vielJzjZnENuB
         HR7viEZ2kW+NuBTX7d3WiRNm8xbL9TIK5OaH2BysxU8TCGpjZ1A+gqDDls2xczlAhuK5
         dNZmf0vuKVgHdYO9pV04+tGkwtOBKvpyFY3Ajyb4s+Oq7DS6VzlLvv8Mc89twBuv9eeT
         /AMPGwH1sb4xoj5LsDGh3ljzYMoyWWcW1ZgoeG/JQEsPBcaXJDYM0iGIjkI3DOibKX72
         lOyvTBNJKgNqcokDpDLSsmsxX+z7D1k4sPqULYcVxZtWvWIVJeqavtgZAeJgR50+JV6r
         kZDw==
X-Gm-Message-State: AOJu0YydMK8ESHyjKQGHiOW8C+GfZ8eoWELZlVqa+Xt2k0WkfFxeGhC6
	TzN5N7t/BNvO+yfqTHRwhXTgodaKNjmt7LyFtw0f3eqjNsezSmmiqA/0vK52sQ==
X-Gm-Gg: ASbGncu+5FtiE1LiM1KasSe3AKWVpX8sEZbiC7VTUD0cXoSYHw0Jn6RSGYPIPKmhnwD
	Yx9+QVyiX9mr+1VAUVhU27ZIyGVEp1HeIsz00BSN7W4o47dS5uFyC14M7Rlx2fmCXLpYbwl6KPj
	kkBUDsHc2rqfKnzehB2+7eb0rD39FWX6Jr3KERaenbdRd/m+SYLpOq9kgHrdppbv+x+S/9/q66Z
	DCvaHjd2OQBor037mN+UYSBMpx2Rk9NypCu3HAZLM8lR+MZvk0vs+MotnsqzUf8xJlJkat/7Hfl
	EeD2K2r5fOGTU5JDo5yJpf81C905v2SzcsQ80RF9b14wAmnmUA7RtmGBHlelKm2OiYbDVArYUVZ
	pQ0rbEKZOR3VDxTs4enLXYOnfk5HuF0c5gQ==
X-Google-Smtp-Source: AGHT+IFFNalAqIFbFd209oLWnmCYU8MVflWHva/goNQG9v+JbwjofbUOIdchk2tyYUNuO4djHkHKFA==
X-Received: by 2002:a17:902:f690:b0:234:d679:72e9 with SMTP id d9443c01a7336-23fb2ffcf90mr222259285ad.12.1753770268951;
        Mon, 28 Jul 2025 23:24:28 -0700 (PDT)
Received: from citest-1.. ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc1adcd24sm65941195ad.167.2025.07.28.23.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:24:28 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH 5/7] generic/563: Increase the write tolerance to 6% for larger nodesize
Date: Tue, 29 Jul 2025 06:21:48 +0000
Message-Id: <f48538de3ce4a98a2128f48aa0f005f51eb552ee.1753769382.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tested with blocksize/nodesize 64K on powerpc
with 64k  pagesize on btrfs, then the test fails
with the folllowing error:
     QA output created by 563
     read/write
     read is in range
    -write is in range
    +write has value of 8855552
    +write is NOT in range 7969177.6 .. 8808038.4
     write -> read/write
    ...
The slight increase in the amount of bytes that
are written is because of the increase in the
the nodesize(metadata) and hence it exceeds the tolerance limit slightly.
Fix this by increasing the write tolerance limit from 5% from 6%
for 64k blocksize btrfs.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/563 | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/generic/563 b/tests/generic/563
index 89a71aa4..efcac1ec 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -119,7 +119,22 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" -c fsync \
 	$SCRATCH_MNT/file >> $seqres.full 2>&1
 switch_cg $cgdir
 $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
-check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
+blksz=`_get_block_size $SCRATCH_MNT`
+
+# On higher node sizes on btrfs, we observed slightly more 
+# writes, due to increased metadata sizes.
+# Hence have a higher write tolerance for btrfs and when
+# node size is greater than 4k.
+if [[ "$FSTYP" == "btrfs" ]]; then
+	nodesz=$(_get_btrfs_node_size "$SCRATCH_DEV")
+	if [[ "$nodesz" -gt 4096 ]]; then
+		check_cg $cgdir/$seq-cg $iosize $iosize 5% 6%
+	else
+		check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
+	fi
+else
+	check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
+fi
 
 # Write from one cgroup then read and write from a second. Writes are charged to
 # the first group and nothing to the second.
-- 
2.34.1


