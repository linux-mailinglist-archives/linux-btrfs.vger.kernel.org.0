Return-Path: <linux-btrfs+bounces-17661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E012BD17A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 07:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70595188E2CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 05:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9422DC35A;
	Mon, 13 Oct 2025 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDN3aqrA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840032DA768
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334072; cv=none; b=nZU1+QdLOrLpVGs/acSqaxTBWckqZLDDW+aciPUWa1ducVQ7Z8X2EG/5qX+vPyZoJ187NTLPF8Pt7W/AUdTPsYwhhoEYk4THGIsGQu5akHrhSnonvS7X80BQNFQSaLTyWhymThIVV01tNK5FL66SzT99UZvseM2ue4gdu64bhwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334072; c=relaxed/simple;
	bh=ArzHjDZV34T1rD71cCC7vaR4GW1nOETgNYKulmywMjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmBOIi62ZvrqHiipGt9p7AVxz8nW3bI9uBh+SIo5zDWIgo+jKLZU568TooeDGqb9ACx4vRqIP+HelzUT9Dp+Rr9aqgRkCho31LsZqoGw5hK9TKVkaa/fmyPPmDl32a684krI5szS2xOhsqJ4S0uma2QU9Jq34zILQ7+pDkTCKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDN3aqrA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso3513231a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 22:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334071; x=1760938871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P97TTuBq98jRf9UuFj90beoAQYgjCqiR1XK0WZ2uylc=;
        b=PDN3aqrAU/BrK1LeIkusJ6fM1ZMj8F6nPjTgYpo8L3FO15vHjQkGp6hwXKoqUyXcGM
         LAJHxPGlau2P4aWFmcfbIN/uZm6mlNwJlnJiPT5HdeTTVlHmBn03aMhVuc9nBvTVXai4
         F9POWA261huyHBPCWM3oULUYHCJDe7I5xGe7XdhXHLFN9sVyqMZxyO+3kINQM4WYMzmI
         G5zMN40rsR0T7xMv0Ki0POdNEFn4ZLQDHfaA8avM1H7q7Hoh9kBuAo6w7Z/xcwwDN5ND
         20pss42eSVwF3jpz7f7E9ceFwD2OrmASMzQGQyrOq+aLxcm2QSG1gkaAPy0z7qxJXejF
         sd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334071; x=1760938871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P97TTuBq98jRf9UuFj90beoAQYgjCqiR1XK0WZ2uylc=;
        b=Ep7BFVz3ps+JFr9yfXkafwBVBueuLf97ptxDKKb6x36oDGVpLk6E27s2IQ/ZhwRvif
         FJ2yETlWROgqoCLGsZdN7WkcqU7iELJnKVY82Zet3H44g2MTW0KR/fFuFlPudIZjjSw8
         p4iJ9RgJw3/ZXdasRPYWkHkasc61vUS2xGxbudv2sSGhfAiKHf2gfTREc3yl9sf1UuuS
         kkCRtX8lMDbW1DlFcwXZtvb/bl1mEjhsc5H6C09E4+WHHlEcE58KKBQFq4BTdZeQojBl
         Pz7KN5vQ3jsjtmYwx2gIwzTB6lVjKkDkzMOoM9wh8I/rElXlofN7WTcwt4M5quqTI6/c
         vUag==
X-Gm-Message-State: AOJu0YylmjqQTPAEmKxlTWOE2+uDz+Bpn/82p+MNc2zDDpp0wzoL3BnU
	eyptJLkkVnUKJq19TOPKaPK03F8cOipRRPzmq4a6PJclTN5NzzgkPUyw
X-Gm-Gg: ASbGncuqd5iODJNPgaSRkfMDXHvvMKdIMcrqi5uKZAVPYkOf8HFDPsQZpPid7AY2nCd
	6b1WjFPNsC8mgkxdnL12Sovl9bq8o7obVStBOn7IielIFAuLuKoCggWcqRwyYnccqIWtly4P6I6
	TmvJwZYSuRK41UghSd1bzoaqKo1CNj94QvCUPYzAq5o0TTbHccpYQMVl5pMyuiFeGwBCDiDJuT2
	q9DD6UXnQ4YDHnLBb8ssmW9vWKCb3Uoc+xXtn9133dyDKkU1idVu2dTsI1v6NrEVoF6dPC9Kk/U
	mV/tYKpVARw7n7rsdygeT82Sv9EivukIjfnn8S4+1Og3ipCAgFG+tkQcDk1ee4/Cq3X/CQRyrPy
	6ebrKW3uQoqZm2VI+wt1GQ3wCZygE706jsx3YrkRVhwolig==
X-Google-Smtp-Source: AGHT+IHZV5lD73I1varDLlvN/eP5YfDKAYIOH8owjFj/oOdsuLNF3Dupu5E3TahOzlunltv0m2Pt6A==
X-Received: by 2002:a17:903:3c2b:b0:24b:62ef:9d38 with SMTP id d9443c01a7336-29027379a32mr274495295ad.19.1760334070731;
        Sun, 12 Oct 2025 22:41:10 -0700 (PDT)
Received: from citest-1.. ([49.207.231.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52968581sm7014726a91.4.2025.10.12.22.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:41:10 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	fdmanana@kernel.org,
	quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: [PATCH v2 3/3] btrfs/290: Make the test compatible with all supported block sizes
Date: Mon, 13 Oct 2025 05:39:44 +0000
Message-Id: <9849006dd25950d390a8b300ad056e0d4be00394.1760332925.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1760332925.git.nirjhar.roy.lists@gmail.com>
References: <cover.1760332925.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test fails with 64k block size with the following error:

     punch
     pread: Input/output error
     pread: Input/output error
    +ERROR: couldn't find extent 4096 for inode 261
     plug
    -pread: Input/output error
    -pread: Input/output error
    ...

The reason is that, some of the subtests are written with 4k blocksize
in mind. Fix the test by making the offsets and sizes to multiples of
64k so that it becomes compatible/aligned with all supported block sizes.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/btrfs/290 | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/290 b/tests/btrfs/290
index 04563dfe..471b6617 100755
--- a/tests/btrfs/290
+++ b/tests/btrfs/290
@@ -106,15 +106,15 @@ corrupt_reg_to_prealloc() {
 # corrupt a file by punching a hole
 corrupt_punch_hole() {
 	local f=$SCRATCH_MNT/punch
-	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 192k" $f
 	local ino=$(get_ino $f)
 	# make a new extent in the middle, sync so the writes don't coalesce
 	$XFS_IO_PROG -c sync $SCRATCH_MNT
-	$XFS_IO_PROG -fc "pwrite -q -S 0x59 4096 4096" $f
+	$XFS_IO_PROG -fc "pwrite -q -S 0x59 64k 64k" $f
 	_fsv_enable $f
 	_scratch_unmount
 	# change disk_bytenr to 0, representing a hole
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr --value 0 \
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr --value 0 \
 								    $SCRATCH_DEV
 	_scratch_mount
 	validate $f
@@ -123,14 +123,14 @@ corrupt_punch_hole() {
 # plug hole
 corrupt_plug_hole() {
 	local f=$SCRATCH_MNT/plug
-	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 192k" $f
 	local ino=$(get_ino $f)
-	$XFS_IO_PROG -fc "falloc 4k 4k" $f
+	$XFS_IO_PROG -fc "falloc 64k 64k" $f
 	_fsv_enable $f
 	_scratch_unmount
 	# change disk_bytenr to some value, plugging the hole
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
-						   --value 13639680 $SCRATCH_DEV
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr \
+						   --value 218234880 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -166,7 +166,7 @@ corrupt_root_hash() {
 # corrupt the Merkle tree data itself
 corrupt_merkle_tree() {
 	local f=$SCRATCH_MNT/merkle
-	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 192k" $f
 	local ino=$(get_ino $f)
 	_fsv_enable $f
 	_scratch_unmount
-- 
2.34.1


