Return-Path: <linux-btrfs+bounces-15724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961FCB14820
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 08:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8A45413CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 06:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61D24A043;
	Tue, 29 Jul 2025 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3iZy+8J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCE12AD2C;
	Tue, 29 Jul 2025 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770188; cv=none; b=qQNG565F7BYJtrmodHWFU6vnMg6XsHuEShZ3hFTEJmgW/OO7mj449H6YmUxnqSq84klKLqbQzqSazu1jDyc72AMLBal9VASbyPpQb31ytvXs6Kr7j6Du077eKxKtqRFD8+k5IDFoG+9jl6px8oeDe5z0bRXmVgV0CFIjEUNizy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770188; c=relaxed/simple;
	bh=lVQGM4Py6gkzAUAWBamVeYFyqzLO823M2nWqgHo8WlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=StHzT+ov0qP2iXwA+cDhnJbgOsVWQCAy+f/6byGeW55PuHBH92YTJtuEZn2NVyHJ8RD3V4btsLm1CdU+8XaYkOjBLDd13BBDwCP7j7oTllCsdyOZYUSt/dmngg2cZC6lGvCk6viNRQl+Ed90QUs2F89PW3l4vb0JtnZw8/4XbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3iZy+8J; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23ffdea3575so15300065ad.2;
        Mon, 28 Jul 2025 23:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753770186; x=1754374986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1SW0st0LLymo5q+14fRkkMt6JxEIJpg+GYxWE1pOgs=;
        b=D3iZy+8J5YDjTCheuTbcJlP7K93D80EIGm/XQCIUUjk2KmoU9kokd+ZDBOPLuto6na
         4mpm9EmrvtSEPMfCFYaUfi+NNVGhYY2lTByTjRMABt0jM6lGhKuPTyA8e2fxUiah4Q1W
         bgJkPtEsG93tmAUwiUW70+QbUyOrVEEbRErBkJlKylpCvf7FC/xFehatjkVRiHW1SxBT
         9fNfqf3NueD1qGgHZEVSuoVOVFUYClkW+0d16K72p+d66Xqru0NdsKdPNeQRbDdkhI9N
         HEu073bBwujdjrxMmdXfjzq+6Fg7QV7A28H95VXvbdFq7ezdm3VyhmEBd5F3m2vaM53L
         LH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753770186; x=1754374986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1SW0st0LLymo5q+14fRkkMt6JxEIJpg+GYxWE1pOgs=;
        b=ASO6dFTXUNq8DuqmgMYWpWkAMsbuiL7uGXUC45ATzZln3CuGxlNzgwDtzJr6dl4epl
         zm7RM/MexOta5kRy2bFHwSj3JTxD/0NonvpoUqDTaAx9KPLFkTCBgtJqHEjGNCy7bVu6
         382GRFczyTZTFnePq0q8hyE62XpwLtVpEpKNxmFG2QvErq9IcLpzWqHHMWetD+fHp55L
         +u7To0qzq2XcrCI+Oy+rsSAjQMQdfHeXTNfwhrz6YsW5FJPYCuGzxerAQ5zoYsIPjSAi
         gco1i3aj0UwMbgT+FJGJUVd9E+EqdsIR8FzeXgSxrQ2dVkKc9/gqkeNkBI0jmWFLF0z5
         dZ7A==
X-Gm-Message-State: AOJu0YxLbguIX+eKHq6rjqZVh+3TCMkw327WXCiPDEKT8qPjz97NOnpH
	bgy0U+SOMak95N5ZJM5Yb0pqB2xTmo+75Ujq0r9CLTxj7UMO1a1IX8ivGW/wUA==
X-Gm-Gg: ASbGncu6G4Hn0GvLeoA5oUUIjxPb3QHujBMiAxjD6q559AGlQTjtNU0I/g6Dh6/ua1j
	dKbAWw81suwyLR40aahRnsIXNs/XYJVJEjtqG1baaFHK7hiIEyyXz3aPFkL1F4rT3qOZAMaWvQm
	SUJmMkFYaKUvLRjFE0M1UcEXQ88rIf8MNVFfxr6lr41eZxWKZi37fG3jAKWUCZuF0g8+p5oG2qp
	0VxE01ToXM8tWNslGaRiauRG7G3CPOETsW2idXfoMYvNgbopHWE59p0YuDyFSFCCVcJQpBpjU9I
	/hjXAIuLqnesDAdRNHT5KQh6YM7C/itoa07VrpGg8V0udWQFMKdty5VHDyWGFs3IliNJn+NMxF/
	FnnoHDwp8vP35j4jGCk7mMUc=
X-Google-Smtp-Source: AGHT+IE0SMUPGkX2VuCRZbdCkAg2mvv++yPlEnPiUSEKL2d18BduIrGxFip0eK9mNHCxAvfarF6a5Q==
X-Received: by 2002:a17:902:d504:b0:240:3f3d:fd37 with SMTP id d9443c01a7336-2403f3dfffemr63957525ad.27.1753770185678;
        Mon, 28 Jul 2025 23:23:05 -0700 (PDT)
Received: from citest-1.. ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc1adcd24sm65941195ad.167.2025.07.28.23.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:23:05 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH 0/7] btrfs: Misc test fixes for large block/node sizes
Date: Tue, 29 Jul 2025 06:21:43 +0000
Message-Id: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the btrfs and generic tests are written with 4k block/node size in mind.
This patch fixes some of those tests to be scalable with other block/node sizes too.
We caught this bugs while running the auto group tests on btrfs with large
block/node sizes.

Nirjhar Roy (IBM) (7):
  common/filter: Add a helper function to filter offsets and sizes
  common/btrfs: Add a helper function to get the nodesize
  btrfs/137: Make this compatible with all block sizes
  btrfs/200: Make this test scale with the block size
  generic/563: Increase the write tolerance to 6% for larger nodesize
  btrfs/301: Make this test compatible with all block sizes.
  generic/274: Make the test compatible with all blocksizes.

 common/btrfs        |   9 +++
 common/filter       |  14 +++++
 tests/btrfs/137     | 135 +++++++++++++++++++++++++++++---------------
 tests/btrfs/137.out |  59 ++-----------------
 tests/btrfs/200     |  24 +++++---
 tests/btrfs/200.out |   8 +--
 tests/btrfs/301     |   8 ++-
 tests/generic/274   |  21 +++----
 tests/generic/563   |  17 +++++-
 9 files changed, 171 insertions(+), 124 deletions(-)

--
2.34.1


