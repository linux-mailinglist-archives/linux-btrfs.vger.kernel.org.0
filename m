Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35F82F22B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 23:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbhAKWZE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 17:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbhAKWZE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 17:25:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D517722D07;
        Mon, 11 Jan 2021 22:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610403863;
        bh=cZy5iG1dWnO85D0f/h8kXpBNZ3w1DGJAW/MQdSkgCQc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CD+dVflhcuLtD9tDg5emdy+S8KSXctN/PPtiE4nlfBhAfw5nF3BHANjZyJQH+VB5a
         zmA/JZYooCJBrCKP5iceA2JGK32ycQcxpyeCO8e6UgvE8CTEh/I21Mtb4hi0euK9Pz
         c1upoGwVOipuUtzuYz/U/INhAjPX7aGC2227MqgbqJkc+FC2vyGnzYJk0kjdhiICAx
         wbLvp3sRtpoBA82+WjgYaFdgpB6kIeNNn1HAAR5+8tUwaeGrH3G6EkI9in6+E7yz2m
         pULqwp5XBTEJ6dmWP4J7V4kf82ZnodTz65LBpanthh9Lsr5ITN5i67cEqiE1xhN1wj
         CR52cwBeC513Q==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id C208360188;
        Mon, 11 Jan 2021 22:24:23 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1610386850.git.dsterba@suse.com>
References: <cover.1610386850.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1610386850.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc3-tag
X-PR-Tracked-Commit-Id: e076ab2a2ca70a0270232067cd49f76cd92efe64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e68b9961ff690ace07fac22c3c7752882ecc40a
Message-Id: <161040386372.14966.4925989524744804733.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Jan 2021 22:24:23 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 11 Jan 2021 22:09:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e68b9961ff690ace07fac22c3c7752882ecc40a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
