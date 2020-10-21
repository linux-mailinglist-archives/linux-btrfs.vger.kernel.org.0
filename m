Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60AE295507
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 01:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507030AbgJUXHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 19:07:21 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57525 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507008AbgJUXHU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 19:07:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 68A6912A9;
        Wed, 21 Oct 2020 19:07:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Oct 2020 19:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=pqUS+qLKnhfJZ
        w6LuzTGU4lKfTwCWKWCZ4sh8oRYeMU=; b=FJC/L4w0rQx8IUydQGw/KhXf//KOF
        B2axJqas7CVVxWje4EzZyMnOmhYfbTuktOi1e5BHRbKN6jdhj5vAZKc0oanMz+oV
        9hPMbrEvvJWNutWz9n/1XX0I7vrAF6fdMd6dpj3AwgxOTOHYDTq67QHwO8YSJOAt
        dwxwZSYrXVOYnCNv+IqkAskVyBbA/y5zrzkvN+cqnpDHpMI0eNCIrWH0H4F3bqLL
        LtAOY4uLMaUNoJuUp4qP/bc1gvAeocwRj0LRx+UgKOLpquTZEy60cOQqCRsa9uKk
        RBFDdbGEKhbWgABM66SH4jh1sEKZqLGl0Ydo88sRyfzcNGdwh3PDnLEJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=pqUS+qLKnhfJZw6LuzTGU4lKfTwCWKWCZ4sh8oRYeMU=; b=X1BuKbDC
        1cRRIPo8TUs63zrifexXV0uDnN22EE2gNWDYojkaQBPa/atSoA6cwbn+FBgqKpZL
        7pSVkUaVSkhwgqsirmC2b5eE/CcX22qCJJ7Dpx0TV0Q1hzZCD2qfy8C0xeXDu9xD
        So+KfhZy10vPXzHPsE3cSNCVWiACXOlYDwsangnXyKLBQu9OHmeUlMWBRlwvHPmo
        tSvPdgEDsD8H0bbMLmzoY3qX+ImXICTOlJKkrzmGrqA6TD3RwI7qpVsg966gfcyg
        pFbcCJJ/wnnWekC/hakDOOaL58cn33gzu4w6ovprfGrKOH1acYf5dDiZYGwnQpc6
        nn006PhW/9DPzg==
X-ME-Sender: <xms:Jr-QX_ZtOnfzrOzDWo5Mw5CREV4KnVGAGN1IMt10wN3aGQ7OVRO9ng>
    <xme:Jr-QX-bxaT32NqUFEJlYUvHDHHBwYEbLcpfjdadJ-hNrOyPv2-sdXVrX8NYXr4vLy
    b6KSGSt8M45hgttPbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:Jr-QXx_72MCHz_S2cBQFM2ri3Tu-9FV-Uy1CreskVdJc1oZNMb-5YQ>
    <xmx:Jr-QX1oyeLUujHLhKyof2yXgHMQG-9UEU8gl5m-pTrjV27e-SpHvSw>
    <xmx:Jr-QX6oQpvRYO4w7gMe9NWIzzTphqD4TDjSu_3RdN2AD8Lns5R6d1Q>
    <xmx:J7-QXxS9uFQN5sZp9V-ByOGU0P0W_gXvnkRmOOwzbZpLoaUyQUng9A>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD0E83064674;
        Wed, 21 Oct 2020 19:07:18 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v4 6/8] btrfs: warn when remount will not create the free space tree
Date:   Wed, 21 Oct 2020 16:06:34 -0700
Message-Id: <ee7999f13f788759fd3b9f223e4196abc8ee7300.1603318242.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603318242.git.boris@bur.io>
References: <cover.1603318242.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If the remount is ro->ro, rw->ro, or rw->rw, we will not create the free
space tree. This can be surprising, so print a warning to dmesg to make
the failure more visible.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c78e3379fa93..5db278243a34 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1859,6 +1859,20 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
 
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    ((!sb_rdonly(sb) || *flags & SB_RDONLY))) {
+		btrfs_warn(fs_info,
+	   "remount supports enabling free space tree only from ro to rw");
+		/*
+		 * if we aren't building the free space tree, reset
+		 * the space cache options to what they were before
+		 */
+		btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+		if (btrfs_free_space_cache_v1_active(fs_info))
+			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+	}
+
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out;
 
-- 
2.24.1

