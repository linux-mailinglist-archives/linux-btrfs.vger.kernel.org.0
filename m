Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B3A603306
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJRTG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJRTGt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 15:06:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5019E7171C;
        Tue, 18 Oct 2022 12:06:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECED3B82034;
        Tue, 18 Oct 2022 19:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7594C433D6;
        Tue, 18 Oct 2022 19:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666120006;
        bh=UzvyzZB4z8zaJHUvDySCub2q8BzcoaN315wpyazuXZI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CbhW/tgxxBCXnctDKghPRNChHGPoCLMPaw5FEbHMRbyH1mCj29MklzPkyok+tNBcx
         XsaNEre06WNlkoh+w+qzrEp+GHIZYRtuNkNCJE98mC3UY5VGkp93S1AsvWJhQIzE6t
         wGBqc3A0NL4WHNn9576XxFyTjM4/i5//EvotjPnODamesBN+ZletFleunpzMcTTsan
         TriuK7C0l2ncR5jEII23F2l2RnmKG2fFgqi6n711nylYREH8PAk8eGsFr4FH8cZAv2
         wuTskOGE/oK4UsJr1oFHcXOMTEhqlTN/5aWTtLttAxLL/xxm4gsq4eNjqiURNSFgrw
         X0dU//o5/CPeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A361FE29F37;
        Tue, 18 Oct 2022 19:06:46 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1666091548.git.dsterba@suse.com>
References: <cover.1666091548.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1666091548.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc1-tag
X-PR-Tracked-Commit-Id: 4efb365a3f04d0bee7833f168b0b00a15edefeac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aae703b02f92bde9264366c545e87cec451de471
Message-Id: <166612000665.5469.12770260882529116064.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Oct 2022 19:06:46 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 18 Oct 2022 13:43:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aae703b02f92bde9264366c545e87cec451de471

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
