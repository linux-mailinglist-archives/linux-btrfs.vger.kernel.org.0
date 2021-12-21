Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41947B862
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 03:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhLUCeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 21:34:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43522 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhLUCeI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 21:34:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D6FB212C3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640054047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dxFfJcNbgD7gDtxEJH0har8f3GU+4Y7PsWJB5De9+54=;
        b=sVgVIWzTeF1X/7Xter6Uj1zVdSVKfSyrfgQy6BhwhNFwoVvfVqA+hf7qDrm5rDVC44+lfx
        D7MMoQDtb1K/yGC3/Q0UK7iQo9BCGtUdJUMYbAfB+LyyRLltQn8Sr002UI01xzO950Lj3z
        CmNCxAUL95/H7EMdsREelYXwWBJZdpo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3BCB13BDA
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1Lw9Ih49wWEOLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/4] btrfs: refactor scrub entrances for each profile
Date:   Tue, 21 Dec 2021 10:33:45 +0800
Message-Id: <20211221023349.27696-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Merry Chrismas and happy new year!

The branch is based on several recent submitted small cleanups, thus
it's better to fetch the branch from github:

https://github.com/adam900710/linux/tree/refactor_scrub

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

[RFC]
- Whether this refactor is preferred
  As one entrance, scrub_simple_mirror(), gets reused in other
  entrances, not sure if this is layer breakage.

- More testing in the real world
  Although it passes all known scrub/replace tests.
  I'm not yet confident in the RAID56 coverage.

Qu Wenruo (4):
  btrfs: introduce a helper to locate an extent item
  btrfs: introduce dedicated helper to scrub simple-mirror based range
  btrfs: introduce dedicated helper to scrub simple-stripe based range
  btrfs: use scrub_simple_mirror() to handle RAID56 data stripe scrub

 fs/btrfs/scrub.c | 680 ++++++++++++++++++++++++++++-------------------
 1 file changed, 400 insertions(+), 280 deletions(-)

-- 
2.34.1

