Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F754C2BB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 13:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiBXM3Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 07:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBXM3R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 07:29:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD63C2649B4
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 04:28:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8993121155
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645705725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+P4kLt65X6It7BfOq/ravk42T5PgE0eFbnygonNOPF4=;
        b=OuexwvGAL1fRi0rBf7Ocgyh03ILUnnECU7MgWqw79LXjhgSF0mxwPCxTg22AX5ojjkrJE2
        CSBsIWig3adTwQTDt3PYHJlVHFEejg5FUfKFz/iEoKE6c8dfqyEQSl9dzRMFxscReZfQ7w
        TFQmarB8JoQybEB1h/9IpMYyy8M1jlk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C479113AD9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RXZcIvx5F2LhAgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] Btrfs: defrag: the remaining unmerged part
Date:   Thu, 24 Feb 2022 20:28:34 +0800
Message-Id: <cover.1645705266.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David has already rebased all bug fixes into his fix/autodefrag-io
branch.
(Although the last patch still lacks one line to make it work).

This patchset is the remaining related cleanups.

If the 2nd patch doesn't apply, it means the patch "trfs:
reduce extent threshold for autodefrag" is not correct, and doesn't
apply extent_thresh properly.

The first patch removes one unused parameter.
The second patch makes __btrfs_run_defrag_inode() to meet our current
standard.

Patch 3~6 re-introduce the btrfs_defrag_ctrl to cleanup the argument
lists, and make btrfs_defrag_file() reports accurate sectors_defragged.

The last patch introduces the needed trace events.
With the trace events, it's much easier to verify the defrag behavior,
and provide a user-friendly way to debug defrag bugs.

Originally I used those trace events to verfy the reduced extent_thresh
for autodefrag, but I found out a better way to verify the behavior
without using trace events.

So I'll send a new test case to check the changed autodefrag behavior.

Qu Wenruo (7):
  btrfs: remove unused parameter for btrfs_add_inode_defrag()
  btrfs: refactor __btrfs_run_defrag_inode()
  btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check
  btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
  btrfs: defrag: use btrfs_defrag_ctrl to replace
    btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
  btrfs: defrag: make btrfs_defrag_file() to report accurate number of
    defragged sectors
  btrfs: add trace events for defrag

 fs/btrfs/ctree.h             |  25 +++-
 fs/btrfs/file.c              |  92 +++++++--------
 fs/btrfs/inode.c             |   2 +-
 fs/btrfs/ioctl.c             | 213 ++++++++++++++++++-----------------
 include/trace/events/btrfs.h | 127 +++++++++++++++++++++
 include/uapi/linux/btrfs.h   |   6 +-
 6 files changed, 310 insertions(+), 155 deletions(-)

-- 
2.35.1

