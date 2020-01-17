Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C46141205
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 21:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgAQUAG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 15:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgAQUAF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 15:00:05 -0500
Subject: Re: [GIT PULL] Btrfs fixes for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579291204;
        bh=fmXTxDUIlYYp54eVmWS+lFuTAi8VG6mPeyJJEcKn9J0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SirTZByzUcM3JPjPw8s3fITeN+8bVh/RxMHHZoHAVV15+wU7laRK2GXl+4Jf7sJwB
         qtbjmWP/xfldii1AlGXfxAgqQ3q62R/tQAydcmENDUEiv9iNX3ED+bfaadiLAOXRt7
         me4yF6G3f0o/rKoCmhk7qHTuOH9RRI5fA4XwAqZA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1579282274.git.dsterba@suse.com>
References: <cover.1579282274.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1579282274.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-rc6-tag
X-PR-Tracked-Commit-Id: b35cf1f0bf1f2b0b193093338414b9bd63b29015
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: effaf90137e3a9bb9702746f993f369a53c4185f
Message-Id: <157929120492.30919.2900017973775631241.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jan 2020 20:00:04 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 17 Jan 2020 19:39:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/effaf90137e3a9bb9702746f993f369a53c4185f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
