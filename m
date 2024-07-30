Return-Path: <linux-btrfs+bounces-6867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A8940F9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 12:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C633B2B11A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531519FA8D;
	Tue, 30 Jul 2024 10:33:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E7819FA76;
	Tue, 30 Jul 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335606; cv=none; b=UJtYUxcPbka6j7WhmenREetR8pAeOOQ5VIWc9eVkT04DwreynvLPxQYrchAbpvGGGutwhBe4VvicbbTRK0bZ9n3CrGlub/EHss9QLcxTRt7cCIxxDXiLWaNHZ8b5ow/Dk6S6q5vBnAhwm053YJSuXgJ40etXkk3pDfvLJVUc0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335606; c=relaxed/simple;
	bh=135AlmRgLOAFNAbD5oG9kFcFDEEB9aEGjaLEjOTTRmc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ShHtAP3Ib/9LrgrFGt+t352BsOfmO4uy6PJM/u6ujZ4EOV4YrihjYGIidfZ6eP0/gxiNnd2fd2SpR7Gw6x6LzfOmyDAz3xve39pc8UZKOlsZXxGdqSKxntLFqYMHXRbV9vJhvn5of8ZEzs2DrNBJsWY6Gwz6PN86B3JclwtVR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so3244611a12.3;
        Tue, 30 Jul 2024 03:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335603; x=1722940403;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSe2xEaIfSV4qwU+SZGcrsIVQrX4aS65AXhHQDRizuQ=;
        b=BMnSiKn3WAE1xeZyLXC3ZcIa0eMJKg8FoAYxcIAI7tUGU2kHuSScO2vXwtQT3fZuwT
         y/yinGPn4eB9vC01I/1qwF59p1R3N5No+O3xoaEG9fghGwpcmVDfAjfWESi+J1EPuDpM
         9VlPOG8zo4yD6LceWjnvczUrSKIpG9Bz7DBsIlWWyKiYc4mqLXGC3Rz8M4w9QFV5SVJl
         yeZAzFEudkdCblEOzP1hOyXj3xJbAQJmbaY3h4RnAJoB1KbFlUljbOKmzWn9gRzHCClV
         SV42HOID1IGsqZIm0bhB49PbS51SVwe6VLviLtEjEiFBXnnENJGwhemazPhVzMGzSGSJ
         MQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ9/fqVZP7oeXlNVVd1XcCPxXVK+OvpIoZ+MUo4Ehc6y3vO0D/H8gt5+/7eBsq1YTfsxLi1ZycyJQAPHWzQ6agJLPiohGpxGNI93oT
X-Gm-Message-State: AOJu0YymOS6yv6M9GEnRQCiBEfhCB+U1jy5KQi6CNxCrBWiGJD0ckRhF
	AeVyAJpIOa+HHy/KG0yWG1HEcqq9cphsvvOLs9iuSLXLvQ8T2x1x
X-Google-Smtp-Source: AGHT+IE86Br6rR5EDD4zyKmnMVymS2QsEPo568XaQa0PyHS+acc6Q1Zpk1Uy9PtfPxK6YWNRxCRPSQ==
X-Received: by 2002:a17:907:968e:b0:a7a:9144:e251 with SMTP id a640c23a62f3a-a7d3fdb7e94mr889027066b.11.1722335602415;
        Tue, 30 Jul 2024 03:33:22 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9f60sm622455266b.223.2024.07.30.03.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:33:21 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 0/5] btrfs: fix relocation on RAID stripe-tree
 filesystems
Date: Tue, 30 Jul 2024 12:33:13 +0200
Message-Id: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnBqGYC/zXMSw7CIBSF4a00dyyGRxXqyH2YDopcKNFAA0o0D
 XsXGx3+JyffChmTxwynboWExWcfQwu+6+A6T8Eh8aY1cMp7KvmRGNRPRyyzqOgBJyE1tO+S0Pr
 X5lzG1rPPj5jeG1vYd/0Lw08ojFBiqRZGKjP0Qp1vmALe9zE5GGutH6OEAD2bAAAA
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Johannes Thumshirn <jthumshirn@wdc.com>, Filipe Manana <fdmanana@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=jth@kernel.org;
 h=from:subject:message-id; bh=135AlmRgLOAFNAbD5oG9kFcFDEEB9aEGjaLEjOTTRmc=;
 b=kA0DAAoW0p7yIq+KHe4ByyZiAGaowXCgyv97WprzYCcmcgaItYzusFc97puLCApg1Xg62HQd0
 Ih1BAAWCgAdFiEEx1U9vxg1xAeUwus20p7yIq+KHe4FAmaowXAACgkQ0p7yIq+KHe4FGgD9HHAK
 ZN8LDX5byxGQHZNfI+cTN9loWRk1LFzUEQM3vGgBAN9L4ZEBKx4WW75BisWbb9VYniiIslYCKif
 AdNQLbA4M
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

When doing relocation on RST backed filesystems, there is a possibility of
a scatter-gather list corruption.

See patch 4 for details.

CI Link: https://github.com/btrfs/linux/actions/runs/10143804038

---
Changes in v2:
- Change RST lookup error message to debug
- Link to v1: https://lore.kernel.org/r/20240729-debug-v1-0-f0b3d78d9438@kernel.org

---
Johannes Thumshirn (5):
      btrfs: don't dump stripe-tree on lookup error
      btrfs: rename btrfs_io_stripe::is_scrub to rst_search_commit_root
      btrfs: set rst_search_commit_root in case of relocation
      btrfs: don't readahead the relocation inode on RST
      btrfs: change RST lookup error message to debug

 fs/btrfs/bio.c              |  3 ++-
 fs/btrfs/raid-stripe-tree.c |  8 +++-----
 fs/btrfs/relocation.c       | 14 ++++++++++----
 fs/btrfs/scrub.c            |  2 +-
 fs/btrfs/volumes.h          |  2 +-
 5 files changed, 17 insertions(+), 12 deletions(-)
---
base-commit: 543cb1b052748dc53ff06b23273fcb78f11b8254
change-id: 20240726-debug-f1fe805ea37b

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


