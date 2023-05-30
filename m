Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AABB716FE2
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjE3Vkt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjE3Vks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 17:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED321115;
        Tue, 30 May 2023 14:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D84B633EA;
        Tue, 30 May 2023 21:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5AB3C433EF;
        Tue, 30 May 2023 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685482831;
        bh=tS/3hyoWFj4T5R6GcI+c4WMzuExqeMxDeVyy9MD043w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WmdfFTeODIZPSKIuU+jQfuDTUs3lT/ruxy+9FuGpMqaipxJl0bo4jpwz9RhpZqpC5
         WbgL/YO0tHv8jGHTxH7C+Voc3Mt4oJe47ssLcwvhIv5N5g2HL8CP8wCe+HIcE6AUSr
         DY9GDUIirujkXVjyIGYOMe7VzgzopurE9qD5f84M/05NjmHdESsw3FFYl8NJxEF/Ym
         cy568kk0GanTCn1QZ1Lc0/wgUM+zdAwjcMD7tB2qlUFDtWor9l6Cc2P5Yq4RaRPNpz
         OOrLjW+7EiUX6CO7ssCo0E87g7uvECATFFAjwpPxfH6cpdt24fCasANUyqPUbe5I2i
         iFhtuFDLlg6Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2F54E52BF6;
        Tue, 30 May 2023 21:40:31 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1685474426.git.dsterba@suse.com>
References: <cover.1685474426.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1685474426.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc4-tag
X-PR-Tracked-Commit-Id: 5ad9b4719fc9bc4715c7e19875a962095b0577e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48b1320a674e1ff5de2fad8606bee38f724594dc
Message-Id: <168548283185.16223.11969697601770490519.pr-tracker-bot@kernel.org>
Date:   Tue, 30 May 2023 21:40:31 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 30 May 2023 22:13:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48b1320a674e1ff5de2fad8606bee38f724594dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
