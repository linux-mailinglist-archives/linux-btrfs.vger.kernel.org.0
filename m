Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18F9426D48
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Oct 2021 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhJHPMe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Oct 2021 11:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242635AbhJHPMd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Oct 2021 11:12:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D17C660F9C
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Oct 2021 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633705838;
        bh=qnEKjLm+KOY5XuDMQ72thaSZ1OqJCZhrjb1V/SAzXtg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=t7p0bExPoGqUqPFNmtiqwnp9w2Ej2KxrwVsywOayp0w0lI+imHv3xL6okmeCA+ch2
         ztjXNAIFqN7K1WqTo0+8bG4/G2qNLCNAHUquwFwmtN0xgG/WzI5jHSGdyiCFJeqBtq
         EW6WzdiEZkOPmzc9BgfKoWwkda/ZChIaw+zMmGCvNSi6Cj0gfkFSH2rQgn+UA3Cq5D
         9HGg1JDIQRcfUWbvK1WjG63r/oRYebrkHiB+Ec6Igc8eJSVFAlGdQdd+3PTL5xC6IO
         HTuIiL0txzvk6uQH8pI1HYCuqxQQZMhBDKOgIM6cxqGSbtNcdMSpvvPSj6jTCLmnuq
         exNCv4MzqnFCQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: fix a deadlock between chunk allocation and chunk tree modifications
Date:   Fri,  8 Oct 2021 16:10:33 +0100
Message-Id: <cover.1633705660.git.fdmanana@suse.com>
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

v2: Updated stale comment after the fix.

Filipe Manana (2):
  btrfs: fix deadlock between chunk allocation and chunk btree modifications
  btrfs: update comments for chunk allocation -ENOSPC cases

 fs/btrfs/block-group.c | 145 ++++++++++++++++++++++++++++-------------
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/ctree.c       |  14 ++++
 fs/btrfs/transaction.h |   1 +
 4 files changed, 116 insertions(+), 46 deletions(-)

-- 
2.33.0

