Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9E720B11
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 23:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbjFBVif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 17:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbjFBVie (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 17:38:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4230C19B;
        Fri,  2 Jun 2023 14:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FCA618A0;
        Fri,  2 Jun 2023 21:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 466E9C433D2;
        Fri,  2 Jun 2023 21:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685741913;
        bh=0h4T2ynZrZzc+YA//ctbuk6Qyvtyr7esIvWnUKMKwJI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QZxfMyzGfcf0klQDV8zQi6i3p/EU3FzeZ4UiddN8C70YUYQLHt0QR8JNho9o8LSBS
         ybuii9hiQAytUp+N5ggdjRXGxVPHwInn1W5vGOGjbYJsdWf6QaggyhcL44fA6u7RWR
         36c9AA6go4Hg8GRtdjRGfsmx0RkR1soq+3ocTsL+6aF8jE2xyOg2lVMnQ3WtZyxAog
         fYjgHoj69jhd2SKcre6u1gZgEBMKMqpY2fZrU37F+QaiAJ3h0CtRonREjiznvjanAd
         zNxyo+Nlwq7EgYHZ3EJQqAe2Z/VGyDvOpW1MK1VJkaNFe4VvvOBTRJaimVIq2xPmIS
         W37ap7xGwpWkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31263C395E0;
        Fri,  2 Jun 2023 21:38:33 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.4-rc5, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1685730530.git.dsterba@suse.com>
References: <cover.1685730530.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1685730530.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc4-tag
X-PR-Tracked-Commit-Id: b675df0257bb717082f592626da3ddfc5bdc2b6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0178b546d24f42a85f4d4da080fb801e0d49107
Message-Id: <168574191317.10268.1456788128469269218.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jun 2023 21:38:33 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri,  2 Jun 2023 21:17:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0178b546d24f42a85f4d4da080fb801e0d49107

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
