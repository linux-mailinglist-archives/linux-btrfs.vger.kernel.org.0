Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B2B35B6A7
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Apr 2021 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhDKS4v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Apr 2021 14:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhDKS4v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Apr 2021 14:56:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 866EA6109F;
        Sun, 11 Apr 2021 18:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618167394;
        bh=Y0ltobkvGUp/igU5oBlFbRTk8w3B/r96GgbR95UUdpg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GDx0VXq47Mq4jj2zEBpB2ArhJrei49qBhJt1HXMhpETjz+1hpMAEBSOGKlsDBv9/U
         HuNgr9ktDg6DoUjiKipMPMdDQlMHctP2dxqciHNNpyFkulnRqrBx9jPaawbM7Pidk0
         VgQXx731sW0U8IMtCcZ0ZtVtYUyFDfAfwL+w5C1+Gv4sR9adK8rZ7v8zoGsVN8IWIK
         jomqj+XSoGf6wk3XUNYC2n5v6u3NcI5QmCfwT3HjQFk3LsP6pZXI244uoOS9cE4YO6
         tDkcnnuhbYK5bYKvXnWY2xkDO0dFKWpLqir75rBDIPGaMKBkY11qDBvh5D33ZEHSVV
         CW+Td9BfHUg7A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 72464609B4;
        Sun, 11 Apr 2021 18:56:34 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1618147058.git.dsterba@suse.com>
References: <cover.1618147058.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1618147058.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc6-tag
X-PR-Tracked-Commit-Id: 53b74fa990bf76f290aa5930abfcf37424a1a865
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d900724913cb293620a05c5a3134710db95d0d9
Message-Id: <161816739440.6502.16136232391633341798.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Apr 2021 18:56:34 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.cz>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sun, 11 Apr 2021 15:55:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d900724913cb293620a05c5a3134710db95d0d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
