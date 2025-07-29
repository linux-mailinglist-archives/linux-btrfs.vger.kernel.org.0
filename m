Return-Path: <linux-btrfs+bounces-15731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B39CFB14827
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 08:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1B41899230
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3450E256C9C;
	Tue, 29 Jul 2025 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eETOjVQK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DF262BE;
	Tue, 29 Jul 2025 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770294; cv=none; b=iLSVarNxYyBEkIeOTbTAtP4jR+OARDEZHNyqs1Kp20OMiAisHOz+emZxyVvb3hH1zN/QFY/nz5HHA7r924we5RTmLDO/FZDDXC8mLIli1vewIPR0Fkl9GSYrNUg1wTAkb4HNA2S/OJXGuuV8bAx8nrOmGwPgXUhocHKci1sEbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770294; c=relaxed/simple;
	bh=g7cFGN8Ey8bEE/xmH8gaWdV9LUJ9jZ0CBsWcSRJT7Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKs4iWLCrGG8sU81VMzFPg9CqMLh8VFgL9XswIST1k+DG//rXYOB7De59Nh7ykNuVDNYnyniE/S00kdtj3TArltjD9eU8tZeb082h+TRVG3Hf3ysZrVd2aC5Ne9xveto0wPGBDblY+G6Negbb5UM56Q6DVYWlfvHw5502uu01UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eETOjVQK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2407235722bso2479425ad.1;
        Mon, 28 Jul 2025 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753770292; x=1754375092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZPFIB3/hAt8BhA9Sy2TEtaE8CXDXsMw1p2jmLIatjg=;
        b=eETOjVQKsw1G+1RYTTe+SFBBnPbiJVKjCg1u2LjldugHMNiGliGvub8l6w/CiZnBOw
         SfCOju/WNwlSFwORr2HTLK9VytTzbgBrdDilaVNmR4NyU2SZHJ1FEpqwNz2JkqM/YQ6+
         G1A0mnvNNrHxDsHJ3LjzPYvjLRB09DpPHMw9nkEif4IrXPxmuOPaYSYOrGu21kB3R4y8
         XmYfzGZ4uY6dLH+KSgu/5L6dPYdslYKlsp0p7O/4cRhm2+Kg7R0QG6xiguR7nWeGXZpq
         YhOpDAiOdEr5JV88Vhu+qJRMoTzb9Eh0c31kq8rLUQlCUGXA0hvG4dlqftQVN88mpY+z
         Y34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753770292; x=1754375092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZPFIB3/hAt8BhA9Sy2TEtaE8CXDXsMw1p2jmLIatjg=;
        b=tmWb/jmrvjoYUS4KCz5+vKbmMT1o7aWa+/UR7sRv+f3QzR8LDL3AEH2J4loKVGCk15
         Q50+SY6j7W3Xuy6ULCUj746s7xl/qseYbNF4HPeyz8r3qhBIHZtxMWPe1cCQ+TojfK/m
         sDF/QnuTDbqqU0HEAr2A6RE+ZVQ34j3dbJyrYtlS6K29LGtEGTR72UPkO7TE9KSOPcsq
         NE2DEKiMMqA89F3+EWvSHa+Hz3xoFARDpw0c8Nmo/85HZwEJ9tZZLhTiUeXa9QIOow3r
         Kmlv+/EkGPyfXKBTyEL5WWKc6YQtInum8log6tyaezjX9eL91VeJUR0tQTrkj0XuYdQ8
         BTFA==
X-Gm-Message-State: AOJu0YxTvuNTBD9sHoplB1ywmOAi4NN/Hl5TCOVe4Ca0V8cpNbNttVVh
	7Q1JzEfU42fE44L6IBxmyDQY2uu6bCtxVQ9UBrnNwKSZMpQmnB8h5nK5mzr6Vg==
X-Gm-Gg: ASbGncvzs1mHeknkcFngTb7yyCtTMa7n64sYZiXxvkXY3q4/iLo3zr9Z089GoCh3Ewv
	IJDAZLtyihu2AOuoYW8Fyu/BIXV1+lBUPMtvTkz/neRmILxtHTiVvEDu7AFpg3iUaodE83s6Qo9
	Dq+jerEIRyV65AOk1Pmyq1yBVdDNDxXlTyg64QFcR4Z2HZF5G8AP7m+75ow1Ubs1vXHK9f/u+LD
	q9jv7lyAbwk+fnZraYxTeBtEA8RH3+qhzw/Mdkh8XJICqwNgUDsLkbaOFVzUVegmYUYc2TlvqYq
	Z6Ojy5C3Y7p1je+mb3TJLcj5NFyz6MhN0A87tqL7e/9GgkCLL3NIFH128v5x9Ob7vvoaoXbtG3j
	o21+sZ5oLFJwF4bzZQaS45sQ=
X-Google-Smtp-Source: AGHT+IET+djYMDWUl8olcaYTH72aSQ/56TLNHsR/qc34N4O75IwvFpgcAElQlTzTFy0zTo6E1blDLQ==
X-Received: by 2002:a17:903:1212:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23fb3145e12mr260917145ad.32.1753770291801;
        Mon, 28 Jul 2025 23:24:51 -0700 (PDT)
Received: from citest-1.. ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc1adcd24sm65941195ad.167.2025.07.28.23.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:24:51 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH 7/7] generic/274: Make the test compatible with all blocksizes.
Date: Tue, 29 Jul 2025 06:21:50 +0000
Message-Id: <0a9f6e6d2018c6d505be192031aeb9e656b23bd3.1753769382.git.nirjhar.roy.lists@gmail.com>
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

On btrfs with 64k blocksize on powerpc with 64k pagesize
it failed with the following error:

     ------------------------------
     preallocation test
     ------------------------------
    -done
    +failed to write to test file
    +(see /home/xfstests-dev/results//btrfs_64k/generic/274.full for details)
    ...
So, this test is written with 4K block size in mind. As we can see,
it first creates a file of size 4K and then fallocates 4MB beyond the
EOF.
Then there are 2 loops - one that fragments at alternate blocks and
the other punches holes in the remaining alternate blocks. Hence,
the test fails in 64k block size due to incorrect calculations.

Fix this test by making the test scale with the block size, that is
the offset, filesize and the assumed blocksize matches/scales with
the actual blocksize of the underlying filesystem.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/274 | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tests/generic/274 b/tests/generic/274
index 916c7173..4ea42f30 100755
--- a/tests/generic/274
+++ b/tests/generic/274
@@ -40,30 +40,31 @@ _scratch_unmount 2>/dev/null
 _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
-# Create a 4k file and Allocate 4M past EOF on that file
-$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc -k 4k 4m" $SCRATCH_MNT/test \
-	>>$seqres.full 2>&1 || _fail "failed to create test file"
+blksz=`_get_block_size $SCRATCH_MNT`
+scale=$(( blksz / 1024 ))
+# Create a blocksize worth file and Allocate a large file past EOF on that file
+$XFS_IO_PROG -f -c "pwrite -b $blksz 0 $blksz" -c "falloc -k $blksz $(( 1 * 1024 * 1024 * scale ))" \
+	$SCRATCH_MNT/test >>$seqres.full 2>&1 || _fail "failed to create test file"
 
 # Fill the rest of the fs completely
 # Note, this will show ENOSPC errors in $seqres.full, that's ok.
 echo "Fill fs with 1M IOs; ENOSPC expected" >> $seqres.full
 dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=1M >>$seqres.full 2>&1
-echo "Fill fs with 4K IOs; ENOSPC expected" >> $seqres.full
-dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=4K >>$seqres.full 2>&1
+echo "Fill fs with $blksz K IOs; ENOSPC expected" >> $seqres.full
+dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=$blksz >>$seqres.full 2>&1
 _scratch_sync
 # Last effort, use O_SYNC
-echo "Fill fs with 4K DIOs; ENOSPC expected" >> $seqres.full
-dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=4K oflag=sync >>$seqres.full 2>&1
+echo "Fill fs with $blksz DIOs; ENOSPC expected" >> $seqres.full
+dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=$blksz oflag=sync >>$seqres.full 2>&1
 # Save space usage info
 echo "Post-fill space:" >> $seqres.full
 df $SCRATCH_MNT >>$seqres.full 2>&1
-
 # Now attempt a write into all of the preallocated space -
 # in a very nasty way, badly fragmenting it and then filling it in.
 echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
 for i in `seq 1 2 1023`; do
 	echo -n "$i " >> $seqres.full
-	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
+	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=$blksz count=1 conv=notrunc \
 		>>$seqres.full 2>/dev/null || _fail "failed to write to test file"
 done
 _scratch_sync
@@ -71,7 +72,7 @@ echo >> $seqres.full
 echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
 for i in `seq 2 2 1023`; do
 	echo -n "$i " >> $seqres.full
-	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
+	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=$blksz count=1 conv=notrunc \
 		>>$seqres.full 2>/dev/null || _fail "failed to fill test file"
 done
 _scratch_sync
-- 
2.34.1


