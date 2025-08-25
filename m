Return-Path: <linux-btrfs+bounces-16321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346CEB33621
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 08:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E0B480F92
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 06:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA9627A11A;
	Mon, 25 Aug 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObwGjThy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629926C3BF;
	Mon, 25 Aug 2025 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101874; cv=none; b=o+wc3zckB2qdn/aQKWUJJS5EJKLXwFrcKGle1A3bsjrFPl8yerCUKWlXDduUm/6C6lYu7cQGrihHeQOJNF7lpL7n8m8PxhENmb8ivUjEDCGoISCwtLoA4kA9ZwP0aSdPdvvd/KxCSbC6EanIM2KOaamWTxYMGRXz+GaTOF/cgG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101874; c=relaxed/simple;
	bh=l/1ihSBpEDDyzTmebmhMKCXwOwW8+uaBpE4j9qiaZqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFaZqXgPliXvHOqPbZunEUoQfIuF/S0C4JBc9lFu5ZByH9qoZbfzVehr+4KtFJJJTNMgS8uS5ePF2qjJi7XM2uGZw7zz0+gIbeAlA3jpoTO/0GWVzdZCpuiV5isGrW8Z+qFF/qDEdtcMDQdHc8RbvnfkEIy4P2mXGQ9NrcKmmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObwGjThy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24646202152so25225465ad.0;
        Sun, 24 Aug 2025 23:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756101871; x=1756706671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oznepEvzbh9Ljf+2tgPLSfmCwYY1QWgnWo/ogGyLSwc=;
        b=ObwGjThya1bldCBhGVoFbv2r3sS9mSCn84vMrfrjxGp+4UfUdjHBRSNSLa46j0mokO
         LOYFDti4MK4kI8S7V1xwzrzpixToj2FEtGN2LsQO4015/g4dgwz6xTyVYBR2O0hD7ZV3
         q3FnN6aG5+Z2F4Owr4PwsqD/PQ/t/ggNhgDbTh+yPv7I6CMaasbF0Omoy+WfCDaBdkUW
         gSN9EbwlrqOV/g0R7LsQCXfOPSjoPqSSokhXe8+OhZu6+zQ/GpEu0n6rA05wimvrhhWr
         e2x+l8q04z2SAEJDG1zd+B3bkE9dCupcod6k8hKjYJ3kZ/wD7UgjeengEq8j9hIbUMmb
         6aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756101871; x=1756706671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oznepEvzbh9Ljf+2tgPLSfmCwYY1QWgnWo/ogGyLSwc=;
        b=W/5K3tTq341UddryaNsgut/1klejJFjWJjJnGWpN0wUVyDXPEgw/BhDB+AdoHCePs8
         eFniufsu7EQTXQWKBP1RqizNnI4ZbE4TGFUxRWfrKO6JNwInOrIFQPJQcpAqnJm5qlmz
         1HQneTpeNjFuvfUGK1tY0W9SlUMC1sBCZmlX9/A7piA/ziZIEsQspOQ/ZR31Gultb5w4
         UGpAH/5ALrU4GdSUc35lPFNb2JM42vOCgQQsXxrgkUg7ty4nRnoD/vLxVfQ8gu5daVyW
         tWuvXIBlKeY6LjVkfF77fcKjllLSXTZfYJI4gdXiBXyFEm7uhbfWzYv4jituvYDO9/fX
         HzNg==
X-Gm-Message-State: AOJu0YwByj0ScstpoHNLC2CwmZr8kY5oxqvVeLUn6In+iEDDrKxl4iGz
	cxzqtvr/N8sPL+ib6wQCs8JzSuaEC2ZK+dNkDYJAhfG9z9wMwGFpBipVDwHe4g==
X-Gm-Gg: ASbGncsok+iHcL8RJv4VKa6B8Sa/sJXyS16IVnqzI5Wv30SVvEEMIXAS4wXLn5aWFeN
	g4Kfj2WBZYoXvXIQM8mtcEINTw65XQIypMnvBgeMg3xDDVXoH4jcqDdPHtHFScfy5znUJs/vodG
	fM226CfD5BTX1HBAbvoCE63CrIf1oy2bGc19Owo8gY5UprmmAHDOxuohgheqDC68vvvI3FeEIrw
	MKwZjqeQGCkoGdBY7q8muhpjNRPMalJ12DOMr4Bzv8i5AhFFcN08iDqwmLJXLUh8alaiTx79SNv
	wIj+snP8u4vBOKF62yY1FP2vjwNwTkK9ufWtKa6jnmpdnGgX2/veW0AA//Z0xc0FmuxTyaixsXu
	ishnizsC+D7OTWrJZq0QmbB/btQ==
X-Google-Smtp-Source: AGHT+IG3kz7Vdbjv48cl5rhGg2L/baoe35q/1+cNBOQnEwbAJOjiT7HWCZqEbPBFkkno+Jht+byKQg==
X-Received: by 2002:a17:902:f689:b0:246:d98e:64e with SMTP id d9443c01a7336-246d98e0aa8mr29372435ad.36.1756101870812;
        Sun, 24 Aug 2025 23:04:30 -0700 (PDT)
Received: from citest-1.. ([49.207.214.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a59b1sm58202485ad.42.2025.08.24.23.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:04:30 -0700 (PDT)
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
Subject: [PATCH v4 1/4] btrfs/301: Make the test compatible with all the supported block sizes
Date: Mon, 25 Aug 2025 06:04:08 +0000
Message-Id: <6b1f91d25b925c19ec01845fa9bb8f6a58c29fd1.1756101620.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756101620.git.nirjhar.roy.lists@gmail.com>
References: <cover.1756101620.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With large block sizes like 64k the test failed with the
following logs:

     QA output created by 301
     basic accounting
    +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
    +subvol 256 mismatched usage 168165376 vs 138805248 (expected data 138412032 expected meta 393216 diff 29360128)
    +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
    +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
     fallocate: Disk quota exceeded

The test creates nr_fill files each of size 8k. Now with 64k
block size, 8k sized files occupy more than the expected sizes (i.e, 8k)
due to internal fragmentation, since 1 file will occupy at least 1
fsblock. Fix this by making the file size 64k, which is aligned
with all the supported block sizes.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/btrfs/301 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 6b59749d..be346f52 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -23,7 +23,7 @@ subv=$SCRATCH_MNT/subv
 nested=$SCRATCH_MNT/subv/nested
 snap=$SCRATCH_MNT/snap
 nr_fill=512
-fill_sz=$((8 * 1024))
+fill_sz=$((64 * 1024))
 total_fill=$(($nr_fill * $fill_sz))
 nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
 					grep nodesize | $AWK_PROG '{print $2}')
-- 
2.34.1


