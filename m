Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211FD31008C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 00:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBDXWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 18:22:34 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59115 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhBDXWb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 18:22:31 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3AAB15C0050;
        Thu,  4 Feb 2021 18:21:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Feb 2021 18:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=NZo1eF7h0q9sXuK5pGPETDhX2U
        QIvrCOKyUnl15oIuQ=; b=mf7W+5ILFOUOmsbnA0y2+ISQpYKOtkoT+f8u39ypo1
        JA2HNKHQkR7dSKrwkc68zDma8dvhne6SZtjMo0AklAOhM+fT39P2kjwMpi95bmqA
        1qyfSHxr5txb7RX4UbsXiycVSwhPDGH5UA0t4kiOIfylCXR2zh2AEbGkc8eyZRdp
        S4VOgdo//bUWPzqURCN/DTW/r8MERGbXGb4eJ/JXo4VX0MTtqwuWINLYS53IHvOO
        oLnMScG3pVs9zyL5+LkQtAHMFT9IPOTxYmiy/7NCihPHVNR5pQIgzk94eLalPE07
        w0Zf69suHPKKY/mWRkVgQgTQ74A3pIUqPNRFb+vdgNuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=NZo1eF7h0q9sXuK5p
        GPETDhX2UQIvrCOKyUnl15oIuQ=; b=FGk7/ZiSCz1SCK7e+JBuwa5mo6kct4Dv0
        dIGGMeheU0qBoJnvspcHzKslVbsSZpUSbPW3FE0vvjnCN4Y6bwytdmVUZW2Zaxvf
        HG1hLvsSgNPJa1rCk84+Sj54PXsUhCRN/XPf9/oCRx0eXD0gSGBy3QPQbsQMcF4Z
        uLuA7GJaMUkT8DxelTfeRczhdQwbzy4QXC0lhpXF1PXonAMoNgx56NwnOmQgv1RI
        QNF2eHEahz8r7ntLnrVZ9brV4aP4D1g/pU8zv4u9h406vM9KCxc4gU/IES05IMXk
        hBXETRbdp49Cfs6ovPSScm88dW/1PFnTjE8/WCrOeYIJFADNd6lyg==
X-ME-Sender: <xms:iYEcYOaQgai5zV5BdwC-f4sYr_Hm_yxMGKb2ziCM5HkyweVOUO1_3g>
    <xme:iYEcYBZyV3dMisXsXqXxxMMyRAOx355nscezrhSDDtUhDPortgLRmhWPr_yZXnSKf
    S9YB83yKg_Mgv4FYok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehu
    rhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtle
    euieejfeelffevleeifefgjeejieegkeduudetfeekffeftefhvdejveenucfkphepudei
    fedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:iYEcYI-vY5iKcgPmK4u4-s8ltGma6DIDDZ3cdA5vuyQgO-3b1AP6_g>
    <xmx:iYEcYAqm45AVC3Jjgi2TGK8ZIYVKktssPTuGsfr4nnO5JwgE0RiY8w>
    <xmx:iYEcYJpyljGwV9jfl5RNba3lWDFVuVqlrBXdClDPt5-LXhIp2VQZXA>
    <xmx:iYEcYISP2-cgRU3m737w91KtdaGrO6bV8czJew4ohYpR5zHJ40n6OQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id B02A41080069;
        Thu,  4 Feb 2021 18:21:44 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/5] btrfs: support fsverity
Date:   Thu,  4 Feb 2021 15:21:36 -0800
Message-Id: <cover.1612475783.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset provides support for fsverity in btrfs.

At a high level, we store the verity descriptor and Merkle tree data
in the file system btree with the file's inode as the objectid, and
direct reads/writes to those items to implement the generic fsverity
interface required by fs/verity/.

The first patch is a preparatory patch which adds a notion of
compat_flags to the btrfs_inode and inode_item in order to allow
enabling verity on a file without making the file system unmountable for
older kernels. (It runs afoul of the leaf corruption check otherwise)

The second patch is the bulk of the fsverity implementation. It
implements the fsverity interface and adds verity checks for the typical
file reading case.

The third patch cleans up the corner cases in readpage, covering inline
extents, preallocated extents, and holes.

The fourth patch handles direct io of a veritied file by falling back to
buffered io.

The fifth patch adds a feature file in sysfs for verity.

Boris Burkov (4):
  btrfs: add compat_flags to btrfs_inode_item
  btrfs: check verity for reads of inline extents and holes
  btrfs: fallback to buffered io for verity files
  btrfs: add sysfs feature for fsverity

Chris Mason (1):
  btrfs: initial fsverity support

 fs/btrfs/Makefile               |   1 +
 fs/btrfs/btrfs_inode.h          |   2 +
 fs/btrfs/ctree.h                |  14 +-
 fs/btrfs/delayed-inode.c        |   2 +
 fs/btrfs/extent_io.c            |  29 +-
 fs/btrfs/file.c                 |   9 +
 fs/btrfs/inode.c                |  31 +-
 fs/btrfs/ioctl.c                |  21 +-
 fs/btrfs/super.c                |   1 +
 fs/btrfs/sysfs.c                |   6 +
 fs/btrfs/tree-log.c             |   1 +
 fs/btrfs/verity.c               | 527 ++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  15 +-
 14 files changed, 625 insertions(+), 35 deletions(-)
 create mode 100644 fs/btrfs/verity.c

-- 
2.24.1

