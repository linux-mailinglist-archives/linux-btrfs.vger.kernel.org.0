Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF177309823
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhA3UCB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jan 2021 15:02:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhA3UCA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jan 2021 15:02:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1DD7264DDE;
        Sat, 30 Jan 2021 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612036880;
        bh=Jz+z0rUUN0yE1nyMgKiXn+DiiWZFjTURqL6sRW1krhE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=da9Mgj861H4jREg6YrRa9UvQHLdNrIN6YLVVUeJKEJu17Zz9Lin7HqlAuotE60Rxb
         CzsI7o90Vm4j4czvd6M8P+jBKkEk4sHJtUff3zIsmoPG7NtQwP+86iuW5WdCVSnvWu
         zyiC5msTeuI2Nfj99gFDaxG4fw0CVB34vLQl9FPJgakrRMp3X7KDe/ZFL8rdIaA/Hs
         7c7SCPRXqrU0mNmUM0JHgAKteYjcDaf2dEeP054APRosmaeXPkSKgLJcgiAJCsDKLb
         G2hIYpEbw+CcwUNx7iAabqIYcDjZ8UN5u6lIbLm78ZIT4X3v/wN50zsRUjpt1OnZ4/
         +ZmvprJXbfS9g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0BCF060983;
        Sat, 30 Jan 2021 20:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1611932305.git.dsterba@suse.com>
References: <cover.1611932305.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1611932305.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc5-tag
X-PR-Tracked-Commit-Id: 9ad6d91f056b99dbe59a262810cb342519ea8d39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c05d51c773fb365bdbd683b3e4e80679c8b8b176
Message-Id: <161203687998.22475.12520605258458720086.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Jan 2021 20:01:19 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sat, 30 Jan 2021 01:35:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c05d51c773fb365bdbd683b3e4e80679c8b8b176

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
