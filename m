Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE46923DEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392146AbfETRAW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 13:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389465AbfETRAV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 13:00:21 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558371621;
        bh=vWPY5Ul5yjk13DZ/U0D2PZdx4tU1xULCEwnZyr79O+c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G2zoIBVgxcNB+dEVqdBm6j1Gw8I9j+cKcW1PNIACLQlOqsc8ZGaM3IuEZglwxyDD1
         maRVekriYBjGAdSHUy0YsBaz/Bf5ofbv5B4VMH9KzlMs2+5nETYnu1azDGrRS5aHru
         c8esXE990CXj+A7hWB2nG9R1tZVqL+KtWOxqMh/Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1558370339.git.dsterba@suse.com>
References: <cover.1558370339.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1558370339.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc1-tag
X-PR-Tracked-Commit-Id: 4e9845eff5a8027b5181d5bff56a02991fe46d48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f49aa1de98363b6c5fba4637678d6b0ba3d18065
Message-Id: <155837162103.7151.17612750682185207342.pr-tracker-bot@kernel.org>
Date:   Mon, 20 May 2019 17:00:21 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 20 May 2019 18:52:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f49aa1de98363b6c5fba4637678d6b0ba3d18065

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
