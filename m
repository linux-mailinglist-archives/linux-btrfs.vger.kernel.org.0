Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B272D29F953
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgJ2X6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47617 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X6Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:24 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 618695C00AC;
        Thu, 29 Oct 2020 19:58:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=GMXWF2a5bNBR50Qj/zV5fD7WXt
        7VYDMpCurJd/0N7zk=; b=PZJpsJL0gg+HNjzVydNGoVUgimkGO8IA0/RHqmfbh3
        1wv7yM/dzsM3D9AHK6qgpsj4a3CMG2EZjc1w6jHEInJOsgjFCF7grWT7XI+Gd+l8
        2Vfcu88O/nDi2pRD+B25dkHnd2BTEEaZn2BozVMrhcekWHlzkgg5PKzaLRyFU8Jz
        vZzXRZHDEIfQMOssdZfXMNm+RCJ6AlZA++VuwKkxUq+ajpm0RdVAanWZPWwaoNoC
        kx2EG9Tv//d3v3gezXdKumzy9WtFvDOUtRjHP6zzAvXN+xzZAlhlwfPVxO3zp0b5
        aJ9YRCJWF26iONzveaw0LooKLrEwGgq4WN7Kvfun+sEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=GMXWF2a5bNBR50Qj/zV5fD7WXt7VYDMpCurJd/0N7zk=; b=gfdE3VtW
        FOdKOUJDLCEDhrEwT7gypbK7Xj+aJdq4u/ENSpVm4F3NksygfubL1LWyjYCUhlWY
        VXrDV2x/MnIjrDj8OFbye0yWToLRq97iNPrl9dbLy9rslrG3w1gi5gDAuLqoAx9E
        W2cfJRaQAMaAMAUqp5R6Tiadiz5FFJNn7PLRpg3OShA9h0ptfLYnbS3pjV0xXBYN
        mOx6V+w3rKgiQRol8PXaoeZQU95CLgG2jKpeY76lfOr/Lhp4AV3khOHqZWDZw20h
        vj7CCyw4f8+Ip+1hokXOpm9/KdnprLjmuMus1breO1yLSeXVLSjTgVXO2XX0rVaP
        qlxz9sEb/sO+Ow==
X-ME-Sender: <xms:H1ebX2T9uKf07JQ_XfUpRuSqWuTNnaqpu4jEA90Av9j5njcujBf7SQ>
    <xme:H1ebX7zXkTWtHHMwLJzO-RR0aTt6Vvf_pLwSpsXJyrXZEIPEduUHL0kaIqJm6wY-R
    szhhEWCvLpDK6zJD0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:H1ebXz0bnLeZa1qwCB7ZiUnIcoQ3rADOBmZpakUiDaqnYnPupu_Z0g>
    <xmx:H1ebXyDTD7VaC2Gv0EQAC2od-qgKsTh_WmxIL_lJC3RPcPKlQmlkFA>
    <xmx:H1ebX_hoL-1mWGFfia2vp6XqNttACnBDbMnnc5VAvxo9Ex1t7qNi3g>
    <xmx:H1ebXxfGut67n2_WYgYMppvmKl2GxhKWZhVPHBCdfH5LnO8kA4fDxQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0499A3280065;
        Thu, 29 Oct 2020 19:58:23 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 07/10] btrfs: use sb state to print space_cache mount option
Date:   Thu, 29 Oct 2020 16:57:54 -0700
Message-Id: <9361af6776a977c4ecab2d4bbd4161f0784e4482.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1604015464.git.boris@bur.io>
References: <cover.1604015464.git.boris@bur.io>
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
index 95465c5a3166..527ab305ac68 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1476,9 +1476,9 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
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

