Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D2D701211
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 May 2023 00:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbjELWO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 May 2023 18:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbjELWOT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 May 2023 18:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E8830FF;
        Fri, 12 May 2023 15:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C9BD61D43;
        Fri, 12 May 2023 22:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D44C0C4339B;
        Fri, 12 May 2023 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683929656;
        bh=1n62FXx//SMdja73NMNPl7TurLEEg1ptkL26ta/W2uc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hKTUbjqH4Gs5nkxmCttY2eeQBQv4xqAN5NSVJbGA6C08SHt836OVqe6FUlteTbm7H
         M51VKmyUy7vB94TeMdS60A2VVjM1WMQX2A0L5ifUWLS1qNFBx8h9Aue2hFuRwxdDzR
         0WYmdsXGRqURnERCwXgRylVD7a+3YTEs0WWc1Doqz2WXdY9w2ItJD01RLgPdRnn2FM
         RVjnChiN61vyfW8DUZNxNgXXErBrfX9ZpiW5M02XDome9GIA87u1zt+byhcEOLBPph
         7FG4UARrfVLXfOpoxsdlO2Y4+7JuWVU1NliImRFZtLMVwxa+6Iqg3AGbcZrMBdoUZM
         cQbRcWja+BusA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2826E26D20;
        Fri, 12 May 2023 22:14:16 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.4-rc2, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1683909716.git.dsterba@suse.com>
References: <cover.1683909716.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1683909716.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc1-tag
X-PR-Tracked-Commit-Id: 1d6a4fc85717677e00fefffd847a50fc5928ce69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76c7f8873a7696dbd8f9cd844e30e5c84cbaba1a
Message-Id: <168392965679.28473.14031901622671616042.pr-tracker-bot@kernel.org>
Date:   Fri, 12 May 2023 22:14:16 +0000
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

The pull request you sent on Fri, 12 May 2023 23:21:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76c7f8873a7696dbd8f9cd844e30e5c84cbaba1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
