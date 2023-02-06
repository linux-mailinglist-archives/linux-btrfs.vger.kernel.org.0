Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8CD68C948
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 23:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBFWW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 17:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBFWW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 17:22:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E28593C4;
        Mon,  6 Feb 2023 14:22:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B22161048;
        Mon,  6 Feb 2023 22:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 710EDC433EF;
        Mon,  6 Feb 2023 22:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722174;
        bh=dgjPS/21Jwz0N/kx64aj+v3qbMDzHxH3oN50UI/eATw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WURzKmJYGUIg+ixUvPRPFYXkgs1cIsWdS92Ee3B4s8vzhP4qSV28Kxm/6vZFC5n0Y
         kUUSqIamf34CIGZFVNVLQEC5E+FZoDUcuN0jOOkqaynOFteEaZX38YqQqb3GLbPUsl
         U8CYAL1++XTDE6sXJk8r9QrTpChurz4qSzGwQKyuVPn+YEXZGFQdbRzNHKXIJUWEYj
         Zjsl9/r6pj5B8zU9pDGO8skeBOmIxT6wbwtZl4013+0pxM2Zmtv5vvAZz0G+HagDgG
         D0+sK/GK0SbSCVVn5kLyNVdYNk43EcYeYgxlfH1JYoL15/pMudOLMTqYCtg+ASvveD
         tshdFHsrWJPSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E998E55EFB;
        Mon,  6 Feb 2023 22:22:54 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for v6.2-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1675710734.git.dsterba@suse.com>
References: <cover.1675710734.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1675710734.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc7-tag
X-PR-Tracked-Commit-Id: a9ad4d87aa263de36895402b66115a3a4b88bf1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66fcf74e5c0d771a456b96ec9aebfb53d648eede
Message-Id: <167572217437.7822.5688360753712205398.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Feb 2023 22:22:54 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon,  6 Feb 2023 20:50:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66fcf74e5c0d771a456b96ec9aebfb53d648eede

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
