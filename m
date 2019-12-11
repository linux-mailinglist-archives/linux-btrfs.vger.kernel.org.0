Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4311A90E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 11:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfLKKki (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 05:40:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728030AbfLKKki (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 05:40:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A6A2AD55;
        Wed, 11 Dec 2019 10:40:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] fstests: btrfs/15[78] btrfs/14[23]: Use more accurate devid/phsyical for corruption
Date:   Wed, 11 Dec 2019 18:40:26 +0800
Message-Id: <20191211104029.25541-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs-progs commit c501c9e3b816 ("btrfs-progs: mkfs: match devid order
to the stripe index") changed the chunk layout, making it more human
friendly for manually offset calculation.

However btrfs/14[23] btrfs/15[78] are using hard-coded devid sequence
for corruption, thus they can't stand such change and fail.

This patchset will handle such problems in patch 2 and 3, to use more
accurate helper to replace the hard-coded one.

And the first patch will address a bad _notrun messages, which is mostly
related to btrfs/14[23].

Qu Wenruo (3):
  fstests: common: Use more accurate kernel config for
    _require_fail_make_request
  fstests: btrfs/14[23]: Use proper help to get both devid and physical
    offset for corruption.
  fstests: btrfs/15[78]: Use proper helper to get both devid and
    physical offset for corruption

 common/rc           |  2 +-
 tests/btrfs/142     | 50 +++++++++++++++++++++++++++++-------------
 tests/btrfs/142.out |  2 --
 tests/btrfs/143     | 48 +++++++++++++++++++++++++++++-----------
 tests/btrfs/143.out |  2 --
 tests/btrfs/157     | 53 +++++++++++++++++++++++++++++----------------
 tests/btrfs/157.out |  4 ----
 tests/btrfs/158     | 48 +++++++++++++++++++++++++---------------
 tests/btrfs/158.out |  4 ----
 9 files changed, 136 insertions(+), 77 deletions(-)

-- 
2.23.0

