Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A397F151149
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgBCUt5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:49:57 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:39056 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCUt5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:49:57 -0500
Received: by mail-qk1-f169.google.com with SMTP id w15so15678354qkf.6
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=waW9U5jKeXM7B9CFmewR76EOthLW8uHtCR2/rSoWi74=;
        b=DpK/caxmYO9GFZE7PrxGjY8COY184qAJ9uP/iXTKvnbi4/2T10sddk/oUSPjWdaFBS
         hTieJKsV9YfUPspziI6OtLijkLAdVqUQD+By/urlzsjDAyk70qI482HIhFx1f0B7mcik
         pnAzoEqkvQprrJWPZvTSPSkZOXXytZiQSmO5foF+8qoarbX6AFhcQ4ZdpXB2Vv0KbxM9
         MhPpWwst+DbQjPFw8NEgRI9Tlda1TE4YdQLx+DDe2AvmnVf+T24FYL2wxgTsBpqpxa3W
         MKFYuBDg4xG6T3SI7Z1vzRJmkfnYmCS64McG7UjzchWz/LCy/Yv7FM0J7rFPH90UM7aE
         E+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=waW9U5jKeXM7B9CFmewR76EOthLW8uHtCR2/rSoWi74=;
        b=GJzO3UKhxADDFOlfM+ugp7+ue4ItkAfT8BnskQvSXmktaSZK8fiB3ZBnrf6YwNeTw6
         nhxQJteYnmJ1cz04aPGAGJ5jGxxWoumRN67vaqFkplyz4/GrbPZz6Ae9TGlX4/dUSTcQ
         cejGG0l+vRIqTGnoeKzdqaUq7JaiPEKSVE/AYZaEMTDe0J45t4UevPOiBR8Rl66PpY/7
         zL4GLDp3fbKrA8lw721pb6grseCkQLddwRjtsBMB+2ipG7jP733M/5wlldnyyl6W+ERI
         yCOi8/AzvBukd8rdSbK6MxI1hEoyA6re8kZIhSqbfY27A7z3nolrJ7yWqMXEc1RdDzpG
         8xQw==
X-Gm-Message-State: APjAAAWbHfXUvO0v/5Iw1NwmJdyYeCprFtPiNZEkzwRoU0C8PDyz0iTD
        6uByVrcQKlxRvJjEBTpXaWM7vaVikNBH1w==
X-Google-Smtp-Source: APXvYqwwkRizcM2lnjrE9q+8899bh2wEF58u+W7rk0r8I9U2CT8OguX2wp2oXA0T3Z612mE8fYJ1Iw==
X-Received: by 2002:a05:620a:13fa:: with SMTP id h26mr25302671qkl.150.1580762993981;
        Mon, 03 Feb 2020 12:49:53 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z6sm9725735qkz.101.2020.02.03.12.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:49:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/24][v3] Convert data reservations to the ticketing infrastructure
Date:   Mon,  3 Feb 2020 15:49:27 -0500
Message-Id: <20200203204951.517751-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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


