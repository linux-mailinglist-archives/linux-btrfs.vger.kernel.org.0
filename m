Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B6729CAF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832077AbgJ0VI5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:08:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60137 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411855AbgJ0VI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:08:56 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id ABCD55C019D;
        Tue, 27 Oct 2020 17:08:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=EZD77wTPzNkgQ
        L9U1ukgJiLTnRKxYsXRoOPTp0z4a/w=; b=ds5E/RMhfYSMFEv8lEPEYcrCsmoI7
        h7hd+HfWrgwTkHi+tuEFm61PpMIovmyYU2ryhwJMc9dBEWjxhkkpGYP7OOL74fJj
        A75I177myq7ZrckqWh8mCufoEolypZp4BCZJjGn1xUjVWEtQmTc5Z3G26gPjXfmu
        53ENwMfwdLu3D7nmLhSSKN+KpaLHNh1FJbJDDrUmrecpZCY99V3KxgXZoUL1mL26
        lgf0NbwiP8wrsD49u4Hqj2mDwvjcSiKWBEk0FZnZsukU7Fwit60KBKnURkecnmEr
        fBlDVTZc6GFiLjH6r20mm6VJhuXgwKmvXJMjxwPJAOGJCvpev6H6DJLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=EZD77wTPzNkgQL9U1ukgJiLTnRKxYsXRoOPTp0z4a/w=; b=Lwt2vw2Q
        fbORC0LIk+BEJl48G4Xj+JWI5IaXsCCzhgUgrAnz4+Ee6DMbQ5Uo2mTxoE94Mq18
        9e4t3QKuRLbdwGUSunCCZKdVFeZtxjRUrXLJJeCpgvNgXjDeelbU3BxQ/FHAUoQa
        s/ixRmgAWxejigw0hFmQgyXqtcPYwVPFhkKuyTb2Ebl0ABDyLgubcZexlapeIkO9
        sqbDM8kJffFz0oZblcQYUnnrkmSnrRGihX2JBS1wOz3e6buMHNE991ZwceMWkPXR
        7BDtAmXr+9yh2sJpPuzbYY/ykGMXIPjCEv1JXUxNcQWXhhiRswBqgOXb257jFQM9
        LVreP2xynOkC6Q==
X-ME-Sender: <xms:Z4yYX2f_KOyp3qWQOsO7QkfeuWqRT0BL7D19yN7Gi8cb2K9_B1cdDA>
    <xme:Z4yYXwNl1W8VlyEA_tLcpEoIhuKKvgL1t0i3_yxvRCuIeWQCyZrEyXshx_5OjArcW
    u3Wvzl7L9qgxHf-eb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:Z4yYX3gMwQaFRTFe3ADapG4n08FQSE2xoTKeubvhq9MUFuPbJ8gd0g>
    <xmx:Z4yYXz-L6SSsrn9TCRjezBde5o-FPGAMC9lrUajrAbl-PFWVyn31_A>
    <xmx:Z4yYXyuo4sZ6vARkRT62wBqtcm4FMucX_AfO0onEyso3T-REuhzUEg>
    <xmx:Z4yYX41ARkPAQpNcVqHUWwkwHED_j_Y-nYP3AMBE3qWCwSIi0Dv_YQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1ABE23280059;
        Tue, 27 Oct 2020 17:08:55 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v5 07/10] btrfs: use sb state to print space_cache mount option
Date:   Tue, 27 Oct 2020 14:08:01 -0700
Message-Id: <a2c0f0fbb5d70da4968f36f3e7a9847643b12334.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io>
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
index 58e54cd3c2c6..6533758f882a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1427,9 +1427,9 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
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

