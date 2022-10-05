Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952D95F5ABD
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 21:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiJETtc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 15:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJETt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 15:49:29 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F637F25C
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 12:49:26 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E3B5E5C01C4;
        Wed,  5 Oct 2022 15:49:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 05 Oct 2022 15:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1664999365; x=1665085765; bh=BO
        1+CiMC4oqAmR5mpTyhYgLTfZF8TEoQLLolW3UFqOA=; b=DyAAi7W6SMoHK+PLMJ
        NO7u5ePKGfMxtMsHWlat0lqXofnb4e/yDjF7m7vZqLQ2KoCywxdX8VAfvvZJLoU/
        bOHAqVqZwXYcW6ZJIgzz+QFI4Q8hBsA3YuwRavxFxWp2iUXj+Dm2RdpUjEZc7sMG
        4ZsEHSTxvmaXmzgL811gdt1RTQ8Iwk4XkkXjuUNKODYIxLBeRBbwwWMxI7Juowdi
        SyE/j6WB3+vkFlZb3F2kGZVoWIC3Avf4EwQaP56VMvLz+1QzXYpG/BrXnJvy+VPB
        1jt8wK20Dh+E2I72FlRWqZyt90r7fGya6ytQFl9C5Mg0ihMzdPOEEip3EdZWswUE
        yKAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664999365; x=1665085765; bh=BO1+CiMC4oqAm
        R5mpTyhYgLTfZF8TEoQLLolW3UFqOA=; b=J213dAaUlKt3SgAtIYgQ6fuT0SKRc
        NtvaX4CuiuiC9PmLscooslbwca6Q3FHCdBmheDZWAu7pufIM0qzoqN0t+iQl1AUF
        KreuJw0TzvxLgDdwq1OKpp4driJunXBtRDoZ9LsrnL4kBwRuu0tGfrpuUaOrarHV
        3cSwZn0NO+ly257oOibsPno+EdLUbUwJ6lElTRmxZtYmroq9hgvK9IjfR224JJ2h
        lGjs9p6tOxqUzfxClK7iUQmjmMqejemt6E5m81A5zP0u8e40ynhq0dLzusgbKfp7
        xjnJVbk6vdXH+4V014Z1AW/PwaBocS8sCoVH7jXmAeL+SgCVgBTwV5d2w==
X-ME-Sender: <xms:xd89Y1KBDAR9zymppR8eFro2YyhaQi0OdOxUrCB8jW8YnA2gtLOnRQ>
    <xme:xd89YxLYEJGVyfOLCz5x9AtPGFAaCG1wLAc3jPilH_fzSIG6jGC4qEJAKHMdOCJC6
    o7LnXp_O9hwSLnL7Ng>
X-ME-Received: <xmr:xd89Y9uDRKpEWQ0v_nL5ozUHNQHyx5UzN8LsJvW6sioNdb40UgRsBoWW7LCRfAUvJiH0twwALs5UXyXlfLlPxtQ7PPDZzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:xd89Y2ZSasrKdSANE8m3KD8yYijOd7mHPyu7S8pUMLF62eQ6knAsmQ>
    <xmx:xd89Y8Z9mFsUJstCJiSddlNyPdq1DwRPh5debOf8j1w3ZH2lXbyJ2g>
    <xmx:xd89Y6ANXCiOWRLPgQCiR3WzDJm0iaMa8js4ImJovqqygCNXgABjpQ>
    <xmx:xd89Y1Ahrry7_wF3bSjl5FB523dk8VP8a43oGu3q9H-gmdCGJ-nTDA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Oct 2022 15:49:25 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: 1G falloc extents
Date:   Wed,  5 Oct 2022 12:49:18 -0700
Message-Id: <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1664999303.git.boris@bur.io>
References: <cover.1664999303.git.boris@bur.io>
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

When doing a large fallocate, btrfs will break it up into 256MiB
extents. Our data block groups are 1GiB, so a more natural maximum size
is 1GiB, so that we tend to allocate and fully use block groups rather
than fragmenting the file around.

This is especially useful if large fallocates tend to be for "round"
amounts, which strikes me as a reasonable assumption.

While moving to size classes reduces the value of this change, it is
also good to compare potential allocator algorithms against just 1G
extents.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 45ebef8d3ea8..fd66586ae2fc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 	if (trans)
 		own_trans = false;
 	while (num_bytes > 0) {
-		cur_bytes = min_t(u64, num_bytes, SZ_256M);
+		cur_bytes = min_t(u64, num_bytes, SZ_1G);
 		cur_bytes = max(cur_bytes, min_size);
 		/*
 		 * If we are severely fragmented we could end up with really
-- 
2.37.2

