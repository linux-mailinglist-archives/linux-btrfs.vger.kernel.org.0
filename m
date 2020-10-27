Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2406629CAF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832063AbgJ0VIb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:08:31 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60941 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1832061AbgJ0VIb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:08:31 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E9835C00AC;
        Tue, 27 Oct 2020 17:08:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=NwF33qAkYY5Jg
        9aMFkZt1nVLSAqpXE9HhMnBgW6gFJg=; b=P4BfpatDAkDMgIMKMLJuG+a/ppDw1
        7VD9pGiBooVXkfyBgVUYZFUjSH1IUl1t6ABB+sf0LuCF7BZXMqQOpnnnEv1yIVWH
        u+mlMwI0GI9S8DYQUNlSni7vSAmDug1Fs1ZBntUJN29+goXzzYLRxFfMXA/gs7OH
        cUo0aKqWnribVhXvDpqyQ5uFQmSHqqq6QbTFPhtFgIunPeOUXAIZLAYAeuChr+9j
        Z5FbvPfqCPDEwT+2ku9aRyvBgoseli9OWzvnAQkfjxplOaexSrJvfhCzztSsXUyJ
        hdAts9Urd1EzrK+PWNMjayMfBy85Y8j98GdC7mCNg+/54+OyDbA7h75nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=NwF33qAkYY5Jg9aMFkZt1nVLSAqpXE9HhMnBgW6gFJg=; b=kxJHqmvx
        BhoQdwCgnPTuvCyWNAHmrNmgrn5cci7o1AOE9CaO5c3vT0pdYLg3kPslkAIBMFcK
        yfGlw9WU8KBzlFzl/KySABj0/u8NQeVz84CzxtoLeyUK68kiPMDSEWk9TNEnuzOL
        t73CO3sBXehkLcsUOj3yUqBfelSK2u3oKtcRYIhMQYZnYxlgRyMPFBq90VXbH+B7
        U/9zUsHn7dzUS51EuYs7xOmEGD1r4Py+XQgKverjUpGhoEInC8dXQt+LzI0wO/FC
        0eZJXbCWU++ZIKa0tcrFer1X2rqDFgcInXOKi6bTsLMc5tSuPiIHSGBM45FQfC2W
        0HT8sMe85abbxg==
X-ME-Sender: <xms:ToyYXz0HzKhDbI2IAF26y0scnC8Q1aM6jvw5zIT38jVDfuqbgsQyvA>
    <xme:ToyYXyH_kQcxO6HiwF0Kqnbrd1gCr4WmO-Yywbh62T1W6e1DceCgPbHY_svV4zVxC
    jcLFAaL47Fklk0dPzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrieenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:ToyYXz6fLSwBkxnJNKnc5Mzk0OkmV2_1FEGf5YlDKkG39dJ-73Nb0w>
    <xmx:ToyYX43tiaLIp_TpYQmgPv3ZIbhjhew4DAZVRCiAs-Pp6iY9j-Lx4g>
    <xmx:ToyYX2GXZqCRCVRVkFJnpUJTREQkxtIAbqSNpmfQpm8f-CRvHi8LRA>
    <xmx:ToyYXxMmDLZl4sOv6HtJdahjqxKQ72r70bqG5TGbmcZfSIBDsPxijw>
Received: from localhost (unknown [163.114.132.6])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA35A3064610;
        Tue, 27 Oct 2020 17:08:29 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v5 02/10] btrfs: cleanup all orphan inodes on ro->rw remount
Date:   Tue, 27 Oct 2020 14:07:56 -0700
Message-Id: <56e0a8c18483c395d20fc6c69a42740d19742eb1.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we mount a rw file system, we clean the orphan inodes in the
filesystem trees, and also on the tree_root and fs_root. However, when
we remount a ro file system rw, we only clean the former. Move the calls
to btrfs_orphan_cleanup() on tree_root and fs_root to the shared rw
mount routine to effectively add them on ro->rw remount.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bff7a3a7be18..95b9cc5db397 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2826,6 +2826,14 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 	if (ret)
 		goto out;
 
+	down_read(&fs_info->cleanup_work_sem);
+	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
+	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
+		up_read(&fs_info->cleanup_work_sem);
+		goto out;
+	}
+	up_read(&fs_info->cleanup_work_sem);
+
 	mutex_lock(&fs_info->cleaner_mutex);
 	ret = btrfs_recover_relocation(fs_info->tree_root);
 	mutex_unlock(&fs_info->cleaner_mutex);
@@ -3308,15 +3316,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	down_read(&fs_info->cleanup_work_sem);
-	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
-	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
-		up_read(&fs_info->cleanup_work_sem);
-		close_ctree(fs_info);
-		return ret;
-	}
-	up_read(&fs_info->cleanup_work_sem);
-
 	btrfs_discard_resume(fs_info);
 	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
-- 
2.24.1

