Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B1864AEE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 06:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiLMFAk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 00:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiLMFAS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710271DF2D;
        Mon, 12 Dec 2022 21:00:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29D09B810E0;
        Tue, 13 Dec 2022 05:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9D6FC43392;
        Tue, 13 Dec 2022 05:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907613;
        bh=db9Pun0kEESV6RgeoClbH6SHHm8RS5Zklvo2ckmgi4w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QOuV3gmDoSHx1ZlSGr8V+tcQLR3c1oJzu+020X9P+TYMlaNoQsJC+1WrhCBnXyJjB
         oPVfUNgfPvBZLUtkdygVLHkJ/VPGYFvO5zjaoCCj0yQJESLoewAa/0C/0/543sPQiB
         x13UqlgqvF5DG2JNDHjOnbiAls+9MChMtvGRWcSS5VLGq52H754HyPxOsr19sIwaZ2
         QBdFhtsiW58XCdsgMydaqaDBL20lJv3PIFh/HqCimx+Aw+DXNQ7EjzwhRCMqVaXqSV
         neLsRc6LG4z0nOuYV1AcuMafKiyd1ss6FOgWEXY8yoXoZHI33pY82pBUoPeH9aJyMa
         VQIZMVU2MZA4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1F7DC00445;
        Tue, 13 Dec 2022 05:00:13 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1670873892.git.dsterba@suse.com>
References: <cover.1670873892.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1670873892.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-tag
X-PR-Tracked-Commit-Id: b7af0635c87ff78d6bd523298ab7471f9ffd3ce5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 149c51f876322d9bfbd5e2d6ffae7aff3d794384
Message-Id: <167090761371.4886.6757909129514713313.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:13 +0000
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

The pull request you sent on Mon, 12 Dec 2022 21:16:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/149c51f876322d9bfbd5e2d6ffae7aff3d794384

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
