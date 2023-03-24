Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8371F6C825C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 17:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjCXQbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjCXQbL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 12:31:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF742D4F;
        Fri, 24 Mar 2023 09:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0A27B82564;
        Fri, 24 Mar 2023 16:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8231C433D2;
        Fri, 24 Mar 2023 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679675467;
        bh=cn3Q9/RgMFICfewqLrvfmgavDElhm2MoiroIKBMSKFE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e6re0kyDk04TDbazW+L0k+b0n3uuArWEpuKuLWpvp+4UhN5Ij0p6axmv7zndPKyRR
         Inpk843+rjh+XGifLFk6nGUmZp3VsmcNE9i4hgPgUSu9yfbCYhjYGu8NW3aRyP1Ynz
         GiuabuEVzJWpCr2dhjWxTl0Awy2GsgiIktVT5dpgGlb+Qt9urGbzTo/pOnceAtkpLp
         PfEsXdbYlb7Vw0nJeYY/7Q0u3AzyMvnTRpbut9DVSMPRBirBpN4gyiBLC3V0+u+PUP
         Wz6Mx1UYck2z/lxK4pstNkDLkV71xVfFSvKNmS7fSFlEgLriqyVcyG5ln+tofik2U5
         fxQv0ZYO3TArw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 935E1E2A039;
        Fri, 24 Mar 2023 16:31:07 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1679610326.git.dsterba@suse.com>
References: <cover.1679610326.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1679610326.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc3-tag
X-PR-Tracked-Commit-Id: e15acc25880cf048dba9df94d76ed7e7e10040e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 285063049a65251aada1c34664de692dd083aa03
Message-Id: <167967546759.8924.7407342366937175988.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 16:31:07 +0000
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

The pull request you sent on Fri, 24 Mar 2023 00:31:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/285063049a65251aada1c34664de692dd083aa03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
