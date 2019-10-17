Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8FABDB7A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 21:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394215AbfJQTim (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 15:38:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbfJQTim (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 15:38:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35B41AF95;
        Thu, 17 Oct 2019 19:38:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E27F1DA808; Thu, 17 Oct 2019 21:38:51 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Extent buffer locking and documentation
Date:   Thu, 17 Oct 2019 21:38:50 +0200
Message-Id: <cover.1571340084.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've spent a lot of time staring at the locking code and speculating
about all sorts of weird problems that could happen due to memory
ordering or lost wakeups or if the custom locking is safe at all, also
regarding the recent changes.

Inevitably I found something but also wrote documentation. Please read
it and if you see need for more clarifications, I'm happy to add it as
I'm now in a state that things become temporarily obvious and trivial.

I've tested it in fstests with KCSAN (the new concurrency sanitizer), no
problems found but this is not considered sufficient, more tests will
follow.

David Sterba (5):
  btrfs: merge blocking_writers branches in btrfs_tree_read_lock
  btrfs: set blocking_writers directly, no increment or decrement
  btrfs: access eb::blocking_writers according to ACCESS_ONCE policies
  btrfs: serialize blocking_writers updates
  btrfs: document extent buffer locking

 fs/btrfs/locking.c | 184 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 144 insertions(+), 40 deletions(-)

-- 
2.23.0

