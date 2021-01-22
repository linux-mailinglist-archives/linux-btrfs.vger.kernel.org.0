Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FCF300752
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 16:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbhAVP3d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 10:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729061AbhAVP3T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 10:29:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A039523A84
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611329318;
        bh=vhy/3YRrRGI9CXR24Lm2QarD1d/496Zr4YdSunpRZC8=;
        h=From:To:Subject:Date:From;
        b=e75XzruZeSnHm6MFPt28elmF1RSlZyv8asBJbIRSvOZBxyPS8abCRqeKmxAADrHRf
         i55WljgzbJs1dA2RE/SKUiyGV0XWJPUjLoZfKQtJZ3nBVOnmripVR6KY0fqRARuODu
         hmCBLhZ+xHhe4LeFWr+8elkJhwVR3GRoR+TwE5pD156JWq51ScRWe+n8ASYHKwGDdl
         O0V6k4FBjEeNtkXuY1BMEUnD03I0N0yaLPom6O1n0+wAUvF5mYIPWGm0Lv5+ESU7SR
         zi9FNssLNrM6oC5d5hgrY6HkawszOA264xiuRzNZsEfwxWBadHY1Pm9xiWD4aHJNoJ
         BiEI1CZqVhnbA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: a couple bug fixes for failures of log replay and mount
Date:   Fri, 22 Jan 2021 15:28:33 +0000
Message-Id: <cover.1611327201.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This small patchset fixes two bugs that lead to an -EINVAL failure during
log replay, causing the filesystem mount to fail. They are relatively new
regressions, one caused by the recent change to make space cache loading
asynchronous and the other caused by the refactoring that made tracking
pinned extents in the transaction instead of tracking them at fs_info.

Filipe Manana (2):
  btrfs: fix log replay failure due to race with space cache rebuild
  btrfs: fix log replay failure when space cache needs to be rebuilt

 fs/btrfs/block-group.c | 15 ++++++++++++---
 fs/btrfs/block-group.h |  3 ++-
 fs/btrfs/extent-tree.c | 15 +++++++++------
 3 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.28.0

