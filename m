Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC8570F95
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 03:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiGLBhH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 21:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGLBhG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 21:37:06 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F562C13D;
        Mon, 11 Jul 2022 18:37:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 4831B1E6BB62A;
        Tue, 12 Jul 2022 09:37:02 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1657589823; bh=y/DZkYjNce34c1ltc+Hweg+VBPqUwo5EWavKtLafmCA=;
        h=From:To:Cc:Subject:Date;
        b=uXWEAx2pavwhDFMSvhk1LvsXmZXAONAZMxhEyGxpMlvY8gEAc92QWyeo8B1mVqUEr
         djrbqw3cHbsM4JA+al/RlOZQyFUOSJj7mLQC3g0H12Ua6AXJ3B0UT4/rzWq3MzOR28
         7GkR/ORKR2u3pIJAiN0VYLpoVLJo8G0ffXklro74=
From:   bingjingc <bingjingc@synology.com>
To:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     fdmanana@kernel.org, bingjingc@synology.com, robbieko@synology.com,
        bxxxjxxg@gmail.com
Subject: [PATCH v2 0/2] btrfs: send: fix sending link commands for existing file paths
Date:   Tue, 12 Jul 2022 09:36:30 +0800
Message-Id: <20220712013632.7042-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.0
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

There is a bug sending link commands for existing file paths. When we're
processing an inode, we go over all references. All the new file paths are
added to the "new_refs" list. And all the deleted file paths are added to
the "deleted_refs" list. In the end, when we finish processing the inode,
we iterate over all the items in the "new_refs" list and send link commands
for those file paths. After that, we go over all the items in the
"deleted_refs" list and send unlink commands for them. If there are
duplicated file paths in both lists, we will try to create them before we
remove them. Then the receiver gets an -EEXIST error when trying the link
operations.

BingJing Chang (2):
  btrfs: send: introduce recorded_ref_alloc and recorded_ref_free
  btrfs: send: fix sending link commands for existing file paths

 fs/btrfs/send.c | 195 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 181 insertions(+), 14 deletions(-)

-- 
2.37.0

