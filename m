Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C18386FF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 04:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbhERCj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 22:39:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:39192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344300AbhERCjZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 22:39:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621305487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cr7vX8uJ/nEUGa+B+Vq+kYfQrRUBFXUCqER4vwDwNQk=;
        b=X0tKaajpdnetQmU8CTYonlTEL7G1LIFfU/EHi5g/emfQwQXcQls3lrvrqdewc98ceYN4Nz
        TIKHPaDT2Q904cID7UmvvcR8u0HgGeKsE8irtXHlaiJNOHsLwVJDnOB9j3UvXMFU/wXcGW
        CdfHKSuNtTlN0Lf3RAtFbnEhJMjeHWM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F642B14A
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 02:38:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: fixes for the 13 subpage preparation patches
Date:   Tue, 18 May 2021 10:38:01 +0800
Message-Id: <20210518023803.107768-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although Ritesh and Goldwyn were both testing full subpage patches and
got pretty good results, our awesome maintainer David still found some
crashes:

- btrfs/125 hang on x86
  This test case is not in auto group, and for subpage case we reject
  RAID56 thus it doesn't trigger the crash.
  It's a behavior change in page Ordered (private2) cleanup sequence.
  We can no longer cleanup Private2 and then finish ordered extent.
  We have to do them in the same run, or later
  btrfs_mark_ordered_io_finished() will skip pages without Ordered bit,
  and causing the hang.

  This needs a dedicated fix, but it's still pretty small, and won't
  affect normal routines.

- generic/521 random crash on x86
  Which I can't reproduce, but according to the dying message, it's not
  hard to find the problem.
  An assignment out of the protection of spinlock.
  This small fix can be folded into patch "btrfs: introduce
  btrfs_lookup_first_ordered_range()"

Changelog:
v2:
- Fix the typos in the commit message of the 1st patch
- Remove the ClearPageOrdered() call in the 1st patch
  As btrfs_mark_ordered_io_finished() will clear it in a more accurate
  way.
  And ClearPageOrdered() is not subpage compatible.

Qu Wenruo (2):
  btrfs: fix the never finishing ordered extent when it get cleaned up
  btrfs: fix the unsafe access in btrfs_lookup_first_ordered_range()

 fs/btrfs/inode.c        | 21 ++++++++++++++++++++-
 fs/btrfs/ordered-data.c |  3 ++-
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.31.1

