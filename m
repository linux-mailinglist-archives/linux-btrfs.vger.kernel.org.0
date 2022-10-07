Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2F15F726B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 03:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiJGBBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 21:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiJGBBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 21:01:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BE4C2CBF;
        Thu,  6 Oct 2022 18:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6FFBB821ED;
        Fri,  7 Oct 2022 01:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84D34C433C1;
        Fri,  7 Oct 2022 01:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665104493;
        bh=7INnRf4ASEnQ/tTpt1SwTQBbyNssjl/WqFI1fKUliaM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c4M4IDIhTcqbm7zRzS25fooPnh+7n1Lf8cbbQ7fZYcX5uFQQnsS2iqQ27b2Ji13J9
         mzXwy7ix4I6Ay3xc53LsoIUz3z+oGgol3CxMsDU1/vy0N9MHin3AbfwlgGxTI4b1Vq
         u1NOhaZ/3MgZo4ZD1h5R7kBFTkyk3iH00mkT45E2Zhxl+pbjnqAW4ct7iKybFj7zxD
         EXvIQNjRKYAyfjYKc6wVAcggOnkHmsqQxThU7U8z+D5c+4QCeVb1F2U6aFCQRUO4T9
         SolSL76mBYg6qyn+wrIcurmtCMO0T0o8jEIl7AMYa579LKqGliiF6jlJ6YSi7mdpDx
         LphwbYk21HSXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71F61E2A05E;
        Fri,  7 Oct 2022 01:01:33 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1664798047.git.dsterba@suse.com>
References: <cover.1664798047.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1664798047.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-tag
X-PR-Tracked-Commit-Id: cbddcc4fa3443fe8cfb2ff8e210deb1f6a0eea38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76e45035348c247a70ed50eb29a9906657e4444f
Message-Id: <166510449345.27686.7895050524611917105.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 01:01:33 +0000
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

The pull request you sent on Tue,  4 Oct 2022 08:31:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76e45035348c247a70ed50eb29a9906657e4444f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
