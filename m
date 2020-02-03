Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE021150E91
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgBCRUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 12:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgBCRUQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 12:20:16 -0500
Subject: Re: [GIT PULL] Btrfs updates for 5.6, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580750415;
        bh=2i4kGZDx1UJ0KCNGsGuS6GtH6PprI0IhXDC3M8ke3HU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BMOYw8bE3Fk/lwgvRGXv0HdJzkwP70E0S5W+DsaPVntYsgUJUPegd2rakY71RPPK9
         danqLhBztx86oN/EgXrZbNNCop4jFPYf9c90SuP5aJbnJrY06U/v8XDlXGDaanbSyF
         3ARjs+RaPQgjbXxyY2vCbjaBdJJn/0LbjaM0ClP8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1580742376.git.dsterba@suse.com>
References: <cover.1580742376.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1580742376.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-tag
X-PR-Tracked-Commit-Id: d55966c4279bfc6a0cf0b32bf13f5df228a1eeb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad801428366ebbd541a5b8a1bf4d8b57ee7a8200
Message-Id: <158075041561.16129.7539615413709223416.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Feb 2020 17:20:15 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon,  3 Feb 2020 16:38:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad801428366ebbd541a5b8a1bf4d8b57ee7a8200

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
