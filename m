Return-Path: <linux-btrfs+bounces-9096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53979ACB23
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 15:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52AA3B214DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D80A1ADFF7;
	Wed, 23 Oct 2024 13:25:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845AC1ABEA7
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689934; cv=none; b=XVXO4HUYzqcKjz9RlrMwJ9Q+VFn294KtuzDDdSnXGr9A0AAb41j+67lUVWzzICtlmUW+fOFr8uBHYRMl7xuqDybKzZjTn+WR+A3RfWHXh3VDDSh7R1RxRplELQnc85Ghi0PwyvcyT3lqBoH9yoVI9usWn1vsTo7/hFghbdpB+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689934; c=relaxed/simple;
	bh=xPWOo6FP+ffH8YAt+0UbdH07FS3ygLbZIFlK2Mhnrf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4lSy+0nhQlXwiuLWBdhiCDDwUYeGH7mU5eC24ZdhWIXiCHNg7J6dKiJyM57E0slqh+JofcPXNL4UyEKXrrrj3qvshHxJyL1zgjtSzV4NvxO4AzUpYkxtfSS1eiVgkYP1EV8Md0/ZmJtey0azzA78H7Pfnt9qrD8UgrjbbHphMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso5408080f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 06:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729689931; x=1730294731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xg9gJ0USTP5zQV606VjuAKMcL1cVJcgrzvn+NmgkAWQ=;
        b=aaIR5qAhzFUDAxN/kUn8rE+mbVg7EhofkQgjYyBagVpFeq37Tsvp84DXUeeH4HXt24
         6h16781zR0jdFflVLEDR/89cDC0AxX/n3e7vmpUYCf4x/L/jn3ABp9cbyf6roWe4csMP
         GCW5BQkgNE+rBaiDymDcv+vtY5itr1ygB6DH5pyeckqmSvDdjwFK5baZqgfXQPEd38C8
         xrFay25puUe7CRIPf7v8yIfh124udq2fI5gq6NA0EY1XKx6UA0dnzh15yjQNdWXJ4P1M
         Wu+uU9wn+gPx32V4brxvhItp0YP9K23avauJjBnoOJ0SB1VAH6d6kId8XVYGrP+VryDv
         RuoQ==
X-Gm-Message-State: AOJu0YzGK+kadcD3Vm0GO8dtAJ89zkk4gM5eosZiBIR5IhnN6Whx+O9g
	wcg5EU4k3rILhUM+UZEqV1BeFEYX4B7IQAIuwJ5wVeh9eBPhVa0orV1rjg==
X-Google-Smtp-Source: AGHT+IFHilaYUELJAaJ6TN8qwnCCTShK7TqrVJv9UiSYaRUA6lXvq11cA214Z9AF7SqlZGnAMecylQ==
X-Received: by 2002:adf:9b8c:0:b0:37d:4894:6895 with SMTP id ffacd0b85a97d-37efcf101afmr1561025f8f.15.1729689930455;
        Wed, 23 Oct 2024 06:25:30 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c1e387sm16169935e9.41.2024.10.23.06.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:25:28 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v5 0/2] implement truncation for RAID stripe-extents
Date: Wed, 23 Oct 2024 15:25:16 +0200
Message-ID: <20241023132518.19830-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement truncation of RAID stripe-tree entries and add selftests for these
two edge cases of deletion to the RAID stripe-tree selftests.

Changes to v4:
- Use btrfs_set_item_key_save() instead of duplicate item (Filipe)
- Add forgotten btrfs_put_bioc() in selftests (Filipe)

Link to v4:
https://lore.kernel.org/linux-btrfs/20241017090411.25336-1-jth@kernel.org

Changes to v3:
- Use btrfs_duplicate_item() (Filipe)
- User key.offset = 0 in btrfs_search_slot() so we can find "front" delete
Link to v3:
https://lore.kernel.org/linux-btrfs/20241009153032.23336-1-jth@kernel.org

Changes to v2:
- Correctly adjust the btree keys and insert new items instead (Filipe)
- Add selftests

Link to v2:
https://lore.kernel.org/linux-btrfs/20240911095206.31060-1-jth@kernel.org


Johannes Thumshirn (2):
  btrfs: implement partial deletion of RAID stripe extents
  btrfs: implement self-tests for partial RAID srtipe-tree delete

 fs/btrfs/raid-stripe-tree.c             |  81 ++++++++-
 fs/btrfs/tests/raid-stripe-tree-tests.c | 224 ++++++++++++++++++++++++
 2 files changed, 298 insertions(+), 7 deletions(-)

-- 
2.43.0


