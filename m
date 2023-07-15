Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BB2754860
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGOLI4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 07:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOLIz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 07:08:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33752B5
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 04:08:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A77AF21FC0
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689419332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qRBLC/3YAPvoBWHa0idn8n96DgKlSkQ4fg9pN/YblEY=;
        b=OGVaNkAjCByuYkh7g+FFpQO3t51PuN8K3qfmTr+setjlmXdSIydbU0XQv1a+x+n96hzzI6
        rRc0VNU5SsrzXi8YZHv9e8LHKifEfbZtFU00pHgOrnd6+awTxBMNm2xpPlqLvZ+gI4C5SR
        XfxaKdwsk2kIBaeJmemvBlGT/dMdCdg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3657133F7
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:08:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XmPzLUN+smRcZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:08:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/8] btrfs: preparation patches for the incoming metadata folio conversion
Date:   Sat, 15 Jul 2023 19:08:26 +0800
Message-ID: <cover.1689418958.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
v2:
- Define write_extent_buffer_fsid/chunk_tree_uuid() as inline helpers

v3:
- Fix an undefined behavior bug in memcpy_extent_buffer()
  Unlike the name, memcpy_extent_buffer() needs to handle overlapping
  ranges, thus it calls copy_pages() which do overlap checks and switch
  to memmove() when needed.

  Here we introduce __write_extent_buffer() which allows us to switch
  to go memmove() if needed.

- Also refactor memmove_extent_buffer()
  Since we have __write_extent_buffer() which can go memmove(), it's
  not hard to refactor memmove_extent_buffer().

  But there is still a pitfall that we have to handle double page
  boundaries as the old behavior, explained in the last patch.

- Add selftests on extent buffer memory operations 
  I have failed too many times refactoring memmove_extent_buffer(), the
  wasted time should be a memorial for my stupidity.

[BACKGROUND]

Recently I'm checking on the feasibility on converting metadata handling
to go a folio based solution.

The best part of using a single folio for metadata is, we can get rid of
the complexity of cross-page handling, everything would be just a single
memory operation on a continuous memory range.

[PITFALLS]

One of the biggest problem for metadata folio conversion is, we still
need the current page based solution (or folios with order 0) as a
fallback solution when we can not get a high order folio.

In that case, there would be a hell to handle the four different
combinations (folio/folio, folio/page, page/folio, page/page) for extent
buffer helpers involving two extent buffers.

Although there are some new ideas on how to handle metadata memory (e.g.
go full vmallocated memory), reducing the open-coded memory handling for
metadata should always be a good start point.

[OBJECTIVE]

So this patchset is the preparation to reduce direct page operations for
metadata.

The patchset would do this mostly by concentrating the operations to use
the common helper, write_extent_buffer() and read_extent_buffer().

For bitmap operations it's much complex, thus this patchset refactor it
completely to go a 3 part solution:

- Handle the first byte
- Handle the byte aligned ranges
- Handle the last byte

This needs more complex testing (which I failed several times during
development) to prevent regression, thus extent buffer bitmap selftests
have been enhanced to catch all those new possible corner cases.

The same applies to memcpy_extent_buffer() and memmove_extent_buffer().
There are several pitfalls:

- memcpy_extent_buffer() name is not accurate
  Unlike plain memcpy(), memcpy_extent_buffer() needs to handle
  overlapping ranges.

- memmove_extent_buffer() must handle double page boundaries
  Explained in the last patch, thus its refactor can not go the same
  direction as memcpy_extent_buffer()

With too many times spent on debugging memmove_extent_buffer(), a new
selftest is added to prevent regression.

Qu Wenruo (8):
  btrfs: tests: enhance extent buffer bitmap tests
  btrfs: tests: add self tests for extent buffer memory operations
  btrfs: refactor extent buffer bitmaps operations
  btrfs: use write_extent_buffer() to implement
    write_extent_buffer_*id()
  btrfs: refactor main loop in copy_extent_buffer_full()
  btrfs: copy all pages at once at the end of
    btrfs_clone_extent_buffer()
  btrfs: refactor main loop in memcpy_extent_buffer()
  btrfs: refactor main loop in memmove_extent_buffer()

 fs/btrfs/extent_io.c             | 292 +++++++++++++----------------
 fs/btrfs/extent_io.h             |  19 +-
 fs/btrfs/tests/extent-io-tests.c | 309 +++++++++++++++++++++++++------
 3 files changed, 396 insertions(+), 224 deletions(-)

-- 
2.41.0

