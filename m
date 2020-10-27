Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB929CAF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832080AbgJ0VJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:09:02 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55237 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411855AbgJ0VJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:09:01 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 957705C0197;
        Tue, 27 Oct 2020 17:09:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=EpO9puftI78qh
        /vOTxmaFw+cP+HSj1Kt/DD7SHV/stk=; b=EdtR6GuNJ4xVy6uJbx5vp4q+IHEia
        D4sfF6zeIfqcQUODj0AamUSe9hlX50nH2NVCD5NmFMXSfyJ5Bcyrv0IfyLtFWqt7
        /WKf757pijehl19B2wvQQLgIHFxZRgslH9sS2+lTYOcoVpbyPsXE3N2lllh0nfoH
        zwd2kDiboio45A4BzHBZX4KZlSliGmvUdVwxR6DSJPEMvPerQ/hdkcIjOHLwh408
        3s4p3Ym41WlBWAGphSDecHYheMGChXMx/8OUyhIawjar3GBiZPP2i1zRArRk9lry
        Jg8dCQM3OyXBWVaQHQRTHj96NcUM6gxK8wZoZxs9xBLYdHIeVLZINP++Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=EpO9puftI78qh/vOTxmaFw+cP+HSj1Kt/DD7SHV/stk=; b=JdPJ6lNS
        xXGqYcqSpfEhv3+bsBE+YKGDPtby9b6bNNhckNkiTNKwxBaoZIT1Lff+paZf9VLp
        rpGOpNvpEailiGkXSvmhLF/Ib46m9VjHrOHRduIph6G/v2F17S1o0lotIpC3XOsi
        6/Gpexgv2uOCJQCnKByhKqM47DvzPkx/dre8DFMxHbxpKH5GNg5kI49iQZg96rBg
        wVNLTDSZXfV66c/aCNz9J95mJOWlVSMJgZcJ26kmGbNAjA876+iysNHlLFUOIaD+
        cf4JYRnc7ml5szFDyLh1t3FBjc/+WxcR/IqCDTy1mXj2eYasdaYFj/LB8cQGqmGL
        uHfVBTbXC5xJgg==
X-ME-Sender: <xms:bIyYX0bdzoTEAqIocxePIboXFpbppX4jLRX-bgnuvkdy_dSVP6_R9w>
    <xme:bIyYX_Y2X1_CvvMBb-7pNNtgUm030EcVKHrgWfABekZo64giJjsHPZLWsKeix5fX4
    -t1dwmbUvP0qXpKJRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:bIyYX-_CEx10q8zvEOKKZ4r9tUBL3KZ36IeTTdbO5J3B2UEP-hud3A>
    <xmx:bIyYX-olxF1V7iZp0aJsroPkGJAtbFGHgZB7sl5lFSGkzyDk735lkw>
    <xmx:bIyYX_okkEI4wsQ959RUif9soUE9MjxKGg0N0w-Xc6kjtbaFW88_1w>
    <xmx:bIyYX-SudssIRr6QtIHucSIPor6P3K6hoy53CCeQXofzztoTMxHYAQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 268E73280065;
        Tue, 27 Oct 2020 17:09:00 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v5 08/10] btrfs: warn when remount will not change the free space tree
Date:   Tue, 27 Oct 2020 14:08:02 -0700
Message-Id: <216bded423dc55c5d3b8744ec20b4a7030ab3317.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If the remount is ro->ro, rw->ro, or rw->rw, we will not create or
clear the free space tree. This can be surprising, so print a warning
to dmesg to make the failure more visible. It is also important to
ensure that the space cache options (SPACE_CACHE, FREE_SPACE_TREE) are
consistent, so ensure those are set to properly match the current on
disk state (which won't be changing).

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/super.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6533758f882a..ed28985a6762 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1865,6 +1865,24 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
 
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
+	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    ((!sb_rdonly(sb) || *flags & SB_RDONLY))) {
+		btrfs_warn(fs_info,
+	   "remount supports changing free space tree only from ro to rw");
+		/*
+		 * Make sure free space cache options match the state on disk
+		 */
+		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+		if (btrfs_free_space_cache_v1_active(fs_info)) {
+			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+	}
+
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out;
 
-- 
2.24.1

