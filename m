Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4BC320CC2
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 19:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhBUSlO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Feb 2021 13:41:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhBUSkz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Feb 2021 13:40:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C1AA464EF5;
        Sun, 21 Feb 2021 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932782;
        bh=OEOlZ0Miwzz9thdzN8093qiYb/uJvzkLOZ7cMsPwcas=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KUIlMLpALupFXZJdPRdU7Jk2p0oPb1Fb96pvhHihMhoHv4GARuG0AMyNwXeVfQ1FX
         XOkbBBDsoRbRaAagNIk6GDX9KnRZM3Jp7Wp+6VSAA/Cm/RxrAVUSFntX/KCRFd7AL8
         Oc8rMmg1QczJswRHeirFXBFwNkycxBlxfFkp7ecGU/6Sezh5hTMUFpdVq5efg77/Nu
         M3WivS/ByXaWoKnsgjKUhMkaCfSNxgO/bOJwxpo/5tZEuYvkf5f8fHzycxa9B6WFqR
         oBxos4b77OKhPjQhEdIYd2yKVMt04Vfw1aB5Gpd/gadDwhGV/FkL6wbLvkjyFq8mpM
         zrwVy71+BRL3A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BDD1760191;
        Sun, 21 Feb 2021 18:39:42 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1613417746.git.dsterba@suse.com>
References: <cover.1613417746.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1613417746.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-tag
X-PR-Tracked-Commit-Id: 9d294a685fbcb256ce8c5f7fd88a7596d0f52a8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f3952cbe00b74739f540981d1afe84cd4dac879
Message-Id: <161393278277.20435.408669554854597551.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:42 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 13:56:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f3952cbe00b74739f540981d1afe84cd4dac879

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
