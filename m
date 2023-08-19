Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FBE781A65
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Aug 2023 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjHSQBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Aug 2023 12:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjHSQBk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Aug 2023 12:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F822A1C;
        Sat, 19 Aug 2023 09:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F88461B13;
        Sat, 19 Aug 2023 16:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FBD6C433C7;
        Sat, 19 Aug 2023 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692460898;
        bh=TfASc8DZh09W/5u3M7HP4qDHOLoaxve3KZ9ogU5J/gg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f2vTswqkzWtX0WQRvl0kCAI3J3iYeBzJ+BwGyavHafJ7heHaESptxhqEgFUWACSjT
         jmW1IWWUfPhV3YxiaTkhjgP8GiJdbNfDRG+5wtFsWXYIwbt8HTDKMbA8aE4ToQLOGb
         YetDNvyoh73SKb7TTEJiqyta2yRFvFrTgk4kmXLAI5IpW6ifUjnfaKcxkbp7QqtmH4
         139VNvpvCoRFA798DtsiE5nOudsVqO3jqjz1oBcAZgwMRzDai7UIOC0+gpDHTQ8hCB
         bT0llvsLwJY+CZd+C3i/4ZtzxEbGqpu3lr+2NM5xrQDHaxHco1Rnomdjssp5Suixe0
         trTajp6gjPEDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 588CEE1F65A;
        Sat, 19 Aug 2023 16:01:38 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1692453407.git.dsterba@suse.com>
References: <cover.1692453407.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1692453407.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc6-tag
X-PR-Tracked-Commit-Id: c962098ca4af146f2625ed64399926a098752c9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12e6ccedb311b32b16f767fdd606cc84630e45ae
Message-Id: <169246089832.15016.12627522455383760470.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Aug 2023 16:01:38 +0000
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

The pull request you sent on Sat, 19 Aug 2023 17:35:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12e6ccedb311b32b16f767fdd606cc84630e45ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
