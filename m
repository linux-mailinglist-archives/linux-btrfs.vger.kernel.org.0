Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C373FEA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 16:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjF0Op0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjF0Ooz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 10:44:55 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD33358A;
        Tue, 27 Jun 2023 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lz+eaKXjltZfgC96+KOEH+DiV357kqzsKaP1ME9j9JM=;
  b=YpuufV72ER5dSm9wrYSnJ+nyISX1oQx33v1s2pGZoMDoTbTZApc/Qnr+
   jWRuBVmLvwZwmibFQ5jrR1vtZ5noOKi7DSKRNrP0U1BZ9FCltFGcibx6p
   ck1ThN0OMstSb7PrPLh1Mq91rYGjkQ4mlVR9Zej3KEIn+kL4eNkAXPzxE
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="114936315"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:43:51 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     linux-hyperv@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        kasan-dev@googlegroups.com,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-scsi@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, John Stultz <jstultz@google.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Liam Mark <lmark@codeaurora.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Shailend Chand <shailend@google.com>,
        linux-rdma@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-btrfs@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-sgx@vger.kernel.org
Subject: [PATCH v2 00/24] use vmalloc_array and vcalloc
Date:   Tue, 27 Jun 2023 16:43:15 +0200
Message-Id: <20230627144339.144478-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The functions vmalloc_array and vcalloc were introduced in

commit a8749a35c399 ("mm: vmalloc: introduce array allocation functions")

but are not used much yet.  This series introduces uses of
these functions, to protect against multiplication overflows.

The changes were done using the following Coccinelle semantic
patch.

@initialize:ocaml@
@@

let rename alloc =
  match alloc with
    "vmalloc" -> "vmalloc_array"
  | "vzalloc" -> "vcalloc"
  | _ -> failwith "unknown"

@@
    size_t e1,e2;
    constant C1, C2;
    expression E1, E2, COUNT, x1, x2, x3;
    typedef u8;
    typedef __u8;
    type t = {u8,__u8,char,unsigned char};
    identifier alloc = {vmalloc,vzalloc};
    fresh identifier realloc = script:ocaml(alloc) { rename alloc };
@@

(
      alloc(x1*x2*x3)
|
      alloc(C1 * C2)
|
      alloc((sizeof(t)) * (COUNT), ...)
|
-     alloc((e1) * (e2))
+     realloc(e1, e2)
|
-     alloc((e1) * (COUNT))
+     realloc(COUNT, e1)
|
-     alloc((E1) * (E2))
+     realloc(E1, E2)
)

v2: This series uses vmalloc_array and vcalloc instead of
array_size.  It also leaves a multiplication of a constant by a
sizeof as is.  Two patches are thus dropped from the series.

---

 arch/x86/kernel/cpu/sgx/main.c                    |    2 +-
 drivers/accel/habanalabs/common/device.c          |    3 ++-
 drivers/accel/habanalabs/common/state_dump.c      |    7 ++++---
 drivers/bus/mhi/host/init.c                       |    2 +-
 drivers/comedi/comedi_buf.c                       |    4 ++--
 drivers/dma-buf/heaps/system_heap.c               |    2 +-
 drivers/gpu/drm/gud/gud_pipe.c                    |    2 +-
 drivers/gpu/drm/i915/gvt/gtt.c                    |    6 ++++--
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
 drivers/vdpa/vdpa_user/iova_domain.c              |    4 ++--
 drivers/virtio/virtio_mem.c                       |    6 +++---
 fs/btrfs/zoned.c                                  |    4 ++--
 kernel/kcov.c                                     |    2 +-
 lib/test_vmalloc.c                                |    9 +++++----
 26 files changed, 52 insertions(+), 47 deletions(-)
