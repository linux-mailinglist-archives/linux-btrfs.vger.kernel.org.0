Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18328267C34
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Sep 2020 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgILUAN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Sep 2020 16:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgILUAM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Sep 2020 16:00:12 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599940812;
        bh=VdoZXTk+UR6XpCrloLo/XtFJu1VPXoE+G6QqginAjPA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rFGKDVN2hiTswqbjE6jUNx32tySVX9VIa6lqm+vZh8p3XN+tTnl5a+qH2K/vpM/c/
         8Jg5KUS06Ye4WhilJb8gbCFTXsKA4HypPjWFYhSzrHbaB1kVBdVWRwUguJ1AoTWqQ0
         z1hbUa2HBYNkiZRKMSvp0a+aEpEHHXAi5Ds3twKo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1599836573.git.dsterba@suse.com>
References: <cover.1599836573.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1599836573.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc4-tag
X-PR-Tracked-Commit-Id: 2d892ccdc163a3d2e08c5ed1cea8b61bf7e4f531
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edf6b0e1e4ddb12e022ce0c17829bad6d4161ea7
Message-Id: <159994081194.29146.3415981946491554173.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Sep 2020 20:00:11 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sat, 12 Sep 2020 19:01:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edf6b0e1e4ddb12e022ce0c17829bad6d4161ea7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
