Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE051E13E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 May 2022 23:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiEFVjl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 May 2022 17:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354971AbiEFVjk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 May 2022 17:39:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A254E11C14;
        Fri,  6 May 2022 14:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 114ACB839B1;
        Fri,  6 May 2022 21:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC4DAC385A9;
        Fri,  6 May 2022 21:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651872951;
        bh=uif5qSoOd4svX7t8pgNrtqryaK/4SsZVfdNrsbtTDyU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GEPhz76vRWYhkGuPG0SJ6UDZcOg0S06M0Ol4YkCQ0ozCtl8jHRk41Osd7DfQ4p9Yg
         UQARd0a1v87nvKuPX7qDSsmvi2klWtcvgeKay6rELdCV04tHi9Kc9PBkcIKNml9yI5
         J7WrhU2mCMca6v8f2y6bHiTorn28AaknhW+wVp55js7p3QQsEK7N+cPvFAvQIhvTSj
         56shF2WbctDK8kX93wy4bfhBYnGLdE+nodoH4qZ535yV6bu/4zo7Pxal+vGMgNwwEG
         c6lpS9rey5JuBrOjpViPm4grviM9i8BOulGLnPNnfx2iqVDfXdfX/9i1qFFhPMSGYU
         csRkrOQJh5zOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7F42F03876;
        Fri,  6 May 2022 21:35:51 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.18-rc6, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1651860315.git.dsterba@suse.com>
References: <cover.1651860315.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1651860315.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc5-tag
X-PR-Tracked-Commit-Id: 3e1ad196385c65c1454aceab1226d9a4baca27d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b97bac0756a81cda5afd45417a99b5bccdcff67
Message-Id: <165187295174.17607.2726486271724468528.pr-tracker-bot@kernel.org>
Date:   Fri, 06 May 2022 21:35:51 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 6 May 2022 22:55:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b97bac0756a81cda5afd45417a99b5bccdcff67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
