Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E0014956F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 13:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAYMO2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 07:14:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:53626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgAYMO2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 07:14:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFAB3B138;
        Sat, 25 Jan 2020 12:14:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9D152DA730; Sat, 25 Jan 2020 13:14:01 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.5-rc8
Date:   Sat, 25 Jan 2020 13:14:00 +0100
Message-Id: <cover.1579953624.git.dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

here's a last minute fix for a regression introduced in this development
cycle. There's a small chance of a silent corruption when device replace
and NOCOW data writes happen at the same time in one block group.
Metadata or COW data writes are unaffected. The fixup patch is there to
silence an unnecessary warning.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit b35cf1f0bf1f2b0b193093338414b9bd63b29015:

  btrfs: check rw_devices, not num_devices for balance (2020-01-17 15:40:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-rc8-tag

for you to fetch changes up to 4cea9037f82a6deed0f2f61e4054b7ae2519ef87:

  btrfs: dev-replace: remove warning for unknown return codes when finished (2020-01-25 12:49:12 +0100)

----------------------------------------------------------------
David Sterba (1):
      btrfs: dev-replace: remove warning for unknown return codes when finished

Qu Wenruo (1):
      btrfs: scrub: Require mandatory block group RO for dev-replace

 fs/btrfs/dev-replace.c |  5 +----
 fs/btrfs/scrub.c       | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 9 deletions(-)
