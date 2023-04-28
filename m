Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B056F1FED
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 23:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbjD1VC0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 17:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjD1VCZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 17:02:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB9810CF
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 14:02:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E8665C00B5;
        Fri, 28 Apr 2023 17:02:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 28 Apr 2023 17:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1682715739; x=1682802139; bh=WRiuYFsKp3
        NMEcfJTFVSIVBfMeQGP65hXZByyKDwWdc=; b=T6AeKIlofL5XZ/vA9uJKLXFQjB
        BBKDTvEK9OrZBTQrgYY1SCQ0rWqMClO5o/RKuTwHwCSMEWMJrkbw2/3dlt9XS3rB
        dkDSjt+Lmu/doyYSE8s0m1sArIcUR3pcr7vzGYT8H2lw1XhLWmKuKtGda1jyrnVj
        3p08ycp73r0dJFasl53rxAUSR533VJdsUkw6mYsNlKnqHy/bvWlN8fBSW56qhwQ1
        aXdn4uvPFIiJbq176p3FHN5rT/3XK7d09x6Y6LzltPqojjpZ/ubUb+xMtzLQp1b0
        SypWuaZ6/C1YL0Ym9GIhwBqxeaBePIVQ64kQb9TCUBeYrpGjAa+aAXcSbE8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1682715739; x=1682802139; bh=WRiuYFsKp3NMEcfJTFVSIVBfMeQG
        P65hXZByyKDwWdc=; b=Hlg3lgRMGY5G/gC8+DULi4B7VyYMnUeoZjLnN2Y9RM/W
        UCDx0kDF8yF+XEJoCA8hPL/4HKjKl6TedUds0BWK56CVZFCEXEZRK8NRAHk7v7x+
        e8rwjHwYzWz0yzjLB2oWCpp3bz6O3boniaEwRNn0h/zNRn3MJ3SwDFej/7Q5KVhc
        iCoLKQVYMwofGik/JnO0SaZ+iXZVukV2CuFuh1iZ7v2OwX3JczXBdkY6okXLS14w
        Da/91QGzW18O29M5/7ZxY1H0lhSdvWMCOpxuanA8rzggKsCWtroj0+A4PS/IjQH7
        UDFXlfQJilN1jiKa9mF7xJascqfCRHYLaTwfeHq6ww==
X-ME-Sender: <xms:WzRMZJ04PaST7zHHp4W24km_HMeFrautTRrxgg4FevJKhsnBM4pC3A>
    <xme:WzRMZAFFoI2x785cxFjX2I2iSNeE4-15o3-uuJXm9zC--VOm63XZb381yzMP7-D7Q
    T7J98pTHF7MFefyvWU>
X-ME-Received: <xmr:WzRMZJ6fiL07N8bJ3uC_mVbi4GOIsn_zM2v2XDEVQBqvN-DGUVIHcEgaGVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedukedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:WzRMZG1WH-HlZj0Y-DfnJe6BZN3KGuQq69hOwACKuGCg1e77fdbMHQ>
    <xmx:WzRMZMF-vXA3MpqF9OZf5EjooyiSyNWrPIK_odhViZnmsc1r-RW6cg>
    <xmx:WzRMZH_6Yvk4E8g3_rlMJNsaNpPlxM9NSGQ53Ixm9X2p9PgqIS1_2g>
    <xmx:WzRMZHPS4qXYVybjEHaUizVr6bJrfwlnfFSe2ywXv6IT64L38gGvnA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Apr 2023 17:02:18 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix encoded write i_size corruption
Date:   Fri, 28 Apr 2023 14:02:11 -0700
Message-Id: <e340cd5aef01df9826746dab5a74cb2fcce19a8e.1682714694.git.boris@bur.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have observed a btrfs filesystem corruption on workloads using
NOHOLES and encoded writes via sendstream v2. The symptom is that a file
appears to be truncated to the end of its last aligned extent, even
though the final unaligned extent and even the file extent and otherwise
correctly updated inode item have been written.

So if we were writing out a 1MiB+X file via 8 128K extents and one
extent of length X, isize would be set to 1MiB, but the ninth extent,
nbyte, etc.. would all appear correct otherwise.

The source of the race is a narrow (one code line..) window in which a
noholes fs has read in an updated isize, but has not yet set a shared
disk_i_size variable to write. Therefore, if two ordered extents run in
parallel (par for the course for receive workloads), the following
sequence can play out: (following "threads" a bit loosely, since there
are callbacks involved for endio but extra threads aren't needed to
cause the issue)

ENC-WR1 (second to last)                                         ENC-WR2 (last)
-------                                                          -------
btrfs_do_encoded_write
  set isize = 1M
  submit bio B1 ending at 1M
endio B1
btrfs_inode_safe_disk_i_size_write
  local isize = 1M
  falls off a cliff for some reason
                                                            btrfs_do_encoded_write
                                                              set isize = 1M+X
                                                              submit bio B2 ending at 1M+X
                                                            endio B2
							    btrfs_inode_safe_disk_i_size_write
                                                              local isize = 1M+X
                                                              disk_i_size = 1M+X
  disk_i_size = 1M
							    btrfs_delayed_update_inode
  btrfs_delayed_update_inode

And the delayed inode ends up filled with nbytes=1M+X and isize=1M, and
writes respect isize and present a corruted file missing its last
extents.

Fix this by holding the inode lock in the noholes case so that a thread
can't sneak in a write to disk_i_size that gets overwritten with an out
of date isize.

Fixes: 41a2ee75aab0290 btrfs: introduce per-inode file extent tree
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/file-item.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 018c711a0bc8..cd4cce9ba443 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -52,13 +52,13 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	u64 start, end, i_size;
 	int ret;
 
+	spin_lock(&inode->lock);
 	i_size = new_i_size ?: i_size_read(&inode->vfs_inode);
 	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
 		inode->disk_i_size = i_size;
-		return;
+		goto out_unlock;
 	}
 
-	spin_lock(&inode->lock);
 	ret = find_contiguous_extent_bit(&inode->file_extent_tree, 0, &start,
 					 &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
@@ -66,6 +66,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	else
 		i_size = 0;
 	inode->disk_i_size = i_size;
+out_unlock:
 	spin_unlock(&inode->lock);
 }
 
-- 
2.34.1

