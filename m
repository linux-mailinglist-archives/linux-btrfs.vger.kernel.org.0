Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4122A0F95
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 21:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgJ3Ugb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 16:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbgJ3Ufy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 16:35:54 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604090154;
        bh=VmrLGl6WE2EXNkLLlDxsm7f6JiKeRoK2ljfuW6VZbWU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0kEZDa0OimBkx3aUBlbbq1gEPwOnthf+pty83JucLhEb4+kLdLuVhEXlZcH0AomhK
         k6TubWuPTWrwjhROAcv2nDN923kpxbsCc9GEFZkDogPfs0UHGpXlTBtNcxuCixTu//
         3GyVyCwa3jnlgMbbbVrjiozptRhBLBUIOxcyhyig=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1604073247.git.dsterba@suse.com>
References: <cover.1604073247.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1604073247.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.10-rc1-tag
X-PR-Tracked-Commit-Id: d5c8238849e7bae6063dfc16c08ed62cee7ee688
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5d808567a51d97e171e0a8111813f973bf4ac12
Message-Id: <160409015420.30485.3407223768263792247.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 20:35:54 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 17:12:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.10-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5d808567a51d97e171e0a8111813f973bf4ac12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
