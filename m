Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47F6EB16F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjDUSPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDUSPX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 14:15:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F3A2127;
        Fri, 21 Apr 2023 11:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E93E64E43;
        Fri, 21 Apr 2023 18:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0B84C433D2;
        Fri, 21 Apr 2023 18:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682100921;
        bh=AJswIoPQK4jl9psU0GdM/Vpu2uMzvXFWvHDFwIEmotA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IDuOOodLgG8JHoVEZxK4xmdXhtX6xRv9fSzCXJhZ3h7nMqmsx9oiygXlPFEz0a1Oa
         f2AfM7gn79S7aAUxmcDGE9lzb1qDLFENqGHgrNHz9szdX9LjJLWUWQFmb/FVbdc2z+
         W+watTykxuUEeUdyMwW/F/taqndKLUWPFUvpPzMGwZBs7ehCUNOuKYJAiPtNd/TWWO
         QbH1LfZInmcMcsQs3PMFUc3W1G9Is7CIJB49V4MPxNEzWe1vo4eRQyIahwiNNSNeC5
         5PGXmNM/CJ7+tPibCW2GzDkMU46VZsHHXq8v1IAm4/T42FWx9U3C0QFqv4x5wW83pM
         Wsxe8C+UYL8bA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D056E270DA;
        Fri, 21 Apr 2023 18:15:21 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.3-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1682088075.git.dsterba@suse.com>
References: <cover.1682088075.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1682088075.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc7-tag
X-PR-Tracked-Commit-Id: ef9cddfe57d86aac6b509b550136395669159b30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c337b23f32c87320dffd389e4f0f793db35f0a9b
Message-Id: <168210092163.26173.4961431818128675021.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Apr 2023 18:15:21 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 17:21:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c337b23f32c87320dffd389e4f0f793db35f0a9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
