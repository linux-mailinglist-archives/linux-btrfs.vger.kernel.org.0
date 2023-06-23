Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3034273C4F2
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jun 2023 01:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjFWXxX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 19:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjFWXxW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 19:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755FB2707;
        Fri, 23 Jun 2023 16:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D063614A7;
        Fri, 23 Jun 2023 23:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FBE0C433CA;
        Fri, 23 Jun 2023 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687564400;
        bh=FnxzefsaTzbp+Ty5/DLKRZksozuMYjx/k4Uq1l9uCs4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y2Oe8Yz2Ec4uzAVMliWTeqznCdY6zSBcjp4oxBRVCQYHWuliI5uZV6JLM1QvzYnae
         Y5CBw/V+hJL6aRdvG2BtwudNsL+cQlNCBNKYA0u7cCgdF5fZpMQNb/ulCQhKAdUoF6
         nrokU/sOUfmRyAgq51+xppBDIX6PlMIvGSvBcJbNY5KsK1uxyNMpAF6RJrJvZdxm7y
         ND2y4A7QKvNBGlZlBLvgxoA+177V/47I+tvR43b69qt0qLEtcabtFWGO52RlPPbKNM
         uRwCmYfzcMy0CQ9fxWnjgAlDHVuSi80NHZb/3AWXv5jdqvJSVtyJgU+kiQbPwg14Sd
         wnGaEm+CcFv7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B457C43169;
        Fri, 23 Jun 2023 23:53:20 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.4-rc7, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1687448378.git.dsterba@suse.com>
References: <cover.1687448378.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1687448378.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc7-tag
X-PR-Tracked-Commit-Id: cb091225a538005965b7c59c7c33ebe5358a5815
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 569fa9392d2d48e35955b69775d11507ea96b36a
Message-Id: <168756440037.22934.17463512814382354107.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 23:53:20 +0000
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

The pull request you sent on Fri, 23 Jun 2023 20:58:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/569fa9392d2d48e35955b69775d11507ea96b36a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
