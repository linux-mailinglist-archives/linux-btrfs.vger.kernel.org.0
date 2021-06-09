Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825F53A1F95
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 23:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFIWBW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 18:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhFIWBV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Jun 2021 18:01:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D8E0C613E1;
        Wed,  9 Jun 2021 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623275966;
        bh=ZTjwBRs8iepYieLOaOmZ5yGsZlt+HP5lzrHnyrqKJos=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nzw7lZVZBOQJRm/0IVkFG+R6BfXETtuEQj/+xHh1oqym/tcaGVSG0tKutLQoEbw/G
         HxV17SEymyB7/RYrUnCd0BQZNSz9NZ7CbWyGy13OyNks6zn9t192ONl1PVN3y+gfAF
         g8k/RUNavYYNgGKsKwhv7pj1eDe0UCj/+XTQzgcS0iccZL4MJfCU2cv95E7sGzw4eH
         yERvagg8VMKzKFc7tSGaJHLrnxpVfhpcYbxK3DJ5CO8dKlY79Jrws3pYzo0ldNp67e
         qh59nJc6SrBiDerTPGW5NAPKfyzJR3FImJwOaNpv5s5Qw4MtkhWrYZL7UkLorAVWrB
         B4ibDFpW5t9Yg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D347E60A4D;
        Wed,  9 Jun 2021 21:59:26 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1623242687.git.dsterba@suse.com>
References: <cover.1623242687.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1623242687.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc5-tag
X-PR-Tracked-Commit-Id: aefd7f7065567a4666f42c0fc8cdb379d2e036bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc6cf827dd6858966cb5086703447cb68186650e
Message-Id: <162327596685.6358.4184696705493003922.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Jun 2021 21:59:26 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Wed,  9 Jun 2021 15:28:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc6cf827dd6858966cb5086703447cb68186650e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
