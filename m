Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7365549B8C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583671AbiAYQdU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 11:33:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46708 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577104AbiAYQbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 11:31:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87F3F6172E;
        Tue, 25 Jan 2022 16:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBBF3C340E0;
        Tue, 25 Jan 2022 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643128293;
        bh=VQsRuu/jA4nWNWLTdhkAabbKcRrNx4KcfGNroobbkeo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AasKlkpnJowQrmZCXnRHYEagzgQFkTa4WOqNiF3hUTWE0uoNVaUVutSsQzFD8H7p/
         ZBRsiW4dEtyNjuB0yuDwfE+zqgPTuiTNyjwUr7AvosT3g4oUE1XLaQU7stn3y3pZ5+
         yXifjfnsY7vuw3tGHV0CuOggP6YGlRnD9vAt+aKslxOQxBfEzuvbxHSHfH7nnh8CSq
         1oRW9nE4iJLG6csMl7dC4jg1vey9T5x+G7U+zti0UmCNLBKI7ot2Ep+ySEsMmVTIhR
         NzFddqMSCHboxBBXA+/5/Uqe8VUh+6HWAaSPVAwnsTe+g2C93jF752uunLjS9e5AkZ
         zy7Fnye+tSpaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6081E5D084;
        Tue, 25 Jan 2022 16:31:32 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1643122662.git.dsterba@suse.com>
References: <cover.1643122662.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1643122662.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc1-tag
X-PR-Tracked-Commit-Id: 27cdfde181bcacd226c230b2fd831f6f5b8c215f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49d766f3a0e49624c4cf83909d56c68164e7c545
Message-Id: <164312829286.8622.16491063957310057694.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Jan 2022 16:31:32 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 25 Jan 2022 16:36:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49d766f3a0e49624c4cf83909d56c68164e7c545

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
