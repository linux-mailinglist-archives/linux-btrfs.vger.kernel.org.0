Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4E1917EF
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2019 18:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfHRQzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Aug 2019 12:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfHRQzK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Aug 2019 12:55:10 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566147310;
        bh=TtfhaUUKj2Y1IGvk2e3S4weWB+Msnb73bJ/bCeL6TwI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K3FhHMrd3iu/9s/iRMEyrT+iLgrFKwQgayjMS1WfXKXoF1uSyI0ziX/i/qYBq2wA/
         WLh1kSMme/7qtnJ4t5Ij0kR0wt5ZiVnta4kuWFcjTjtlaEOCQA1wHvcM6Q9s+3AoZl
         3Y4UsOd+v7RL7gCCD2FIsr4CZ7JKYc/575+IHxpc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1566128979.git.dsterba@suse.com>
References: <cover.1566128979.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1566128979.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc4-tag
X-PR-Tracked-Commit-Id: 07301df7d2fc220d3de5f7ad804dcb941400cb00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3039fadf2bfdc104dc963820c305778c7c1a6229
Message-Id: <156614730998.21549.16408074511740817535.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 16:55:09 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sun, 18 Aug 2019 13:58:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3039fadf2bfdc104dc963820c305778c7c1a6229

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
