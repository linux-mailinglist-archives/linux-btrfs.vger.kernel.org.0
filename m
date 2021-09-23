Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED284167A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 23:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbhIWVoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 17:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243322AbhIWVoR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 17:44:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 869B261214;
        Thu, 23 Sep 2021 21:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632433365;
        bh=RjjaToJXcNrptpcnNIYMT9jIJMpxE8u8iL6ymHPju0Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Js5hkx3UyfkZyVT93MR6ohhqQJsz93w+3AWXpyIJDdk23ZxVCFMEMxCAUyS9r0V1c
         4L9NmMOAkJVHminaNDkuOIMtBypBaFajNK4Pv8TNCqw9vBKLGd5U0vy+Hd6Dw2hphZ
         F3GgS2tRjPH9S8gt5dQhYxjrPV+HTcT+dHuaaiqFZCCqRHMw4ASmQj+pb9+J984SuN
         CYDgtF5WH9AsAnG3O0MJwNr1YcNA+MKmjV6blrjDErhYYg8EFc14W6matfVvn2cAL9
         OjcVkq6S7sMjuMmiIqdFuDxFO6QZm5vGlZOKm3IXN06DgXmOT5GOML0zl73DsmGX2+
         6PhTi5rZgc4Og==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8023C60952;
        Thu, 23 Sep 2021 21:42:45 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1632432123.git.dsterba@suse.com>
References: <cover.1632432123.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1632432123.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc2-tag
X-PR-Tracked-Commit-Id: 0619b7901473c380abc05d45cf9c70bee0707db3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9e36107ec70445fbdc2562ba5b60c0a7ed57c20
Message-Id: <163243336551.317.17177075008294838993.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Sep 2021 21:42:45 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Thu, 23 Sep 2021 23:36:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9e36107ec70445fbdc2562ba5b60c0a7ed57c20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
