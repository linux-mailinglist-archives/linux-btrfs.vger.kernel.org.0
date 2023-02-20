Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B681A69D599
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 22:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjBTVMU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 16:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjBTVMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 16:12:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8291D92C;
        Mon, 20 Feb 2023 13:12:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D942960F34;
        Mon, 20 Feb 2023 21:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA27DC433A0;
        Mon, 20 Feb 2023 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676927504;
        bh=MpnAenEtinpbZkhZE+jfHbzj2+GuyGHJBreF3chMOGU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XphPvde8mT2aPePHs81+0FbD47quwahQugAzvBZahq6eTkqSCJf2RJ5rpsSbhhP5E
         6vDjwYHY1K/gK7LuHWgvO1cACdxZSjH2QxqIukiv2vlvKh2R5ogPGQvuQ5Ha4AsPSE
         4fICSeT3Reqc03SoAXhZTOTuvDpgoeQbv4U+pdypIw68IQ/cr8OIYDD6AoEBR3jl+1
         Ud4rZ0P5i4WleoibGmcZys525kuHF/obPxRVOoLQ0B1zhga7jj0k6ZpUBuHOxPX0E5
         Z4r0UYFQdaBxjbGNRTdCdmyzFLIvcVcJBmLQsm66Zsvhz1PqutiQredgb2X8SY+WSm
         WuvlMpjQxrfvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9422DC43161;
        Mon, 20 Feb 2023 21:11:44 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1676908729.git.dsterba@suse.com>
References: <cover.1676908729.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1676908729.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-tag
X-PR-Tracked-Commit-Id: 964a54e5e1a0d70cd80bd5a0885a1938463625b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 885ce48739189fac6645ff42d736ee0de0b5917d
Message-Id: <167692750460.16986.9056314304024744739.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 21:11:44 +0000
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

The pull request you sent on Mon, 20 Feb 2023 20:20:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/885ce48739189fac6645ff42d736ee0de0b5917d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
