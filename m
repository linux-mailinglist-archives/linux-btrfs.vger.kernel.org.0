Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED27149758
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 20:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgAYTFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 14:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgAYTFF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 14:05:05 -0500
Subject: Re: [GIT PULL] Btrfs fix for 5.5-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579979105;
        bh=H+0XpGFfGPUV2y2iRW2Owf5aTH1ZSxhxku/PWb2qBfY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iEsc696AGm6SJ2x+Ui5BVlpUFLYwr9JmYZ1sP/qpeRZ4zIEGtHyuz4X8rt9bPwYRn
         Ut3S6XvM3RmXqj9+RaKcn9f2jwWU/qXkUpx7Cv6D1zHeoTeORcqFv7XK9esOBuwvTl
         cJ+iLEhLXEE7kJ/KRjFJhOeujTONf3sY1Ivdt9bw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1579953624.git.dsterba@suse.com>
References: <cover.1579953624.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1579953624.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-rc8-tag
X-PR-Tracked-Commit-Id: 4cea9037f82a6deed0f2f61e4054b7ae2519ef87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a075f23dd4b036ebaf918b3af477aa1f249ddfa0
Message-Id: <157997910521.7716.16664199927978016601.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jan 2020 19:05:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sat, 25 Jan 2020 13:14:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-rc8-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a075f23dd4b036ebaf918b3af477aa1f249ddfa0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
