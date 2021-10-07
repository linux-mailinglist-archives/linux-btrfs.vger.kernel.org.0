Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1624251A4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Oct 2021 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhJGLGA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Oct 2021 07:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhJGLF7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Oct 2021 07:05:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 903DD61042
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Oct 2021 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633604646;
        bh=yRyFb4TfyMBdPt3/6MMYuT7NMcgdZh3/url9qXAS+Qw=;
        h=From:To:Subject:Date:From;
        b=GbXhUfDbCIY7VwlRHVabNZUduWDqqDPTyMbfXewCXW7iFGn8NdBHJiDjIWllOVw4l
         jxKDysyvAPcTUw6RtBP3fz5UdKix05ZUXhbwkpfYe27PzPjP7ZeFQj62j4DSBpR+Lj
         5M/eA01lnUkpxip7lr7RvmZhV7GSdr5t2OkoZg9SjmTTCl+I/TYOzRQqZ3o8tXxOuu
         ahcAPKKY26ZPR7JYmwx5ujzKeo8747eKV6S+smZSxygeRzadHjEswlenUdiyXOO1GF
         B/BqEzRe1w+1ib8bPBs21Qzta4uHxENCA3Zu8PAgmuiAvcyPaxC5h9KfnRRpRfwfK7
         2+hqhCJ9fCj9Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix a deadlock between chunk allocation and chunk tree modifications
Date:   Thu,  7 Oct 2021 12:03:58 +0100
Message-Id: <cover.1633604360.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

Filipe Manana (2):
  btrfs: fix deadlock between chunk allocation and chunk btree modifications
  btrfs: update comments for chunk allocation -ENOSPC cases

 fs/btrfs/block-group.c | 140 ++++++++++++++++++++++++++++-------------
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/ctree.c       |  14 +++++
 fs/btrfs/transaction.h |   1 +
 4 files changed, 114 insertions(+), 43 deletions(-)

-- 
2.33.0

