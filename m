Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035FB68AEE5
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Feb 2023 09:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBEIyG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Feb 2023 03:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBEIyF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Feb 2023 03:54:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730981C7EA
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 00:54:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A00802043F
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 08:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675587240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ehnp3Av5PACobTh7+9xCBwjyTgC5sjy0XsKeABbDtJA=;
        b=Y9t5r//YZW9wnyckhNryMgA+ks55V2hxn0/1pWYZl2lhteOPtLUPg5vUNgsqURpdsTg6ef
        vmIec7iMF0Io8BMKlbYxEvSwrJ9X7PSbTDu7jfJYfGWmKNzLBhOPtX1eX1z3ayO6SFDQOe
        WsvCvTp7z78lzjknS11tB3ZlVB6YDUk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E3A2138E7
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 08:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zOjBMqdu32NWNQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Feb 2023 08:53:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: reduce div64 calls for __btrfs_map_block() and its variants
Date:   Sun,  5 Feb 2023 16:53:40 +0800
Message-Id: <cover.1675586554.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
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

Div64 is much slower than 32 bit division, and only get improved in
the most recent CPUs, that's why we have dedicated div64* helpers.

One usage of div64 is in __btrfs_map_block() and its variants, where we
got @stripe_nr as u64, and all later division has to go the div64
helpers.

But the truth is, with our current chunk size limit (10G) and fixed
stripe length (64K), we can have at most 160K stripes in a chunk, which
is small enough for u32 already.

So this patchset would reduce div64 calls by:

- Remove map_lookup::stripe_len first
  So now we don't need to call div64 to calculate @stripe_nr, just a
  simple right shift, then truncate to u32.

  This is a prerequisite for the 2nd patch, without the fixed stripe
  length, we have to rely on div64.

- Reduce the width of various @stripe_nr to 32

- Use regular divitsion and module to do the calculation
  Now we can get rid of the fear that we missed some div64 helpers.
  

Qu Wenruo (2):
  btrfs: remove map_lookup->stripe_len
  btrfs: reduce div64 calls by limiting the number of stripes of a chunk
    to u32

 fs/btrfs/block-group.c            |  18 ++---
 fs/btrfs/scrub.c                  |  43 ++++++------
 fs/btrfs/tests/extent-map-tests.c |   1 -
 fs/btrfs/tree-checker.c           |  14 ++++
 fs/btrfs/volumes.c                | 110 +++++++++++++++---------------
 fs/btrfs/volumes.h                |   7 +-
 6 files changed, 104 insertions(+), 89 deletions(-)

-- 
2.39.1

