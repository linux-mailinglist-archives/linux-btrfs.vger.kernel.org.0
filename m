Return-Path: <linux-btrfs+bounces-16171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FBEB2D5E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 10:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF75A03985
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387C62D8790;
	Wed, 20 Aug 2025 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FosZehap"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54C2C11ED;
	Wed, 20 Aug 2025 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677731; cv=none; b=tBgfZD1CTNJ5D/oRMJFC90NmZtghxDU/G2pG4n1WjX2hfSYoZ+l8NyUe80Ipfur6IUPM2byXfducG7lyB+QWowfQKiwrhn/iimByXCcd4fCOxMXTarPn+ZZ/mDLfWdTF16fhtJ0BT7OPBykK/MxlFZgcCcMIRRd4ZPz44LuJy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677731; c=relaxed/simple;
	bh=uLiJFhino7uMU63jntXaJR106kZM7Ai2qFFQGfPF60c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMmykGvJx0pIvxM4EPHtLjcQFixCmpwxoJ0VVwwRyOUgeC3it1nTB46B9fauzGLBYbqj+qi11lmioiB8fgIFfpuR4towmKEyFZYvPVEhbOs/kjWYp+B8eFWIEnCNMhhjjPSL0VApT4H9emb9y7FN+Ys0oeZkzFqjmFuQXVX4Znw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FosZehap; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24457f5b692so64811695ad.0;
        Wed, 20 Aug 2025 01:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755677729; x=1756282529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8LaDV3bTRGf4guLR53ihmopdxL+cgez5Nxow5DR+Lo=;
        b=FosZehapO6dDfAZ8r3kF+3uMwEtSU2qirrfgPE0UvjqO+gz6hPt08jmhHkfPsQaHqv
         6Lw8dszB30j/6B2nk3AmuZrw/yLZhcIerRXe8gyQ/qAhBgdRP0oBpqImDINbIakl5veR
         CW7NTl0rk5txIIhgluPUSgo0npe0OGsV+sLZNOG5pV1q1ewCrixcwf5M46K7jHUkUZw4
         0RdLwNbs8ZFBJldobfDbh9v09tzb4t6G7h7XlGZlGBJ0eIxpVXabNuL78xbWCr2P6BL/
         khrqFSHHPX2CT74v+1+jptHy9ScdKZFhL44pXXseRSgcSxtk7bCiGH8lmj6nqSkXFNjH
         sReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677729; x=1756282529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8LaDV3bTRGf4guLR53ihmopdxL+cgez5Nxow5DR+Lo=;
        b=q6lduCTuznUBK9zrbTm1CCP1IbMTyZCyThUEagKILjL9eB7xfWtKuC0k5a9WrFFzo5
         aupY0SwTfihiolj5KlwoQCcncd5XP1z2SFDL/zwl8/LBzZjqVxErDQwfzPpYyIsR2uZn
         Du5GeOM7ljoAHxwl+e/3poygQQBxkinYYWAv8FEeY4B2atuOansU5nUqbobYaowpcjzW
         KwvK4omfg75lZAaJckGmvbxabEysZKv2l/McjqOU2tfLsAhfg4MR/g/ZpHtYF3d+SFbM
         R0pPRu0unFq3uXqecnL4KEi/beKerDl9F4GatCfthimuX+uBbxEs3RVd1cdrHm0Ud7AU
         qUmQ==
X-Gm-Message-State: AOJu0Yxnss+7f8vnXiLs2WcqaAGfOPh4ND9joW1bBoAUkE3a9EXLqFDl
	EA27Zryiabq/vIIatY+zZdBydhZSg/d0L1RZKn/KlPVlsZz+afuMXA8oAn0pMA==
X-Gm-Gg: ASbGnct8Y3FqgJyb7HCXqaIwTA5a4EOPwlutqGTm+Tz8xi7w+FL0KbvoMLtPg+df+Qj
	88tjmpVTTY/TQlZ/lAtWETAMn/FZWUlJ+GYR577G4Gb1lCOoA0mxtrSnoBjG5kNvU8TwdyZSf5g
	b2jn0wA0tTmboiS8iRjhhYj6sDfEK3EZeMd5DB/k79dM9signOJg0q3h5ApI/jofGRt+QGRvdhD
	tfQ2WEH+R6w3LA5Nm3Pmpna13neHFS8OKTqsrsFedxyZw4pmSs+YdeGNrWzzHalv98xv0I1Yb/y
	rPbniwTn55h4EJiEwbxQGpT7F9duus9V3F0XMINpoK/AFFGnuroKDcjG1fYawz2akc1Uod0b/U2
	qjhZxpAesCp9VTd4YwFX+FIHeTg==
X-Google-Smtp-Source: AGHT+IHvtyqNzx1HOK32WqAL3Fj+mCylI6s9iO2O1+D4MlL/x7M3kT2/3+XOvzVPqgYuL0MaThYvqw==
X-Received: by 2002:a17:902:f550:b0:240:52c8:2556 with SMTP id d9443c01a7336-245ef24a172mr29316475ad.39.1755677728894;
        Wed, 20 Aug 2025 01:15:28 -0700 (PDT)
Received: from citest-1.. ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed517beesm18848935ad.134.2025.08.20.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:15:28 -0700 (PDT)
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
Subject: [PATCH v3 0/4] btrfs: Misc test fixes for large block/node sizes
Date: Wed, 20 Aug 2025 08:15:03 +0000
Message-Id: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the btrfs and generic tests are written with 4k block/node size in mind.
This patch fixes some of those tests to be compatible with other block/node sizes too.
We caught these bugs while running the auto group tests on btrfs with large
block/node sizes.

[v2] -> v3
1. Added RBs by Qu Wenruo in btrfs/{301, 137}
2. Updated the commit message of generic/563 with a more detailed explanation
   by Qu Wenrou.
3. Reverted by block size from 64k to 4k while filling the filesystem with dd
   for test generic/274.

[v1] -> [v2]:
1. Removed the patch for btrfs/200 of [v1] - need more analysis on this.
2. Removed the first 2 patches of [v1] which introduced 2 new helper functions
3. btrfs/{137,301} and generic/274 - Instead of scaling the test dynamically
   based on the underlying disk block size, I have hardcoded the pwrite blocksizes
   and offsets to 64k which is aligned to all underlying fs block sizes <= 64.
4. For generic/563 - Doubled the iosize instead of btrfs specific hack to cover
   for btrfs write ranges.
5. Updated the commit messages

[v1] - https://lore.kernel.org/all/cover.1753769382.git.nirjhar.roy.lists@gmail.com/
[v2] - https://lore.kernel.org/all/cover.1755604735.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (4):
  btrfs/301: Make the test compatible with all the supported block sizes
  generic/274: Make the pwrite block sizes and offsets to 64k
  btrfs/137: Make this test compatible with all supported block sizes
  generic/563: Increase the iosize to to cover for btrfs

 tests/btrfs/137     | 11 ++++----
 tests/btrfs/137.out | 66 ++++++++++++++++++++++-----------------------
 tests/btrfs/301     |  2 +-
 tests/generic/274   |  8 +++---
 tests/generic/563   |  2 +-
 5 files changed, 45 insertions(+), 44 deletions(-)

--
2.34.1


