Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3492EC3DB
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 20:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbhAFTXb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 14:23:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbhAFTXb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 14:23:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AF4E223123;
        Wed,  6 Jan 2021 19:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609960970;
        bh=+P/7jLrGNl81j6sOwVgCopo8xsY5C89pS4E4HvIw2Wk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lOpnp+XRfREPXHL7nE+09OuOFzarDV0ofAzxqPK3Fu1MgYIXaNp3OaQCnKMYUvpp/
         AChXs1s2/z2eqcFDLR1/yPWZg9tntl/AgrdFHJAL0Vm0nTdP7/ZCpB1IHOfMtzQ3xr
         iQpqZ1mo9ffRU31FNVfwMVrMIlhmPmzBzXFL6clNRjYauRMQ/Mv1t33+RAY9I8nGD7
         jnTsZHsEvSIUa6QBn/mqsVm/UZdHsdV3jFiv7PdMfwyA+MnmLPN9OaEqVHJQ2sbeMU
         fSO71mX8jS+L4ikL+Zfbp5PyJOaORyyr3wi7yVz9u1hQ+Sqqbn+ci2jNMBmMplVQAg
         3IF2oQ2dUlgDw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 9AED760385;
        Wed,  6 Jan 2021 19:22:50 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1609855176.git.dsterba@suse.com>
References: <cover.1609855176.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1609855176.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc2-tag
X-PR-Tracked-Commit-Id: a8cc263eb58ca133617662a5a5e07131d0ebf299
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71c061d2443814de15e177489d5cc00a4a253ef3
Message-Id: <160996097056.25393.11030152966145479938.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Jan 2021 19:22:50 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Wed,  6 Jan 2021 12:48:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71c061d2443814de15e177489d5cc00a4a253ef3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
