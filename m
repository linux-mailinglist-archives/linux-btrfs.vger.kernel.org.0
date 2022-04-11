Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A014FB37D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 08:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiDKGP1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 02:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiDKGP0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 02:15:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF838DBC
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Apr 2022 23:13:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A6AE31F388
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 06:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649657590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/q2kf4sQqwZKNk4YGMtb//qupiq/lSRa7DFVV4VJZVY=;
        b=XKk78rBBqzgqdOwDumYSG6u/Z7MwLE7oCa8TGAkRGzMO+jtMXMioVm2dQcvSUMoRMidSBM
        /1hgSxDNKcE8ppHoY/AJ7HIw4qwV8lUVgDMUyjpV67Cy17bOTWYsUfr7tP6XnG8REjb+pX
        bytF/FQA+DnxrVqFHQESC7eU0/RMGRU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 093A113AB5
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 06:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kr4/MfXGU2LEfwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 06:13:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: vairous bug fixes related to generic/475 failure with subpage cases
Date:   Mon, 11 Apr 2022 14:12:48 +0800
Message-Id: <cover.1649657016.git.wqu@suse.com>
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

When testing my subpage raid56 support, generic/475 is always hanging
with some data page unable to be unlocked.

It turns out that, the hang is not related to the raid56 subpage
support (obviously, as the test case is not utilizing RAID56 at all),
but a recent commit 1784b7d502a9 ("btrfs: handle csum lookup errors
properly on reads") introduced a new error path, and it caught us by
surprise.

The new error path is from btrfs_lookup_bio_sums(), which can now return
error if the csum search failed.

This new error path exposed several problems:

- Double cleanup for submit_one_bio() and its callers
  Bio submission hooks, btrfs_submit_data_bio() and
  btrfs_submit_metadata_bio() will call endio to cleanup on errors.

  But those bio submission hooks will also return error, and
  finally callers of submit_extent_page() will also try to do
  cleanup.

  This will be fixed by the first patch, by always returning 0 for
  submit_one_bio().
  This fix is kept as minimal as possible, to make backport easier.
  The proper conversion to return void will be done in the last patch.

- btrfs_do_readpage() can leave page locked on error
  If submit_extent_page() failed in btrfs_do_readpage(), we only
  cleanup the current range, and leaving the remaining subpage
  range locked.

  This bug is subpage specific, and will not affect regular cases.

  Fix it by cleaning up all the remaining subpage range before
  exiting.

- __extent_writepage_io() can return 0 even it hit some error
  Although we continue writing the remaining ranges, we didn't save
  the first error, causing @ret to be overwritten.
 
  This bug is subpage specific, as for regular cases we only have one
  sector inside the page.

  Fix it by introducing @has_error and @saved_ret.

I manually checked all other submit_extent_page() callers, they all
look fine and won't cause problems like the above.

Finally since submit_one_bio() will always return 0, the final patch
will make it return void, which greatly makes our code cleaner.

But that patch is introducing quite some modifications, not a candidate
for backport, unlike the first 3 patches.

Special thanks to Josef, as my initial bisection points to his patch and
I have no clue why it can cause problems at all.
His hints immediately solved all my questions, and lead to this
patchset.

Qu Wenruo (4):
  btrfs: avoid double clean up when submit_one_bio() failed
  btrfs: fix the error handling for submit_extent_page() for
    btrfs_do_readpage()
  btrfs: return correct error number for __extent_writepage_io()
  btrfs: make submit_one_bio() to return void

 fs/btrfs/extent_io.c | 139 ++++++++++++++++++-------------------------
 fs/btrfs/extent_io.h |   3 +-
 fs/btrfs/inode.c     |   9 +--
 3 files changed, 61 insertions(+), 90 deletions(-)

-- 
2.35.1

