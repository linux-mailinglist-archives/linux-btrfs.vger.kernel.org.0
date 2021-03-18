Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A59340F80
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 22:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhCRVBf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 17:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233084AbhCRVBO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 17:01:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A5DEB64EFD;
        Thu, 18 Mar 2021 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616101273;
        bh=DBbLvA4WdkItlvbvWpkSOrxXy1Bz+ZsumyThRKk+jTg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xv98zdqeFcJ4qxamDBlcUJEnWvhbULt6rYPSpV0vD7DRHlX9Pt2TKxvUhXD5DF7X+
         QiLJ510ByBLhA5l+2OiXg9c1Ss8Zb7T3rlS1c7tGxG+QNMtTBsRSQyW9v2tPFOAdTd
         moXyLDXCBmuVOxgga7NtsLC76qekj0lxu5jptHA1ZvkASUfH5ZiuMR3hDyYhYz4xfs
         FWggPXzeYv+SmbXjxOePczIIUM+h/VkoMZ72+pPsjmAIpByr36O3MDOjZ5+GDo1Xjt
         lGfQ0ZvjszaWr5tlFZJWzB0uwMWYkn4C02HptMxrImMJhHrJXKY9mmMT69JwHPb6h6
         MlHeviRP16k/g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9407C600DF;
        Thu, 18 Mar 2021 21:01:13 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1616083082.git.dsterba@suse.com>
References: <cover.1616083082.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1616083082.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc3-tag
X-PR-Tracked-Commit-Id: 485df75554257e883d0ce39bb886e8212349748e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81aa0968b7ea6dbabcdcda37dc8434dca6e1565b
Message-Id: <161610127354.4581.9390555913775423642.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Mar 2021 21:01:13 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.cz>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Thu, 18 Mar 2021 21:14:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81aa0968b7ea6dbabcdcda37dc8434dca6e1565b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
