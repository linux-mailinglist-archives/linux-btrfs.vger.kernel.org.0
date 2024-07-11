Return-Path: <linux-btrfs+bounces-6358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5018392DFFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 08:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068F11F23A6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 06:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBECF12E1FF;
	Thu, 11 Jul 2024 06:21:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CC12C460;
	Thu, 11 Jul 2024 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678903; cv=none; b=oZSU2zaxOGVYepsFnNUWHEKM9h1iIx+oJ5gSYw/Uu7FNGdHkBDXMrBZPR48yr2MMALBsu7EMt/15S2oPGQ0bAoFSQHmMRZh0xjU9hmD74ATPOiwMdPqk5sF1UI7hPGRfiDyhoLlua+pn6cBpFvsbyFNN27/w6PAQlmpveiNTFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678903; c=relaxed/simple;
	bh=1LEgqOe5KfDdCJh3Sj4LyTkVQox0PFDL4IcUQ3QXZto=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FrBiQZVCt4IcRT5F6epKjrzKHC/0hERlTZI+9chHiQY7TZnPQTHUFADlc06Ab/Uc3TI/K7BskU8tIK7HNAnloJ4G17iAw9B+GZCWo6FgbbuwIupzRUD4y5QbFgllLDkzck7QfTULQLXf54WmFpJP6Q1nJMzA0byGLQ36s99ltUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea929ea56so997400e87.0;
        Wed, 10 Jul 2024 23:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720678900; x=1721283700;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTsaLyduRenwpQeCuz06olwLlKipuwQKMIuDpNGXLkg=;
        b=hMyi3qhdC3xmxhSsfQY0Z12sT2gHNG/pdzZpK3GzCT9X9u+9YZEZPPLb+0UohpCJYe
         Q0eXZrWsX9XHapZnKXIEepnQLaiOJWxGcsLmcLFH2RzfUk23cVAfRgSjaqXIe5gceryC
         5bh5219nPpZ2CuTwlIOm/YzccZUaH4xyUYQx0PdLFoVzU6Znnc6R9f3YoRmAgSn7VZk5
         +5u4dVEytbMBCCueEwrgxJqlQnR13tkeOxl6nyLqzDAdZcKfbZqlVFP/q5cQdE63NUJA
         JUXJnNP1gSLnVXJXwV4BSxyIAC2hfFGIkuyBFWYmg2d0dOZvsBYwBsBOtRo2jYzxJ/zt
         mRyg==
X-Forwarded-Encrypted: i=1; AJvYcCX3jsso94eBqwxa9GQYNwp8ukBNXNOwJ5oXTvtqsN9iCU7dQXJaQ4ejTWpN4XXdBNZ1RzKQs22V66w/0ZDwg4xfxcXyO/kFeD0QpzdA
X-Gm-Message-State: AOJu0Yw68bQpGGrgJ7nAzTBqhkaTuhmbEqcNJH/R7hPqlLM6IugAZDV2
	ckV9NvD8EBNlVN0Liv+z6C3tMbZzCrQAjAHQN2aawa2LTlfMztBN
X-Google-Smtp-Source: AGHT+IFOHCJ20l64eq2xOm78/XcdEfLSJJFY5743CageKC4Ha5MlPpgZB0rJ1boCrIMruBqH1Joocw==
X-Received: by 2002:a05:6512:3e0c:b0:529:b718:8d00 with SMTP id 2adb3069b0e04-52eb9991e93mr7960042e87.8.1720678899328;
        Wed, 10 Jul 2024 23:21:39 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f73ce200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f73c:e200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff73bsm224815266b.101.2024.07.10.23.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:21:38 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 0/3] btrfs: more RAID stripe tree updates
Date: Thu, 11 Jul 2024 08:21:29 +0200
Message-Id: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOp5j2YC/3XMQQ6CMBCF4auQWTtmaGq0rryHYUHpABNNIVMkG
 tK7W9m7/F/yvg0Sq3CCa7WB8ipJpljCHCroxjYOjBJKgyFj6UwOvUVNC77m0C6c0HvXEVvXhZO
 HcpqVe3nv4L0pPUpaJv3s/lr/1r/UWiOhIboQhZ6pD7cHa+TncdIBmpzzF1VutA2tAAAA
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=jth@kernel.org;
 h=from:subject:message-id; bh=1LEgqOe5KfDdCJh3Sj4LyTkVQox0PFDL4IcUQ3QXZto=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaT1V37UPHZyXkOGwOXZDRwt5/hswzbemO285Xuf6aYDI
 bJdqR7TO0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAik/8wMjw5EzA9tfDz5Yc7
 WJKVHFdfv98v8ezKrJvHPk0vL9i/+HQPw2/WB10XtHcyZfhc7nq393eFQvPCfMeL/CZ/mOJOzbs
 FNA8A
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

Three further RST updates targeted for 6.11 (hopefully).

The first one is a reworked version of the scrub vs dev-replace deadlock
fix. It does have reviews from Josef and Qu but I'd love to head Filipe's
take on it.

The second one updates a stripe extent in case a write to a already
present logical address happens.

The third one correects assumptions in the delete code. My assumption was
that we are deleting a single stripe extent on each call to
btrfs_delete_stripe_extent(). But do_free_extent_accounting() passes in a
start address and range of bytes that is deleted, so we need to keep track
of how many bytes we already have deleted and update the loop accordingly.

---
Changes in v2:
- Add Qu's Reviewed-by on patch 2
- Add patch 3
- Link to v1: https://lore.kernel.org/r/20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org

---
Johannes Thumshirn (3):
      btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
      btrfs: replace stripe extents
      btrfs: update stripe_extent delete loop assumptions

 fs/btrfs/raid-stripe-tree.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c          | 28 ++++++++++++++---------
 2 files changed, 73 insertions(+), 11 deletions(-)
---
base-commit: 584df860cac6e35e364ada101ccd13495b954644
change-id: 20240709-b4-rst-updates-bb9c0e49cd5b

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


