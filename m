Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCED675B392
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 17:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjGTPy4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjGTPyz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 11:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1F312F;
        Thu, 20 Jul 2023 08:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0727961B79;
        Thu, 20 Jul 2023 15:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6827DC433CA;
        Thu, 20 Jul 2023 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689868466;
        bh=g/klJKu4e9nEA6xOvl8vjvc+D39ecUc8yVX0M5tAQsg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vp11WSeZ/sh+kUM+Zgs2EiAh8AUk36dVREhBq6wgS2Vpy9TfB9VCy3ct0S6q430ZB
         cJP0g8cF53jFgSMCbP+ygr+UIFib65LUXKwVWvqcI3QnhNDwH/53jD+YOZ3WLaFO2Q
         nGdJD7WzcJK5BWzAN9K7hJFYw2xdtRoD/lLE7P8uOhRCi65MgPDZkYnZUEJcL2J5tG
         KbOGbamIGU7fVcLp9NuNs7ic4QAvAFZr5dae4YxgFwKmQKjtXMdhUIdKnXjOGABNy7
         +poF8Lp7EkP9//NLvRNOOoEc3Go2qFIfRv8ZCm/Wo0nks0UlXQbXDt/hSTiGtK3TUw
         5s6aUtLFMVVtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54CF4E21EFB;
        Thu, 20 Jul 2023 15:54:26 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1689800327.git.dsterba@suse.com>
References: <cover.1689800327.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1689800327.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc2-tag
X-PR-Tracked-Commit-Id: aa84ce8a78a1a5c10cdf9c7a5fb0c999fbc2c8d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46670259519f4ee4ab378dc014798aabe77c5057
Message-Id: <168986846634.27763.18201552089227974454.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jul 2023 15:54:26 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Thu, 20 Jul 2023 16:23:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46670259519f4ee4ab378dc014798aabe77c5057

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
