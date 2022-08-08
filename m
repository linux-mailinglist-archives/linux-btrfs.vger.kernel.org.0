Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC9358C658
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiHHK1p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiHHK1n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 06:27:43 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DC12708;
        Mon,  8 Aug 2022 03:27:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id E497D2B08A8E2;
        Mon,  8 Aug 2022 18:27:39 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1659954461; bh=TQLRjYrA+Sj8oaFJnOb2CN3R1WbhZr4ErqXj5Q6I/oI=;
        h=From:To:Cc:Subject:Date;
        b=g6EcVH1Y39kSynj4mWHGrNbbZKJkQFr5jX7r8oYoQbvO68cQAfiYE23Zpw0p1j6HE
         CEBsOI6HhbBxMaHs8uQo95ylFH0JKMUEJrrEzbdZRcTg8IoDG8izkggroOAv1c9Rcn
         nCYdwJoSl9KCRb4Gph87zyv5psTBqLq9kLzcF71M=
From:   bingjingc <bingjingc@synology.com>
To:     fdmanana@kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bingjingc@synology.com, robbieko@synology.com, bxxxjxxg@gmail.com
Subject: [PATCH 0/2] btrfs: send: fix a bug that sending unlink commands for directories
Date:   Mon,  8 Aug 2022 18:27:33 +0800
Message-Id: <20220808102735.4556-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

There is a bug sending unlink commands for directories. In
commit 46b2f4590aab ("Btrfs: fix send failure when root has deleted files
still open")', orphan inode issue was addressed. There're no reference
paths for these orphan inodes, so the send operation fails with an ENOENT
error. Therefore, in that patch, sctx->ignore_cur_inode was introduced to
be set if the current inode has a link count of zero for bypassing some
unnecessary steps. And a helper function btrfs_unlink_all_paths() was
introduced and called to clean up old reference paths found in the parent
snapshot. However, not only regular files but also directories can be
orphan inodes. So if it meets an orphan directory, a wrong unlink command
for this directory will be issued. Soon the unlink command fails with an
EISDIR error.


BingJing Chang (2):
  btrfs: send: refactor get_inode_info()
  btrfs: send: fix a bug that sending unlink commands for directories

 fs/btrfs/send.c | 390 +++++++++++++++++++++++-------------------------
 1 file changed, 189 insertions(+), 201 deletions(-)

-- 
2.37.1

