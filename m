Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174662B8820
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgKRXGu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:50 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51319 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbgKRXGu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:50 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 87402CE3;
        Wed, 18 Nov 2020 18:07:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=qhJNwfFO32uVvXe17S26UzeX38
        a8eFRmWBBGcLmUESc=; b=dJ3h+4e1WQLVbnJpzrnhLLQwp0yWYVmL6Jq8/Ng8Zs
        3WMx52qAUT/O6dU5SxxH/gii4n26t77tpSPnryFXFTmEXptkx/b9bZlU1J1CYjVw
        MPZpUxixw98UOevdGhtoCgTaZSwF/I39jqIfo7rgv0GVOoSLNwM2QuSThNGnyPwn
        ln2RFxwSYi/16dWp2rXIedohxHJ/0qDLpBo2SGUD4DwXWDBvAi9P+L/wXPK4kpvY
        DvOsTz5T7mKEH0CY7+f52jIIobJ1zu8m2bCgjCI2SO1a2VCW9OrHiucAkWH9CcZ4
        ZO3NkUUez+uIYmmYtBbWMwVbcilRxx9ugSh/AM57RsmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=qhJNwfFO32uVvXe17S26UzeX38a8eFRmWBBGcLmUESc=; b=WrTiZGkB
        LALnBhSyY70v31uJIeEVZov0t9WShqo383ym2b7S9GZuV9FN9ytgfksDC77yyi9e
        HYlDiczKlC53q6EDAX0ZSIgHrq70WvtfDl2TNOTxKBTecYQeUDMzokiWSlOnI839
        LXAw1dAokRsWiWHqTSR00EPhaksYEAqgMfvZCs5U11x7iOn3s3W/IdGpPoebVK91
        4cugMFpEbpDb2DDS5zleFHmUFHgFOcDgAPqNwFJayCijoaOW7Of8doCf5M+jjRa/
        Rasg7ub04+pqFBHfnUHmeyPDC+/PVSJJgjP5hKh2g/cpPhMouL7bC38OyShMQnUm
        7VK0hz/LnvDjEA==
X-ME-Sender: <xms:Gqm1XxQCK25YzqQXs5AJPL5za-dTdFaypuZJfACWagmmmDCkcydDAg>
    <xme:Gqm1X6z2kxaoFGyGAl3NaHYE6LWTU9LDCN3_xQxKJ8H5n9Ykm-RbUvRQf1yMvpd6z
    w6mZQRjjeCDVaq5f7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:Gqm1X23njhLoGUCjD-6di95_psTm_-mS8P6DpazmzXDJe7q-N4USjA>
    <xmx:Gqm1X5DjI27HLXpitQtx2Ul5KOpIiDo99tIzxt4HqbFrNU5nEBLNuA>
    <xmx:Gqm1X6gIvwj4GOHdOWQDXlJwa4XoLwMA2zhdjaYaBsGFgv2Iq6_cfw>
    <xmx:Gqm1XwfT57k0BPUIFpnnKRO5uKyjXzf_UIiyaaHFi9XKdw__VyJnCg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id B261D328005E;
        Wed, 18 Nov 2020 18:07:05 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 08/12] btrfs: use sb state to print space_cache mount option
Date:   Wed, 18 Nov 2020 15:06:23 -0800
Message-Id: <db77b1ac25bd0876583a6cbb4fb64265d0504b7a.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To make the contents of /proc/mounts better match the actual state of
the file system, base the display of the space cache mount options off
the contents of the super block rather than the last mount options
passed in. Since there are many scenarios where the mount will ignore a
space cache option, simply showing the passed in option is misleading.

For example, if we mount with -o remount,space_cache=v2 on a read-write
file system without an existing free space tree, we won't build a free
space tree, but /proc/mounts will read space_cache=v2 (until we mount
again and it goes away)

cache_generation is set iff space_cache=v1, FREE_SPACE_TREE is set iff
space_cache=v2, and if neither is the case, we print nospace_cache.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ff19f900cee1..e2a186d254c5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1474,9 +1474,9 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",discard=async");
 	if (!(info->sb->s_flags & SB_POSIXACL))
 		seq_puts(seq, ",noacl");
-	if (btrfs_test_opt(info, SPACE_CACHE))
+	if (btrfs_free_space_cache_v1_active(info))
 		seq_puts(seq, ",space_cache");
-	else if (btrfs_test_opt(info, FREE_SPACE_TREE))
+	else if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		seq_puts(seq, ",space_cache=v2");
 	else
 		seq_puts(seq, ",nospace_cache");
-- 
2.24.1

