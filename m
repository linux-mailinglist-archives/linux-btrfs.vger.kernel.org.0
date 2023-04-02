Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75526D39A9
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Apr 2023 20:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjDBSCL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Apr 2023 14:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjDBSCJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Apr 2023 14:02:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BC3526C;
        Sun,  2 Apr 2023 11:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C01EB80F62;
        Sun,  2 Apr 2023 18:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A701C4339B;
        Sun,  2 Apr 2023 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680458525;
        bh=rhMD0KTrG2qbbcUavFCg3Odn146aTFcPgHnxP9NYJNM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P1NdusGwtqBC8i+C/FKemgxvoVhJ38iJYGRPB+FuFJS4AFEw6+Rd4khxas0HsfFgf
         Bz+qLQMj9Pjod7QPMqFAr9YJOOR/ie4czOBYT5mSpuflmS4v+YzLAAI4cKlbfr9lzy
         VnUByN90M7PDF08+hdkE5lElfbN5XjAJVWueQxNvWGYWcLCGVBtoSzkkGJ8cM/wC6f
         5PemBgqsg2vHccsFkTX+fw7lZWE58X+8Ib4cWPmrjIZV8zcl3VtRfw2Zm5jBpvcZQq
         EDZ/lkkuy1LGwsxElKcgcarshAKmdoUbakGSuZnZGpFaMJCzCNEhV4SyzyfYwSa+NH
         rvV+9hwPUKHpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A474C73FE0;
        Sun,  2 Apr 2023 18:02:05 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1680455513.git.dsterba@suse.com>
References: <cover.1680455513.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1680455513.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc4-tag
X-PR-Tracked-Commit-Id: 2280d425ba3599bdd85c41bd0ec8ba568f00c032
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ab608fe852b50fe809b22cdf7db6cbe006d7cb3
Message-Id: <168045852523.9845.6788501321106990894.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Apr 2023 18:02:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sun,  2 Apr 2023 19:34:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ab608fe852b50fe809b22cdf7db6cbe006d7cb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
