Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3253E55B32A
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jun 2022 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiFZRg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jun 2022 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiFZRgS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jun 2022 13:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B07E0AD;
        Sun, 26 Jun 2022 10:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB3D560B2C;
        Sun, 26 Jun 2022 17:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EC90C34114;
        Sun, 26 Jun 2022 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656264972;
        bh=4QWReVqnu4V1iDKEVwnrfn4pUMY+KUtwu9PHDfBfnJY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tG13KPdY53/gAcQ1N6GrljxvJHRmNgU1M+3k+OUJJR00wwk4kmaWtzD3MqSQDP78V
         zwyT0w28qUYcTC/ER0SsXCOcT1KVaO/PF8+UBShJZtfQQDbmv2axQKWna4lCvqeeXc
         bY4bz1++M1qGux/SOeZiw3oCawPONSBGYBQPwcepovXigtDM4RgyT5b76P5sCPkbNk
         ViG++op2yGA3X11picn3SQyY9sPsMdzKJswQBQ6yDhXZ2OHYNFvLJDZ8MWYeVyvM95
         FQzqniRHW/cbSQiRgSxC9C9jSrhQ3LjvK/A4jG57g2wM5TamyFaL2+PydvWjfL1y/P
         aPFYcnjHb5cig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DED0E73875;
        Sun, 26 Jun 2022 17:36:12 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.19-rc4, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1656256131.git.dsterba@suse.com>
References: <cover.1656256131.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1656256131.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc3-tag
X-PR-Tracked-Commit-Id: 037e127452b973f45b34c1e88a1af183e652e657
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82708bb1eb9ebc2d1e296f2c919685761f2fa8dd
Message-Id: <165626497231.22456.7971556031884843341.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 17:36:12 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sun, 26 Jun 2022 17:30:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82708bb1eb9ebc2d1e296f2c919685761f2fa8dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
