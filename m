Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBAA765C67
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 21:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjG0Tte (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjG0Tt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 15:49:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743D630CF;
        Thu, 27 Jul 2023 12:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86CC161F31;
        Thu, 27 Jul 2023 19:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE20BC433C9;
        Thu, 27 Jul 2023 19:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690487361;
        bh=iAc1kJNObjDK53IYe81q+zX6mOvpFTZ1CnO4N11oKPw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NVyBdYTY89Pa2BteWItgI6CdbTR7vigMG5AcYK0U3fSfjIL6FsgnYJHtqv6BdOG1k
         JwG0qnnF9KBgNwtvKUKG9vqK8nsQkheeHSgFW/fShXTOz8F3sjc3VIY3HhLEJPPEU6
         Yc22s1XRAjnDn9gWOafTemhoqMUk/8jSG7Ojob4jmeJiK8cWuLtYFp8eQNyJXxOCWs
         dWJfz4W+iiybQymgWmpgIcZOqpLxuRodESJRELXpHjUE1EMOEqUo9vU9y4nUyN0fnb
         NdORvUHwIa9ADAmIJhA4CkesmPBlgnKRq9KJtqjhSqiR6KqWwuw4iuHVIbVy2MwffO
         58S3AWOP8Vd0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB98AC40C5E;
        Thu, 27 Jul 2023 19:49:20 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1690455145.git.dsterba@suse.com>
References: <cover.1690455145.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1690455145.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc3-tag
X-PR-Tracked-Commit-Id: b28ff3a7d7e97456fd86b68d24caa32e1cfa7064
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64de76ce8e26fb0a5ca32ac2210ef99238c28525
Message-Id: <169048736089.11614.12085071304525055611.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Jul 2023 19:49:20 +0000
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

The pull request you sent on Thu, 27 Jul 2023 13:16:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64de76ce8e26fb0a5ca32ac2210ef99238c28525

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
