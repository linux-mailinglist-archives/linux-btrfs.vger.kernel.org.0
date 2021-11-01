Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B33544215C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Nov 2021 21:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhKAUHj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 16:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231371AbhKAUHa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Nov 2021 16:07:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2674C60D07;
        Mon,  1 Nov 2021 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635797097;
        bh=wsztAH+vPKvPuiZP1b5VZe7eFH5cIhjvIA7Dqe1E5uc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r+rXI4AmuYS0Lr5+AAvyrHXM7Nx5efyHt7EQJ7XOiQ3vBMUkOs5lMAIVqPb1kd0eA
         +ns85RoKvJPaQd0m5F/39zeMxb/+38lAEGyEnP2yNy1TbVV6PuYULxpq423dktjpIP
         cag02q3a9Pg5mKVWVsbzH9faFVL1Tw97/DXTYdkCMiMHS/P4q99t80G/sbrcHGdkk2
         fUpPwNBvRputVhBiLsrYMuNZbXOXgRKdlr0/gX9dfUxgm9iiQksDTLN7fh7WoT6TZW
         xkMwIV3nHlid6TJIzDArxLKpKORbIoU9U+w4IpbGeqlPfzffwHXUYePsAxawTvB/By
         sUyXzldDuNf8g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1F1D8609EF;
        Mon,  1 Nov 2021 20:04:57 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1635773880.git.dsterba@suse.com>
References: <cover.1635773880.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1635773880.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-tag
X-PR-Tracked-Commit-Id: d1ed82f3559e151804743df0594f45d7ff6e55fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 037c50bfbeb33b4c74e120eef5b8b99d8f025418
Message-Id: <163579709711.1875.13335296229565050268.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 20:04:57 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon,  1 Nov 2021 17:45:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/037c50bfbeb33b4c74e120eef5b8b99d8f025418

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
