Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE517EB37
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCIVcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:32:55 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53182 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgCIVcz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:32:55 -0400
Received: by mail-pj1-f66.google.com with SMTP id f15so458458pjq.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIxmfNXkHngvWMxGX21z2YKcMmGvsAGOrdqVH+4SFMM=;
        b=sTFOGuiWD0/2niedz3msLceCMMDxUCHn3SJVMEY0AGUUDJzy2z1XHbqSzbbu8gl4Yl
         JROXo3xhVASTY1SYMK82BQDhhZWhIMV3lHUD1vZ1DkjLTfQXdKBpMq9lUdrzbRf7r7s2
         FOmas6UWZMrdD4dcypbs7GslVLbVQt9bMIg3Pwir1RQa9tk7fFRH5MglyMql5GP2MMgI
         ZVZA7ocZrGjhSr4cuyu04x1wEInv5zat2ZDJhgVy1nZtN849QuIQS/BmFW/nEWo0OmWe
         jpacrMC28PaJWegGuSwn1i2RdVBHB57vZld8P7yLeZ6RZ3XN+lH8ioB7I3GR+BG+GXAJ
         2+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIxmfNXkHngvWMxGX21z2YKcMmGvsAGOrdqVH+4SFMM=;
        b=Fe9InWS9DVKioeDr+ipHoT2qLrrNvPwtA6dw03v3EqbTZpBFz71ZeNnF+khG1jWfdS
         nRKzzs3/RYjYz/tENLmVa0osRCSnJFGlZfYfAVjPs2JbWCllbaeD8ahYUg+5OdGsNr7F
         fYeW3FiBlMsgjAmRnkcuCFSAiA6tYN6Sf/GDaKlW2ElQdErxQIuaIkvWaZtDtC/bKK9u
         ELBe/wH/3HFcWSZdzpzavZ0bGaEzqJqx3R9IgYdNTPczH0E01/trVGl8DmfiY2PPX/x6
         ZJt3gBaeZpVmmb6jzf4UJHBxOh1gkXAl3OlO16fSq4h9MEYk9ex22KwCJGF0CA2mCwN6
         KGoQ==
X-Gm-Message-State: ANhLgQ1mE0++QgoMb7R58XGJj2yhQfovAInDpaw5getWa7IWytZPazJ8
        JBu2PzZxD0OcvLYK7f5KspoNYY9hITQ=
X-Google-Smtp-Source: ADFU+vsvZSrDo2bpnithTAHTMvV3IdHlo2CiUPzzwXHRYc5QozwANfb//Vi+XPn0IpIOXldMfWAbjw==
X-Received: by 2002:a17:902:aa4a:: with SMTP id c10mr17197247plr.183.1583789573566;
        Mon, 09 Mar 2020 14:32:53 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:32:53 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 00/15] btrfs: read repair/direct I/O improvements
Date:   Mon,  9 Mar 2020 14:32:26 -0700
Message-Id: <cover.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This series includes several fixes, cleanups, and improvements to direct
I/O and read repair. It's preparation for adding read repair to my
RWF_ENCODED series [1], but it can go in independently.

Patches 1 and 2 are direct I/O error handling fixes. Patch 3 is a
buffered read repair fix. Patch 4 is a buffered read repair improvement.
Patches 5-9 are trivial cleanups. Patch 10 converts direct I/O to use
refcount_t, which would've helped catch the bug fixed by patch 1.
Patches 11-14 drastically simplify the direct I/O code. Patch 15 gets
unifies buffered and direct I/O read repair, which also makes direct I/O
repair actually do validation for large failed reads instead of
rewriting the whole thing.

Overall, this is net about -400 lines of code and actually makes direct
I/O more functional.

Note that this series causes btrfs/142 to fail. This is a bug in the
test, as it assumes that direct I/O doesn't do read validation. I'm
working on a fix for the test.

Christoph is cc'd for patch 3. The fix looks at the bio internals in a
way that I wasn't sure was recommended, although there is precedent in
the bcache code. I'd appreciate if Christoph acked that patch or
suggested a better approach.

This series is based on misc-next.

Thanks!

1: https://lore.kernel.org/linux-fsdevel/cover.1582930832.git.osandov@fb.com/

Omar Sandoval (15):
  btrfs: fix error handling when submitting direct I/O bio
  btrfs: fix double __endio_write_update_ordered in direct I/O
  btrfs: look at full bi_io_vec for repair decision
  btrfs: don't do repair validation for checksum errors
  btrfs: clarify btrfs_lookup_bio_sums documentation
  btrfs: rename __readpage_endio_check to check_data_csum
  btrfs: make btrfs_check_repairable() static
  btrfs: move btrfs_dio_private to inode.c
  btrfs: kill btrfs_dio_private->private
  btrfs: convert btrfs_dio_private->pending_bios to refcount_t
  btrfs: put direct I/O checksums in btrfs_dio_private instead of bio
  btrfs: get rid of one layer of bios in direct I/O
  btrfs: simplify direct I/O read repair
  btrfs: get rid of endio_repair_workers
  btrfs: unify buffered and direct I/O read repair

 fs/btrfs/btrfs_inode.h |  30 --
 fs/btrfs/ctree.h       |   1 -
 fs/btrfs/disk-io.c     |   8 +-
 fs/btrfs/disk-io.h     |   1 -
 fs/btrfs/extent_io.c   | 141 +++++----
 fs/btrfs/extent_io.h   |  19 +-
 fs/btrfs/file-item.c   |  11 +-
 fs/btrfs/inode.c       | 694 ++++++++++-------------------------------
 8 files changed, 260 insertions(+), 645 deletions(-)

-- 
2.25.1

