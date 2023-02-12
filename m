Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A5E6939AC
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Feb 2023 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBLTet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 14:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBLTer (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 14:34:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81CCE3B8;
        Sun, 12 Feb 2023 11:34:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50EC6B80D4D;
        Sun, 12 Feb 2023 19:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBDD4C4339B;
        Sun, 12 Feb 2023 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676230484;
        bh=sPxOyIMW5drkS2BvOPWkz5xuPQYTFpDt4KX8VE7dsoA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sfFcxtmr/9YRuuaGfLsgt5lDynmI8XqcLWXPDw80PysMuH1EDSO0ti9nL6W7OjAL2
         kKruq9ltvtwkubMIb2wZNUIKOFyR74td7J4A2wo/Ri6PW0vWBKJcMTDnbCQ0vpfAwe
         I2KXokIKIOHukrW9uKiXwp+o3j7Ru+xIA60fbCN4zf7WrGj5w/Q6InUCeQDak5U5Kq
         bcSEzsWt8/skBj+HAYgcSDPPJF4qZjkLvNg4467n3n/kx4tXEnDpdid1tzsmUdjPno
         pEScsBPh2TbeG8Dyo96QF9zIPHW4AEYXq+u2CexQ8w0LBkFz4BU+HoAeby6HuyJAqd
         nDkQdMkzKnorw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAB62E21EC5;
        Sun, 12 Feb 2023 19:34:43 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.2-rc8, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1676207493.git.dsterba@suse.com>
References: <cover.1676207493.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1676207493.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc7-tag
X-PR-Tracked-Commit-Id: 5f58d783fd7823b2c2d5954d1126e702f94bfc4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 711e9a4d52bf4e477e51c7135e1e6188c42018d0
Message-Id: <167623048389.930.18000731224872263698.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Feb 2023 19:34:43 +0000
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

The pull request you sent on Sun, 12 Feb 2023 14:34:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/711e9a4d52bf4e477e51c7135e1e6188c42018d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
