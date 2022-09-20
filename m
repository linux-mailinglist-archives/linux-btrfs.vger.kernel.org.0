Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0115BEC16
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 19:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiITRfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiITRfB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 13:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04193A17A;
        Tue, 20 Sep 2022 10:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D24762BB1;
        Tue, 20 Sep 2022 17:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B50F8C433D7;
        Tue, 20 Sep 2022 17:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663695299;
        bh=Rkxydn4YN+5M7j3qI/Fs1N4qdqh58G/P+hNWDeNT6Mw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MnA8N/ypMO6BmIr/XbI7+SVnEjx06Ww9K4nXYE5yjf3BEAfUFh7eh2Pjv4EnRBed+
         PcWzPftjDVu0Y9l+P4JU8nEEQZVRZ5kkd3zToXVK8D4Kuh8AOv2+1rPq7rzHE0C1kz
         +WAklntA13sXLHXW5TdyI+FXwBWxxgcWZXmoIaWYDqJTFSdHZ+m+FxXmb0o6GmknOE
         cnY8I65QFudNX02JdVc6kwlE5mIMAW5ut3a0ssZYU7bVBFZUfLlbgdkiyPUdZJVw+q
         1cktwe1WJYQnVGlDvehhMRCGHH04xhvXA/F4VWOtz3AHG4KtQEwA2u5aqKJVSAAMun
         WOEMUnxDnlqqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E856E5250A;
        Tue, 20 Sep 2022 17:34:59 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1663677070.git.dsterba@suse.com>
References: <cover.1663677070.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1663677070.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc6-tag
X-PR-Tracked-Commit-Id: 2dd7e7bc02829eded71be2342a93dc035f5223f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60891ec99e141b74544d11e897a245ef06263052
Message-Id: <166369529963.7287.16853168427881544465.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Sep 2022 17:34:59 +0000
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

The pull request you sent on Tue, 20 Sep 2022 15:05:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60891ec99e141b74544d11e897a245ef06263052

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
