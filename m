Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B538642BB3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 11:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhJMJO4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 05:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238479AbhJMJO4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 05:14:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A04A60E54
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634116373;
        bh=9wf+sa2ehIzwlZxZf8O1aKA5Ueq2bR9vL/DxREsP1VI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ha4Wv1gJ7EyGp8URKSDHtOy0GsJtnbsd/oZrLWzf2s//vJ9qHKCXJ8O/uWfpoKLQn
         fU3AsmeHfwL94rozJsWmdTdB1Ysss6Od014foHJK/ce8bHNHsrzVe6lxkIU9dyBZ56
         q5rIUN3+k07hjjm/djPArUylqsjBHUSJ2XD4sghph34bY17MO3zkEXQDevbXsKiKZf
         4l5v2/U/ELJqssxVN6O6ZjgQa3FeMXQVmVyTsxR4Ydv6e2Bvd9LVlhqdKWPbVfc76Y
         F7J/G2w2ytY/eGVLtQKzSK0AQ4ivWqwl7I2CjNwVbPzYriod2cQ4lWAeSh7OyjWHn+
         i9MrI1u25meoQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: fix a deadlock between chunk allocation and chunk tree modifications
Date:   Wed, 13 Oct 2021 10:12:48 +0100
Message-Id: <cover.1634115580.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633604360.git.fdmanana@suse.com>
References: <cover.1633604360.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This fixes a deadlock between a task allocating a metadata or data chunk
and a task that is modifying the chunk btree and it's not in a chunk
allocation or removal context. The first patch is the fix, the second one
just updates a couple comments and it's independent of the fix.

v2: Updated stale comment after the fix (patch 1/2).

v3: Moved the logic to reserve chunk space out of btrfs_search_slot() into
    every path that modifies the chunk btree (which are the cases listed in
    the change log of patch 1/2) and updated two more comments in patch 1/2.

Filipe Manana (2):
  btrfs: fix deadlock between chunk allocation and chunk btree modifications
  btrfs: update comments for chunk allocation -ENOSPC cases

 fs/btrfs/block-group.c | 166 +++++++++++++++++++++++++++--------------
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/relocation.c  |   4 +
 fs/btrfs/volumes.c     |  15 +++-
 4 files changed, 128 insertions(+), 59 deletions(-)

-- 
2.33.0

