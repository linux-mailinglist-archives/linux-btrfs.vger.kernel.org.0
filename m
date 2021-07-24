Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04793D4409
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 02:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhGXAC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 20:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233337AbhGXAC6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 20:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5BDB4600D3;
        Sat, 24 Jul 2021 00:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627087411;
        bh=ToTblDG9PYv4Gwwcz2H9L07OwkGImR4cYwZY0k6WBDk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qvb3Rz1LkgJOOFU90HiSf4+RoDg+ElD6E7wlrsz+oqrjXlAJeaimjheVCvCbejG+I
         oSaeeJQM+44FaRUmRdJXCPsZC+S8uttn5hUcXl69mkFkKaZ5RBSioEDuWAKukqro5y
         sqtmzusoynmFxpvbYB6ii+5yv2nbbMxrjEQxYk2h5Yn3NaOGeAkBH9vXffuLjkX6L+
         jsaQwVt75oUQ4yUADvfZaMGRlzviFCwCkCRn4ircFamb1d9/wNK0PQf0qFW+tgmS2Q
         9fBUYk7/b7MzMOA2By6/DqIIlVzxK1qX6uGsnQHNFW3/cXcrEvbUHSoxcqeFpXoau7
         RQRu8/SDk0A1w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4987560972;
        Sat, 24 Jul 2021 00:43:31 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1627068865.git.dsterba@suse.com>
References: <cover.1627068865.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1627068865.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-rc2-tag
X-PR-Tracked-Commit-Id: c7c3a6dcb1efd52949acc1e640be9aad1206a13a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0fddcec6b6254b4b3611388786bbafb703ad257
Message-Id: <162708741124.15696.18236474466511747868.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Jul 2021 00:43:31 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 23 Jul 2021 21:45:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0fddcec6b6254b4b3611388786bbafb703ad257

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
