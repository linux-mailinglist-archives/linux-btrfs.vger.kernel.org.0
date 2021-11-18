Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54F456475
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 21:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhKRUwH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 15:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233131AbhKRUwB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 15:52:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E9C4161264;
        Thu, 18 Nov 2021 20:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637268541;
        bh=siVq0e438uiRtsiWtGzNd3hjyjKb1dAZWPDysi4Ne2A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oF147evwWftN1mxEYR7v+kg9EngTuSX1F1yrcMS3CPaqauPF/bBo0joSKV3opDixN
         /DJSeiJMDCBAxcTRY39UC+jem4DGxpYr7Uq280Y4YgsTsYz+9HZ0i6xrFONdYPf05v
         W03z+5qbE5YPcZUhH2R7Xkq7dzTKcabesDNtb0kcrzPfMV/VU2LKx9xRaWoDJTeFv7
         /npiEcrPFdGeBI1gO9J0w4U1196jeZDpodXC+t44OkBZGIb8VaIvIwbQ6fRF9Oo3Q+
         PsZZ1gGBfA7XeaY8KorfCuVoGeLs0K9TinDXA6boseLkEyLWNZCJOax+bwA49h6DVF
         QTgKGR917iFgQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D6E4B60A3A;
        Thu, 18 Nov 2021 20:49:00 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1637255480.git.dsterba@suse.com>
References: <cover.1637255480.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1637255480.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc1-tag
X-PR-Tracked-Commit-Id: 6c405b24097c24cbb11570b47fd382676014f72e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fdf886424cf8c4fff96a20189c00606327e5df6
Message-Id: <163726854081.10311.9888697616725802760.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 20:49:00 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 18:37:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fdf886424cf8c4fff96a20189c00606327e5df6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
