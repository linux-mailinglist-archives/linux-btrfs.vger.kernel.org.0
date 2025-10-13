Return-Path: <linux-btrfs+bounces-17660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BDBBD17A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 07:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C7B3B62FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 05:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A12DC76E;
	Mon, 13 Oct 2025 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxUIDS3W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480512DC76A
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334062; cv=none; b=Fxq/LZn2BOMRybbPEnLRoHCizSmVM18lzDZLmTsgKe+LWXcc/nq0ECAdn0Zjl2EMu++TAlHMlQbdqQXiwULbMGkQL5/XEp3gpsSPJJK5u1u+gFaqKI5+sB59tYeFPdf+cmLxdzTSohPXdENSx7eckFZddIg5HtfgsdVARn3PByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334062; c=relaxed/simple;
	bh=TUuiJQIkx4zApOps7CqiBiHdmhJj+mMM/kZdcnCoeYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCBZBQP8faJM+1dD7+q6JLQy6Kg+MGVqRIxGoi9zXsrCPu4U8W3/9ONVzgwRw6f5cLCEMC7UE8ukwygEfzMAuCTK6JyoafZil5n41dqcOrZGmxYCLt1VnLQfuMd+UoggXqXwsaM1afvRJcwAcRKS16JHwla+Ei975glBF6wU4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxUIDS3W; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so3929711a91.0
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334060; x=1760938860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLK9qO1/R6EGWIZqb2TUkVvkexP9qyEFErwjwtz/uPc=;
        b=cxUIDS3WW7f9pEf+Ezvce7Q+906+2dkdOswXK/YwP0BIlhN5oYe7Qvnx5WuC4BPv7P
         xqYll7aBKL45vGviQpb5xHUsxT3Y4tCfzFFhJBRMSl+aXbTBntxODH77CSqFo97aFHtj
         PhlrYaih4/HO9kKSYmQUT+Zb7J4iRzLubUnOrQ218KGH3fekCW4AvNFmKy9ktQpZeTP/
         SvI+R97MIxwXjo0hnTC/B67YinhhEmntQL2XxsXFvPm5MAlEAQl4xVoHKmXDYSCf4JmX
         PMcpmmKVSDMZ6BSWJIt5tRt2qS/hkA6rJakE19xrgrXKNm4H10n35S5g2o+GUS67arC/
         NS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334060; x=1760938860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLK9qO1/R6EGWIZqb2TUkVvkexP9qyEFErwjwtz/uPc=;
        b=ePSULk0bnYabzc/7K8k3MVbCYjht+gioRzQdgbhU5ICnJO55hmn+lBt0iifp0OhGnh
         umUAO42T322atTiFsxW6c92wjzinPgG/Va8QuuuNCoVImE4YpG0pv+f6Orx8moOyUtPX
         fWChVnPFbj0Dy/DWQQFfgqYW25qRWa7k4ThJnswV3CI5umz+HqY9qXnRbbkxbdqS5/IO
         EF0k+TSrgwXxjxVHVDrOT++5unlg8+hKThp7PGvOksebWopJBj1iTUfAsz0jXmVZ6rPz
         vwH8Ws1SrZ1OUq2v45F9yafpi8AnPfX/MJuVmx1EUR9CnYDkqHXfsZ3wZV6Qmx+cKD6G
         DKTg==
X-Gm-Message-State: AOJu0YxdTnKP/js3jVbiYgLsfawAYBVb656FaKdvM/eYOCow94AfQ4Y8
	tBmNUgZx1AnWvvyQLgJCOG6dcf/GkbsZCBcgYoH7jeR2iqwo+sKtQgTt
X-Gm-Gg: ASbGncv3jPXgOBkbjBcpWXBPAM6Dg2xXfdfZklh5BM1ziqsIjeKMk39CqK4Gxsf7idU
	LrhiRY4d5Kp6T+C1EBlLuMzqJwkHgIPEwfVGZt9xNL3lC4o6RUXAhvD0VGnrr2lZUpNlg+1MrCk
	J31/RJvcUHJy5wLa0gO6ClafM0Y3TaodFPA/8kLshoYgCqns4z62HRWp6F6zZB/dI7bC6padqFu
	8lJNU72/6U1RsGR4JkWsWT4MhHNlbP8fv3qtoW9JcQI8zMhW1kACTCURXtqBnzQqnSqRTyuS+Zg
	vBFD4Td4RDQIKiu3oGohUWNbBKOFUymSnMJGp9JbkVizFEumxaaIodWI0BG13c8auuszyMhUZJZ
	66G5ixscKuv03N5iSuw4r6T5hT89qH5dEWrNpHQzhR26db2zxyU/XbBqG
X-Google-Smtp-Source: AGHT+IHale/kMoCEjDjftg6c7JJvs9/sTJT07ULkXW/Ljncj+bc0Mdn9ws/VjBTkV2yajYv6SeF/YA==
X-Received: by 2002:a17:90b:1b4c:b0:32e:4924:6902 with SMTP id 98e67ed59e1d1-33b511496d1mr30128320a91.3.1760334060485;
        Sun, 12 Oct 2025 22:41:00 -0700 (PDT)
Received: from citest-1.. ([49.207.231.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52968581sm7014726a91.4.2025.10.12.22.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:41:00 -0700 (PDT)
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
Subject: [PATCH v2 2/3] btrfs/200: Make the test compatible with all supported block sizes
Date: Mon, 13 Oct 2025 05:39:43 +0000
Message-Id: <aa7dd84c98a5042f36639bc99c46302d6b22fdc0.1760332925.git.nirjhar.roy.lists@gmail.com>
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

This test fails on 64k block size with the following error:

     At snapshot incr
     OK
     OK
    +File foo does not have 2 shared extents in the base snapshot
    +/mnt/scratch/base/foo:
    +   0: [0..255]: 26624..26879
    +File foo does not have 2 shared extents in the incr snapshot

So, basically after btrfs receive, the file /mnt/scratch/base/foo
doesn't have any shared extents in the base snapshot.
The reason is that during btrfs send, the extents are not cloned
and instead they are written.
The following condition is responsible for the above behavior

in function clone_range():

	/*
	 * Prevent cloning from a zero offset with a length matching the sector
	 * size because in some scenarios this will make the receiver fail.
	 *
	 * For example, if in the source filesystem the extent at offset 0
	 * has a length of sectorsize and it was written using direct IO, then
	 * it can never be an inline extent (even if compression is enabled).
	 * Then this extent can be cloned in the original filesystem to a non
	 * zero file offset, but it may not be possible to clone in the
	 * destination filesystem because it can be inlined due to compression
	 * on the destination filesystem (as the receiver's write operations are
	 * always done using buffered IO). The same happens when the original
	 * filesystem does not have compression enabled but the destination
	 * filesystem has.
	 */
	if (clone_root->offset == 0 &&
	    len == sctx->send_root->fs_info->sectorsize)
		return send_extent_data(sctx, dst_path, offset, len);

Since we are cloning from the first half [0 to 64k), clone_root->offset = 0
and len = 64k which is the sectorsize (sctx->send_root->fs_info->sectorsize).
Fix this by increasing the file size and offsets to 128k so that
len == sctx->send_root->fs_info->sectorsize is not true.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/200     | 8 ++++----
 tests/btrfs/200.out | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/200 b/tests/btrfs/200
index e62937a4..b53955ce 100755
--- a/tests/btrfs/200
+++ b/tests/btrfs/200
@@ -38,14 +38,14 @@ _scratch_mount
 # Create our first test file, which has an extent that is shared only with
 # itself and no other files. We want to verify a full send operation will
 # clone the extent.
-$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
+$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 128K 0 128K" $SCRATCH_MNT/foo \
 	| _filter_xfs_io
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 128K 128K" $SCRATCH_MNT/foo \
 	| _filter_xfs_io
 
 # Create out second test file which initially, for the first send operation,
 # only has a single extent that is not shared.
-$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
+$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 128K 0 128K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
 _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
@@ -56,7 +56,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 # Now clone the existing extent in file bar to itself at a different offset.
 # We want to verify the incremental send operation below will issue a clone
 # operation instead of a write operation.
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 128K 128K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
 _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
index 306d9b24..a33b3c1e 100644
--- a/tests/btrfs/200.out
+++ b/tests/btrfs/200.out
@@ -1,12 +1,12 @@
 QA output created by 200
-wrote 65536/65536 bytes at offset 0
+wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-linked 65536/65536 bytes at offset 65536
+linked 131072/131072 bytes at offset 131072
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 0
+wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 At subvol SCRATCH_MNT/base
-linked 65536/65536 bytes at offset 65536
+linked 131072/131072 bytes at offset 131072
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 At subvol SCRATCH_MNT/incr
 At subvol base
-- 
2.34.1


