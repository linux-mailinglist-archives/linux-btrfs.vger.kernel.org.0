Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF8675E86
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 21:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjATUGk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 15:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjATUGj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 15:06:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00959370B;
        Fri, 20 Jan 2023 12:06:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E22D6207C;
        Fri, 20 Jan 2023 20:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A356CC4339B;
        Fri, 20 Jan 2023 20:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674245197;
        bh=SzklnK+JBjT0Ao1194ovpqtY04L5Jhm6C1RShd5eUoU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GYUSXx+hd64iXd2mp9wN5NHxOwkbLNPSaE84bmkzBogQi1O555tyfdinIAgDhDf6P
         v8oyvjwYA+VaR+qX5/Vsh2BEPLil1Fh+kv8B0sb3YdFmTTN6CO0hLpKz4rTd89brhA
         81QSE/jjLMpWhv7m95Z3k4RMjZcra128OglfeWMwmOH2uVI/HBHfRwEgpnGBLtdRIJ
         sIQ2GvkMtpIEB9JpikJjUgjI4CMJb+srd/0xrPETUK0KYWxKH78HiXPHtVVUz3c5fr
         ZWD52fx4QOObzYg/mTdJgWaMtpephjLjSKgKXocwkmxvP1OtOCIYbthB329l8ZRHpG
         kmYcu6WcEuizQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FD09C04E31;
        Fri, 20 Jan 2023 20:06:37 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.2-rc5, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1674232757.git.dsterba@suse.com>
References: <cover.1674232757.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1674232757.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc4-tag
X-PR-Tracked-Commit-Id: b7adbf9ada3513d2092362c8eac5cddc5b651f5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26e57507a0f04ae0e472afe4799784e2ed19e1b0
Message-Id: <167424519757.30775.15589105896916864359.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 20:06:37 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 20 Jan 2023 18:09:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26e57507a0f04ae0e472afe4799784e2ed19e1b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
