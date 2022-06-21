Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236ED553980
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 20:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245265AbiFUS1z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbiFUS1x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 14:27:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2ABE8;
        Tue, 21 Jun 2022 11:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BD2BB81B07;
        Tue, 21 Jun 2022 18:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17944C3411C;
        Tue, 21 Jun 2022 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655836070;
        bh=jA8R89dvSyQ5wCVRbol7dZe6YE63jq+v5PF6BtR698w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r+GdfxtJEQuZzKf9rVf6YrV7ZyDQAo2QCgIDOUAS529crnH2cI5R3hqubzTpRSaB2
         CEoc2pPimP4v2b8HMuy/GRkcXtd6EHynROqI/0F7TobYOYXxUrtZt9NIVC4dwGVk19
         7CSqS7cYvTlwlfJ1nqEV0PjdxRcI2sdle3IqEKpj8fQWVJe3AzCfP2CM4G1dnGTlwX
         0iBcjqSPTwZoQH4FBuordAQuhGzwPhYP/HF9O7CGZ7nr7JkwY8QxxQthsUqRUyJiHc
         7fT/yfpEKnY8bLPezu3Giipge7tKap6Jz3QET1orxuDmSf/Dtr2P22ON/r0wE+XxNr
         ye3F5qc6GlDLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02C0CE574DA;
        Tue, 21 Jun 2022 18:27:50 +0000 (UTC)
Subject: Re: [GIT PULL] Fixes for btrfs 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1655815078.git.dsterba@suse.com>
References: <cover.1655815078.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1655815078.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc3-tag
X-PR-Tracked-Commit-Id: e3a4167c880cf889f66887a152799df4d609dd21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff872b76b3d89a09a997cc45c133e4a3ddc12f90
Message-Id: <165583607000.899.6280521569082066273.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Jun 2022 18:27:50 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 21 Jun 2022 14:41:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff872b76b3d89a09a997cc45c133e4a3ddc12f90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
