Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2B716AA47
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBXPh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 10:37:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:65149 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgBXPh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 10:37:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 07:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="284384038"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2020 07:37:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A916DFE; Mon, 24 Feb 2020 17:37:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/4] btrfs: bypass UUID API aliasing
Date:   Mon, 24 Feb 2020 17:37:48 +0200
Message-Id: <20200224153752.35063-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

UUID API has been converted to differentiate UUID and GUID.
Btrfs is using aliases to the new API for some time.

Bypass that aliasing by converting btrfs to use API calls directly.

The series has been compiled only.

P.S. It may be applied either to btrfs tree or to UUID one.

Change v3:
- rebase to latest kernel base (Linux Next)
- explain in cover letter purpose of conversion (Johannes)

Andy Shevchenko (4):
  uuid: Add inline helpers to import / export UUIDs
  uuid: Provide a GUID generator for raw buffer
  Btrfs: Switch to use new generic UUID API
  uuid: Remove no more needed macro

 fs/btrfs/disk-io.c     |  6 +++---
 fs/btrfs/ioctl.c       |  4 +---
 fs/btrfs/root-tree.c   |  4 +---
 fs/btrfs/transaction.c |  7 +++----
 include/linux/uuid.h   | 22 +++++++++++++++++++++-
 lib/uuid.c             | 10 ++++++++++
 6 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.25.0

