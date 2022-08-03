Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6558946B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 00:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbiHCW3l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 18:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiHCW3d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 18:29:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB25D0E2;
        Wed,  3 Aug 2022 15:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAB0D6162D;
        Wed,  3 Aug 2022 22:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57A6BC433C1;
        Wed,  3 Aug 2022 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659565764;
        bh=t1RciV1xPTwChvX7bhjaTpzTaaf8NHf8H2MceaXA9Es=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FA7ifDjo8fQKjPmyhpleXkzlbWD/52IvOgoQ1HmxoGkdSwb3BDtzQWGLnYp8h8m2f
         prIThBExJYNjCmJejX0Xxb4eR4hk5QoxZUDG1UnH/f9eKbplVbKa8dVfAPNrjm2eW3
         GnSyPaJI651XljO335m4Y4plZbWjyH0x08rh0jmfCOvxtG5+A87oNpvimVx+cJpHVG
         V1uodcFwwsAUlBtQWnzxZVNeYwQjF99z5FUY//RpTGmgaFCS3B8exYNRh0nHLUlUXb
         o3SJTsH4NlPgdXWEHLX+W68ZB054+aYTACIUcRRGHSYqMpOMBmid/4yG3HjRloUdh0
         2/9fU3NOX+Oaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45E4EC43140;
        Wed,  3 Aug 2022 22:29:24 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1659357652.git.dsterba@suse.com>
References: <cover.1659357652.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1659357652.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.20-tag
X-PR-Tracked-Commit-Id: 0b078d9db8793b1bd911e97be854e3c964235c78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 353767e4aaeb7bc818273dfacbb01dd36a9db47a
Message-Id: <165956576428.24057.5912940537330062229.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 22:29:24 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 18:40:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.20-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/353767e4aaeb7bc818273dfacbb01dd36a9db47a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
