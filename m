Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598B46DE452
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDKSwb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDKSwa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 14:52:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B414718C;
        Tue, 11 Apr 2023 11:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C53360DFA;
        Tue, 11 Apr 2023 18:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADC5DC433EF;
        Tue, 11 Apr 2023 18:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681239148;
        bh=xgkGv+4WdT2HU2DVQa5K6Iw5Vrw+XtrK0ss8HgX69dw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SFAcnz4Lj1z3KPDs40jwID/FyajC18DQNB0CpOUuSAiH8r+lpiSJMSr4HTG4DiCO0
         jQVdoHa8S+xBOlj1+s3lrwhL1hGu6w9cHbzPnstupqzG0X3XDQEquxyAICMl394on+
         L2U2fbMkNLwJ4wOFiAQkOvfmhHTxK1DcLaH+KcBUQIx5TPay0VEnKl6ypAz50tfYL6
         D1+73joXzma8d64nJCoXKuth76dTYeV2AdvOFAbjg8hg0fEHhv6SK8j5skPcAbYEa4
         lZUUYgH4RIYicmsj5Ol42QT+JZauQxB8UIo3sWdLb0ytlCde8WPDAMNYGMd5mWYOA/
         Xl/hactDCEWkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A4BFE52443;
        Tue, 11 Apr 2023 18:52:28 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1681236364.git.dsterba@suse.com>
References: <cover.1681236364.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1681236364.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc6-tag
X-PR-Tracked-Commit-Id: 68d99ab0e9221ef54506f827576c5a914680eeaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c40519251d61590377b313379ae2d4d4ef28266
Message-Id: <168123914862.3950.15008647061454291192.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Apr 2023 18:52:28 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 11 Apr 2023 20:12:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c40519251d61590377b313379ae2d4d4ef28266

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
