Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE4E5BA77E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 09:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIPH3B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 03:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIPH3A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 03:29:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E8DE8E
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 00:28:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8E681FFBA
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663313337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=n3blT+9BJo5RjXKDmhaVqL9N/ML2y92stpQxXuFguoY=;
        b=rgZvPgudtQFZqJSYsmUWoanxYcjGEp9Z2ekWMxpJcRUekoPwUyVajCFbW1M8EMKKb7pTFl
        MIKJAcuQUGvVNKzuaz4S+K0ggP5sY2ZSOj4l3bRPhKUCpQeN0sspMilYhcV9YqCZoU/J0z
        2QP/pyj8Pu17plZWaYU4SO+6RRHozls=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19BB61332E
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6mSdM7glJGMMKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:28:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs: btrfs_get_extent() cleanup for inline extents
Date:   Fri, 16 Sep 2022 15:28:34 +0800
Message-Id: <cover.1663312786.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we have some very confusing (and harder to explain) code
inside btrfs_get_extent() for inline extents.

The TL;DR is, those mess is to support inline extents at non-zero file
offset.

This is completely impossible now, as tree-checker will reject any
inline file extents at non-zero offset.

So this series will:

- Update the selftest to get rid of the impossible case

- Simplify the inline extent read

  Since we no longer need to support inline extents at non-zero file
  offset, some variables can be removed.

- Don't reset the inline extent map members

  Those resets are either doing nothing (setting the member to the same
  value), or making no difference (the member is not utilized anyway)

- Remove @new_inline argument for btrfs_extent_item_to_extent_map()

  That argument makes btrfs_get_extent() to skip certain member update.
  Previously it makes a difference only for fiemap.

  But now since fiemap no longer relies on extent_map, the remaining
  use cases won't bother those members anyway.

  Thus we can remove the bool argument and make
  btrfs_extent_item_to_extent_map() to have a consistent behavior.

- Introduce a helper to do inline extents read

  Now the function is so simple that, extracting the helper can only
  reduce indents.

[CHANGELOG]
v2:
- Do better patch split for bisection with better reason

- Put the selftest to the first to help bisection
  Or we may hit ASSERT() during selftest.

Qu Wenruo (5):
  btrfs: selftests: remove impossible inline extent at non-zero file
    offset
  btrfs: make inline extent read calculation much simpler
  btrfs: do not reset extent map members for inline extents read
  btrfs: remove the @new_inline argument from
    btrfs_extent_item_to_extent_map()
  btrfs: extract the inline extent read code into its own function

 fs/btrfs/ctree.h             |   1 -
 fs/btrfs/extent_map.c        |   7 +++
 fs/btrfs/file-item.c         |   6 +--
 fs/btrfs/inode.c             | 100 +++++++++++++++++++----------------
 fs/btrfs/ioctl.c             |   2 +-
 fs/btrfs/tests/inode-tests.c |  56 +++++++-------------
 6 files changed, 83 insertions(+), 89 deletions(-)

-- 
2.37.3

