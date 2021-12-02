Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02839466173
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 11:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356982AbhLBKeK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 05:34:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50494 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356795AbhLBKeJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 05:34:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0CB44CE2131
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB968C00446
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638441043;
        bh=LToZFck2Y7PAnhbHlTfaTlaZs/HQGoa1CA9+5sb47mo=;
        h=From:To:Subject:Date:From;
        b=LnwWkQh0uHdjKIwjrRfjyoWLX3Hn+BgeWQjpeWH5Jus6yka0YyFaCK+juW+mtUi+d
         s29LoWTSIfnxiHlnLYPGnDiefON5/wtn8O+0hJJYJqunW7s+tFx/bH8IqgzqhUcDJ3
         8GbeXjEpIddkn5vT/Bdm7TP1+Wr5hagZtsCmTqUX+id+hfUw9Pz/7NiyMSqmQRPylk
         mGzGN+TU+/Zi58SbLgpahDscCI7KWDfNzSijzelxKmaIyGmMI3Vf/s6I2O33i6oGS1
         PgTDEAFuGyaU+LaNTKKWgX3Mk1EAqYB/hICW44o15ZN9UVlU5UOC367/eSnEuZmWqs
         g74hJCLOOI9qg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: optimize btree insertions and some cleanups
Date:   Thu,  2 Dec 2021 10:30:34 +0000
Message-Id: <cover.1638440535.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset optimizes btree insertions to allow better parallelism, by
having insertions unlocking upper level nodes sooner and avoid blocking
other tasks, or reduce the time they are blocked, that want to use the
same nodes. The optimization is in patch 2/6, patch 1/6 is preparation
for it, and the rest are just cleanups or removing stale code and comments.

Filipe Manana (6):
  btrfs: allow generic_bin_search() to take low boundary as an argument
  btrfs: try to unlock parent nodes earlier when inserting a key
  btrfs: remove useless condition check before splitting leaf
  btrfs: move leaf search logic out of btrfs_search_slot()
  btrfs: remove BUG_ON() after splitting leaf
  btrfs: remove stale comment about locking at btrfs_search_slot()

 fs/btrfs/ctree.c | 254 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 181 insertions(+), 73 deletions(-)

-- 
2.33.0

