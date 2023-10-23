Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AFC7D3E7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjJWSDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjJWSDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 14:03:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FE9D73;
        Mon, 23 Oct 2023 11:03:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D42ADC433C8;
        Mon, 23 Oct 2023 18:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698084209;
        bh=DXnF5UoPUrZo4SRz8Yk22ieWJlgqPuVpPPxQdiC7wJ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DV5Q9I8PW799CQTwXzaoEG4D4jdB3pqidU2ZeoDhaOKSm4ylQagA5zaxw3F+Uq/db
         79qjWJDDOWytaDeAwkfSQj9q7S5TwplozNRNBD15oUv0eLm0XMU1+jUxZcvQXlFC1K
         WXhxwfaD4Ad7jhWg3oNYdgO56OAPAEtgaGkMqHt7dicvO59I1GNSf4XzaEUGiZEPP0
         VpLwFpKyBxcWDjUpO1OYd8bEWdl5r6Q9VlCjspTHfcATxpuyUu+WyXQrOa5HAFcWi8
         xhZLXYdz3QowqIOQfTh+oWER1YzuGqvW6IMmB2zbDwTacRhQ1wijDt0rQuCebUCysi
         Nc2pI0y6rxsqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF57CE4CC11;
        Mon, 23 Oct 2023 18:03:29 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.6-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1698076832.git.dsterba@suse.com>
References: <cover.1698076832.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1698076832.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc7-tag
X-PR-Tracked-Commit-Id: eb96e221937af3c7bb8a63208dbab813ca5d3d7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e017769f4ce20dc0d3fa3220d4d359dcc4431274
Message-Id: <169808420978.25326.158983676233710217.pr-tracker-bot@kernel.org>
Date:   Mon, 23 Oct 2023 18:03:29 +0000
To:     David Sterba <dsterba@suse.cz>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 23 Oct 2023 18:10:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e017769f4ce20dc0d3fa3220d4d359dcc4431274

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
