Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633944AA145
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 21:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbiBDUeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 15:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiBDUen (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 15:34:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7716DC06173D;
        Fri,  4 Feb 2022 12:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38854B838EF;
        Fri,  4 Feb 2022 20:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF5B8C36AEA;
        Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644006879;
        bh=0Ao1o6X0x09WbH9vZNytGw4gbF+XOE0SXQfzFkBt1GA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uJV6ThZ81szlxE8ALUKvz/ZPDu+2WJ2vAXouguscU4ZCzrhgtjvvNUqg7JBotDdOY
         /3yfC4QxmR0SiXdvKmdOxPuRwkAGNfsTTke+g7XMsmtp5ExXEwGROIKnFyOgLL++G7
         abKpCfOzB5wm0uhbUgf5s8iSPU9yCs1OfqEnqAJYD/Z3t+XunYhl9dpJd/xgQIyS22
         CyxkYAPGQ72Sp1emksXul5WggWtJcRDl8JS+6TssTWM/oOFsqHkfV728PNxOPaihQJ
         vUROyomjdOdaQEWsXy/SBUl2jI5rbFphoSm1hJnRy7r7Eg0NpAYpLKE0K/WCRa34zV
         BwMIez1Za6Dyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF682E6BBD2;
        Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1644001677.git.dsterba@suse.com>
References: <cover.1644001677.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1644001677.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc2-tag
X-PR-Tracked-Commit-Id: 40cdc509877bacb438213b83c7541c5e24a1d9ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86286e486cbdd68f01d330409307f6a6efcd4298
Message-Id: <164400687984.31755.13439340173384849614.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 20:34:39 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri,  4 Feb 2022 20:25:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86286e486cbdd68f01d330409307f6a6efcd4298

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
