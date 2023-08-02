Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08F376CA4C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 12:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjHBKER (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbjHBKD7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 06:03:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7144B7
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 03:02:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F9D41F749
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690970560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=c/4ofg37V4RmsR6q0+YVlm5DRkAkm2vOR3nkNYQxj9A=;
        b=Pd2dV7BaVm2l/ijbrr/RQWG9bGJH9nahpeqSzzDx7wuYJWzo1SVTFqtob7HxkST6jY/PMH
        4P8rZ/oWTpLHY+5xC7FMC+Lpr2AJpQpmZemBQwxbgblhMdrOTvXOT1im3/u9Cdq+fAFwos
        h0JyJraQ9wVXcSLK9MtEdMxmpo1NgrY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 709F613909
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 10:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tfRvDb8pymQDeAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 10:02:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: fix an ASSERT() triggered inside prepare_to_merge()
Date:   Wed,  2 Aug 2023 18:02:18 +0800
Message-ID: <cover.1690970028.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

[CHANGELOG]
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

 fs/btrfs/disk-io.c      | 13 ++++++++++++-
 fs/btrfs/relocation.c   | 40 ++++++++++++++++++++++++++++++++++------
 fs/btrfs/tree-checker.c | 15 +++++++++++++++
 3 files changed, 61 insertions(+), 7 deletions(-)

-- 
2.41.0

