Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4FD64E4F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 01:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLPAGl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 19:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLPAGk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 19:06:40 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719355E0BD
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Dec 2022 16:06:37 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DCBF75C0185;
        Thu, 15 Dec 2022 19:06:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Dec 2022 19:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1671149196; x=1671235596; bh=naxmT6q+rWaUV3NIHp//FB5XU
        Jy50xAyvdn5m5wzNyo=; b=I2AcwHzs7KXybdrqtra2NbaDPZP9R6quQreI4MVIC
        QK15ArnQQqF0mX2bv5SUE2dx3ymDb/qO/xT/oseSmu/V4KGQYLTCtSPw+1sZj1zA
        whWo8sHBBFlnOQgaKBTKRa5I+ifwnPGnKGuWJ+a6vsraQesar/OG25sLKrTtlGzr
        VZ4HugLlyki1pYfk1TApWh3mxBaeeaLbCccRlXRxcfpqIVaBLd0rFJ+IJYEv8O3k
        Kl1xAWNQmZe5qPCGfFG0sUq/ixwgizFUVWg5XHL272VMa52OGDbRHf+F1Us8ZqqS
        0MPBqugpzcMVMQRborjQAUTgwZUcYM+RI2FpdpxcxxHCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1671149196; x=1671235596; bh=naxmT6q+rWaUV3NIHp//FB5XUJy50xAyvdn
        5m5wzNyo=; b=S690H971Rq7KJsw6Lx4xsRLx7yoCD1JUvKuNHvEMcBaWb/ASbXy
        uZustBBClltZEzK19GWjZjZssLbAbHIqQBkYMjlgO3uZ5ejQiFVATuedORbCfhMQ
        tGu+t6A8zbFF7TN0j+2jZOFaAAKo0932WxLjVAXYpsX2MhsQT1T1jt/q2b6nr5IB
        UQQ0KERc7wje/H/JBAcJSGg4/iSu2jk8ZJcKF8KEb3CSe0N5v6UZTHsbsrGsyIQ2
        yBS9wr5SR8DfIJm20f+BOIQqkN6j+Ry8bkqfK7DXbNZy/3ZbKVCMXm4eAc3fXLYx
        OSPm4My75uxZFDcj9UnZebDXc9mC/wcIdUg==
X-ME-Sender: <xms:jLabYzgnircW2MxfT_YGt9oDNWnZi5-pbfJk4OQ8CO33yTxYb2id_w>
    <xme:jLabYwAfpUSGkUIoz_NUX9XwNXBh0-h45v36i1nxWo-jt_JV1hzvMywRG-W9jOKu1
    FZr7Fo2MvxiS1LqyvE>
X-ME-Received: <xmr:jLabYzGLiB8ENRcnBr7oWS7YCEO_dkI0bO1WhaSBAuAJfjZUptTRZkBL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:jLabYwS2QC6fzirvfgVSSgL2vCWYuPEusKlHUH03ImGEygjEnD8V7Q>
    <xmx:jLabYwzcCFUD_86mT1J4XlREDLmbUGqHCmEZvGncozh-WQ-GzRlpxw>
    <xmx:jLabY24Vb-65_GnOPqlf_C2qnVIAY0dq5U2HU56hlkTuthPosiThng>
    <xmx:jLabY2Z9b5QeZBqbhFavTRL5V7J7MOt4k-98pUsovWtGvvLWXTzXVQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 19:06:36 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 0/5] btrfs: data block group size classes
Date:   Thu, 15 Dec 2022 16:06:30 -0800
Message-Id: <cover.1671149056.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch set introduces the notion of size classes to the block group
allocator for data block groups. This is specifically useful because the
first fit allocator tends to perform poorly when large extents free up
in older block groups and small writes suddenly shift there. Generally,
it should lead to slightly more predictable allocator behavior as the
gaps left by frees will be used by allocations of a similar size.

Details about the changes and performance testing are in the individual
commit messages.

The last two patches constitute the business of the change. One adds the
size classes and the other handles the fact that we don't want to
persist the size class, so we don't know it when we first load a block
group.

The final patch is a tweak to skip zoned fs-es which is particularly
meaningful for ZNS.
---
v4:
- add patch to skip zoned fs
v3:
- fix double newline in extent-tree.h
- fix ctree.h include in extent-tree.h refactor
v2:
- removed 1G falloc extents patch
- rebased tracepoints patches onto significant header file refactor


Boris Burkov (5):
  btrfs: use ffe_ctl in btrfs allocator tracepoints
  btrfs: add more ffe tracepoints
  btrfs: introduce size class to block group allocator
  btrfs: load block group size class when caching
  btrfs: dont use size classes for zoned file systems

 fs/btrfs/block-group.c       | 243 ++++++++++++++++++++++++++++++++---
 fs/btrfs/block-group.h       |  16 ++-
 fs/btrfs/extent-tree.c       | 167 +++++++-----------------
 fs/btrfs/extent-tree.h       |  81 ++++++++++++
 fs/btrfs/super.c             |   1 +
 fs/btrfs/zoned.c             |   2 +
 include/trace/events/btrfs.h | 128 ++++++++++++++----
 7 files changed, 479 insertions(+), 159 deletions(-)

-- 
2.38.1

