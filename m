Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ABD4E4613
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 19:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbiCVSdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240485AbiCVSdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 14:33:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB9C91348;
        Tue, 22 Mar 2022 11:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A54EB81D59;
        Tue, 22 Mar 2022 18:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21170C340F4;
        Tue, 22 Mar 2022 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647973925;
        bh=wt2Iaiui7xADQd/1+rA3KvctqZBk85f0RhMyeRekhOE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RYTpmb6y6MDJ3L8MTv8eHq0Qy9kIuLpmhvZApBGqmloSJ1e4OjxgaqMPJDx5ztGj+
         YOdL02KD2RqsRxXhnBWdzVd6ug/uISLvJ5NtrQlNMTYTuarajCrJwFX5K4YRaEykso
         CE5uXZNv4vHRe2QyLXlnGpCGwsBkzze58S1YVdlA+lKBEK+aJGJcwfyqeEnPU1+ea+
         k8jtITNyOIhzAlHn2fHDglH1rsX2LQ/FYpxVz9XqvyRWBR8TQ96sqJp5yZcO+9Y7vi
         gEOVMPLoLtSqdECIufPdOUeOK1JY1d/ZqZgApelLWF8MKYG6qIR84Nh5zthPHK+HMx
         kW5vNa4UHm7MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C5EDE6D406;
        Tue, 22 Mar 2022 18:32:05 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1647894991.git.dsterba@suse.com>
References: <cover.1647894991.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1647894991.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-tag
X-PR-Tracked-Commit-Id: d3e29967079c522ce1c5cab0e9fab2c280b977eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5191290407668028179f2544a11ae9b57f0bcf07
Message-Id: <164797392504.17704.3328669229268785822.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 18:32:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 22:33:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5191290407668028179f2544a11ae9b57f0bcf07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
