Return-Path: <linux-btrfs+bounces-4357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6628A8603
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B03F1F21A3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDB91411FF;
	Wed, 17 Apr 2024 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2RvJUehZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FF17736
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364570; cv=none; b=rUf6sNTgHA2BX54TePHJi6vIReuO+XfmjgJaw8/Ncvoi8KdSIioBb6ZZ7hj7k7l3pV/O7UzypyaG8uepPSSsAabF814Rbr90gLJiyl1vIqRRmM9/gpXazIYMVWQnAWMFeyBP31bkD7yEZxiTgD5nkcGMyahsm399UfYaXWWD93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364570; c=relaxed/simple;
	bh=aqolu7X5ThEbNoHgfHAm0/f3DOIqXcd7HDtGO3Z6ryo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BeWBqiTKrtWSB04h20sFc6nJVXS5vEAeYqH4kg8eTNZi21N5V4e0CnxInKajvGWt8cT7tsQBaZAvxjcw2He2zbN3zVjYhxWUyNDk/h5FsF5RoDAPbGZtgFFzBvRgdfAJgzC/w2t3DpwpqCEQskkzToRdALrVJrumEEcgP0nZVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2RvJUehZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4375b8b4997so8353961cf.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364565; x=1713969365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2JWulGj8I+jPHzOyaYSkF/2fboxR/aEPf5c1IgW1C0=;
        b=2RvJUehZQgty3O2ik+A0cl6YK87ywHVyiNMZoyf3u/fECV5YPPhnzJrrGtS/LIUdiM
         RqfoV3iK9O8yLQSL+RhMgIYLIDXzTVPBKewu6xujjJiZFCaM4KdNh6+lZsPa1VBLhpZh
         +MmR1Ye2POlVPzMzP4P6kNhQIpEdVt5dUx6QIeXCbhSv0y6WaJKitvkJXM26xWxgZ3pu
         9wSjSRogahur7CT14fXYDcIzpHDKtQI7f1CMOjZCiOAs+aOsTUy1XvjCjV7h6ftKSi3g
         DUoCesE2rNy27V6OFqlFj1nZwlerbmTJLFn8qHujV9N7ZhbhmzPmV2uE4Q5C2fRUMgda
         ag1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364565; x=1713969365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2JWulGj8I+jPHzOyaYSkF/2fboxR/aEPf5c1IgW1C0=;
        b=SsLpZE4v/jjMGodsOTRocUwWum81yUXqybYLhuZFWUn0jmtArMPRsyvov8n3Vb3TRP
         31gVEP7Y8Ez8MgQaGuj8lCJVqZR5JY9baby23tEzxgN0QYqVGefUO9sj/VoxbuC9uEXm
         CV3q0wReQ//5DM4EW1oYjiEQiTFLMKJRY7VKaYX51XQeIpSVfmL2KRnVjy41Xx5A4RNW
         Alk78iAnOUPdBa+hMrJfpsooxEYo8806PEKudImezNu/GE9WTA2g3HVDx1KiQf8oEn4W
         CrN3OFjQbFhp8iqJSnQ8ei7m7UcIU/3qpyFVe1wpISjnOcTQ7TClabRkE4+0pTHh/HcZ
         w5Eg==
X-Gm-Message-State: AOJu0YwruuWL/O6z89TdUSMTQF0tmzzYlg3xbrJ6/sgneyeaNcqat16p
	pbmeUenoyGwKcsmFQ2wYOXPy5/LtY/jgzzq+vsa24BYxJTX0kMIZatVLHDSVAAtRb74Z0DvXpgC
	L
X-Google-Smtp-Source: AGHT+IHM4CUlTWEZEI/7PK3PtvT77FOnR5QHhxj0rYklePamf6sHiCrJ05bEAHWWonC6xRX4U6217Q==
X-Received: by 2002:a05:622a:19a4:b0:436:8e52:48b2 with SMTP id u36-20020a05622a19a400b004368e5248b2mr18882047qtc.18.1713364565446;
        Wed, 17 Apr 2024 07:36:05 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id kd2-20020a05622a268200b004369f4d31f2sm6325441qtb.50.2024.04.17.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 00/17] btrfs: restrain lock extent usage during writeback
Date: Wed, 17 Apr 2024 10:35:44 -0400
Message-ID: <cover.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We use the extent lock to cover a pretty wide range of operations during
writeback, and this has made things like the iomap conversion more annoying.
It's also relatively complex how the rules work, and in fact are different
between compressed and normal writeback.

This series is meant to address this by pushing the extent lock down to cover a
discreet set of operations.  Being able to clearly define what the extent lock
is protecting will give us a better idea of how to reduce it's usage or possibly
replace it in the future.

The current state of affairs has been we lock the page for the range we're going
to write back, and then we lock the extent, and then we start writeback.  This
looks a few different ways

COW:
lock page
  lock extent
    allocate the extent
    insert the pinned extent
    allocate the ordered extent
    clear DELALLOC
  unlock extent
unlock page

NOCOW
lock page
  lock extent
    lookup the file extent
      check if the file extent can be used nocow
        if no:
          cow_file_range
        if yes:
          insert pinned extent if prealloc
          allocate ordered extent
          clear delalloc
  unlock extent
unlock page

COMPRESS
lock page
  lock extent
  unlock extent
    create async objects for the page ranges
    compress the pages
    submit the compressed extents
      lock extent
        allocate the extent
        insert the pinned extent
        allocate the ordered extent
        clear DELALLOC
      unlock extent
      unlock pages

As you can see there's some variations above, but in essence the extent lock
protects

- Calling into the allocator.
- The em_tree modifications (pinned extent).
- Allocating and attaching the ordered extent.
- Clearing the various bits on the extent_io_tree.
- Looking up the file extent items on disk in the NOCOW case.

We don't actually need to protect the allocator when we're allocating, that has
it's own locking, we're not gaining anything from the lock being held there.

We also don't need to protect looking up the file extent items in the NOCOW
case, we are protected by the page lock here.  There are 3 cases we would need
to be worried about here

- Prealloc.  This locks the inode and calls btrfs_wait_ordered_range() before
  doing the preallocation, so there will be no dirty pages in this range before
  it begins the preallocation.
- Zero range.  Same as above.
- O_DIRECT.  We invalidate the page range before we start the write, so again
  we're protected here.

This allows us to reduce the scope of the extent lock to the 3 things that
really matter

- Protecting the em tree modifications.  This makes sense, this is directly
  related to the inode range.
- Protecting the extent_io_tree modifications.  Again this is clear.
- Allocating and attaching the ordered extent.  Also clear.

With this in mind we can push the extent locking down into the functions that do
these operations, and drastically simplify the locking that we're doing here.

I've run this through several runs of the CI to validate that this doesn't break
anything.  Nothing has failed yet, but it is a rather scary looking change, so a
sharp review is absolutely necessary, and having a decent soak time.  I would
like to get this merged ASAP so we can start pounding on it and make sure it's
solid before I attempt other locking related changes.  Thanks,

Josef
        

Josef Bacik (17):
  btrfs: handle errors in btrfs_reloc_clone_csums properly
  btrfs: push all inline logic into cow_file_range
  btrfs: unlock all the pages with successful inline extent creation
  btrfs: move extent bit and page cleanup into cow_file_range_inline
  btrfs: lock extent when doing inline extent in compression
  btrfs: push the extent lock into btrfs_run_delalloc_range
  btrfs: push extent lock into run_delalloc_nocow
  btrfs: adjust while loop condition in run_delalloc_nocow
  btrfs: push extent lock down in run_delalloc_nocow
  btrfs: remove unlock_extent from run_delalloc_compressed
  btrfs: push extent lock into run_delalloc_cow
  btrfs: push extent lock into cow_file_range
  btrfs: push lock_extent into cow_file_range_inline
  btrfs: move can_cow_file_range_inline() outside of the extent lock
  btrfs: push lock_extent down in cow_file_range()
  btrfs: push extent lock down in submit_one_async_extent
  btrfs: add a cached state to extent_clear_unlock_delalloc

 fs/btrfs/extent_io.c    |   8 +-
 fs/btrfs/extent_io.h    |   2 +
 fs/btrfs/inode.c        | 279 +++++++++++++++++++++++-----------------
 fs/btrfs/ordered-data.c |   6 +
 fs/btrfs/ordered-data.h |   1 +
 fs/btrfs/relocation.c   |   4 +-
 6 files changed, 177 insertions(+), 123 deletions(-)

-- 
2.43.0


