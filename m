Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03F1329236
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 21:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbhCAUlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 15:41:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243538AbhCAUgj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 15:36:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 887F56024A;
        Mon,  1 Mar 2021 19:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614627852;
        bh=OfSBaJPBhc/fjGQk4m3zQhQDW9sTgfgItYBfLQNB2/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LdKtzKESoDxk+F9VIjiqCS9rDn4NL3qxWEQUYeb3qw73t6r6Hg5lKyxAPOmhyAz0U
         EEmF/JKZk8huu4l/PQSCg6ugmId9tZY7cBggxhT2MO9r2FliKUDq1zH9gr83C4X666
         sveJmwET2Iy5iWCfa7qwh/7vaIB1nK0qMQzxLEC397sDA4SfT+d5mOjYOXrOrHVwX2
         koOtv0VEvoBuu6zGLPe5+8FxZf46dSrx6Kl96CBTxstHblkbARo7DphZmxDEKO4VgD
         4uqOUJgsfuGacH5HYOlsO1VoB3IYaXy1JEh1bbGadNeV8JzBV6KKB5iA9Bn7DdSJOy
         LxhoLQOSxS2aw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 83D6F60A1B;
        Mon,  1 Mar 2021 19:44:12 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1614605230.git.dsterba@suse.com>
References: <cover.1614605230.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1614605230.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc1-tag
X-PR-Tracked-Commit-Id: 6e37d245994189ba757df7dc2950a44d31421ac6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c608aca57dd034d09f307b109b670d1cfb829279
Message-Id: <161462785253.2736.17440051067724079509.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Mar 2021 19:44:12 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.cz>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon,  1 Mar 2021 14:44:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c608aca57dd034d09f307b109b670d1cfb829279

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
