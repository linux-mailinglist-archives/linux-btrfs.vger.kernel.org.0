Return-Path: <linux-btrfs+bounces-3726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB88900E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 14:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80990B23750
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942EE81AD0;
	Thu, 28 Mar 2024 13:56:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8E14294;
	Thu, 28 Mar 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634198; cv=none; b=TwHriEoWTqoyvpCm7PNqHzNyq1te9+aU7fTXxpBZcYxuUi9V2F2fOW4y6BP3XJ2wte0gchX9CA6w9ynxwoyZnK/tVvmppZjYgRDqPOlXKtHWGc8RQvB3G/fL74I8xI5IJP7p9hzLNrDZvmXlO0tSVILAMAi/Iu5Rgy7eHTTmKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634198; c=relaxed/simple;
	bh=F5hUSk85hnxWbxGk/O656hneYPZj9/33L9DzTGsry3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UrBcMSaRT/Pq7g49YujZSywrVItOnzPggxpa2bRRAa3RXggcY6ce9oxYYXswdz8dunGfBWGTO6Kg36YGZOd4XVBeEKxxi7DjYZ8fmbUi4Y/gJQCgXzjm4wZhw6ocTsblku8UJeseVl+mDbspi94YcSPCI3mlPTNiZLHXg1uJQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4149529f410so9648775e9.3;
        Thu, 28 Mar 2024 06:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634195; x=1712238995;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWUG/M8h4ce1tDofK2qig9Jq+3pVhe68X67Iu+wugeA=;
        b=SubecfH23bSCw/EMnXNYJ0rZwTjeWVtBG/RMwPurqi0tv2V8W70JFbRaCObgxsox1E
         t4i5INeY6gT0OSJKhSc/jHWmUgeBrKMUb9K+HZisifoSaSmH0dOxIEFVpW9ZKB3DmF2G
         nX/ALqVH8QH34SGQdK2fWPFjO8SUlOk2wxKGe2kK7kBF8AnnqMLN8l2Cjo0FVWdfVwGN
         +tP+BrFNDz/GoEfZBa1IjFUblYCO0QCtegFaZNhuCDMVkB62oHpKW4jNYdpwjm4a9UWW
         /yVA+NFXm6zcMC6C91fvwIeu8I1Axq8Vm0WXhKFo9v+9PYcQP2BjZuUQ9TMZf1XpUThC
         E2xg==
X-Forwarded-Encrypted: i=1; AJvYcCUVeyaS/T3uvDOgD7sQdljvnSz96PpQvY89x/aevBed5kYRmumK6YpHOdto+Q/faRXhqHydXc1KUAIEwHP37BGJrj+mi/fi0NnKhomL
X-Gm-Message-State: AOJu0Yzw1/0OZygaCET3xBhfO/qgZnYn599hvrUZVVu8gLMtxtMPFgJS
	qWI4V1g3YLK+MgtoFFxdJjSa3VpJihs6N85yPaIM/AEiyvLX081C
X-Google-Smtp-Source: AGHT+IFG9VTrEkGatGcuErLL/Zu9020iTvJwG60clqoohGTbcEYIvpwKwg2mzTEKV4jF2SpmfJzMBg==
X-Received: by 2002:a05:600c:19c6:b0:414:854a:8167 with SMTP id u6-20020a05600c19c600b00414854a8167mr3249020wmq.18.1711634194615;
        Thu, 28 Mar 2024 06:56:34 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b004148a5e3188sm5519570wms.25.2024.03.28.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:56:34 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH RFC 0/3] btrfs: zoned: reclaim block-groups more
 aggressively
Date: Thu, 28 Mar 2024 14:56:30 +0100
Message-Id: <20240328-hans-v1-0-4cd558959407@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA53BWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMLXaBgsa5RsmWqcZJJopllqoUSUGlBUWpaZgXYmGilIDdnhQDHEGc
 PpdjaWgC6P5Z1YQAAAA==
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans Holmberg <Hans.Holmberg@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 hch@lst.de, Damien LeMoal <dlemoal@kernel.org>, Boris Burkov <boris@bur.io>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

Recently we had reports internally that zoned btrfs can get to -ENOSPC
prematurely, because we're running out of allocatable zones on the drive.

But we would have enough space left, if we would reclaim more aggressively.

The following fio-job is an example how to trigger the failure.

[test]
filename=$SCRATCH_MNT
readwrite=write
ioengine=libaio
direct=1
loops=2
filesize=$60_PERCENT_OF_DRIVE
bs=128k

The reason this is still an RFC is, it is enough to have DATA block groups
free but not METADATA block groups. Of cause the same principle could be
applied to METADATA block groups as well, but I'd prefer to have a
discussion on the general direction first.

---
Johannes Thumshirn (3):
      btrfs: zoned: traverse device list in should reclaim under rcu_read_lock
      btrfs: zoned: reserve relocation zone on mount
      btrfs: zoned: kick cleaner kthread if low on space

 fs/btrfs/disk-io.c |  2 ++
 fs/btrfs/zoned.c   | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/zoned.h   |  3 +++
 3 files changed, 59 insertions(+), 2 deletions(-)
---
base-commit: c22750cb802ea5fd510fa66f77aefa3a0529951b
change-id: 20240328-hans-2c9e3b4a69e8

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


