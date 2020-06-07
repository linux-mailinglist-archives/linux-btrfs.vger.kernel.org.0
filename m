Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC21F0A57
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgFGHZT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 03:25:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:53590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgFGHZS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 03:25:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D09BAAD89
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Jun 2020 07:25:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: qgroup: detect and fix leaked data reserved space
Date:   Sun,  7 Jun 2020 15:25:10 +0800
Message-Id: <20200607072512.31721-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is an internal report complaining that qgroup is only half of the
limit, but they still get EDQUOT errors.

With some extra debugging patch added, it turns out that even fsstress
with 15 steps can sometimes cause qgroup reserved data space to leak.

This patch set is going to:
- Fix the reserved data space leakage
  Mostly caused by missing btrfs_qgroup_free_data() call in release
  page.
  As I thought a dirty page either goes through finish_ordered_io(),
  or get invalidated directly.
  But due to the designed of delayed finish_ordered_io(), we can
  still get dirty page get released directly.

- Add extra safenet to catch qgroup reserved space leakage.

The existing test case btrfs/022 can already catch the bug pretty
reliably.
I will add a specific case for fstests if needed.

Qu Wenruo (2):
  btrfs: extent_io: fix qgroup reserved data space leakage when
    releasing a page
  btrfs: qgroup: catch reserved space leakage at unmount time

 fs/btrfs/disk-io.c   |  6 ++++++
 fs/btrfs/extent_io.c | 34 +++++++++++++++++++++++++++-------
 fs/btrfs/qgroup.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h    |  2 +-
 4 files changed, 77 insertions(+), 8 deletions(-)

-- 
2.26.2

