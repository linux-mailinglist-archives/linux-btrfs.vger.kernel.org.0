Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA604570CF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiGKVox (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 17:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiGKVow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 17:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BAD52E4A;
        Mon, 11 Jul 2022 14:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 437B660DC5;
        Mon, 11 Jul 2022 21:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6773C34115;
        Mon, 11 Jul 2022 21:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657575890;
        bh=R52JOdyWk7Mt2q4tXimE67bzH38ROCTvOP4FmFrFChs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rSfnP9xHSqW9uyQcVnRp8ZXdzCa1rWHmOtWPRE3kO3KsJeUX0qIuFstm9xLE3wz3k
         oZACJLpt+KkcGoDtfgmJvppaGLmjM3znAPqrFkvf01erqJclAMH7jW2fGGEYHts+Qy
         VOGj6BOOIz6cdBFwSPs9/Hse57EwxFUyV7yahoDodYbmwLRzkNGqUlm1v+hN3pIRsc
         ktaHJDEbYrzn1ArilQHasjHH4QhphgR5G7rQFS9ej838Z5p5DlFUN6WvirE3m/Cuxx
         2v5upybN27+clMn7AB8RvwS1Wz8blyBnpWkMksovluuBLGLVimlMFBR5XBqNiizQwA
         CZgaN8SksITQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 928D6E45222;
        Mon, 11 Jul 2022 21:44:50 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1657571742.git.dsterba@suse.com>
References: <cover.1657571742.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1657571742.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc6-tag
X-PR-Tracked-Commit-Id: b3a3b0255797e1d395253366ba24a4cc6c8bdf9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a29232d870d9e63fe5ff30b081be6ea7cc2465d
Message-Id: <165757589059.9905.4569155165777374428.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Jul 2022 21:44:50 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 11 Jul 2022 23:16:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a29232d870d9e63fe5ff30b081be6ea7cc2465d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
