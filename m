Return-Path: <linux-btrfs+bounces-5817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ADD90F23D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4B01C215F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52A215098C;
	Wed, 19 Jun 2024 15:35:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5621345;
	Wed, 19 Jun 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811302; cv=none; b=IOD1gd2I5hg56lNvI9OoVRH8avWI72Tjejiuu1/NwoOyB88lrbIxCDBHmmLNLSQg0g3Bb5fac7JY6K7DdgJBKxrmrt4ZvM4GnDKumC1FQEkTPgo7uvtn4QcU3r/XXZ9eShX18jWwhVeZLQ2G0olg8b2jdQHUWogwspFC7xiy3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811302; c=relaxed/simple;
	bh=8Sj/sfIq0DqAipfp8q/x2Yhr2FOucgns8h820VpArjs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=afzJE5PJ+mCbsWaarRd851OTxWbkDymejbjxDi3IMS7ckOZVii+Z2UTN+gwF1SaK5BAr6SmHOoaiwOnpf4utMKbfK8wKxU0D/TXmi0owjwgQR1Bx7BmDw6ZxNtBhbWleAl7DT992hB6WVpfmjmnffZjypRtNHI+bzhalIDH+ECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso51779585e9.3;
        Wed, 19 Jun 2024 08:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811299; x=1719416099;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IbJBDc9fMWWKBCXNiLbufouO1Jc0DPFGGRKeM11Ktw=;
        b=gHc/ouk9HiQN8LEE/FIjgQ1MY5RJl5kk62OtDcnuGbwrhVzrAGyptxzxZAkPP5jPB5
         utsr9TjFo6z/hYgLqGUIC0GpoClNhXw6unjnf7twc2a6dQbwZwEFAA8pREV4KNqFHadj
         nzr5bzpm8qiRSb2VGXvCdrj/lLmVVrX3ThnCwuLhgwmu6l72/LU6+9Xl8Zf5zLxlWMQK
         a7roDP6VtOkb6duWmTV2u+2/5qJDkt4KiFaYkpswozYsFxEDu0LmSKRMHFQ38K4UeJ5D
         U0rkt3DSPrHqUycFWqzQI4XvppsQ/7ApuQRt8g9UBhWs/8mciD6caWtXUJ9WgSqLH3ao
         +7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe6Za/3KBzezWovWwyOfB9qZJHy3KQPKp87gLkohEwbsnEaQNvI0Df9nUBkODclhCKCmWXwdITdQiTCn1GVhBTgMszGDJwlPTUvggL
X-Gm-Message-State: AOJu0YzMWb4IDL8QKmCjJxSA21SBHDU9m8kGK2jPqhVVj2qyNr8Rf2ol
	WOcZeplGLEaLYZbqdmIEaE8jwQDEEuYSJ7Q+mtdla7s/XpOaGngM5zyQ2Q==
X-Google-Smtp-Source: AGHT+IFatbXodFriOCDmjeXXw55Q8EQ98EJmL63Z3UivMQzTQ3sFlzgLpEfcko3EwOv8HpQIpn5v3A==
X-Received: by 2002:a05:600c:78a:b0:421:5609:115d with SMTP id 5b1f17b1804b1-424752a6722mr18812795e9.41.1718811298815;
        Wed, 19 Jun 2024 08:34:58 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7110500fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f711:500:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe9263sm268882135e9.15.2024.06.19.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:34:58 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 0/4] btrfs: rst: updates for RAID stripe tree
Date: Wed, 19 Jun 2024 17:34:50 +0200
Message-Id: <20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJr6cmYC/3XMQQ7CIBCF4as0s3YMkIriynuYLihMW6KhzYCNp
 uHuYvcu/5e8b4NEHCjBtdmAaQ0pzLGGOjTgJhtHwuBrgxKqFVoK7FvklPG1eJspoRfWaqN7408
 W6mlhGsJ7B+9d7SmkPPNn91f5W/9Sq0SB8mycJHLiMqjbgzjS8zjzCF0p5Qv6cPmxrQAAAA==
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=jth@kernel.org;
 h=from:subject:message-id; bh=8Sj/sfIq0DqAipfp8q/x2Yhr2FOucgns8h820VpArjs=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQV/VrwMcnclaF9C7fYFN5X2j9ntkxsLuSYuVabbYHtZ
 XXrH29kO0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAifRsY/seXTkwsakib9Ozw
 461CIlm3X2X+3FH2o7G8O/C054HlH7oZGSZLbZI0eD3z8cSC07NfMLH8/PfUcdXRwA8PzPc8N9S
 /qcMFAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

Three independent updates for RAID stripe tree.
The 1st one removes pointless space from the on-disk format. As the
feature itself is still experimental I'd like to get rid of that as early
as possible.

Patch 2 replaces stripe extents in case we hit a EEXIST when inserting a
stripe extent on a write. This can happen i.e. on device-replace.

Patch 3 splits a stripe extent on partial delete of a stripe.

Patch 4 adds selftests for the stripe-tree delete code, these selftests
can and will be extended to cover insert and get as well

---
Changes in v2:
- Added selftests for delete code
- Link to v1: https://lore.kernel.org/r/20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org

---
Johannes Thumshirn (4):
      btrfs: rst: remove encoding field from stripe_extent
      btrfs: replace stripe extents
      btrfs: split RAID stripes on deletion
      btrfs: stripe-tree: add selftests

 fs/btrfs/Makefile                       |   3 +-
 fs/btrfs/accessors.h                    |   3 -
 fs/btrfs/ctree.c                        |   1 +
 fs/btrfs/print-tree.c                   |   5 -
 fs/btrfs/raid-stripe-tree.c             | 150 ++++++++++++++-----
 fs/btrfs/raid-stripe-tree.h             |   8 +-
 fs/btrfs/tests/btrfs-tests.c            |   3 +
 fs/btrfs/tests/btrfs-tests.h            |   1 +
 fs/btrfs/tests/raid-stripe-tree-tests.c | 258 ++++++++++++++++++++++++++++++++
 fs/btrfs/tree-checker.c                 |  19 ---
 include/uapi/linux/btrfs_tree.h         |  14 +-
 11 files changed, 384 insertions(+), 81 deletions(-)
---
base-commit: 7f5983607be0823e94c20f565915faf9074a370d
change-id: 20240610-b4-rst-updates-d0aa696b9d5a

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


