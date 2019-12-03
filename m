Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8060C10F487
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 02:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfLCBee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 20:34:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37992 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfLCBee (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 20:34:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id t3so782872pgl.5
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 17:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwEsWzwEN/UIHTvzgTNobQ3BhxuHM+FLvbYwmp9pKM8=;
        b=sZYbXvJDp6lNG+KqU53ZEtMO552MS94pwm8ztVlMdRcT0m76Mw9jdgEYwuaiAIDbyT
         9GkVO9M39BZ9bMNb14XjFPQe/3pu/6DB1/1DTygqbrUupLl5Lyo8CLlSMJ2lxH4jpT6p
         ScVJmYKT+0OloIhmRXxVzJ/1m2I4hDpbiwNZAMb7GZLzLHefrJ6YnL0rparzxAdqVyag
         gtGMFbG8DMJd2ID9Ho8Sy/jDgKi0/ZljkDOuT2G3cfngHJ541QHwwEr42csMAc8XDKlM
         dHnAGTcbKbEkmFpp/Fv7GujTmSQ14Fur0Ao4nGELKLw+tbXFbnqOH3FK5T32P/IGvVgF
         pLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwEsWzwEN/UIHTvzgTNobQ3BhxuHM+FLvbYwmp9pKM8=;
        b=R25CwqB0Mf6jDVaDeR5DcY664ewXDEw0dsEtcWBE5RZzZFb4HHxZ2JKcZym1HgboMy
         FlnCbZfbjjFv5gNArfDul7NI6VV/4jNKUcVnCealI0WkB0gyLLkF8px6rf3g9Npy/dOh
         +sJjr4XIcsyi3p1iBjPg+GMTCweCZcm5Hkz+aOSVmFpahkDjzQp6IHru4VfUgwpiKnQx
         XRiyfmZvzxlq+EaEXywsWdS5YpZUAAxGkswuR2vWsZdmJzLVsEmX/Rc4KTf5NB2/yH6n
         Db7iUlCoEw10M4MAQrWNFb2CGho/H//nGGeLp4yqLIOAWAVpGm+OHM8HHWwe6N+frOH9
         ix0g==
X-Gm-Message-State: APjAAAUtfC50HUxgyS93WRusPW/8EWpW8wobCGbg3Lw3cc3wsFvFYUiC
        QJjed5Y5mJSkTzciEPK/FilIycuW1BkLkg==
X-Google-Smtp-Source: APXvYqzByuzTiwi7lf22Jlh7WLT8xHovYW/YFD6/rarni+Xi/pmOHrKgAvZtghrOdP869bhlni747g==
X-Received: by 2002:a63:1b1f:: with SMTP id b31mr2479585pgb.177.1575336872519;
        Mon, 02 Dec 2019 17:34:32 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::6ddc])
        by smtp.gmail.com with ESMTPSA id u65sm800242pfb.35.2019.12.02.17.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:34:31 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 0/9] btrfs: miscellaneous cleanups
Date:   Mon,  2 Dec 2019 17:34:16 -0800
Message-Id: <cover.1575336815.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This series includes several cleanups. Patches 1-3 are the standalone
cleanups from my RWF_ENCODED series [1] (as requested by Dave). Patches
4-8 clean up code rot in the writepage codepath. Patch 9 is a trivial
cleanup in find_free_extent.

Based on misc-next.

Thanks!

1: https://lore.kernel.org/linux-btrfs/cover.1574273658.git.osandov@fb.com/

Omar Sandoval (9):
  btrfs: get rid of trivial __btrfs_lookup_bio_sums() wrappers
  btrfs: remove dead snapshot-aware defrag code
  btrfs: make btrfs_ordered_extent naming consistent with
    btrfs_file_extent_item
  btrfs: remove unnecessary pg_offset assignments in
    __extent_writepage()
  btrfs: remove trivial goto label in __extent_writepage()
  btrfs: remove redundant i_size check in __extent_writepage_io()
  btrfs: drop create parameter to btrfs_get_extent()
  btrfs: simplify compressed/inline check in __extent_writepage_io()
  btrfs: remove struct find_free_extent.ram_bytes

 fs/btrfs/compression.c       |   4 +-
 fs/btrfs/ctree.h             |   6 +-
 fs/btrfs/disk-io.c           |   4 +-
 fs/btrfs/disk-io.h           |   4 +-
 fs/btrfs/extent-tree.c       |   2 -
 fs/btrfs/extent_io.c         |  42 +-
 fs/btrfs/extent_io.h         |   6 +-
 fs/btrfs/file-item.c         |  39 +-
 fs/btrfs/file.c              |  23 +-
 fs/btrfs/inode.c             | 801 +++--------------------------------
 fs/btrfs/ioctl.c             |   2 +-
 fs/btrfs/ordered-data.c      |  69 ++-
 fs/btrfs/ordered-data.h      |  26 +-
 fs/btrfs/relocation.c        |   5 +-
 include/trace/events/btrfs.h |   6 +-
 15 files changed, 171 insertions(+), 868 deletions(-)

-- 
2.24.0

