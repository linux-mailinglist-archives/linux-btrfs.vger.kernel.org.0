Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62583330CB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 22:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhCIVWS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 16:22:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:18988 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCIVVu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Mar 2021 16:21:50 -0500
IronPort-SDR: ZCkBKzL6/4Gh58jkLjZ2nEFTBZNTKNmh68Bo/RFlgQtimiAnq8XQzdD7e3ZTWmfqrszBdqKLfA
 TXowhzDCuDSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="167597023"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="167597023"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 13:21:48 -0800
IronPort-SDR: f5gFzJRA3Q243esLlPA/Y3Tdx/L/Tuyzj16PiDwlgENALpXu2RUhoeX7/rnoHk3hI9nK5yoo5O
 L7zU4V21G10A==
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="386373791"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 13:21:47 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] btrfs: Convert kmap/memset/kunmap to memzero_user()
Date:   Tue,  9 Mar 2021 13:21:34 -0800
Message-Id: <20210309212137.2610186-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Previously this was submitted to convert to zero_user()[1].  zero_user() is not
the same as memzero_user() and in fact some zero_user() calls may be better off
as memzero_user().  Regardless it was incorrect to convert btrfs to
zero_user().

This series corrects this by lifting memzero_user(), converting it to
kmap_local_page(), and then using it in btrfs.

Thanks,
Ira

[1] https://lore.kernel.org/lkml/20210223192506.GY3014244@iweiny-DESK2.sc.intel.com/


Ira Weiny (3):
  iov_iter: Lift memzero_page() to highmem.h
  mm/highmem: Convert memzero_page() to kmap_local_page()
  btrfs: Use memzero_page() instead of open coded kmap pattern

 fs/btrfs/compression.c  |  5 +----
 fs/btrfs/extent_io.c    | 22 ++++------------------
 fs/btrfs/inode.c        | 33 ++++++++++-----------------------
 fs/btrfs/reflink.c      |  6 +-----
 fs/btrfs/zlib.c         |  5 +----
 fs/btrfs/zstd.c         |  5 +----
 include/linux/highmem.h |  7 +++++++
 lib/iov_iter.c          |  8 +-------
 8 files changed, 26 insertions(+), 65 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

