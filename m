Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2089A31339
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEaRA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 13:00:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:59986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfEaRA1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 13:00:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62276AD6F
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2019 17:00:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 44670DA85E; Fri, 31 May 2019 19:01:18 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] More lockdep annotations
Date:   Fri, 31 May 2019 19:01:18 +0200
Message-Id: <cover.1559321947.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Lockdep annotations are better than comments about necessary locks.

David Sterba (5):
  btrfs: tests: add locks around add_extent_mapping
  btrfs: assert extent map tree lock in add_extent_mapping
  btrfs: assert tree mod log lock in __tree_mod_log_insert
  btrfs: assert delayed ref lock in btrfs_find_delayed_ref_head
  btrfs: assert bio list lock in merge_rbio

 fs/btrfs/ctree.c                  |  4 ++--
 fs/btrfs/delayed-ref.c            |  7 ++++---
 fs/btrfs/extent_map.c             |  2 ++
 fs/btrfs/raid56.c                 |  4 ++--
 fs/btrfs/tests/extent-map-tests.c | 22 ++++++++++++++++++++++
 5 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.21.0

