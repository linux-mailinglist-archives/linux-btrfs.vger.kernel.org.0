Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECED786789
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 08:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjHXGeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 02:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbjHXGdo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 02:33:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA7A8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 23:33:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65EBF20E4E
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 06:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692858821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RV8pdyGY+zvMsFO0vFvzcKWaDGgH9dX2Oivi5uVndPQ=;
        b=MbOT6usnCYgylHoG0WZyLb+mB+Lu1AB4Q4TRSRI8s9WnvhyrI8WCLR/T+sbTmdXhHulJSd
        1M8wX+hSO1qrNkj5YypDO+mCpPRPO+fydRjtakMEOKa3ZVXcuvBNtbS1vr+yAL9vx0VKTb
        La36GvcoapOCbw4wcSJLIAselUDRkaI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB00B138FB
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 06:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SotAIcT55mQqDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 06:33:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: make extent buffer memory continuous
Date:   Thu, 24 Aug 2023 14:33:35 +0800
Message-ID: <cover.1692858397.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
RFC->v1:
- Rebased to the latest misc-next branch
  Just a small conflicts in extent_buffer_memmove().

- Further cleanup the extent buffer bitmap operations

[REPO]
https://github.com/adam900710/linux/tree/eb_page_cleanups

This includes the submitted extent buffer accessors cleanup as
the dependency.

[BACKGROUND]
We have a lot of extent buffer code addressing the cross-page accesses, on
the other hand, other filesystems like XFS is mapping its xfs_buf into
kernel virtual address space, so that they can access the content of
xfs_buf without bothering the page boundaries.

[OBJECTIVE]
This patchset is mostly learning from the xfs_buf, to greatly simplify
the extent buffer accessors.

Now all the extent buffer accessors are turned into wrappers of
memcpy()/memcmp()/memmove().

For now, it can pass test cases from btrfs group without new
regressions.

Qu Wenruo (3):
  btrfs: warn on tree blocks which are not nodesize aligned
  btrfs: map uncontinuous extent buffer pages into virtual address space
  btrfs: utilize the physically/virtually continuous extent buffer
    memory

 fs/btrfs/disk-io.c   |  18 +--
 fs/btrfs/extent_io.c | 360 +++++++++++++------------------------------
 fs/btrfs/extent_io.h |  17 ++
 fs/btrfs/fs.h        |   7 +
 4 files changed, 139 insertions(+), 263 deletions(-)

-- 
2.41.0

