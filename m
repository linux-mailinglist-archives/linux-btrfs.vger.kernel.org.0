Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07D9386F7F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 03:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbhERBnR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 21:43:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238427AbhERBnP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 21:43:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621302116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=m99VCa/7iG4Qs/i3iU0C8BBz8g6nj+dVrncN49oqL40=;
        b=g0tpKJmSWv7jf3Sy514sSjC6EbC3u6InSfdJhqZ73u8IfBVg7w9oS2npfZXbBZBEgNDZSH
        f402qxlwEDQ/H7Q2iaS3v3g6cZk5LVLluABIQwCypF3MVvrR2HdW7k4Xr/JtTu393Jl0BX
        BDy/6bx8Uk77Lfk6QpstQTMMnqNPr08=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8162B115
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 01:41:56 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fixes for the 13 subpage preparation patches
Date:   Tue, 18 May 2021 09:41:50 +0800
Message-Id: <20210518014152.77203-1-wqu@suse.com>
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

Qu Wenruo (2):
  btrfs: fix the never finishing ordered extent when it get cleaned up
  btrfs: fix the unsafe access in btrfs_lookup_first_ordered_range()

 fs/btrfs/inode.c        | 20 ++++++++++++++++++++
 fs/btrfs/ordered-data.c |  3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.31.1

