Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7956731ADDC
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Feb 2021 21:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBMUEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Feb 2021 15:04:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhBMUEX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Feb 2021 15:04:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6F7C164E29;
        Sat, 13 Feb 2021 20:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613246623;
        bh=hZnvRJr3oD9IDR8yD3jP5BPGlWkf1jcsDop0WiXLF58=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KVZwBfO2A8hMBELKkMFr47VE18Ou5RP843wd3hrtDOXaYequXXbVhZ5SGb9/TBbVO
         dhi5Jcp1CfmAhJJc5M8dr2DiOseFevsCxk48YfBXTNBbjx2xkXeRlcxV25cn0QLGra
         Td3Y1gVYF+HLxCbJbzBKfGzd5zg/2F+zp/3SEY40t8dpKYjztHbgJcT3tvbFiKHN8d
         9kK68w2ie0j3YqBBe4Nc9ZvgZhjiPofEBlpn2NTnaElxrFvmQVfo4aSof92Ju1jGTp
         bWjT7BFbdAfuK5U+V1AW7Ls5XQXzdgEuHT6lme/aJd6Nmd7DRbCaCIY6W9p7xOu7R3
         IZdd6hj7u9Lrg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 61CF660A2F;
        Sat, 13 Feb 2021 20:03:43 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 5.11-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1613141613.git.dsterba@suse.com>
References: <cover.1613141613.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1613141613.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc7-tag
X-PR-Tracked-Commit-Id: 83c68bbcb6ac2dbbcaf12e2281a29a9f73b97d0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e42ee56fe59759023cb252fabb3d6f279fe8cec8
Message-Id: <161324662334.16511.11554487863932417402.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Feb 2021 20:03:43 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sat, 13 Feb 2021 14:02:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e42ee56fe59759023cb252fabb3d6f279fe8cec8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
