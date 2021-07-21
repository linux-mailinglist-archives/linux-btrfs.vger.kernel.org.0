Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB23D0EF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbhGUMDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 08:03:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44572 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhGUMC7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 08:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626871416; x=1658407416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NX/aH2lh+HQtcYIkjI+zaaI7EsPLjnk2FxRQR2eFUg0=;
  b=Tarc0PYyy5rNNl5zjkT71/IUcWOlWxncKj4t/gCjoHWsAQ1e0vzVd0os
   VRGsTtSKAhP8a0WjKXNQ3JgxzzXQ8bCIF+A5ERHslzBrYTM7wwmFetkUA
   Q4fSx8GrTVwoEHzUr1805bjQscGsB/1vLtjdCXv5FU76EXdcyOdqPFSjv
   3OU9XcthyUufHZ4F6DOow4tp9e1nM0uAoptiDIkoLMfiGmIHd+pcZ9Hfp
   y7+NqT+bcidzy14cqRuaAAxYyhDvWrYRdaJJM4TB//QtWdX3jO7l6ACcg
   WB0CKpVG97FJn2VLDNohi1LVAs9RL0mmYCyhGW4kt02UTrwaadas+NXcf
   A==;
X-IronPort-AV: E=Sophos;i="5.84,258,1620662400"; 
   d="scan'208";a="174366708"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 20:43:36 +0800
IronPort-SDR: UAYrgrJOlcy2zUqZWbFF9gYjDVoX0V5f5fJ8rdftlGF1vcP//+K/EuVwt+GWubVGkmHhHuUmsz
 HFkiFKZAGRG/dUg6nswEyx603bN7gH/00Q8C06mxjWfQizJbj7kdfO6EwXGP1xdMK1+udPkaB/
 7fsfTi5acuUBow3CoWhVQB+Y6MliGzi1hIgVtfrGNep7tUWPqCJ8oMSnwkwbK9eyfs+OJ2lnvz
 71e1tlHnuBskWr+VMhaZAHhDC6YvJtf/YNLaxIQlPGGdpxeEpBcKno+gfWvPknOMfcxIwFcPKh
 gj8GFpII7t5Oh4NTVn4pvu7A
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 05:19:51 -0700
IronPort-SDR: 20eciOtnVRk4ned8VsILKWOuNWXULPNrmXntojm93iCGn+EoHlKX1lzB0K5nO6pQiKLYsqiT7p
 P7eMISV3b0iaQiRTzOV2bbtcSs7Xmf2+XNz5Oe9ubg4KsaazhuDYqSS/QAfVQs1ZDp5SrcbKFD
 EcHa7NxwThh7y2p0HxbTwBEGmOevU2M024M9vhU46S36Ad8C2rkamzccYHHp+8IBUrdZ2e4mNa
 tgxCBzxMpoWc6pv3fZbTX++IrSg7BjXhZEGflYPCd0MRxgE5R13H86Cj4SvyL/psQc4LEl5sEO
 x/c=
WDCIronportException: Internal
Received: from my8nr8qf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.83])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jul 2021 05:43:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/3] fix argument type of bio_trim()
Date:   Wed, 21 Jul 2021 21:43:31 +0900
Message-Id: <cover.1626871138.git.naohiro.aota@wdc.com>
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
- v3:
  - Introduce BIO_MAX_SECTORS instead of a function local const
  - Some style fix
- v2:
  - Add WARN_ON and ASSERT to catch overflow values
  - Change argument type of btrfs_bio_clone_partial() to u64

Chaitanya Kulkarni (2):
  block: fix arg type of bio_trim()
  btrfs: fix argument type of btrfs_bio_clone_partial()

Naohiro Aota (1):
  btrfs: drop unnecessary ASSERT from btrfs_submit_direct()

 block/bio.c               | 12 +++++++-----
 fs/btrfs/extent_io.c      |  4 +++-
 fs/btrfs/extent_io.h      |  2 +-
 fs/btrfs/inode.c          |  8 ++++----
 include/linux/bio.h       |  2 +-
 include/linux/blk_types.h |  1 +
 6 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.32.0

