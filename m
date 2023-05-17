Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2D870614C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 09:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjEQHgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 03:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjEQHgD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 03:36:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD0D527D
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 00:36:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D9A21FF66
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684308961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fF43vjNjsTFdUzpka0M7QKbeRorqyGfn0/aWo+4waN4=;
        b=LRjEV80Jsi27tWdmhwrBhbWSCLSN2zxrCSm+ZCBXvPp9JaBOr8HMlqPRZMi9wdY6U8mLkB
        yNK0KOERMuK8cEkrNgOodKh47rvtyAhY8lkLivDhar6L9Zsrhvogx+jNa9cJ8o72F9fD/7
        YEqWEh0U8wAIjntY8zh9uw6B/Ws2gkc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 639DC13358
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gN4mCeCDZGQkEQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs-progs: csum-change: add the initial support for offline csum type change
Date:   Wed, 17 May 2023 15:35:35 +0800
Message-Id: <cover.1684308139.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[DESIGN]
The csum change workflow looks like this:

- Generate new data csums
  New data csums would have a different objectid (CSUM_CHANGE -13),
  other than the existing one (EXTENT_CSUM -10).

  The generation part would also verify the data contents, if any
  mismatch we would error out.

- Delete the old data csums

- Change data csums objectid

- Rewrite metadata csums in-place
  At this stage, we would check the checksum for both old and new algo.
  If the metadata matches the old csum, we rewrite using new csum.
  If the metadata matches the new csum, we skip it.
  If the metadata doesn't match either csum, we error out.

[TESTS]
For now it's only basically tested manually.

So far the result looks good, the result fs can pass "btrfs check
--check-data-csum".

[TODO]
- Support for resume
  Currently we won't resume an interrupted csum conversion.
  Although the design should be able to handle any interruption at data
  csum conversion part, and as long as metadata csum writes are atomic,
  the metadata rewrites should also be fine.

- Support for revert if errors are found
  If we hit data csum mismatch and can not repair from any copy, then
  we should revert back to the old csum.

- Suppot for precaustious metadata check
  We'd better read and very metadata before rewriting them.

- Extra test cases

Qu Wenruo (7):
  btrfs-progs: tune: rework the main idea of csum change
  btrfs-progs: tune: implement the prerequisite checks for csum change
  btrfs-progs: tune: add the ability to read and verify the data before
    generating new checksum
  btrfs-progs: tune: add the ability to generate new data checksums
  btrfs-progs: tune: add the ability to delete old data csums
  btrfs-progs: tune: add the ability to migrate the temporary csum items
    to regular csum items
  btrfs-progs: tune: add the ability to change metadata csums

 check/mode-common.c             |   11 +-
 convert/main.c                  |   12 +-
 kernel-shared/ctree.c           |    3 -
 kernel-shared/ctree.h           |   19 +-
 kernel-shared/disk-io.c         |    8 -
 kernel-shared/file-item.c       |   46 +-
 kernel-shared/file-item.h       |    4 +-
 kernel-shared/print-tree.c      |   11 +-
 kernel-shared/tree-checker.c    |   12 +-
 kernel-shared/uapi/btrfs_tree.h |    1 +
 mkfs/rootdir.c                  |   11 +-
 tune/change-csum.c              | 1053 +++++++++++++++++--------------
 tune/main.c                     |    2 +-
 tune/tune.h                     |    3 +-
 14 files changed, 649 insertions(+), 547 deletions(-)

-- 
2.40.1

