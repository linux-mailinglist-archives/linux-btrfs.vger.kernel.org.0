Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8116060C
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2020 20:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBPTuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Feb 2020 14:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgBPTuU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Feb 2020 14:50:20 -0500
Subject: Re: [GIT PULL] Btrfs fixes for 5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581882620;
        bh=0k+MbIU1ONhD+5i27TCKqRnE+r3QyWQAXl96Sc9M/Lc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U7T90rf6PPazwggKT7YvfMSWJzh8vUKCdfW9ArBTwUnDq5cSHah28usc2T15/64ES
         GAx8JLGKIvzxG0S29NHRA8siugWry+RuaXkjpl2Y4X/MXRYCU/85Tgdd+S0gpHy1kZ
         JaQvzPtSRQdV+MFcJZN1CBBEOC1K5ynj/RpgXQmA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1581859345.git.dsterba@suse.com>
References: <cover.1581859345.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1581859345.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc1-tag
X-PR-Tracked-Commit-Id: 1b9867eb6120db85f8dca8ff42789d9ec9ee16a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 713db356041071d16360e82247de3107ec9ed57f
Message-Id: <158188262032.7458.5326663573994894744.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Feb 2020 19:50:20 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sun, 16 Feb 2020 14:51:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/713db356041071d16360e82247de3107ec9ed57f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
