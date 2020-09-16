Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49D526C5F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgIPR1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 13:27:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:32894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgIPR0v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 13:26:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37405B211;
        Wed, 16 Sep 2020 17:26:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A26B8DA7C7; Wed, 16 Sep 2020 19:25:12 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3] Use unaligned put/get
Date:   Wed, 16 Sep 2020 19:25:11 +0200
Message-Id: <cover.1600276853.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use buffers that get mapped to structures and then accessed via
member pointers. For all the on-disk items we have the setget helpers,
but there are still some other cases like send and free space cache
(v1). Due to natural alignment this worked and we haven't received
reports where from strict alignment arches. Use the
put/get_unaligned_le* helpers to make it explicit.

David Sterba (3):
  btrfs: send: use helpers for unaligned access to header members
  btrfs: free-space-cache: use unaligned helpers to access data
  btrfs: use unaligned helpers for stack and header set/get helpers

 fs/btrfs/ctree.h            | 20 ++++++++++++++------
 fs/btrfs/free-space-cache.c | 21 +++++++++------------
 fs/btrfs/send.c             | 14 +++++++-------
 fs/btrfs/struct-funcs.c     | 10 ----------
 4 files changed, 30 insertions(+), 35 deletions(-)

-- 
2.25.0

