Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E27639140
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 23:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiKYWAk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 17:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiKYWAj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 17:00:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564171D644;
        Fri, 25 Nov 2022 14:00:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F9C7B82C78;
        Fri, 25 Nov 2022 22:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B26F5C433D6;
        Fri, 25 Nov 2022 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669413636;
        bh=+9xeJyPXOHY6S2U4yJseSexBw6o0pMYdntiG07UPwaQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ecw392+uH0vutEXrBsbcvTxsO5xSSB/WQV8NMRaNknHdpOFSL8nmZYPszxgwmHDhr
         Mn5ZnXyEjBhS0fyqtn7ca/AhGwHHVS1kjQRXlojQtYwPehnM5BeQIIOhBHnW2kH5w8
         AIVewu5WzjySdpgg2jgGVAClBN+Wc2IDfFiT8iJk8djuh4PuNnXJ1MCYw376SF21om
         KlVTKQ8Xv/WZGkXkRfiZFqRKinDN/LPYg2n43kEjXNyyj2uOYv3WYLkmt0oxiaSOj8
         mNfoGjdoQmpyiQWYAx4FcavCMwRAwjbD1/45cH8QnBGv9KZuB0PsbBMrBsd0HfMAjC
         lvJmTm0R8nm3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A18D5C395EC;
        Fri, 25 Nov 2022 22:00:36 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1669400851.git.dsterba@suse.com>
References: <cover.1669400851.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1669400851.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc6-tag
X-PR-Tracked-Commit-Id: ffdbb44f2f23f963b8f5672e35c3a26088177a62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3eaea0db25261f62e21229f5763728dac40a1058
Message-Id: <166941363665.29754.11372559724942162466.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Nov 2022 22:00:36 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 25 Nov 2022 21:47:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3eaea0db25261f62e21229f5763728dac40a1058

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
