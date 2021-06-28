Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820D53B6B66
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 01:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhF1XjN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 19:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233819AbhF1XjD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 19:39:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 28DE661CF6;
        Mon, 28 Jun 2021 23:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624923392;
        bh=VgdtsaxqUIuUUk3CT+1AR20xTf7vtxnZGV0pwLxhiCM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sfMk++KyGCADuTN4Qo/OQWMIm14JeBNrQceO1OwKmNWbXkuh/Q845YzCGbfqW5ZiT
         htrYFqu2cb6kF6lpEFAyqBP2OesdS6mE0b9/aY1ZCNzA9RPzlDN4kai0QSYdXd7uyH
         +LjTSCod0jHTKMmiSC6xzcMR5BfLKVEmnkbrHNg2fWNdsftPENH5hmDf5qdZDQXMUB
         SBQKRxdjO/jWHQ/4PEq0XgleYHF05sVUXJrW+Lj6ykHwY03GPX728wqClHwZnr1/M4
         PYnJQQyGGmuDyrkfFQHuVnIqPwXJXZo4agm7tN+NAx5d94r3jZJ2K202jZiCsHtJpt
         G2NDXYUlNl41Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2453860A56;
        Mon, 28 Jun 2021 23:36:32 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1624891843.git.dsterba@suse.com>
References: <cover.1624891843.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1624891843.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-tag
X-PR-Tracked-Commit-Id: 629e33a16809ae0274e1f5fc3d22b92b9bd0fdf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 122fa8c588316aacafe7e5a393bb3e875eaf5b25
Message-Id: <162492339214.13806.7154005954656729838.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 23:36:32 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 20:16:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/122fa8c588316aacafe7e5a393bb3e875eaf5b25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
