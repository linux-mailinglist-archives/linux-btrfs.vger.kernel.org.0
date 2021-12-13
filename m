Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC8473648
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbhLMUyf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 15:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhLMUyd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 15:54:33 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CF1C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 12:54:32 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id t11so16548962qtw.3
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlandiPGYALd8EtDb4OySXHPd3EFGnpPYbAEHo+MfHM=;
        b=I5Xp6q4n2nxouZGJUkYPHTMdduMV30Za3xd1T/iEw786JoqubdGoXXIEFoIKbzhSd7
         GZ3o/Kv/+8qUQkHUH+pZIW4au9TJxZ144BMSwzZNNUs5cWFfnR+5mYRPeZ1y9uDKHTpB
         CbScYvIU1tYFMQkLqrwBCnXlIKbNn0++hco6tabfkKaVhypwJuAXJHFNUpgMb4raK9C+
         64OA9KYSNKUDegt9k4186ZNNCumIgEyQv691G2LgKAvUqZIh82UamMwFUgIR/WzEUwbz
         WambXvQINf9rBm0t1BdwThziYorJPkR4/dkpWuvFl6gNFFBTu8IBE4kRkHLHXC/RBC9P
         yTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlandiPGYALd8EtDb4OySXHPd3EFGnpPYbAEHo+MfHM=;
        b=X02+gDoMIC7gw1f6nXdWhoJPKb8EwcJdguzAUHMOc9BxWTqqKV+dnuXBZ3Kz4OvQTo
         sJXHW6PPB2uFqTIUltWhNcFKzW5cP+0CnpIN9OQWza328OwkMYoWX5H7X+HI7lPblq7L
         0lAOjbQ3i3XKsqZuLocla5JY55H28n+ipd19YomL+SZJH1UUdN530eqF+g8YbUIyS1kc
         zjh7frgZ++VEYkB7LWspR7WexoOODo8CiTkYNUfOHtl1/vq+A6TG9dJmCcB3nK1SLlcE
         aE0p7NTAZeJ7oZnFIUYOKLChJSkzk3ci5S8hEmsMRgs2vfNqf1N4qb2JcsqMMNgq8Da1
         +Wgg==
X-Gm-Message-State: AOAM532BsMsrw3/0OR7uf9lJvIc5yJ37Vj29MQnzOmTaHKo1G77uEHxE
        3A1fYsPc6AJ0rWv65pP8ZWpTqIqK0pvZrw==
X-Google-Smtp-Source: ABdhPJyRGWbGP0sQKGSUgtd6sofCdCGeGvGCObjLgl+D6yA4b1D4OYp5ESuZdISnm+fM6SXYIAQ7uA==
X-Received: by 2002:a05:622a:4e:: with SMTP id y14mr975935qtw.106.1639428871507;
        Mon, 13 Dec 2021 12:54:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m20sm6600879qkp.112.2021.12.13.12.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:54:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] btrfs-progs: handle orphan directories properly
Date:   Mon, 13 Dec 2021 15:54:27 -0500
Message-Id: <cover.1639428656.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

While implementing the garbage collection tree I started getting btrfsck errors
when a test would do rm -rf DIRECTORY and then immediately unmount.  This is
because we stop processing GC items during umount, and thus we left the
directory with an nlink == 0 and all of its children in the fs tree.

However this isn't a problem with just the GC tree, we can have this happen if
we fail to do the eviction work at evict time, and we leave the orphan entry in
place on disk.  btrfsck properly ignores problems with inodes that have orphan
items, except for directory inodes.

Fix this by making sure we don't add any backrefs we find from directory inodes
that we've find the inode item for and have an nlink == 0.

I generated a test image for this by simply skipping the
btrfs_truncate_inode_items() work in evict in a kernel and rm -rf'ing a
directory on a test file system.

With this patch both make test-check and make test-check-lowmem pass all the
tests, including the new testcase.  Thanks,

Josef

Josef Bacik (2):
  btrfs-progs: handle orphan directories properly
  btrfs-progs: add a test to check orphaned directories

 check/main.c                                  |  15 ++++++++++++-
 check/mode-lowmem.c                           |   6 ++++--
 .../052-orphan-directory/default.img.xz       | Bin 0 -> 1432 bytes
 tests/fsck-tests/052-orphan-directory/test.sh |  20 ++++++++++++++++++
 4 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 tests/fsck-tests/052-orphan-directory/default.img.xz
 create mode 100755 tests/fsck-tests/052-orphan-directory/test.sh

-- 
2.26.3

