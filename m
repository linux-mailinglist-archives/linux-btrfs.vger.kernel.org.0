Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4702165B6DD
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 20:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjABTLf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 14:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbjABTLe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 14:11:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3389FCE;
        Mon,  2 Jan 2023 11:11:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC9DD61084;
        Mon,  2 Jan 2023 19:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BE9EC433D2;
        Mon,  2 Jan 2023 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672686693;
        bh=amXc586uJbUZXup5hB8IqGUhyCm1HZg+HkDBQY3fH2c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MBQOomroRvbdC3I3Ztvn1C8WY8A9Id8JWaAhiVKDxgCyzbs0vCGW/fl0kQyZtIiZk
         4WDdi8jxY5FeckeMIpxH96thGSj0rqfO/nWitrQoATK3CDAYTrNGkIJ4aVhvpJe6BM
         fRZiyp1+lYCopwRQK9Xt4T8v6+6eu9wgjuIt1pAaTfHXnZMsKaUJI1g0d48+6n4Dax
         2OENE1Er3HnsBhiPjNSnvTbZQ7F7+dLLrBKjUtcuRQGoWllDuQf3yqSvQTaQRuH3j0
         b/0ESK+Gk9TkZz4MgQnr69q9zFexdv39gLLzC/SgKHgmfp/pQgFhJ4bijLxO3CL8PA
         wXnSGULphjLgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29904E5724A;
        Mon,  2 Jan 2023 19:11:33 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1672662506.git.dsterba@suse.com>
References: <cover.1672662506.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1672662506.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc2-tag
X-PR-Tracked-Commit-Id: fee4c19937439693f2420a916169d08e88576e8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69b41ac87e4a664de78a395ff97166f0b2943210
Message-Id: <167268669316.32021.8658551249487115866.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Jan 2023 19:11:33 +0000
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

The pull request you sent on Mon,  2 Jan 2023 13:38:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69b41ac87e4a664de78a395ff97166f0b2943210

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
