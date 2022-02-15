Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFEF4B7767
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 21:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbiBORSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 12:18:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242391AbiBORSl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 12:18:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C85140B4;
        Tue, 15 Feb 2022 09:18:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3AC86156F;
        Tue, 15 Feb 2022 17:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5699FC340F2;
        Tue, 15 Feb 2022 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644945510;
        bh=JL6/TlRg09bmkMjLwNrzNtH5fkjGZtpZHPT6IS+AE9s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s3JIOWO19hXarPnkwn5eSi2bWrKPiaqIlGQe+zXcke0XAb1eoqU/Lfr+VQkIFk4cQ
         fPyn3Np97U22PAYOFuMsATDFoFnxuMqxf4zpJ8Ihz3dJcRikqEzp8816I1PflhI6wq
         p+to6+Yh5VBPqQdbrqGxnyauOyMU3kDfuvrIAaX1F0+xTr0pRh7RoeYjomqkJWjjDW
         QSSaU4cbCPf9ELakvHzexmfxZJcRb9RtukgxJA6GXXjVvQ8K6WDa8jkfLFooB+Zpka
         z5BLQkJmYtSo7j5S7H3SMh+paU5KyUJOo2agiAOxKmun8AQvH1dVApd8qIuQd4wTdc
         yFLowt5SioE+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 449EAE5D07D;
        Tue, 15 Feb 2022 17:18:30 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1644935941.git.dsterba@suse.com>
References: <cover.1644935941.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1644935941.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc4-tag
X-PR-Tracked-Commit-Id: 2e7be9db125a0bf940c5d65eb5c40d8700f738b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 705d84a366cfccda1e7aec1113a5399cd2ffee7d
Message-Id: <164494551027.28256.12563623130665524701.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Feb 2022 17:18:30 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 15 Feb 2022 15:44:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/705d84a366cfccda1e7aec1113a5399cd2ffee7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
