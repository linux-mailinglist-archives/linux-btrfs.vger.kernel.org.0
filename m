Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C747429A73
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 02:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhJLAco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 20:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233228AbhJLAcm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 20:32:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5DC9960E54;
        Tue, 12 Oct 2021 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633998639;
        bh=8j0yO3mrzdajsPBefvELAQ3OF4X12HB+ATnTDOvcn3g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o/4aVHE/rSXXcfF9C69qRfwW9dRofqiDJQHdm59vf7Pa0WiERuX9tt2u26+JXMKf7
         RzW2tGK3+Ec3Fk//Lp2iLmx1j0Ya7577WAVkXdfO6USAn7eb/lHzqdzZEWcqRQO+kf
         PQ3LgfeRlEKdC3uf5EhN5fZ66djZYVURl9xD84PWqdD5DdTyfsrK9Cmfry2R4PRBRA
         l3BK2uxEotvRiAIe0R5iQWgPU+qLrp8yluCQgNIkwfGS/WtYxdsQXPP+FOvPv1HgbQ
         7aKzS+YqlbhDLZlj15ivgxXfZwQA6pOlaRv8Ek4oZ39JwE4LRhCM9uLfsbsCaKr87V
         4bm5HAfYIbKDg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4DCF2608FE;
        Tue, 12 Oct 2021 00:30:39 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1633976241.git.dsterba@suse.com>
References: <cover.1633976241.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1633976241.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc5-tag
X-PR-Tracked-Commit-Id: 4afb912f439c4bc4e6a4f3e7547f2e69e354108f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1986c10acc9c906e453fb19d86e6342e8e525824
Message-Id: <163399863925.7007.8693559836175490858.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Oct 2021 00:30:39 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 11 Oct 2021 20:40:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1986c10acc9c906e453fb19d86e6342e8e525824

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
