Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD681243F73
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 21:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMTrG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 15:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgHMTrG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 15:47:06 -0400
Subject: Re: [GIT PULL] Btrfs updates for 5.9, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597348025;
        bh=MqGI7BVaytxO8TFlnO4oNLiLpBRGWrzNeO+UdRVW2rY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1kiCxWgznFypqWGW7OXOEdu+VvybEIexlnfnD5RwkAsOJSQXa7ls4+g6nPMWQDgG/
         5m1fXfkupkJpnVrstE9YhGOTNpNXmaGCsPGXpV6k3Rf1LNAf3JQfgQDfwL4AGwNEYR
         3Msbd65ximX3V5sd4UWcGVdsupiYCyAidKzBCTTU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1597326304.git.dsterba@suse.com>
References: <cover.1597326304.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1597326304.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-tag
X-PR-Tracked-Commit-Id: c57dd1f2f6a7cd1bb61802344f59ccdc5278c983
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23c2c8c6fa325939f95d840f54bfdec3cb76906c
Message-Id: <159734802572.27850.2787554778682149297.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Aug 2020 19:47:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Thu, 13 Aug 2020 15:52:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23c2c8c6fa325939f95d840f54bfdec3cb76906c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
