Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675F8246612
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHQMMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 08:12:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:57080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgHQMMi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 08:12:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42F91AD60;
        Mon, 17 Aug 2020 12:13:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E8F1BDA6EF; Mon, 17 Aug 2020 14:11:32 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Misc warning fixes
Date:   Mon, 17 Aug 2020 14:11:32 +0200
Message-Id: <cover.1597666167.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Compiling with W=1 or W=2 gives warnings that seem to be worth fixing.

David Sterba (5):
  btrfs: remove const from btrfs_feature_set_name
  btrfs: compression: move declarations to header
  btrfs: remove unnecessarily shadowed variables
  btrfs: scrub: rename ratelimit state varaible to avoid shadowing
  btrfs: send: remove indirect callback parameter for changed_cb

 fs/btrfs/backref.c     |  1 -
 fs/btrfs/compression.c | 35 -----------------------------------
 fs/btrfs/compression.h | 35 +++++++++++++++++++++++++++++++++++
 fs/btrfs/inode.c       |  1 -
 fs/btrfs/scrub.c       |  8 ++++----
 fs/btrfs/send.c        | 11 ++---------
 fs/btrfs/sysfs.c       |  2 +-
 fs/btrfs/sysfs.h       |  2 +-
 8 files changed, 43 insertions(+), 52 deletions(-)

-- 
2.25.0

