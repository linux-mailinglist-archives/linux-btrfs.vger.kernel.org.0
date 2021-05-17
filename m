Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77181386C5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 23:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhEQViV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 17:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235836AbhEQViU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 17:38:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6829B611CC;
        Mon, 17 May 2021 21:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621287423;
        bh=qBe5mhR7YpKZMe0+XXsws1WMqvqeobEECQyQH1bwcyg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iVJK2HPHb0wbLPmnQTj+1NSY2IFBQDz9vAuPiIURqBtCk7F7/KmMVA/jLstPVNV5o
         mFJ2jRXrpL8h41sf3ZIRFo0FRinIVYK8BOR2qigO4ra4HQ2EcEbem8uKjBaMjX2O9p
         N4swM/f3IGipToDsGLlnnOJPHApTTLMT5AOxhLl2Ub0s54PJqgNnkDKF7w7umTwpa8
         lEWE+k0GeON1DktPKU3wIXMEKnOJYIg29yk9hTQhenr7vJFg3awlxJzHfGkNPqMte0
         +5n7LUXRIqVQyZfSQBG4/4y071EbehH+r2PqLU8Uy0nbzwCa3rb16lA27n9KUMkMHa
         yhV44Kv3XXUzw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 580B160A35;
        Mon, 17 May 2021 21:37:03 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1621258094.git.dsterba@suse.com>
References: <cover.1621258094.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1621258094.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc2-tag
X-PR-Tracked-Commit-Id: 54a40fc3a1da21b52dbf19f72fdc27a2ec740760
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ac91e6c6033ebc12c5c1e4aa171b81a662bd70f
Message-Id: <162128742329.17425.3913250442730236677.pr-tracker-bot@kernel.org>
Date:   Mon, 17 May 2021 21:37:03 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 17 May 2021 15:47:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ac91e6c6033ebc12c5c1e4aa171b81a662bd70f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
