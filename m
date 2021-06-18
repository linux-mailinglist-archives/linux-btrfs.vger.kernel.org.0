Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5F53AD613
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jun 2021 01:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhFRXnf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 19:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhFRXnd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 19:43:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D810261261;
        Fri, 18 Jun 2021 23:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624059683;
        bh=KO7Mky7TEISWwYQgm3GqeIzYRSBkq+MhTix608n1iWU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N576FvJOdNgAlZCIhHt75rPKw0FHWBESQbMFSjsJhcmeEGSBs5K7APkbnNnG6EAPo
         ADqnAasX/MrLqcmCCgqnVks6/dqqV01eC5zfKhcDnIhXAmGIfRY1T7sgPdrxlPS5vH
         MDWVOT9EKIn9zM9JUblibScP/vUBGqUQtFVeTb3kK9mjHakZTCxFsvZ9Tx7BvVc3Qu
         x08GJolE3yhLbt8lp3gyjeivwWC7eodNf0U3KkbQ/7xwoP4GAX9hBl7ErFGAKJ1I/w
         GaN7Q0Ygz+lffhBKuECV3VxWvApeGw7y0s4vKps6CL4l4l1i5SjXIIQ+SjRqlqdyKo
         PWNUAQNZC9seA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C5642609D8;
        Fri, 18 Jun 2021 23:41:23 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 5.13-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1624051838.git.dsterba@suse.com>
References: <cover.1624051838.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1624051838.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc6-tag
X-PR-Tracked-Commit-Id: f9f28e5bd0baee9708c9011897196f06ae3a2733
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fab154a33ba9b3574ba74a86ed085e0ed8454cb
Message-Id: <162405968374.12858.13556789583759382541.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jun 2021 23:41:23 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sat, 19 Jun 2021 00:03:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fab154a33ba9b3574ba74a86ed085e0ed8454cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
