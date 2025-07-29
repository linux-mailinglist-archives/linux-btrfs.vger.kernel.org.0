Return-Path: <linux-btrfs+bounces-15730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48639B14826
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 08:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAFC3A6B4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 06:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9171256C9C;
	Tue, 29 Jul 2025 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNqtvx4A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D2262BE;
	Tue, 29 Jul 2025 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770284; cv=none; b=Y2AtJB1EilMwuzpMYAH7506Tkvz6mS2qv4v4SitWq165YFRFFPgPg8yNYHyp6Ak/atmwPNydr1I15ofrfuzmkyN3Q/L8nZo9MgqZAFiHHA8w4o3G7KZv7/K2bfGQFYzmUoqmBgvZcQv77mzLvcuqMxaBuhSRPp8l1BPhRQ0WTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770284; c=relaxed/simple;
	bh=KN+SnO3WTYus7dR9WGYhHvpWx/YWLdHtfePtur0u/j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZPNWURx6aJXMQDGkQTUOnzpjXG8CTSPHx3bBHNB0ybF8naDdwRwvnXO4+Q88aiG0//b04mK1Jdc6Yyc2HktuO6JZftmqgXr6G8zWaX6iuZLCy5Tnh7VAg0oqVnE2dfeA7DGA5KGFeDgon4T5kPdPL4vWC91wmPaBb1FnFmg+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNqtvx4A; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3226307787so4426864a12.1;
        Mon, 28 Jul 2025 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753770281; x=1754375081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSXab2Bv7Yq7N37ynIGKMl6pX8UVqfin196gyD3sRI0=;
        b=UNqtvx4AEVYIHZcSlv1gIQxZImWH1nSWs+izty2vaq0v1HxigYTY+uRY9iRHcG1+bd
         F8/GxVJwCMIkYjwFnEKre1hmRwGdYmvnTVF1NnnOGTeLQNSPdofeT/sdk9KLLEuuSsgv
         erYx8fdo/Vw0sHOSby+ex4dRJoSlI49abZwbnVSMYEC3nMp3hDykQCzB1m2LQwWz36dM
         Zpv7Bo8X35/zZsisahDYC3NpUbADdhrTGhnT/Euyw//DNa3cooV+4kUJBpsIcIDH2Em2
         XXUscxnLoRXAXSjlPiqHujSN0KmaFPfN27cuoGl7laKxkrSRtP0Ptiwk0DkNvFoVvNZa
         ssjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753770281; x=1754375081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSXab2Bv7Yq7N37ynIGKMl6pX8UVqfin196gyD3sRI0=;
        b=orfnKkATJZWo8I+KtZw1N6yU5xIwXxl6H1pxNCUJ7NwlowhIYJE0LLrCaINDiWObkM
         ZwIs+yN7ZCRlccOypDENxkFCk3zT3gk4EWXDDmJC1dMJ4dnJ27mOdWJeGFVWIJC8dSGb
         TDtudK40iK28rN70Q+oAThGlMLA69d1lfwXNBDOFZyN+P6HWEkhjOUyDYNaLeoqEr2cS
         UZcMyExd0Xm316IWq8mEoZG+pLXmfzUImaoKnXuYyyI5lhNHsyDglsFOu1ol4U9vdFvs
         wFW+ho2HGs6c8snZ6rOiJjuLJ6jHwZUmEvw5HGgs+eVgrj0RiNnwitfL7n1T9DGpkLWE
         Mojg==
X-Gm-Message-State: AOJu0YxTNusEwHzJsMal/ZZuSaB0vx34t8yz3MVQMp5sLpor8pTxWQYF
	jYheRErsDjkbi+pG6xqcL9WyMpDhsmZx7ff3FGp2MGUBYI0gLBKJ62RNkX3dzA==
X-Gm-Gg: ASbGncvIsQe4WEwNSK9H5e5rSLHAtWcB9JBaVpxEY27p6nmxf1cZUvBc5txMFXmIxiQ
	FF4z4MWrIHeN6b4leP0iVC9ck5TN/6c9zWiYEp3g+TO+sR8OphwVulsJIjwOl1Du5vOz02rpxFq
	3A+w2oE9T0MObhsKeO1P7DNTNCZ3molWV1Ec/ihKVJHNA/538bDqpWd0i5KgXOck+RNDhdJ7uEU
	ADrIJMhotBso5qO0RVBpf4sZyDAEuoK8Dqdg0fue9ZWfJLWvpAqxFcpcvFCKYWijHQxNCxqdwEe
	0Vb3QZuuHL9qdxf1fAvtqNzSRx3d6lRHbbfluGcWrAuCCfB7ErIGdTaHHromOdXpVaWoIrfq2e2
	Jcd/ucY2GUZOekZ8ZtA9eQgE=
X-Google-Smtp-Source: AGHT+IFi+S4DrDZEjb7ZHW7vQloaoWT09MLhIMwp9M/nYeM0NvSCy2HteOy2nEuMdvdtMxsueiiSeg==
X-Received: by 2002:a17:902:d50a:b0:234:f182:a735 with SMTP id d9443c01a7336-23fb315a963mr208673575ad.34.1753770281434;
        Mon, 28 Jul 2025 23:24:41 -0700 (PDT)
Received: from citest-1.. ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc1adcd24sm65941195ad.167.2025.07.28.23.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:24:41 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH 6/7] btrfs/301: Make this test compatible with all block sizes.
Date: Tue, 29 Jul 2025 06:21:49 +0000
Message-Id: <a8233808db2ee1d7c5fe7ee8710388bb0cb8f787.1753769382.git.nirjhar.roy.lists@gmail.com>
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

With large block sizes like 64k on powerpc with 64k pagesize
the test failed with the following logs:

     QA output created by 301
     basic accounting
    +subvol 256 mismatched usage 33947648 vs 4587520 \
         (expected data 4194304 expected meta 393216 diff 29360128)
    +subvol 256 mismatched usage 168165376 vs 138805248 \
	(expected data 138412032 expected meta 393216 diff 29360128)
    +subvol 256 mismatched usage 33947648 vs 4587520 \
	(expected data 4194304 expected meta 393216 diff 29360128)
    +subvol 256 mismatched usage 33947648 vs 4587520 \
	(expected data 4194304 expected meta 393216 diff 29360128)
     fallocate: Disk quota exceeded
(Please note that the above ouptut had to be modified a bit since
the number of characters in each line was much greater than the
72 characters.)

The test creates nr_fill files each of size 8k i.e, 2x4k(stored in fill_sz).
Now with 64k blocksize, 8k sized files occupy more than expected
sizes (i.e, 8k) due to internal fragmentation since 1 file
will occupy at least 1 block. Fix this by scaling the file size (fill_sz)
with the blocksize.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/btrfs/301 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 6b59749d..7547ff0e 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -23,7 +23,13 @@ subv=$SCRATCH_MNT/subv
 nested=$SCRATCH_MNT/subv/nested
 snap=$SCRATCH_MNT/snap
 nr_fill=512
-fill_sz=$((8 * 1024))
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+blksz=`_get_block_size $SCRATCH_MNT`
+_scratch_unmount
+fill_sz=$(( 2 * blksz ))
+
 total_fill=$(($nr_fill * $fill_sz))
 nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
 					grep nodesize | $AWK_PROG '{print $2}')
-- 
2.34.1


