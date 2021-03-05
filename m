Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3017932F5A7
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 22:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCEV67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 16:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhCEV6o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Mar 2021 16:58:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A9E0D65012;
        Fri,  5 Mar 2021 21:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614981523;
        bh=bUQbUgqvrNSxzar2qMasEAos3EmLo9rUdax6ZSF2h5I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z3+VmPEm2sh1Y8jHYSdAaAmb2gkXVrsyiu9K0n9eXu6QLJDcWSJs0sC2s23gFnCFW
         qY74PmBj1Ad8GwzUYH2htGsvfHkzOWKW+Hy9SZNMPuJVfDC7u5Lx/QFbsGNZjqzhrm
         PwadwTON0p/+Xh+8yegW/8O5aTsLRPMFqzAkMZMY0osuHKp+icqJEPXuNF30n6i3pK
         87JjAAg0J4/Gg5UHru/Jea9CnJ+Xsduf3y2tDMDee69Z7g0mfchqpMgmieIl4ifP9M
         K6Faoh58LZ42FHeZedFp0Cv+e6+ETnBwnDSloDAOZhIiB8zxt/U6I9Oy0KwQlPILCW
         l9/ZVhgXTA+Qw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A2D5660A12;
        Fri,  5 Mar 2021 21:58:43 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.12-rc1, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1614954547.git.dsterba@suse.com>
References: <cover.1614954547.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1614954547.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc1-tag
X-PR-Tracked-Commit-Id: badae9c86979c459bd7d895d6d7ddc7a01131ff7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f09b04cc6447331e731629e8b72587287f3a4490
Message-Id: <161498152366.14373.6018450622738416840.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Mar 2021 21:58:43 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.cz>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri,  5 Mar 2021 16:55:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f09b04cc6447331e731629e8b72587287f3a4490

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
