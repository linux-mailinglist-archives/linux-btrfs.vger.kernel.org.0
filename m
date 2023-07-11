Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8774E857
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGKHuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKHuF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 03:50:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03103DB
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 00:50:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42062226FE
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689061802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rmndyjrxSNEgdM8a7sX4FOW8Zshm68yQU+nFAAycu/I=;
        b=lawEputf//nvFQ9YKIaZCyRN7c6+6/nI3DaA1FxPFT4dkkwmrkqgEIcrUwywh++5PvXZOB
        BZUilSHtjt8aD4pcVLRRmKhh8DgA97Prry6+X4UEjNO92TariMQM6Y3mRhHpct1ME/DjYq
        HL5iNHZFWTP936UMU270TkfyWi7HXio=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F36F1391C
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 07:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vEQPBKkJrWS6LgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 07:50:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: preparation patches for the incoming metadata folio conversion
Date:   Tue, 11 Jul 2023 15:49:38 +0800
Message-ID: <cover.1689061099.git.wqu@suse.com>
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

[OBJECTIVE]

So this patchset is the preparation to reduce direct page operations for
metadata.

The patchset would do this mostly be concentrate the operations to use
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

 fs/btrfs/extent_io.c             | 219 ++++++++++++++-----------------
 fs/btrfs/tests/extent-io-tests.c | 161 +++++++++++++++--------
 2 files changed, 204 insertions(+), 176 deletions(-)

-- 
2.41.0

