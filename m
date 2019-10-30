Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2456BE9A80
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 11:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfJ3K4q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 06:56:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfJ3K4q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 06:56:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CBC2EAD12;
        Wed, 30 Oct 2019 10:56:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 71D61DA783; Wed, 30 Oct 2019 11:56:54 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 0/5] Extent buffer locking and documentation
Date:   Wed, 30 Oct 2019 11:56:54 +0100
Message-Id: <cover.1572432768.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

V2:
- removed one READ_ONCE in 3/5 "btrfs: access eb::blocking_writers
  according to ACCESS_ONCE policies"
- drop patch 4/5 "btrfs: serialize blocking_writers updates"
- enhance locking documentatin
- add lockdep assertions

----------------

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
  btrfs: document extent buffer locking
  btrfs: locking: add lock assertions

 fs/btrfs/locking.c | 234 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 196 insertions(+), 38 deletions(-)

-- 
2.23.0

