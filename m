Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFDBFBA67
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 22:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfKMVFH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 16:05:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfKMVFG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 16:05:06 -0500
Subject: Re: [GIT PULL] Btrfs fix for 5.4-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573679107;
        bh=F23cvoRoqrCWlr35NjIMIE49ZR7wTNyqsqVpCHoHjMs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gDgM3NyJWuSPY9VpjGU4pZDEKxUV5B5nkqTPIPUSj9ug8XUImRBK+weMnH8E8h5jr
         L5dp+7gQI669IYDRb7DT14sbxTAyQPWpT0BIHat3+bI1sSvVyEsM4wsu0YQ4+2Yfdg
         pk5lR11RVc8o+WKvAGWONZPfAdpYOT4aK+hGlt8k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1573671550.git.dsterba@suse.com>
References: <cover.1573671550.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1573671550.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc7-tag
X-PR-Tracked-Commit-Id: e6c617102c7e4ac1398cb0b98ff1f0727755b520
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afd7a71872f14062cc12cac126bb8e219e7dacf6
Message-Id: <157367910652.4154.3240212309981343057.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Nov 2019 21:05:06 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Wed, 13 Nov 2019 20:06:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afd7a71872f14062cc12cac126bb8e219e7dacf6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
