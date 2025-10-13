Return-Path: <linux-btrfs+bounces-17658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B89C1BD179B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 07:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D41A74E8DB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 05:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54952DC76E;
	Mon, 13 Oct 2025 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAUBrutS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67274296BDC
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334033; cv=none; b=NvvxCFXZTksJlOR7g0H/b/B09oS6iV0PdoVgkM7pBhRBC0apOnWPdMVFj/otYc9bheHJJ9GQ5apsQYE8IKCvZNZB1Y+TC7Gf8IEa23Pr0TehkfOcB4WOgqCHkCmqZ1xcV+/DRBHwQTbUJn3+Py20djjHVX49Pe9+fn/t8oK8WjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334033; c=relaxed/simple;
	bh=cxgyZxSPFqdEV+bzon1DlQodKZF6jClXPN0aaxXDbLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b+t+HDlf40p03x0U3z5nUU6X9912y2Y+qMf2KCX5Wm2bywqOJO2UKUyuMFOCgCYNeXsPqMq5tDqxcTQMIVPeqZJXxz9RQiZOAQI4oHWgD88mEG+UvnOgJfgXNuCrf1rMXUvdXTCMhnemFUE2WFq/ChEK6CWomMkRjfGhkgoTvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAUBrutS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso3505564a91.0
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 22:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334031; x=1760938831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEba+0gCaQrfxoNni+oDcfAKt/GiRqPhL9l/uPdmkbE=;
        b=kAUBrutSXxE1vqku0D5HjoZBwTWrtUgqv2VlFswYSRNRaGm38TqDE+hL3pPV4UKflG
         DS0VDyu/mT5T6gmyj1ufwHPdE3CuLqieCzbmc/aP/QQt6aZnLOF8TJ6ln2DPBYkScTgQ
         iKNxWpdFFGN8FOw6kLVS5N2r3/jiHYhUWKoc3Y3tj/38U+x4CdF2DBlk2rloAh84iA5t
         gSUohTGXrmJO8yo7K7wb/yaeyMeQShGCryrHVlwZD+0lbeOvVXAI4XydyD2+52rT7J7T
         J1wt2bh71aEltNo+eGdFJviZjQwGh8yvoD0C1viZyhZOUOnQssFW0GxUx3Aa20chsPfW
         0+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334031; x=1760938831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEba+0gCaQrfxoNni+oDcfAKt/GiRqPhL9l/uPdmkbE=;
        b=FHfIBZ7oQ/1PXmDuUPUkAyuD2tphNHR+Upcg9pAvbMkUoSa9BsEjMVV6qkJq6ukxTF
         oY65UFJpleWT9sK6MuMQlBe/nNRnSNsb1s+TuayLTyo86XDCydAsdkr+8KAUnjyhx/FU
         5Y8V4fqHzggoN72GH9mAqT03bV9Sc6/VuGtWGcxTxWh4z9zXnAx4lln0uW/32PVUV2b3
         bSTQvr4XgtMR5WOg+wWyb8YZvhpTzobOdv2a/F28eqksCuVtvgwu+4HAdx04dBQI+TO+
         /navBLWeW16KXSKO+NaG/bzWOiNin9XYWJn+JTTTZvgwfXoMyx4Zag7WIbdiBEFcicyx
         bc5g==
X-Gm-Message-State: AOJu0YzlqFnsjppf0OiDA1AXBR0r5zBraOofHIEIyKaZN/dxNyKP65PE
	oE+0P7zEEqs7SrfxQvI2WSM5wghFWkI3oabgnNzT/S2NVmhfV1bmep92
X-Gm-Gg: ASbGncvN3HOtuV0Apfs/kV+h5JApbe3uYGfWmek4tA+DlhmhhPslNJoUcBk7m17zcuJ
	erfkrveu7xYdiELf1prAMk9q1STHhCDt2tF/LwJsHYNcXSxdx9I21zybkP8nnqdP1DCJV5TWXV8
	KT4P/ENO05/US5QebxyHhGxb3SthhYAgycmHnJ76E8k4pX85DYJwzQF8gc7Lc66id1n0vI/nViC
	mHnCavDrvIzEFUn5yc3GKptA1272ULZIiv+2Hla9Q1rwcKkTOlf+qZpolHSPn4desR5PPitWCgA
	FkY+QiPsdfLUfTBpnpon5YlxONa88XIKdo5rKm2ChqXoYYAIQtK7QqvCFge4PzpbdG5Oz01y5pF
	al5JhieVxCpF8voqHt03A6c7eh2fy9Vxw8oiZxE8XbnnOdQ==
X-Google-Smtp-Source: AGHT+IEXNzExHsC4hdSOyEJbtuOn/55j31Q+bCvxghBnsMs8nP3dPrVEW6BgdAucRb6FWKr6XCowbQ==
X-Received: by 2002:a17:90b:1b05:b0:32e:7270:94a0 with SMTP id 98e67ed59e1d1-33b513990c7mr29721239a91.33.1760334030723;
        Sun, 12 Oct 2025 22:40:30 -0700 (PDT)
Received: from citest-1.. ([49.207.231.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52968581sm7014726a91.4.2025.10.12.22.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:40:30 -0700 (PDT)
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
Subject: [PATCH v2 0/3] btrfs: More test fixes for large block/node sizes
Date: Mon, 13 Oct 2025 05:39:41 +0000
Message-Id: <cover.1760332925.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More btrfs test fixes. These tests were ran with 64k block size and they failed.
Individual patches have the details. A previous patch series with some other
test fixes was posted[1].

[v1] -> v2
1. Removed the patch for generic/371 (will send it in a separate series)
2. Added RB by Filipe in generic/562
3. Added RBs by Filipe and Zorro in btrfs/200
4. For btrfs/290 - Commit message changes and changing "196608" and "65536" to
   "192k" and "64k" respectively in the test script to make it more readable
   (Suggested by Filipe).

[1] https://lore.kernel.org/all/cover.1756101620.git.nirjhar.roy.lists@gmail.com/
[v1] https://lore.kernel.org/all/cover.1758036285.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (3):
  generic/562: Make test compatible with block sizes till 64k
  btrfs/200: Make the test compatible with all supported block sizes
  btrfs/290: Make the test compatible with all supported block sizes

 tests/btrfs/200     |  8 ++++----
 tests/btrfs/200.out |  8 ++++----
 tests/btrfs/290     | 16 ++++++++--------
 tests/generic/562   |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)

--
2.34.1


