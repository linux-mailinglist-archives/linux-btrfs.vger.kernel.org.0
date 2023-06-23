Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F3973C283
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 23:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjFWVUD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 17:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjFWVTo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 17:19:44 -0400
X-Greylist: delayed 211 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 14:18:49 PDT
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095473A9A;
        Fri, 23 Jun 2023 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yokMEiNdELJzyHFQdE73QSq1qzFaQMznhY0/hFJPXdI=;
  b=PQ1b0Em2N9AUVeD/LpbU+ZN+rhktTH+Y6Q7VDw8Cf3pNA0l+BtcyhZxn
   ojeRsFjGxDD8u0+Y/YOKGSuPFSO6phFB8O6SWqeWn+vMMRvPryqL5bt/o
   lImhNqRZeaTWVm1/g7h+gT/Zhi5gA6YeaCo8RJpx27aob7O1b3mfST+O1
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686157"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:09 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     linux-staging@lists.linux.dev
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-sgx@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kasan-dev@googlegroups.com,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Krishna Reddy <vdumpa@nvidia.com>, linux-scsi@vger.kernel.org,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Shailend Chand <shailend@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-btrfs@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH 00/26] use array_size
Date:   Fri, 23 Jun 2023 23:14:31 +0200
Message-Id: <20230623211457.102544-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use array_size to protect against multiplication overflows.

This follows up on the following patches by Kees Cook from 2018.

42bc47b35320 ("treewide: Use array_size() in vmalloc()")
fad953ce0b22 ("treewide: Use array_size() in vzalloc()")

The changes were done using the following Coccinelle semantic patch,
adapted from the one posted by Kees.

// Drop single-byte sizes and redundant parens.
@@
    expression COUNT;
    typedef u8;
    typedef __u8;
    type t = {u8,__u8,char,unsigned char};
    identifier alloc = {vmalloc,vzalloc};
@@
      alloc(
-           (sizeof(t)) * (COUNT)
+           COUNT
      , ...)

// 3-factor product with 2 sizeof(variable), with redundant parens removed.
@@
    expression COUNT;
    size_t e1, e2, e3;
    identifier alloc = {vmalloc,vzalloc};
@@

(    
      alloc(
-           (e1) * (e2) * (e3)
+           array3_size(e1, e2, e3)
      ,...)
|
      alloc(
-           (e1) * (e2) * (COUNT)
+           array3_size(COUNT, e1, e2)
      ,...)
)

// 3-factor product with 1 sizeof(type) or sizeof(expression), with
// redundant parens removed.
@@
    expression STRIDE, COUNT;
    size_t e;
    identifier alloc = {vmalloc,vzalloc};
@@

      alloc(
-           (e) * (COUNT) * (STRIDE)
+           array3_size(COUNT, STRIDE, e)
      ,...)

// Any remaining multi-factor products, first at least 3-factor products
// when they're not all constants...
@@
    expression E1, E2, E3;
    constant C1, C2, C3;
    identifier alloc = {vmalloc,vzalloc};
@@
    
(
      alloc(C1 * C2 * C3,...)
|
      alloc(
-           (E1) * (E2) * (E3)
+           array3_size(E1, E2, E3)
      ,...)
)

// 2-factor product with sizeof(type/expression) and identifier or constant.
@@
    size_t e1,e2;
    expression COUNT;
    identifier alloc = {vmalloc,vzalloc};
@@

(
      alloc(
-           (e1) * (e2)
+           array_size(e1, e2)
      ,...)
|
      alloc(
-           (e1) * (COUNT)
+           array_size(COUNT, e1)
      ,...)
)
    
// And then all remaining 2 factors products when they're not all constants.
@@
    expression E1, E2;
    constant C1, C2;
    identifier alloc = {vmalloc,vzalloc};
@@
    
(
      alloc(C1 * C2,...)
|
      alloc(
-           (E1) * (E2)
+           array_size(E1, E2)
      ,...)
)


---

 arch/x86/kernel/cpu/sgx/main.c                    |    3 ++-
 drivers/accel/habanalabs/common/device.c          |    3 ++-
 drivers/accel/habanalabs/common/state_dump.c      |    6 +++---
 drivers/bus/mhi/host/init.c                       |    4 ++--
 drivers/comedi/comedi_buf.c                       |    4 ++--
 drivers/dma-buf/heaps/system_heap.c               |    2 +-
 drivers/gpu/drm/gud/gud_pipe.c                    |    2 +-
 drivers/gpu/drm/i915/gvt/gtt.c                    |    6 ++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_devcaps.c           |    2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c         |    4 ++--
 drivers/infiniband/hw/erdma/erdma_verbs.c         |    4 ++--
 drivers/infiniband/sw/siw/siw_qp.c                |    4 ++--
 drivers/infiniband/sw/siw/siw_verbs.c             |    6 +++---
 drivers/iommu/tegra-gart.c                        |    4 ++--
 drivers/net/ethernet/amd/pds_core/core.c          |    4 ++--
 drivers/net/ethernet/freescale/enetc/enetc.c      |    4 ++--
 drivers/net/ethernet/google/gve/gve_tx.c          |    2 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c |    2 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c  |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c   |    4 ++--
 drivers/scsi/fnic/fnic_trace.c                    |    2 +-
 drivers/scsi/qla2xxx/qla_init.c                   |    4 ++--
 drivers/staging/media/ipu3/ipu3-mmu.c             |    2 +-
 drivers/vdpa/vdpa_user/iova_domain.c              |    3 +--
 drivers/virtio/virtio_mem.c                       |    6 +++---
 fs/btrfs/zoned.c                                  |    5 +++--
 kernel/kcov.c                                     |    2 +-
 lib/test_vmalloc.c                                |   12 ++++++------
 28 files changed, 56 insertions(+), 52 deletions(-)
