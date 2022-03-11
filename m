Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE04D5C78
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 08:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347223AbiCKHkM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 02:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347225AbiCKHkM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 02:40:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8249256408
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 23:39:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 402271F38D
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646984347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KlbMWigG3taDVaCopgLoZiZWAna4pQMoDmtXmVdU3X4=;
        b=Gzam8xKfurf7HGE8/11nx3rtLF3zoQoQ9YBeNjfwxFO2uL32m9fCKFaPmQM5+yXEb1Q4Bk
        qpJEqoNjQLgBZbs7dBkkfvtBj0ShH1gSZCxnNh0r98sJ9LXsgfk8iQ9qhtm6qjVBpsdp/D
        FSttw4K7MNUUo18Lr641hCKUyMsbrmI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92FD613A82
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aPh6F5r8KmKkJgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/9] btrfs: refactor scrub entrances for each profile
Date:   Fri, 11 Mar 2022 15:38:40 +0800
Message-Id: <cover.1646984153.git.wqu@suse.com>
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

This patchset is cherry-picked from my github repo:
https://github.com/adam900710/linux/tree/refactor_scrub

[Changelog]
v2:
- Rebased to latest misc-next

- Fix several uninitialized variables in the 2nd and 3rd patch
  This is because @physical, @physical_end and @offset are also used for
  zoned device sync.

  Initial those values early to fix the problem.

v3:
- Add two patches to better split cleanups from refactors
  One to change the timing of initialization of @physical and
  @physical_end

  One to remove dead non-RAID56 branches after making scrub_stripe() to
  work on RAID56 only.

- Fix an unfinished comment in scrub_simple_mirror()

v4:
- Rebased after scrub renaming patchset
  Only minor conflicts.

- Fix uninitialized variable in patch 6 and 7
  Now there should be no uninitialized even only patches 1~6 are
  applied.

[CRAP-BUT-IT-WORKS(TM)]

Scrub is one of the area we seldom touch because:

- It's a mess
  Just check scrub_stripe() function.
  It's a function scrubbing a stripe for *all* profiles.

  It's near 400 lines for a single complex function, with double while()
  loop and several different jumps inside the loop.

  Not to mention the lack of comments for various structures.

  This should and will never happen under our current code standard.

- It just works
  I have hit more than 10 bugs during development, and I just want to
  give up the refactor, as even the code is crap, it works, passing the
  existing scrub/replace group.
  While no matter how small code change I'm doing, it always fails to pass
  the same tests.

[REFACTOR-IDEA]

The core idea here, is to get rid of one-fit-all solution for
scrub_stripe().

Instead, we explicitly separate the scrub into 3 groups (the idea is
from my btrfs-fuse project):

- Simple-mirror based profiles
  This includes SINGLE/DUP/RAID1/RAID1C* profiles.
  They have no stripe, and their repair is purely mirror based.

- Simple-stripe based profiles
  This includes RAID0/RAID10 profiles.
  They are just simple stripe (without P/Q nor rotation), with extra
  mirrors to support their repair.

- RAID56
  The most complex profiles, they have extra P/Q, and have rotation.

[REFACTOR-IMPLEMENTATION]

So we have 3 entrances for all those supported profiles:

- scrub_simple_mirror()
  For SINGLE/DUP/RAID1/RAID1C* profiles.
  Just go through each extent and scrub the extent.

- scrub_simple_stripe()
  For RAID0/RAID10 profiles.
  Instead we go each data stripe first, then inside each data stripe, we
  can call scrub_simple_mirror(), since after stripe split, RAID0 is
  just SINGLE and RAID10 is just RAID1.

- scrub_stripe() untouched for RAID56
  RAID56 still has all the complex things to do, but they can still be
  split into two types (already done by the original code)

  * data stripes
    They are no different in the verification part, RAID56 is just
    SINGLE if we ignore the repair path.
    It's only in repair path that our path divides.

    So we can reuse scrub_simple_mirror() again.

  * P/Q stripes
    They already have a dedicated function handling the case.

With all these refactors, although we have several more functions, we
get rid of:

- A double while () loop
- Several jumps inside the double loop
- Complex calculation to try to fit all profiles

And we get:

- Better comments
- More dedicated functions
- A better basis for further refactors

[FUTURE CLEANUPS]
- Refactor scrub_pages/scrub_parity/... structures
- Further cleanup RAID56 codes

Changelog:
v2:
- Rebased to latest misc-next

- Fix several uninitialized variables in the 2nd and 3rd patch
  This is because @physical, @physical_end and @offset are also used for
  zoned device sync.

  Initial those values early to fix the problem.

v3:
- Add two patches to better split cleanups from refactors
  One to change the timing of initialization of @physical and
  @physical_end

  One to remove dead non-RAID56 branches after making scrub_stripe() to
  work on RAID56 only.

- Fix an unfinished comment in scrub_simple_mirror()

Qu Wenruo (9):
  btrfs: calculate @physical_end using @dev_extent_len directly in
    scrub_stripe()
  btrfs: introduce a helper to locate an extent item
  btrfs: introduce dedicated helper to scrub simple-mirror based range
  btrfs: introduce dedicated helper to scrub simple-stripe based range
  btrfs: scrub: cleanup the non-RAID56 branches in scrub_stripe()
  btrfs: use scrub_simple_mirror() to handle RAID56 data stripe scrub
  btrfs: refactor scrub_raid56_parity()
  btrfs: use find_first_extent_item() to replace the open-coded extent
    item search
  btrfs: move scrub_remap_extent() call into scrub_extent() with more
    comments

 fs/btrfs/scrub.c | 1037 +++++++++++++++++++++++++---------------------
 1 file changed, 559 insertions(+), 478 deletions(-)

-- 
2.35.1

