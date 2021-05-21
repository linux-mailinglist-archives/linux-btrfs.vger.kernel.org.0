Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90538D201
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 May 2021 01:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhEUXdL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 19:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhEUXdK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 19:33:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1B77061026;
        Fri, 21 May 2021 23:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621639907;
        bh=HXPclzjaKYZAgxTDeosb3i/LEGol6Rxqyo32K+ZRYog=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hbd5aYMhf6MCOYQgEeISr51jpDK79zVfXKm/EY5cEhQma9wKbe3KUX4a/mHWJ/kaa
         at3KVFa9DLCuQDC8PsOZ70NHuxBWrB4ECJD96XOO8xziqT4LRK9x6zb3m0Fx2bmJnG
         2qhtAf3xPz+4HjLDhNIXT5/426lPeyIfkzW+YCbSxWvtgRc72ETt9Y0xiaSvi3f12U
         5w9iYn191idRTgYicio4OBrU3ef0LhmJYa7bY0baphsS63w/RM/PwO+jNOi7aAhYDB
         TvBvnzIPGhcqfXx0+en4UDK/RgQsGrEXe+0uBe4iO2C0pSCd6lrpQ3eyG8uKVNHDur
         1a+sUvMsCW95g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1439360A2A;
        Fri, 21 May 2021 23:31:47 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for v5.13-rc3, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1621627293.git.dsterba@suse.com>
References: <cover.1621627293.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1621627293.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc2-tag
X-PR-Tracked-Commit-Id: 764c7c9a464b68f7c6a5a9ec0b923176a05e8e8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45af60e7ced07ae3def41368c3d260dbf496fbce
Message-Id: <162163990707.25567.9717741625796090238.pr-tracker-bot@kernel.org>
Date:   Fri, 21 May 2021 23:31:47 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 21 May 2021 22:11:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45af60e7ced07ae3def41368c3d260dbf496fbce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
