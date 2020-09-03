Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6DE25CAAB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 22:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgICUeR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 16:34:17 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:44569 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729633AbgICUdk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 16:33:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CFB04EC2;
        Thu,  3 Sep 2020 16:33:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 16:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=epLhnqqelOYStPma9EaEe/23Sa
        MZfaCfY8aS832CLIw=; b=KpK+IMrW8Cs3QhmaxmBlBKLYq3gDrLevjF4DZ/376c
        +SVVB7j48hvc3/GL4ei5v9SQEqZ+Cnu6NiZZ25J+s0FZlShU2QnJcATsEP6yCVJk
        zyAT2QkPDcMTAnNHzZ+ePrC8Q06Bi0YaqW5O4SB93ryxtjffPXcq/Z1tZQKWuXoM
        tGeo1pWFa2KV4y2jeU1Fa4JZo/GLSdOiXrD0fnbbr8XYGrlBnMGcPFuoB2NrGr5h
        YjXFzTJQEbrxPBpfO2j8nqldBZzFkvpk6i82CxGCSQLC+84yOiEmckT0P3Ak1z4N
        XhBPUPoMm81WliZDjNc3SbeD1vfA+GyxFXraNASCQfoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=epLhnqqelOYStPma9
        EaEe/23SaMZfaCfY8aS832CLIw=; b=GNGdyZ44oG31hsj01KiFnINOlu8uwPoWP
        shVLZAbNhbidSVOmWA8+NKSO/MHbGenibSV7MdWRnAvjKQ5A8QxtoP5KyVqHIpB3
        l7A+BpkRKxIyF7FO5K9xq6IAdfk4G8xKcVGK2pi7u6bPqz0lf3fLSF9b/u+IddOt
        wy3hPaYSMpuTY+D0SXSMgLusdP2W6hPuuoiMOcXkZsQ8tlnyfltw+qJtEoaEOch6
        HQNlZ+SQPJGz0V3PZ1kPFNYNIfCny/zuz/4Dt3o2jZBJecwzxxVBrJiXlWRGDI6J
        zlWkYXiMPAS8UhtSNiUB7Qkcu69hI57M4P8RGCxJPCRMxEb7Xes9g==
X-ME-Sender: <xms:FlNRX9H1QqCqDpTcqdfSr5VIN7bfFWSdNTKEvJq4zgoTkqYbcgjlHA>
    <xme:FlNRXyWM_odgfQc31USm3hkq8Vo7BciQ4HBEH2YWBCLvSuP8gDfR_Dky4VEpGhoJ0
    bKQaHOCS8BmCaKsrbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudeguddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduie
    dtleeuieejfeelffevleeifefgjeejieegkeduudetfeekffeftefhvdejveenucfkphep
    udeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:FlNRX_JBx9i_6ymWD2eF_8oKDREZ9InisqUk9F-M5fcMfVITqz2gHQ>
    <xmx:FlNRXzHsET5io-tOpuPgg-ibdEIVUHuEMOLQFjBvAr-ikWgMXRdPrA>
    <xmx:FlNRXzVbRf89uf3jJRAlbxfME5Mr2r5U2GGaJ6knneRzAPGTQLgfXw>
    <xmx:F1NRX-RuE5Cep60AxB9evCl7l8z05BOq5x9Oe7mV1L9Hm4ULGupICQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 41D20328005A;
        Thu,  3 Sep 2020 16:33:26 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Dave Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: free space tree mounting fixes
Date:   Thu,  3 Sep 2020 13:33:07 -0700
Message-Id: <cover.1599164377.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A couple fixes for issues with mounting the btrfs free space tree
(aka space_cache v2). These are not dependent, and are only related
loosely, in that they both apply to mounting the file system with
the free space tree.

The first patch fixes -o remount,space_cache=v2.

The second patch fixes the slight oversight of not cleaning up the
space cache free space object or free space inodes when migrating to
the free space tree.

Boris Burkov (2):
  btrfs: support remount of ro fs with free space tree
  btrfs: remove free space items when creating free space tree

 fs/btrfs/block-group.c      | 42 ++++---------------------------
 fs/btrfs/free-space-cache.c | 49 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/free-space-cache.h |  2 ++
 fs/btrfs/free-space-tree.c  |  3 +++
 fs/btrfs/super.c            | 17 +++++++++++++
 5 files changed, 75 insertions(+), 38 deletions(-)

-- 
2.24.1

