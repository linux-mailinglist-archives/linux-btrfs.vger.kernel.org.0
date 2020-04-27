Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048101BAFA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgD0UkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 16:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgD0UkP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 16:40:15 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588020014;
        bh=UoFNoceYZZH5pyapz8+tDtt45JQ4gGxzCkqT0ld/LeQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WdYQQTkyxeK95T8CuHjz8bTH+zFimCl4GD6Z+WidKsgXUWQuUhxmGWIoYhTkfxRsc
         WU9DRhYs/o3mb7CHXk72wj710Uk1LzdjmY3VPTJLQwYrvijiq4cP69Opj6nhKhH2hz
         nQSFSeNmB+XfoO2o+ArhUknYksQMF/8aLB8Mc+vU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1587992189.git.dsterba@suse.com>
References: <cover.1587992189.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1587992189.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.7-rc3-tag
X-PR-Tracked-Commit-Id: 1402d17dfd9657be0da8458b2079d03c2d61c86a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51184ae37e0518fd90cb437a2fbc953ae558cd0d
Message-Id: <158802001470.5189.1036883224851379926.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Apr 2020 20:40:14 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 27 Apr 2020 15:45:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.7-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51184ae37e0518fd90cb437a2fbc953ae558cd0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
