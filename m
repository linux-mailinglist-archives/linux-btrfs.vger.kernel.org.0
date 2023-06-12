Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69872CE24
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbjFLS3Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbjFLS3H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 14:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4741FDC;
        Mon, 12 Jun 2023 11:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2F2762D00;
        Mon, 12 Jun 2023 18:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 513A6C433D2;
        Mon, 12 Jun 2023 18:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686594521;
        bh=3NQtLr0tPS3rHfm5+0qfrGP1gzAN91HCdh658vzGeF0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E0bzocJCIzWxlEhdEvg5FSzfcbbwHXswFnousrOUZbxhGjwcOz98D1YhWxHZPe7iJ
         DaU8WIg1ZnQrunKMzH41nzVvUCLg5n9eOTujXh0llqI/9hHZYv5lzfbrSaBpfSGkWa
         lnaH7fM+Mn2aGDmIU/zocNeV6aZlJGoTJk4Xq69Igt9/TEsYTmTlRuljZV1cMGORgi
         h0HNl1eCeOjNQ9vQd7uEKrNOCso/Uu4SM8X/5hRr8MC12x0EhK3WurJm4DaJ0p16LP
         +BghqGpnef8tcIr19MGdgORD0kM74zF7BjjrDZLePuV85+s3vEJ5Xp5bPaoKmftZq5
         DlZxRrUO/wkFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B13AC395F3;
        Mon, 12 Jun 2023 18:28:41 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1686588386.git.dsterba@suse.com>
References: <cover.1686588386.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1686588386.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc6-tag
X-PR-Tracked-Commit-Id: 79b8ee702c918f1936e17cc53e14bec388ce1045
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ace9e12da2f09faf85cd1904c14e1ab3ca49a590
Message-Id: <168659452123.31790.6549126518126752347.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Jun 2023 18:28:41 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 12 Jun 2023 19:36:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ace9e12da2f09faf85cd1904c14e1ab3ca49a590

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
