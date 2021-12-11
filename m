Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61469470FEE
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Dec 2021 02:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbhLKBm3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 20:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345586AbhLKBm2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 20:42:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7291C061714;
        Fri, 10 Dec 2021 17:38:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 969B7B82A7F;
        Sat, 11 Dec 2021 01:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6828DC00446;
        Sat, 11 Dec 2021 01:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639186730;
        bh=1JfpQPOQL4eYqHCYcD7awOQz2G1YmmawBn1cAE8Qvqo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FW/HDYvNEtxt8f2fWdJzNfJFCtQISgtVrnU77vgdG49qA57nzEoWVQlaSvJ23vpN0
         0njtgJgnTfMgLp0vMUnudPv8Z5I9eoenIUm36wtrFX7y5wWUjIC01ATMhl30Xs6nzt
         nsPUbV6pQnRjtX3DvUhKKrd83LamVstEIhB5oh4pA85wTpg23Q6TVx6kv7JF2kYZay
         BVirZlhszzE629gOasgSXec2JK3vg0xwOpct2Apx/ke0gZUKxLTxlDxjdxq9fY3pl8
         OL+QHHjkB8p/vuHs6vbJkC4BanEJ6rUW65a7ibr8xdFPG2W2ngkOZa/WFm6/kbly2x
         7mlijC1FlBlAg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 55E4960A37;
        Sat, 11 Dec 2021 01:38:50 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1638975228.git.dsterba@suse.com>
References: <cover.1638975228.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1638975228.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc4-tag
X-PR-Tracked-Commit-Id: 8289ed9f93bef2762f9184e136d994734b16d997
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f513529296fd4f696afb4354c46508abe646541
Message-Id: <163918673034.12736.2334798226700083003.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Dec 2021 01:38:50 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 21:41:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f513529296fd4f696afb4354c46508abe646541

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
