Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3414C3A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 00:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgA1XkH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 18:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgA1XkF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 18:40:05 -0500
Subject: Re: [GIT PULL] fs: Deduplication ioctl fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580254805;
        bh=tUhXcy5ta6IIU8tmwDqL/iRBsLFREm3taAO1DytlLAg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VTFIwDPQnC7wXIFqKXQ6vGoBwhZkGiQeXpxaeZNXgVq4l0p6phULPaVbL882PX82v
         /5HgDrJ0QQpo8DhBBijslnMwaN4BvVzUgk4qSGkrK7rcIC94Yg6xB7BP8UfiVBjple
         gXRq7S3x8BypMYYwv4GwCfqqKwBMaps3Gl7WQiIQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1580142827.git.dsterba@suse.com>
References: <cover.1580142827.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1580142827.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
 fs-dedupe-last-block-tag
X-PR-Tracked-Commit-Id: 831d2fa25ab8e27592b1b0268dae6f2dfaf7cc43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5f7ab6b1c4ed967fb76258f79251193cb1ad41d
Message-Id: <158025480536.16364.16698686040672279236.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 23:40:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 18:19:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git fs-dedupe-last-block-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5f7ab6b1c4ed967fb76258f79251193cb1ad41d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
