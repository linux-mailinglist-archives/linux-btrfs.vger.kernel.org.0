Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF09151E1C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgBDQT4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:19:56 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:40189 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBDQT4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:19:56 -0500
Received: by mail-qk1-f171.google.com with SMTP id b7so3269003qkl.7
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqw6cDTVWGXm6THa7zbRW8lp5WtYjqjUBHlnlRVe/u0=;
        b=WEsaUzBLSc7D8YCSr8BVkgI1LVjuGLP/0L7UQS3ovQZ0WVkTdWp3ZqPhrKhKZNHnQ8
         AgnBuLl0lb7iF/J5B28gEYwi4gp8D1fJ5rxFyY2y89XLwqyuxHfSq5lYu+kzIalhAcrW
         xYED/9AZA7kBAVKbEB3ZgGbfmMGnswGE91lEpS9oZxGswZx9e+ZIZkqOwE6tnWF94ZMg
         tTHWDnkUMDiQQAnVZJSh+3X2bJsJXZP6j/wmB3cLEyqq4TlFv7SEEPQ2Aobwp61nHxqq
         4kPAd+sd2cPy7oYVHulKHkbSab8MuKLOiq1Ejo7KchXVRwD80zH8ruzGRNH5uSD9xSDe
         pCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqw6cDTVWGXm6THa7zbRW8lp5WtYjqjUBHlnlRVe/u0=;
        b=TdqjSlgmu/5bNeUSFLuqO9oyc/PB8OKfPSF1VwzlhF2AbeIYnxrZTqhghMp6/doin4
         kfThnwYIsJVuA3ZVuAIchtifaK33nmIAL1b15sCmuCZI6VkEwV8RefGSlF93n7LoXmYS
         N+qpFOnpzR72iHSkzs8lWmgPctPxLztk08yy9/prn4sl6rxZdspWGt50BROixze2yE5r
         4u1yT/sUZmjUCzZaBAx+sd4uZCUxOV8KAfEwIFQlbu9NFlk9VQ1fL9P5CaDuCBOIrKL5
         ObTdq2Oz8u4Gdpm0AZvaqt1fGMoSpup+LI2q+bql5JAbRrWoN0PdgAuzyy3Yu65E9yxW
         FBDw==
X-Gm-Message-State: APjAAAU7ZFXBG1aKB7XFkownyBIUk/ma7rO6iEsPIgZgz+jKqaOJBOVe
        AasS28JopyiluKmuVl4o7FmLxb9DW4YJ0A==
X-Google-Smtp-Source: APXvYqw6gfHsqdu9HxehToxq+tTqEdLuWYSiuUzEd3nKmcXNjS0BsOqfzmnyc9lMZ/6XrUdVlGPqZw==
X-Received: by 2002:a05:620a:23a:: with SMTP id u26mr28620573qkm.426.1580833194277;
        Tue, 04 Feb 2020 08:19:54 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f10sm11294093qkk.70.2020.02.04.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:19:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/23][v4] Convert data reservations to the ticketing infrastructure
Date:   Tue,  4 Feb 2020 11:19:28 -0500
Message-Id: <20200204161951.764935-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
- merged the patch that stopped forcing commit for data with the patch that
  removed the bytes_needed parameter to may_commit_transaction.
- fixed the wording in the comment patch as per Nikolay.
- Added the reviewed-by's and tested-by's to everything

v2->v3:
- added a comment patch for the flushing states for data.
- I forgot to add cancel_work_sync() for the new async data flusher thread.
- Cleaned up a few of Nikolay's nits.

v1->v2:
- dropped the RFC
- realized that I mis-translated the transaction commit logic from the old way
  to the new way, so I've reworked a bunch of patches to clearly pull that
  behavior into the generic flushing code.  I've then cleaned it up later to
  make it easy to bisect down to behavior changes.
- Cleaned up the priority flushing, there's no need for an explicit state array.
- Removed the CHUNK_FORCE_ALLOC from the normal flushing as well, simply keep
  the logic of allocating chunks until we've made our reservation or we are
  full, then fall back on the normal flushing mechanism.

-------------- Original email --------------
Nikolay reported a problem where we'd occasionally fail generic/371.  This test
has two tasks running in a loop, one that fallocate and rm's, and one that
pwrite's and rm's.  There is enough space for both of these files to exist at
one time, but sometimes the pwrite would fail.

It would fail because we do not serialize data reseravtions.  If one task is
stuck doing the reclaim work, and another task comes in and steals it's
reservation enough times, we'll give up and return ENOSPC.  We validated this by
adding a printk to the data reservation path to tell us that it was succeeding
at making a reservation while another task was flushing.

To solve this problem I've converted data reservations over to the ticketing
system that metadata uses.  There are some cleanups and some fixes that have to
come before we could do that.  The following are simply cleanups

  [PATCH 01/20] btrfs: change nr to u64 in btrfs_start_delalloc_roots
  [PATCH 02/20] btrfs: remove orig from shrink_delalloc
  [PATCH 03/20] btrfs: handle U64_MAX for shrink_delalloc

The following are fixes that are needed to handle data space infos properly.

  [PATCH 04/20] btrfs: make shrink_delalloc take space_info as an arg
  [PATCH 05/20] btrfs: make ALLOC_CHUNK use the space info flags
  [PATCH 06/20] btrfs: call btrfs_try_granting_tickets when freeing
  [PATCH 07/20] btrfs: call btrfs_try_granting_tickets when unpinning
  [PATCH 08/20] btrfs: call btrfs_try_granting_tickets when reserving
  [PATCH 09/20] btrfs: use the btrfs_space_info_free_bytes_may_use

I then converted the data reservation path over to the ticketing infrastructure,
but I did it in a way that mirrored exactly what we currently have.  The idea is
that I want to be able to bisect regressions that happen from behavior change,
and doing that would be hard if I just had a single patch doing the whole
conversion at once.  So the following patches are only moving code around
logically, but preserve the same behavior as before

  [PATCH 10/20] btrfs: add flushing states for handling data
  [PATCH 11/20] btrfs: add btrfs_reserve_data_bytes and use it
  [PATCH 12/20] btrfs: use ticketing for data space reservations

And then the following patches were changing the behavior of how we flush space
for data reservations.

  [PATCH 13/20] btrfs: run delayed iputs before committing the
  [PATCH 14/20] btrfs: flush delayed refs when trying to reserve data
  [PATCH 15/20] btrfs: serialize data reservations if we are flushing
  [PATCH 16/20] btrfs: rework chunk allocate for data reservations
  [PATCH 17/20] btrfs: drop the commit_cycles stuff for data

And then a cleanup now that the data reservation code is the same as the
metadata reservation code.

  [PATCH 18/20] btrfs: use the same helper for data and metadata

Finally a patch to change the flushing from direct to asynchronous, mirroring
what we do for metadata for better latency.

  [PATCH 19/20] btrfs: do async reclaim for data reservations

And then a final cleanup now that we're where we want to be with the data
reservation path.

  [PATCH 20/20] btrfs: kill the priority_reclaim_space helper

I've marked this as an RFC because I've only tested this with generic/371.  I'm
starting my overnight runs of xfstests now and will likely find regressions, but
I'd like to get review started so this can get merged ASAP.  Thanks,

Josef

