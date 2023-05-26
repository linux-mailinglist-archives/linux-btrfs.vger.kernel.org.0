Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34E7712E38
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 22:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbjEZUir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242194AbjEZUio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 16:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52506189;
        Fri, 26 May 2023 13:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 984786533F;
        Fri, 26 May 2023 20:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08F24C4339B;
        Fri, 26 May 2023 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685133521;
        bh=FUJvcqU86bt+hk32OHBpGY6Mp/z9Xa4m5vh2a76LjLc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EnYh/SYei8R5zOM1hFMehHB0E61WTwtyf0i+VUTnVbh4IKkKMRMk76gro3U6YADM5
         sZV7LSYGjXXVgTAFwhSkLpuMkg2l1UwYMmnVtkwAI7m2iYNZsJmaxyTRlq0AEHPo+e
         P2AwK7w3oou6NjDA/LE/ngWWNH7TSRgbtkPk8W+0x+rFoG4O9lM5duooR9wFKMLTAn
         SKqWkK/jpgEQ/oKdPyOa6PCfJiTELpJD5iAHYWh4zk45Mkh9+DmyA/PxZYFQPWvWFu
         wNVvdodXeDYFij1HGZTMluYtdi0Kj1wJTNRk5NPMTto399yQJnZz1SLlOpIR481+ob
         YXCozwLSJUpCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAC64E22B06;
        Fri, 26 May 2023 20:38:40 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1685104958.git.dsterba@suse.com>
References: <cover.1685104958.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1685104958.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc3-tag
X-PR-Tracked-Commit-Id: 597441b3436a43011f31ce71dc0a6c0bf5ce958a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b158dd941b4f28e12c4f956caf2352febe09fe4e
Message-Id: <168513352095.25583.17156837301874092238.pr-tracker-bot@kernel.org>
Date:   Fri, 26 May 2023 20:38:40 +0000
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

The pull request you sent on Fri, 26 May 2023 14:48:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b158dd941b4f28e12c4f956caf2352febe09fe4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
