Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4439959A78D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 23:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352304AbiHSVOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 17:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351689AbiHSVOn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 17:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650E3D399A;
        Fri, 19 Aug 2022 14:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02E5C6173F;
        Fri, 19 Aug 2022 21:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6978FC433B5;
        Fri, 19 Aug 2022 21:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660943681;
        bh=4ygUPp+aIFecoGYX8y+QA9dNQzyIbBQ+ZAyD0vk6aYA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pHLWDctchzvdnFGiD7M0cT0b4uwa5PoMDtdfbu5bgPxJwYzotkpktO7u7TPb1N0HQ
         iInZdPWIq+a1fO2LkCPslIzoIqn/sGxQgAM5Cq+huj1ik/vXTL3O2V67vPdlzdkb6K
         ugwz0KBYrshX8zbTe4yvOHeUCD6NKkviOeJSqhGVHePp2gTjdFJE4iz+IOxco51Ald
         ZKnHHwu6eBrhI5Fd9zKeKvLZQh78XZ8bgSOa5ZS1AaMlL0QHxsXi0WHSr1rAvkx0EB
         n10/zQ10PdkjHfWofwkZSrP1h9tjpcfn7IEMiDPU0GmgbSgWz1s0wCluk1bATfVeW9
         MYddUdboyeHsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5704BC43142;
        Fri, 19 Aug 2022 21:14:41 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1660908668.git.dsterba@suse.com>
References: <cover.1660908668.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1660908668.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc1-tag
X-PR-Tracked-Commit-Id: 899b7f69f244e539ea5df1b4d756046337de44a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42c54d5491ed7b9fe89a499224494277a33b23df
Message-Id: <166094368135.15089.7383849118918589560.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 21:14:41 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 14:00:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42c54d5491ed7b9fe89a499224494277a33b23df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
