Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1867C3D08DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhGUFqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 01:46:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34917 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhGUFqc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 01:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626848829; x=1658384829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jfB5AiHhm2qgWTBRUNoHX8ejDRxAH9AhjHaoVz3I5+E=;
  b=ZAAVy6BICCrsEBtWTH43LU6rAgf4xFs9HCkij3jy4BxrOrnAZs63zuQG
   AID5peWzfW/gbnH5A2sztysgXllICta4tTpa+OY/rJN49KE5zOKcuZnAb
   Xh0y/vTdMRN98061GEJ0HmxSbIRyWQxVR0ZrZe72tQfwT0vUTb9AZQzNn
   Li2RZYb6wnT7YHBXpIz29kN/auwdkuWHlyPbRzPKb6kVcZ21Sllw1q/re
   WatrnCtX30HvxkL++LrkFvIOdNyaJZ5gtK7b7GisD0JcE1Z3wOzpXQu+8
   tEVBHueVul2l4LfrDveHmk3N0K397N1575dSGRA6EFkRwOyISApxFPOp8
   g==;
X-IronPort-AV: E=Sophos;i="5.84,257,1620662400"; 
   d="scan'208";a="179924887"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 14:27:09 +0800
IronPort-SDR: v/8A/0QB7exrSQWIQwvFGKrjjxgmSx+dp7wnzFxKNrZwLro1t+czWm1U8bgC4yJI2Lqd8wnGFu
 dHyvLC1LQv90L5OIx84oRW7pDhx8cSrKh8NeaTwm44AQplQFoZyq3hXB6HTq0RtsyuoX1doRTn
 qlN0TvdwPwo+XbdAVvbvy1drSANTUfuChtdx2T6j75+tEhgNdkdux1cMKbkoX1+3a1Jqk9KKTL
 Zgh+3OHZnhbTF5gDbNGxGhUw7fb82//H7NfnIfJ3VsyzqUHKa9Rkrh+U6mbJrCyLBVzi7E3vvY
 V1orI1HdHxx1W9reiy5T2tAa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:03:24 -0700
IronPort-SDR: RYUWpYQrDCX1aziM/gtJj9zH1uJmBTrKFCXRQQQk81137kKVnTBWDCKIxMPCc3sbZVQL40YrPi
 wAed6w56gEyjpqFIqmb7zOvwb9nDocYynYP7fOTIQ3pVUfm1qugrrLQM+XZPDPz9GI4TRkYWLP
 xM8rjHQESDoqeA07wrhe1HlYWjN8j1lDYOZT0vUuQ0vbr3gJKc7g0shalPZdv+J2ZNRrw94E5N
 xo7a/xiG2P+cphYya4TT05yoc1rPaNWP0q1z6FG69Dc+q8Rn2EG4qpvyJI+3cjn14HPE55qdTh
 kcw=
WDCIronportException: Internal
Received: from d1zj3x2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.44])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jul 2021 23:27:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/3] fix argument type of bio_trim()
Date:   Wed, 21 Jul 2021 15:26:57 +0900
Message-Id: <cover.1626848677.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function bio_trim has offset and size arguments that are declared as
int. But it actually expects sector value and the range of int is not
enough for bio->bi_iter.bi_size and bio_advance() which is/takes unsigned
int. So, let's fix the argument type of bio_trim() and its callers.

Patches 1 and 2 fix bio_trim() argument and its caller's argument.

Patch 3 is depending on patch 1 and 2 and do some cleanup for btrfs.

Changes:
- v2:
  - Add WARN_ON and ASSERT to catch overflow values
  - Change argument type of btrfs_bio_clone_partial() to u64

Chaitanya Kulkarni (2):
  block: fix arg type of bio_trim()
  btrfs: fix argument type of btrfs_bio_clone_partial()

Naohiro Aota (1):
  btrfs: drop unnecessary ASSERT from btrfs_submit_direct()

 block/bio.c          | 14 +++++++++++---
 fs/btrfs/extent_io.c |  6 ++++--
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     |  8 ++++----
 include/linux/bio.h  |  2 +-
 5 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.32.0

