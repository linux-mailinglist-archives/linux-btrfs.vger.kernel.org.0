Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B53B1386
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 07:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhFWF5v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 01:57:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41952 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWF5u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 01:57:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36F6621941
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624427733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yPmYnpd/SAmb0Z/3igOjWF2NT9FhtY+Tn7GgCHUpxqU=;
        b=Aaf1NhiZ4YKbPTnsWUdJR0nVvlBL7RUut+g+KJ7LKJh5qlSxBy79Ifg8tdzEmMIm4a89Sv
        G1h38mO8c2mf/h3/8h2aPP52Gn4JjSF5hio5BNtzgowrmlgk61PUHkeZrvwE0TCQ8Zu3ut
        BRSBXNXApiv/myAJpooaPi3GqBwGHwg=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 3BDBFA3B8A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/8] btrfs: experimental compression support for subpage
Date:   Wed, 23 Jun 2021 13:55:21 +0800
Message-Id: <20210623055529.166678-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset is based on my previously submitted compression refactor,
which is further based on subpage patchset.

It can be fetched from the following repo:
https://github.com/adam900710/linux/tree/compression

It only has been lightly tested, no stress test/full fstests run yet.
The reason for such a unstable patchset is to get feedback on how to
continue the development, aka the feedback for the last patch.

The first 7 patches are mostly cleanups to make compression path to be
more subpage compatible.

The RFC is for the last patch, which will enable subpage compression in
a pretty controversial way.

The reason is copied from that patch:

```
This mechanism allows btrfs to continue handling next ranges, without
waiting for the time consuming compression.

But this has a problem for subpage case, as we could have the following
delalloc range for a page:

0		32K		64K
|	|///////|	|///////|
		\- A		\- B

In above case, if we pass both range to cow_file_range_async(), both
range A and range B will try to unlock the full page [0, 64K).

And which finishes later than the other range will try to do other page
operatioins like end_page_writeback() on a unlocked page, triggering VM
layer BUG_ON().

Currently I don't have any perfect solution to this, but two
workarounds:

- Only allow compression for fully page aligned range

  This is what I did in this patch.
  By this, the compressed range can exclusively lock the first page
  (and other pages), so they are completely safe to do whatever they
  want.
  The problem is, we will not compress a lot of small writes.
  This is especially problematic as our target page size is 64K, not
  a small size.

- Make cow_file_range_async() to behave like cow_file_range() for
  subpage

  This needs several behavier change, and are all subpage specific:
  * Skip the first page of the range when finished
    Just like cow_file_range()
  * Have a way to wait for the async_cow to finish before handling the
    next delalloc range

  The biggest problem here is the performance impact.
  Although by this we can compress all sector aligned ranges, we will
  waste time waiting for the async_cow to finish.
  This is completely denying the meaning of "async" part.
  Now to mention there are tons of code needs to be changed.

Thus I choose the current way to only compress ranges which is fully
page aligned.
The cost is we will skip a lot of small writes for 64K page size.
```

Any feedback on this part would be pretty helpful.

Qu Wenruo (8):
  btrfs: don't pass compressed pages to
    btrfs_writepage_endio_finish_ordered()
  btrfs: make btrfs_subpage_end_and_test_writer() to handle pages not
    locked by btrfs_page_start_writer_lock()
  btrfs: make compress_file_range() to be subpage compatible
  btrfs: make btrfs_submit_compressed_write() to be subpage compatible
  btrfs: use async_chunk::async_cow to replace the confusing pending
    pointer
  btrfs: make end_compressed_bio_writeback() to be subpage compatble
  btrfs: make extent_write_locked_range() to be subpage compatible
  btrfs: only allow subpage compression if the range fully covers the
    first page

 fs/btrfs/compression.c |  8 +++++--
 fs/btrfs/extent_io.c   |  7 ++++--
 fs/btrfs/inode.c       | 49 +++++++++++++++++++++++++++---------------
 fs/btrfs/subpage.c     | 24 ++++++++++++++++++++-
 4 files changed, 66 insertions(+), 22 deletions(-)

-- 
2.32.0

