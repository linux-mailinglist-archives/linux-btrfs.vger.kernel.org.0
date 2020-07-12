Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189DE21CB20
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jul 2020 21:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgGLTaF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 15:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgGLTaE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 15:30:04 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.8-rc5, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594582204;
        bh=SF5iAQeq/11QhFwI1nHYlrFH2RvER9fHSR60c0I3TM0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GJXGeUidSuIGFqE8Q2ehiS9utzXW3w8WDaL14yEOeXrcsfenZ8AHfc884nfTmD2PU
         eMPKsgeLeeuCDvZtc9XObNv3XM3DBmqlW9wdcIFtU4jBfXqzvNBF3IaVkdA5ryztpO
         2/bZVn3BejBTRaD/W08tf3C6uZMUKcKdaGvw8B7g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1594548115.git.dsterba@suse.com>
References: <cover.1594548115.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1594548115.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-rc4-tag
X-PR-Tracked-Commit-Id: d77765911385b65fc82d74ab71b8983cddfe0b58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72c34e8d7099c329c2934c2ac9c886f638b6edaf
Message-Id: <159458220443.16981.9962622832431601410.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jul 2020 19:30:04 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sun, 12 Jul 2020 12:14:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72c34e8d7099c329c2934c2ac9c886f638b6edaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
