Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C40E38E41B
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 12:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhEXKhq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 06:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhEXKh1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 06:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 665A361074
        for <linux-btrfs@vger.kernel.org>; Mon, 24 May 2021 10:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621852559;
        bh=GSDjrtFnIDl+2sMcmJsinFYwzCRqaAzvGre8jYD+Y7Q=;
        h=From:To:Subject:Date:From;
        b=kBGOWBRLib1irZe3eVDDJInobHA8EBr0YJArR2Go7I1eqM8tzzZH3HG+sWS4VvlJn
         r6uckDcIJIymGn4q7sIo8tT47WK7opoi2vrLmrYW8c6ino9fWKdC+ZEudQj6dNR+tg
         18jxP3SGhr1623AhxrH/Okd6SOnCFmkGH7+nAhYaEwtmyHiyXt7saH24J5QqW4AlHZ
         b6U6ondpsI6ttqrZYmrxVtiYIlfQPmY7RRQQ7opttpwASW6yEY/0hqaP//vihqgV5t
         iwLtjaiDtqdcxnpgt1rfcT2JDnhKm337jLJNHyTLi61vkxyDDCY5Q3ZA+N42Z4cYln
         dgP8ujm6zEK7w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fix fsync failure with SQL Server workload
Date:   Mon, 24 May 2021 11:35:52 +0100
Message-Id: <cover.1621851896.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset fixes a fsync failure (-EIO) and transaction abort during
a workload for Microsoft's SQL Server running in a Docker container as
reported at:

https://lore.kernel.org/linux-btrfs/93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de/

It also adds an optimization for the workload, by removing lots of fsyncs
that trigger the slow code path and replacing them with ones that use the
fast path, reducing the workload's runtime by about -12% on my test box.

Filipe Manana (3):
  btrfs: fix fsync failure and transaction abort after writes to
    prealloc extents
  btrfs: fix misleading and incomplete comment of btrfs_truncate()
  btrfs: don't set the full sync flag when truncation does not touch
    extents

 fs/btrfs/ctree.h            |  2 +-
 fs/btrfs/file-item.c        | 98 ++++++++++++++++++++++++++++---------
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 65 +++++++++++++++++-------
 fs/btrfs/tree-log.c         |  5 +-
 5 files changed, 128 insertions(+), 44 deletions(-)

-- 
2.28.0

