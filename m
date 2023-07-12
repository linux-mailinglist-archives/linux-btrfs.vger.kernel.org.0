Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18FD74FF79
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGLGjo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 02:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGLGjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 02:39:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EC19A7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 23:38:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6792A223B9
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689143884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/rQmHIRpexpl88HYvFWxd3FB17CWXxWdEMhUW9mUZ/8=;
        b=K0HhLMJsl1PxC2kXXxXiW56TLZEFdWbXooXCTlXw0RFT98yjXpsRcSHwsehMS1zq527ubl
        PV2FNaTkzP4T0cVhRoq2SMI/egNxZQ7pWgpuE3nte73jBIAJ35uxdEGrfK3bRpQf0UIocq
        JWdjQEUnlSdG3s6IW9JQBE1foIOQIko=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C872D133DD
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DewbJUtKrmRhDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/6] btrfs: preparation patches for the incoming metadata folio conversion
Date:   Wed, 12 Jul 2023 14:37:40 +0800
Message-ID: <cover.1689143654.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
v2:
- Define write_extent_buffer_fsid/chunk_tree_uuid() as inline helpers

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
development) to prevent regression.

Finally there is only one function which can not be properly migrated,
memmove_extent_buffer(), which has to use memmove() calls, thus must go
per-page mapping handling.

Thankfully if we go folio in the end, the folio based handling would
just be a single memmove(), thus it won't be too much burden.


Qu Wenruo (6):
  btrfs: tests: enhance extent buffer bitmap tests
  btrfs: refactor extent buffer bitmaps operations
  btrfs: use write_extent_buffer() to implement
    write_extent_buffer_*id()
  btrfs: refactor memcpy_extent_buffer()
  btrfs: refactor copy_extent_buffer_full()
  btrfs: call copy_extent_buffer_full() inside
    btrfs_clone_extent_buffer()

 fs/btrfs/extent_io.c             | 224 +++++++++++++------------------
 fs/btrfs/extent_io.h             |  19 ++-
 fs/btrfs/tests/extent-io-tests.c | 161 ++++++++++++++--------
 3 files changed, 215 insertions(+), 189 deletions(-)

-- 
2.41.0

