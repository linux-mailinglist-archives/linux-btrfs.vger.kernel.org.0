Return-Path: <linux-btrfs+bounces-17659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C1CBD179E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 07:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB173B2D06
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 05:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DD22DC774;
	Mon, 13 Oct 2025 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeGDbGA2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F18B2DC352
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334052; cv=none; b=DoA1iGJalg6BuEbOMtDaAS1dq+H3Dp6z1MqZKA5oPFSu2GtjEZn+83yjbe6Qz1WUnviSN/JTPlr7HnD4RchkKPckGvAzCJ3jnVjNIiMsfiK3NY75wN4nVbxR8DcCEXIOE/H3HIXucdlIk8ruuQamkay1DeUxdR4IQ8LKQm47d68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334052; c=relaxed/simple;
	bh=A4P2QZNpcdYK5m4BlZzRsL7WQu8Ep97HMFJ8GP+z6BU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GfrIszk0fZ4VLBhQ7noGmafqu6ObqWwbx+vhpRLHEMf0/Jzrb4u6U4vv3lwinfrLIsTf1q0ZAQCc/De3ssvb75rBcW7slvJfJnV5OtjdNgbSqkX5UvJgdHkhZeZGeQfUklhncR8Tgu6R4Psd/54PiN/e6NB2Bv/plKy9X1tzAXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeGDbGA2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2698e4795ebso38257865ad.0
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334050; x=1760938850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDI7CENxna34nHIzC2g7WI3cwL+ASU0TruZRiZNSx6E=;
        b=PeGDbGA211r6fJNR8+Xmm0umK2nzSNIn2h6lLEpVwUd0m+oj2Y5YipbACV2CS3l8iO
         ZO1TCxlisRp5daS+SDufyHyd87iRkPE5irSwTMS6fcvovZ/doMG3d3yxI3LsK7zysJ7Y
         LP7oK6xlLVYosM5x1bpEdJfxffPpwxd+CIOhToQymajZoRHIzZq0MiyWIBx18p0629UV
         B4lxiEoD+vl4vmVMBuVrrBIQaIErSs2N9ugTNuYLBt7EVOu8ArqdYrXf2sbYDnUWMxfj
         kK5Yn+67Lwjh8p/cpp2bGOKamTQyXXP1i9cpu15Gi3gwmSP+rrclubgFsfdSNG7ur8AT
         hxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334050; x=1760938850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDI7CENxna34nHIzC2g7WI3cwL+ASU0TruZRiZNSx6E=;
        b=aOPd1a1lUthsX3kMDNm1lVQg0iAaAZ7eQGAGgE2zQWA2unO/WcWav7Sq50M9R0ZoPr
         M7fpraOaLNfNI7ccL0OF7oytdENFmtWsLeK/k7e4L/l0vz0S2skQREwYHonZNfzuOSln
         WIbhEXXvvmdL1lbfUZb0pZvMqa8gNUNbwTGgDyWPvm8l87XllXDyy/3Xl9TTT3Dwoj9m
         dT92/F4eUWOdy6TCtF8ycpqUXPdfzFD5Dmd8BYD4dY4oOsxVGhknU/OTSzf6Ks49zgwF
         vB8Ohe/kUojJ9bt0t+QVGVOBZo2v05NyS7Zdl0fxWw/4NHXulvPnL6qy+DEtCmvhicmK
         uZTQ==
X-Gm-Message-State: AOJu0Yz/jomIyngYjdEfSmemXt9O/vkxh1SAtRDCkXtyS5YVse/qtxS2
	b457lCp1IDZ1Eo+crr4ge/RZ2jGyMzeuUSSMBtbYuJh4f3xJk71vFSmFOZMmDKSa
X-Gm-Gg: ASbGncuo5+kweMnY2dNADRsj8VYpYS2LzzzBAP/vThFJgkSuJbqmouarl7zq+QerbwB
	6nnbfPPCFf7DQWKgWa2DUxpac7NLXLWwuSrpHajrTkslKoXqeu3VoDHNaAxtWph7h3l92fDsgrL
	CwLtSAppIjRbbaI2ORTKX8n1j3qMWQp/bs/ZVgjhEyylV+fZwq1idfuYvpAcZKrtNV6MtQMDjKQ
	rTX5PMoCMsC2bit7FCjETc7j8bRt+GoAbPXa+UpPKSJYaS20GqXP13eQ4lqt3zbjGVCUwMnHqWK
	IT97FGyk798WEm5BAwmwOyZnlXdTZMU4XKX4hR8vfq8L9nhOgDdDG8zIMRwrz30S5WjlwGctQ7M
	8j0j7mbx9bN2sxtN6+yPV1z9pR8I3TE5kzYCoQXMa2mGZLt0JBCYig8/9L5HG+0nMVgU=
X-Google-Smtp-Source: AGHT+IEPHtioewCXbVir9Ed9ncnWlyzNiiJ+40tGNufoNOTuBElfG1MvarqVd0JcdV5YT9KHccAnYw==
X-Received: by 2002:a17:903:1a87:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2902737495amr271690195ad.19.1760334050258;
        Sun, 12 Oct 2025 22:40:50 -0700 (PDT)
Received: from citest-1.. ([49.207.231.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52968581sm7014726a91.4.2025.10.12.22.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:40:49 -0700 (PDT)
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
Subject: [PATCH v2 1/3] generic/562: Make test compatible with block sizes till 64k
Date: Mon, 13 Oct 2025 05:39:42 +0000
Message-Id: <1371a509f56cb8b9e2dd5434cac91e5d6a5bda36.1760332925.git.nirjhar.roy.lists@gmail.com>
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

This test fails with 64k sector size in btrfs. The reason for
this is the need for additional space because of COW. When
the reflink/clone of file bar into file foo is done, there
is no additional space left for COW - the reason is that the
metadata space usage is much higher with 64k node size.
In order to verify this, I instrumented the test script and
disabled COW for file foo and bar and the test passes in 64k
(and runs faster too).

With 64k sector and node size (COW enabled)
After pwriting foo and bar and before filling up the fs
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      512M  324M  3.0M 100% /mnt1/scratch
After filling up the fs
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      512M  441M  3.0M 100% /mnt1/scratch

With 64k sector and node size (COW disabled)
After pwriting foo and bar and before filling up the fs
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      512M  224M  231M  50% /mnt1/scratch
After filling up the fs
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      512M  424M   31M  94% /mnt1/scratch

As we can see, with COW, the fs is completely full after
filling up the fs but with COW disabled, we have some
space left.

Fix this by increasing the fs size to 590M so that even with
64k node size and COW enabled, reflink has enough space to
continue.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/562 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/562 b/tests/generic/562
index 03a66ff2..b9562730 100755
--- a/tests/generic/562
+++ b/tests/generic/562
@@ -22,7 +22,7 @@ _require_scratch_reflink
 _require_test_program "punch-alternating"
 _require_xfs_io_command "fpunch"
 
-_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
+_scratch_mkfs_sized $((590 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
 file_size=$(( 200 * 1024 * 1024 )) # 200Mb
-- 
2.34.1


