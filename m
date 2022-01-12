Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E711448BBAB
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 01:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347380AbiALAN4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 19:13:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50038 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiALANs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 19:13:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24D49CE1BBB;
        Wed, 12 Jan 2022 00:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97AF6C36AE9;
        Wed, 12 Jan 2022 00:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946425;
        bh=yaqZ7ZkdvZqSamupusB0ez1vekurvW326ryWZO1cb9I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S/B7U8hKfJ/mCve5KCOXPl+PT/YUVrNLRyABvNdLdB8MrYgIgL1Z7/OCZDTaHqfz+
         TCxhJNjSm9xcjEDyfMMY8I/3D0hxTFVW3RH53lKkMelkN9f9wj0pUqCczLp1NDHRIw
         7D27rt8kS+ZVda2l9vF+/BoOv6FaRdCclJ8URcwtd9HqpW3GZ5N1MdAHWKGoxZSoAX
         RIXHbO79XrdXHaryCRxNXWbuW7ROv9rRi5p+/nFuJZIAm29AOlr1rLfkL+rqZRJK8h
         253h9tVMEA9Qamiv+j4C7UZNutrkoM8jh8S9Vtxn5qJL6XUMEWwleuAqDDMZgZJeKQ
         7j1MP2IwW6hMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87770F60794;
        Wed, 12 Jan 2022 00:13:45 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1641841093.git.dsterba@suse.com>
References: <cover.1641841093.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1641841093.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-tag
X-PR-Tracked-Commit-Id: 36c86a9e1be3b29f9f075a946df55dfe1d818019
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d601e58c5f2901783428bc1181e83ff783592b6b
Message-Id: <164194642555.21161.17952361717310328392.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:45 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 20:11:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d601e58c5f2901783428bc1181e83ff783592b6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
