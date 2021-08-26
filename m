Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D83F8E38
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbhHZSxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 14:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243350AbhHZSxj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 14:53:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D3CC261037;
        Thu, 26 Aug 2021 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630003971;
        bh=exzlZmAfx7XoWDN6zboi85bMGq8VcbfoWZD9a0PExpA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IxrTz3OyYylv1YvvkEgHl8GKsQ5U+t2XetNep7eda2PvOYX90dEHO3lzIjYH5tW8H
         eWEJEbxhA2CkxlVdqnlZppyuRNs6Dk+wVGHR3wePmKZyzddqcMH49ic/ORD9QPiBc5
         hr6c69qkCl8Ss3hEKGFmARDXFlS2OIkCekPy21nORM5dewNowxl82JH6/BhWi5P2RG
         wh32ofx5mnZFlhtFdfjjED9I+ig/DQehq1FMLrZ2jcorAidtVKKLGgyJxU1BD3GrzY
         wi/69ycL0/HZbNjFcZ7PVfdq8qGjjx0JOACLNNdew7tuWJzBPUCy/Qx5vs04iG+rBA
         wBcflod7gtVPQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C452760972;
        Thu, 26 Aug 2021 18:52:51 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 5.14-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1629897022.git.dsterba@suse.com>
References: <cover.1629897022.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1629897022.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-rc7-tag
X-PR-Tracked-Commit-Id: 4e9655763b82a91e4c341835bb504a2b1590f984
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b49ceb8545b8eca68c03388a07ecca7caa5d9c1
Message-Id: <163000397174.15844.10404432096604090598.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Aug 2021 18:52:51 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Thu, 26 Aug 2021 12:15:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b49ceb8545b8eca68c03388a07ecca7caa5d9c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
