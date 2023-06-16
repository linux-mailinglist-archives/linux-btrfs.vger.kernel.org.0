Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C7B733ACC
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jun 2023 22:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjFPU1b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jun 2023 16:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjFPU12 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jun 2023 16:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9360D35B8;
        Fri, 16 Jun 2023 13:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E6B5611C3;
        Fri, 16 Jun 2023 20:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81D50C433C8;
        Fri, 16 Jun 2023 20:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686947246;
        bh=pBTlkEGtuXCeIAmC9a50/yKLDhAI/Ba85+cP9NDj51c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=onqcQanDMcQt6oKvxGjezZflbDdXa6a4oxXHdYLomqARGuJKVimaWv69+nTtZKGKQ
         nMcLkhdWcTf0HUw5GBUJf0LZ9JwMiqCD/OmFmct2WWQOtpp60vB1zCnxh8LUkYniKP
         rO/TEJhmWYW+sdwvq7sRPA0IQG1X6kFxpBL7zweZ5u+jajKrp2YRKcqQ6co/pkKy5V
         QDIYW6fzKsPBu1FZCa4WSK3fn7b6P1VFRv4QDWyrPMO+ikrIZG7fSeWHRa3HJpHgId
         DFL4qHliRkFnLhumX9w6rSoIqgoqL3ULAxpsPlJ9nKd9i1QH2VWbKfk2JelOWciySO
         FnRmfxDK39eig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7010CE21EE4;
        Fri, 16 Jun 2023 20:27:26 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes 6.4-rc7, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1686930269.git.dsterba@suse.com>
References: <cover.1686930269.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1686930269.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc6-tag
X-PR-Tracked-Commit-Id: b50f2d048ecf1512ff85128ea4153bceb0e60590
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4973ca29552864a7a047ab8a15611a585827412f
Message-Id: <168694724645.23512.15722225202328933636.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 20:27:26 +0000
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

The pull request you sent on Fri, 16 Jun 2023 18:06:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4973ca29552864a7a047ab8a15611a585827412f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
