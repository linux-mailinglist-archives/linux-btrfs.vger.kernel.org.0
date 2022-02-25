Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E3A4C515A
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 23:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiBYWQE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 17:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiBYWQD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 17:16:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B83218F228;
        Fri, 25 Feb 2022 14:15:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48D00B833A7;
        Fri, 25 Feb 2022 22:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7558C340E8;
        Fri, 25 Feb 2022 22:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645827327;
        bh=y60jg4iXegdd6xxVPwgo5J3j0KBckupOIk/TJur8s2w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EkGn0OfVn8bKAiL2mWQ3/+10Ill8djp2CNQib0ktroDePykDxTi0iOaK/BC/7vVwT
         KF+FzcZXCY7uyOyhTXwukrx4iRqcvIkIepGgC1M21Fr2eyfmEpmq4TXckYbSJg/rXZ
         u2KBvblDuIhShcmoz+5w/ElDaNQyNejLZMl24s63lXogEu57OZtL76GgLhqg4TocL/
         Sn0kKBopltnnWMkRjwcTqtQTJQbrjzJmlEuil9Z1/L6XnTJMuxXAoweGFc7lPCRpU2
         DMrZE68GMKd6PtN6hqSIzmnVuJczZVs2IO/SfLNqpC3rPEED7LnKHi34rZKQWzY1Wr
         CjiTP+P8sKvhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3DB0E6D453;
        Fri, 25 Feb 2022 22:15:27 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1645801545.git.dsterba@suse.com>
References: <cover.1645801545.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1645801545.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc5-tag
X-PR-Tracked-Commit-Id: 558732df2122092259ab4ef85594bee11dbb9104
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0419188b5c1a7735b12cf1405cafc3f8d722819
Message-Id: <164582732779.9849.9832898554008995178.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 22:15:27 +0000
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

The pull request you sent on Fri, 25 Feb 2022 16:53:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0419188b5c1a7735b12cf1405cafc3f8d722819

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
