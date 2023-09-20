Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033157A8B57
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjITSNv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 14:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjITSNt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 14:13:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBAFC6;
        Wed, 20 Sep 2023 11:13:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01524C433CC;
        Wed, 20 Sep 2023 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695233621;
        bh=wBySTkqQJ1YaVyim8QR9MvVHFLBEmKtko+P744/AlG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OXypoR+9oRTTJiNcesrtN3X9OGm7ikChcIeNr7IlOmyXrjQMgcIgH1NJxG2asgejs
         sSKnsb1KVzgIrN9am7fhLZ0UiUO4uyqclDptXsIsg0e6q29Pj2pVBfZb9INcqjtF+o
         gSqnsWJBuNoAowicM4D2sItEo+X3X+1jU+cw3tROkNlwcjhTFe8FF+vV8fGEb4GBYE
         qylSu6UMVZ6BJ1v/KCurztEDWXyN/2LRlda7H4Y947m8wRTa+gy8Kml8vgx2AKZerd
         xre0/Cd0api321H16W3OcqiyWMdsdAX99c0ANK48u0xO64f3zSysExsH8e1E+9QIwb
         8UpYQeks2UltA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2B3DC40C5E;
        Wed, 20 Sep 2023 18:13:40 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1695229068.git.dsterba@suse.com>
References: <cover.1695229068.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1695229068.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc2-tag
X-PR-Tracked-Commit-Id: 8e7f82deb0c0386a03b62e30082574347f8b57d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a229cf67ab851a6e92395f37ed141d065176575a
Message-Id: <169523362091.8714.10908798950895409814.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Sep 2023 18:13:40 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Wed, 20 Sep 2023 19:38:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a229cf67ab851a6e92395f37ed141d065176575a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
