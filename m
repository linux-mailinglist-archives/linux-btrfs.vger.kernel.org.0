Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAB04DB22D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345247AbiCPOKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351602AbiCPOKi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 10:10:38 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D514D26B
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647439764; x=1678975764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1QQMwGymv2ZmMjlKXRKSrogoH1rAGNXi+XiXBxwuNyg=;
  b=E0A4B/y4tJv3viECPyG63kj8SKknxYKeCcoGsBae18tU9LD1yBydesG+
   BvttzbxAGmO/qielRIkY7UaIUUec9wVrUzBYSiSZcNmGibwKYwWATlgB5
   JU2ht+Omk7K8bSqvPMLxPqyvgwwrmdLctPZfIeuR00862EA7vxuOGvRor
   EGdE3dp3328OVtQMC6vDn25BvQzPbcvtTwDrLHrstg/YUaHDVy7JsAGSF
   LH9057EESzcG7KMlo/a+AsbVzrrnXJK+bYKnaDOcrSxuehiDkT3sgC+rk
   olrwamxglKKIUjqChb1vz+lMlT0JKcCeXClHXTGTnaMzvKEYrCQl6ta0Z
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="196448081"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 22:09:22 +0800
IronPort-SDR: j8ftzcxhRX06mmaQ5E/WR48DR/EZYxXWw4te97OKoci88wZVdAv2SQLE5oPYv1cbJnVcXYrazw
 IqNevxYh40QgR2fADGqDe6miKcZAv4wO6X+fOHZx24PPmKF91CBJmsr+rDbMta+cD9Oj4y+09f
 OfFwR3Ap63mF5xGm60bihPvbcvWoFVIm07l/6/UiN5PzdhgJoFz3XVD/3ayNKVsrVTA7XhVnL/
 JnQE15fyZ8iVlmGVc/r8kyweiJQRZq8kScGI6mya+Q8JfDdLrNbINBbC5AIqF++ds+/wMjkH8j
 owBoq89KzUO4tDQtomr+gG0x
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:40:27 -0700
IronPort-SDR: +Iq4GLE96InCzsjjvTZ5u0cnu5H4tQu37Fc3UjVT0FnWyrtP1OOc5O31hY4Cvd25B5PrHwojGf
 FLNDxbTZ2n9V052MXxB6IrzVsJhM/7exR9FXE5NvqbmuYgCa6uqbIvRyOQhAy0LYaia74nBIEe
 MTRO04R7MMoD8MlSnqm6xIww/SjEiDlOegfaBx7cmNI8IUBMq/2Wf1J6FksZQ5Wmt32tMzCX+R
 pJopLe3sHQyxuu0HKSwz+mu50nto/sGU6CKfeNyn/bSokSqSCCppzXYF1Z4aBiN4lnJTX85TJv
 704=
WDCIronportException: Internal
Received: from d2bbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.209])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Mar 2022 07:09:20 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs: zoned: activate new BG only from extent allocation context
Date:   Wed, 16 Mar 2022 23:09:10 +0900
Message-Id: <cover.1647437890.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_make_block_group(), we activate the allocated block group,
expecting that the block group is soon used for the extent allocation.

With a lot of IOs, btrfs_async_reclaim_data_space() tries to prepare
for them by pre-allocating data block groups. That preallocation can
consume all the active zone counting. It is OK if they are soon
written and filled. However, that's not the case. As a result, an
allocation of non-data block groups fails due to the lack of an active
zone resource.

This series fixes the issue by activating a new block group only when
it's called from find_free_extent(). This series introduces
CHUNK_ALLOC_FORCE_FOR_EXTENT in btrfs_chunk_alloc_enum to distinguish
the context.

Naohiro Aota (2):
  btrfs: return allocated block group from do_chunk_alloc()
  btrfs: zoned: activate block group only for extent allocation

 fs/btrfs/block-group.c | 36 +++++++++++++++++++++++++++---------
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent-tree.c |  2 +-
 3 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.35.1

