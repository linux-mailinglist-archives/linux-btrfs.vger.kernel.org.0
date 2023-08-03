Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2745976E006
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 08:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjHCGHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 02:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjHCGHP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 02:07:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9231704
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 23:07:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 567FE219DE
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 06:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691042829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YXQ/sF24IPAOkfrJLnLR6USwMRo6IMxLCsGDNNxYjwg=;
        b=gk29j9PZu8QuwxsjERb4GpvXFBjEd0aObkODSClTwLbdu7/flu1T3MxXELly7MsDUTQxsc
        c9iIAFONnyPg8O0ISpLEfwFoy2GGeM11NnndgTSwg3eo704VnebyvAxtKDkGGxskp86yJY
        EeMhBaT3a+6Xh/pMHeEIUfzagF9qrpU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A23C5134B0
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 06:07:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q1YwGgxEy2TlDQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Aug 2023 06:07:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/3] btrfs: fix an ASSERT() triggered inside prepare_to_merge()
Date:   Thu,  3 Aug 2023 14:06:47 +0800
Message-ID: <cover.1691042474.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
v3:
- Update the comments and commit messages

- Replace the deleted ASSERT(0)s with WARN_ON()s

- Remove a debug dump_stack() in the last patch

v2:
- Add two new patches
  One to properly fix the root cause (race between quota tree creation
  and relocation).
  One to reject obviously corrupted reloc trees.

- Remove two ASSERT()s from merge_reloc_roots()

[BUG]
Syzbot reported an ASSERT() triggered inside prepare_to_merge(), which
turns out to be a regression caused by commit 85724171b302 ("btrfs: fix
the btrfs_get_global_root return value").

[CAUSE]
The race can happen between quota tree creation and relocation, the root
cause is btrfs_get_fs_root() can try to read quota tree as one fs tree,
thus setting ROOT_SHAREABLE flag.

This leads to relocation code to create a new reloc tree for quota tree,
which should not happen.
Furthermore at later relocation stages, we will grab quota root from
fs_info->quota_root, which is not the same as the one read by
btrfs_get_fs_root(), thus quota_root->reloc_root is NULL.

This triggers the ASSERT() and crash the system.

[FIX]
- Make sure non-subvolume trees are always grabbed from fs_info
  This changes btrfs_get_root_ref() to a more explicit checks,
  and would return PTR_ERR(-ENOENT) if a non-subvolume (data reloc tree
  still counts as a subvolume tree) objectid is provided.

  This is the root fix.

- Replace the ASSERT() with a more graceful exit
  Still does the extra kernel warning through
  btrfs_abort_transaction(), but with more useful error messages.

- Reject obviously incorrect reloc trees through tree-checker
  Just another layer of sanity checks for on-disk data.

Qu Wenruo (3):
  btrfs: avoid race with qgroup tree creation and relocation
  btrfs: exit gracefully if reloc roots don't match
  btrfs: reject invalid reloc tree root keys with stack dump

 fs/btrfs/disk-io.c      | 13 +++++++++++-
 fs/btrfs/relocation.c   | 44 +++++++++++++++++++++++++++++++++--------
 fs/btrfs/tree-checker.c | 14 +++++++++++++
 3 files changed, 62 insertions(+), 9 deletions(-)

-- 
2.41.0

