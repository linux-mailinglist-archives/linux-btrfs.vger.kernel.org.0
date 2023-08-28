Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC378B955
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 22:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjH1UP2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjH1UPA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC05B19F;
        Mon, 28 Aug 2023 13:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4152465127;
        Mon, 28 Aug 2023 20:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA374C433CA;
        Mon, 28 Aug 2023 20:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253695;
        bh=NmfNo7gafJraxZpiIc8OHdpybXKziwT1fx6ifOiximE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aH3/8xW03qUJUrE88BP+uCasn/tajiiE1DUm2pe1CX0xZHtz4dE/GhYRiR+Q7R4NU
         OcEQeGuHk5f7exTrAUztWDSSkjvZrHI8RpRap2IOiFQT4Pn1G/OqDNBffZ1wZ/KLUC
         npTFW6zI0yGSeK1xGZvVDLy7VcSCCXX3CPVHS2zekCFzAd/XcwqRxP8gqoqnor4Q9j
         uWqJ98IpRrZ/FZbvWaIuumJ87VJDnKAjZ5S2VHfPupBw3lK+0YzkI+ztB0/MeIoJJ6
         jzD6kSneB8tcobGi1MwACoN1xcwUtX8mWI27Q0gdTrKUv5Lh5yqzy7oU8FvDhuTwBB
         7rclEM/c11k7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99B83C3959E;
        Mon, 28 Aug 2023 20:14:55 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1693225246.git.dsterba@suse.com>
References: <cover.1693225246.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1693225246.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-tag
X-PR-Tracked-Commit-Id: c02d35d89b317994bd713ba82e160c5e7f22d9c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 547635c6ac47c7556d6954935b189defe90422f7
Message-Id: <169325369562.5740.7922248431412073728.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:14:55 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 19:40:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/547635c6ac47c7556d6954935b189defe90422f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
