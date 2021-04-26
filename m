Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2D36BAE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhDZU6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 16:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234754AbhDZU6U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 16:58:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D371561168;
        Mon, 26 Apr 2021 20:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619470658;
        bh=tfiRF3YInutSAa640YrKoZPtOXKb6o9vlfPgZejh4b8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ef1ybwHUKHm/Hvq8lu5AlClSPWiFQUQr3UJAZjt+oS1r580ZtCIX98R7FJ8Jd6uFN
         maQFjmVrzeohNAhTrzxzjJ9vxdnPN/IuHhXzrGdvY4azs4JOOTOEQytaxug6g4nxfM
         6h9B5tAe94o+5gvpSeJqK1vjgCt+IZzEuPhPgaN6ZjqhS0bqlswISBG80AD1uphLOT
         T6RNxxdzdw6ZiDfZIgsw2PYY6aqIk56XnhMHCGw6Z3uVUiA17ALStGfF63r4ztaSri
         M9h1+f9f0SeE5JZZWfH4vlwUo9+tZAj2hY0XXQTRgAd5KuhK6Aa743f2GF+xQigfYR
         uz5h3Y8oMjY1Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CEB5B6094F;
        Mon, 26 Apr 2021 20:57:38 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1619466460.git.dsterba@suse.com>
References: <cover.1619466460.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1619466460.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-tag
X-PR-Tracked-Commit-Id: 18bb8bbf13c1839b43c9e09e76d397b753989af2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55ba0fe059a577fa08f23223991b24564962620f
Message-Id: <161947065884.16410.3330289498068506592.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 20:57:38 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.cz>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 21:59:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55ba0fe059a577fa08f23223991b24564962620f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
