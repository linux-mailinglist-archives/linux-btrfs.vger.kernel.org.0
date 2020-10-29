Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D714129F94F
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgJ2X6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:12 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38583 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X6L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id AF3255C009E;
        Thu, 29 Oct 2020 19:58:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=h7FMY6l6GhuxmnOsgSApRcJOTc
        +8aE0nMMynJ1gceQg=; b=hc9O3n3Leo9XlIEE56OpxclDSgiySGbJMAJwMLLq6O
        6V+YWBFzcz95MY7/b3vZBIWtA7s3OEsll7eORwbchYJLMzBjff4/39VYzyoF68tA
        UfDpq0M0nFYDd4dgGlBJypxphAQ7DNxJJ/ibXuFBl9oR9OYJmYAFb579yIQdxcZx
        UxOH9doPkd4LkSjBAIBG78/WL3p+zZGMMM/fjOgZH5e5K6/ty5YsYQKztFva8M1a
        uJcad0SHH4yzN6bOzURW2Pb+bVNZHNr3uCslJIOfMznB0/4G/SRXb0FjyYocb2Lw
        JkGTsktlNmmE09G8PRc4B5GpsuaK7wYsPnzZF64zJ6nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=h7FMY6l6GhuxmnOsgSApRcJOTc+8aE0nMMynJ1gceQg=; b=G16DTQJA
        YMx1Ix76CHEn38GW2SYJVcZGr0rh0XtZ/FM2wS6hpeyE8bjLxtdC5PuwWITxaH2W
        wenB2fnmi4Il+1a99uAaHNyepM+ZhD83NMQx93QsQMrTt8fr/1Xn2xBvLCyT76nA
        FYmfZ38Yl7+1KRLfe4hNK4qrlC2hQIEL90F7jIzxLmKqjOX8wMUP3+YW/BCJjOMu
        qLAMHwijTxIxSEYNa9GdQev5AlyuDOnztAt0qNaksgqIXtFmX896mIvpCfsi5QE5
        QkYwzNVeJjF7uW6r6m1x2hP1cZ8UJQz3DMWR2eidwH4iofkzhFaDCXulWeJP8lNQ
        MyF6pwR/W1ZLLA==
X-ME-Sender: <xms:ElebXw43cWhDS0kvSZQsKesd5uaUsqG2JdZ9Ci6nwdIG3-4FEFshWw>
    <xme:ElebXx4hiVyJ9PzwLghwh3H2-d58sZjhZmbEM4oXheZXXIB8NbWyzy9wY0jT6NmZZ
    X82B08DQY6xfqq8z0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:ElebX_dlLB2kyRj7lrpvYQQbd2MzPJaSCsXdxzgktQOBWVLEnImBQg>
    <xmx:ElebX1LAGsbXouTw6BnkT01HyA9XPNEU77aAxuEXIWBWzJ7qBCt5uw>
    <xmx:ElebX0JTCQaz0w-wKgqu2lmFL9HuyXBeFfsiIRQh9F0zSltnhtJuyg>
    <xmx:ElebX7kZWfTRdiA21o6zljyarhrhirMmSr7TzBVgEZB2mueFoAImww>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4A82A3280060;
        Thu, 29 Oct 2020 19:58:10 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 03/10] btrfs: create free space tree on ro->rw remount
Date:   Thu, 29 Oct 2020 16:57:50 -0700
Message-Id: <a1b60e506c13d9000bf0cf48b1374beb7e79056f.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1604015464.git.boris@bur.io>
References: <cover.1604015464.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a user attempts to remount a btrfs filesystem with
'mount -o remount,space_cache=v2', that operation silently succeeds.
Unfortunately, this is misleading, because the remount does not create
the free space tree. /proc/mounts will incorrectly show space_cache=v2,
but on the next mount, the file system will revert to the old
space_cache.

For now, we handle only the easier case, where the existing mount is
read-only and the new mount is read-write. In that case, we can create
the free space tree without contending with the block groups changing
as we go.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e42548287161..69a878d8cc79 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2922,6 +2922,17 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+		btrfs_info(fs_info, "creating free space tree");
+		ret = btrfs_create_free_space_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				"failed to create free space tree: %d", ret);
+			goto out;
+		}
+	}
+
 	ret = btrfs_resume_balance_async(fs_info);
 	if (ret)
 		goto out;
@@ -3384,18 +3395,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
-	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		btrfs_info(fs_info, "creating free space tree");
-		ret = btrfs_create_free_space_tree(fs_info);
-		if (ret) {
-			btrfs_warn(fs_info,
-				"failed to create free space tree: %d", ret);
-			close_ctree(fs_info);
-			return ret;
-		}
-	}
-
 	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
 		close_ctree(fs_info);
-- 
2.24.1

