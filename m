Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B4326E3CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 20:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIQSfS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 14:35:18 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38515 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgIQSbB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 14:31:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0F6417B2;
        Thu, 17 Sep 2020 14:13:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Sep 2020 14:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=81VELH1pcJTlt+XJnl+p7vAnht
        5YpG98vgEskwvf1QA=; b=Uckt3EIx+3oP+WHZ0PSZbjcpX7qSh7E+oVBQtQ/ZEM
        sR9KWB0r1suHeslo6uyv5Wf1LwcZ6Lt4/YHEA74Voh+JX1+hCg4xSmY4xNdN4ksg
        E5ORrEkUPLTghuMGLGiYE9xrEJ02ULarZP5xyutLrV+XRUCGnFVylPlhOPHMneAx
        SGdiHOWuThdI+RZhU0xOUtPKNkxp2kw6Lhv3tmA+QQ2D86Rip9yDb2S4NPI9ooYH
        yL/kESqrC1wy+4KvjfdLdEKp2yHfu6g/gcUU7jMTpuF+vziOWgOacWRB+259joJq
        NX8XZRSNar06m3AUJATkBBKl+A0wbeK2vawj1E/dXarA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=81VELH1pcJTlt+XJn
        l+p7vAnht5YpG98vgEskwvf1QA=; b=pUZCSRL7YaNY9DhTApZAmVAZHSCHw9r68
        DJnx64o/oEkNw/bDLuxrgTjIza9TyLreRuDeez5h180cTGS4a3EInQbp7QRELj+W
        dlpD5Gj1Xo0I+a8hAVqrGJfwBejralbNssvfXknMEV9GbvNTcwSAhcLaoJbStZDL
        xDG/1+14GfxzO7BsJ1cv80kUf05vwt/9fXpoIN9o/NQ6ZD19KcyuyHolDHevTClc
        yzbzXmCHmhWOlqQU6RcsRzEWVghifE4qxTvUsaeW/CxBYq7fvVLhZUbeFXb6Dqom
        9+ZrvSj+W0vSGzT32IMR9yPb1Cqib0+E4FPjS0fltm9UseSRNw99g==
X-ME-Sender: <xms:YadjX9a5CuBVBiSgRc64r0S7NXoQyBkTda0Kd8udXHmQar6UuOZuuQ>
    <xme:YadjX0aAxTRNvK_uV4k7WeR451AUmZA748n-kuj6Jcsbj4f5qWBK-J3WFLRyH7Ga1
    Q5sPwpGGADx0ZMzJho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucfkphepudeifedruddugedrudefvddrfeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:YadjX__ZPtV0uXfK9fo5m5JoB8pA_zbz3U1PMtKFJBr-a_ro7s0Flw>
    <xmx:YadjX7pXlaEOcHxvaAqblpdZsW9MHSZhZwkdNMTlPwg_RY9aAx3OQA>
    <xmx:YadjX4o6I2Fyx1fgttkwPj4XEiveK-oWIWKbKE6XBcSzdyCnj9rlwQ>
    <xmx:YadjX_SXp5H0L8S_GNrz6XunWtcNXq8YGQxxhZtex8zvdTDnwvD1qA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3FCD3064687;
        Thu, 17 Sep 2020 14:13:52 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v3 0/4] btrfs: free space tree mounting fixes
Date:   Thu, 17 Sep 2020 11:13:37 -0700
Message-Id: <cover.1600282812.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few fixes for issues with mounting the btrfs free space tree
(aka space_cache v2). These are not dependent, and are only related
loosely, in that they all apply to mounting the file system with
the free space tree.

The first patch fixes -o remount,space_cache=v2.

The second patch fixes /proc/mounts with regards to the space_cache
options (space_cache, space_cache=v2, nospace_cache)

The third patch fixes the slight oversight of not cleaning up the
space cache free space object or free space inodes when migrating to
the free space tree.

The fourth patch stops re-creating the free space objects when we
are not using space_cache=v1.

changes for v3:
Patch 1/4: Change failure to warning logging.
Patch 2/4: New; fixes mount option printing.
Patch 3/4: Fix orphan inode vs. delayed iput bug, change remove function
           to take inode as a sink.
Patch 4/4: No changes.

changes for v2:
Patch 1/3: made remount _only_ work in ro->rw case, added comment.
Patch 2/3: added btrfs_ prefix to non-static function, removed bad
           whitespace.

Boris Burkov (4):
  btrfs: support remount of ro fs with free space tree
  btrfs: use sb state to print space_cache mount option
  btrfs: remove free space items when creating free space tree
  btrfs: skip space_cache v1 setup when not using it

 fs/btrfs/block-group.c      | 42 +++-----------------
 fs/btrfs/disk-io.c          | 20 ++++++++++
 fs/btrfs/free-space-cache.c | 78 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  5 +++
 fs/btrfs/free-space-tree.c  |  3 ++
 fs/btrfs/super.c            | 42 +++++++++++++++++---
 fs/btrfs/transaction.c      |  2 +
 7 files changed, 150 insertions(+), 42 deletions(-)

-- 
2.24.1

