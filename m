Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56F014F4C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgAaWgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:20 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:38673 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgAaWgT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:19 -0500
Received: by mail-qk1-f170.google.com with SMTP id k6so8224190qki.5
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fix2cwZFYQiiBhqSxbCFZx7hw2zVThwQXlmZoHJ8wK4=;
        b=R6bYDNHkfGuZ7QpeeVQgbkJfcUwSLZ5tzvpk9lK18diGdIKQp8vb50MKD7pEvqFXdr
         gCEfxFGODQL5frCKHtZLMHY0UfuxDpjPhU1EBmalAb+gemuZw7uXDLND0S1KL1qZq1r4
         p575XxlROVenofHeE+wUDrW17gb527Mx4HnB8Jad3UjKtiRqgSds3ZOEG/5+wlPOmrV6
         8MypivdySaw/D9woUyWZK5il3jTki5XgORPEX2/f1qLVng7fkYu7YosblRXADa7wazPP
         OcAwZgfAvZwTj3EL2ZvRjz2Va2Z4Ra9N0RU9ucD52EKCYzdAQOr/4fdv4hDIEdfLJQ+c
         2Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fix2cwZFYQiiBhqSxbCFZx7hw2zVThwQXlmZoHJ8wK4=;
        b=sDMjS0P7xS+0um13mCcrgZOhWNTesCrbDwW586WYn9dAC7VCXFVKpUdHXlyoe55ez5
         SJ0T80xXkuVrvRjQGfjJwTiuV7KizT2t0Aa5z4opyGpuuorSD9qu4WYPqZ0kfwAyjjig
         SSRwJTa/0M4xPdiMOMt9U5dKR7i7Mh15kBrWKSnZJwz5Z54winTLdy1Orwn6WZW3ba8r
         D/okX1tFXpeurmoXSHbgsEPeQkr0jzsZJbp8g/d7SAtUVjEGRSHCAkJJYVO/ctauyrB2
         XIaZLkKk9KozlwBH+R/3SMm9Sjo4+ImA7EprQIclYTsroOc2uBHwNDDSictNKv+jcUJy
         9i7w==
X-Gm-Message-State: APjAAAXUEvWnP0GbvGq66LxQL8NGnsDEEddWJ81R7xkXYNk5fy5OcWlA
        6R4BMFy+rDabQdTIzKWxrRZ/24kV90bJhw==
X-Google-Smtp-Source: APXvYqyEQJmMWioWYtNfMaoXvrA6+mQPN1Ss0K8w0QHw2pJLqbjUeRoonTruDQf0CMYE00DVJz4/GA==
X-Received: by 2002:a37:354:: with SMTP id 81mr13199822qkd.276.1580510176680;
        Fri, 31 Jan 2020 14:36:16 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h7sm5294764qke.30.2020.01.31.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/23][v2] Convert data reservations to the ticketing infrastructure
Date:   Fri, 31 Jan 2020 17:35:50 -0500
Message-Id: <20200131223613.490779-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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


