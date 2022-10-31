Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE135613433
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 12:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJaLLg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 07:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJaLLf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 07:11:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59059B847;
        Mon, 31 Oct 2022 04:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1634CB815E0;
        Mon, 31 Oct 2022 11:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED216C433C1;
        Mon, 31 Oct 2022 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667214691;
        bh=Oxlp09yroYRgvBSdhCOiolxQcbXzvoPBSpbmhof2feM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opl3udtGWTC7zekgxmYouurpf8PTePgj5ufw4VQVu0gL8h8W3cev32naEb9MaEewT
         WvOnZp+YZOKzseCDw4r5D0wAx+Ykio2K+CqDL45v98WlxDjRCT42I8eCwwUbGRrDmU
         6FMJfY0iz55yIYLkfjW2zXjLQkVdopULSddnlMxBi/JQ1lKEPg4IYN+eqEqHt7CoRh
         OaIqj93lavD5Qjmq7UThi3Gz/4pCTPPkWryL0OuwOzg7w+cj9BJkOCBgeSF+/r7BTe
         8qodfReH/V6QfdNdxYgN993VBeGRAX2yqsb0c/jPeW1tlftH/lUfxoMzPykbJYwoqu
         yohUegB8pJ4bw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/3] common/punch: fix flags printing for filter _filter_fiemap_flags
Date:   Mon, 31 Oct 2022 11:11:19 +0000
Message-Id: <a1a5c698061d4c4e6c8994cde7b51969d8929de3.1667214081.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667214081.git.fdmanana@suse.com>
References: <cover.1667214081.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In the filter _filter_fiemap_flags, if we get a flags field that only has
the 'last' flag set, we end up printing the string "nonelast", which is
ugly and not intuitive.

For example:

  $XFS_IO_PROG -f -c "pwrite 0 64K" $SCRATCH_MNT/foo > /dev/null
  $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags

Gives:

  0: [0..127]: nonelast

So fix this by updating the filter's awk code to reset the flags string to
an empty string if we have the "last" flag set and we haven't updated the
flags string before. So now the same test gives the following result:

  0: [0..127]: last

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/punch | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/punch b/common/punch
index 47a29c92..94599c35 100644
--- a/common/punch
+++ b/common/punch
@@ -130,6 +130,8 @@ _filter_fiemap_flags()
 			if (and(flags, 0x1)) {
 				if (set) {
 					flag_str = flag_str"|";
+				} else {
+					flag_str = "";
 				}
 				flag_str = flag_str"last";
 			}
-- 
2.35.1

