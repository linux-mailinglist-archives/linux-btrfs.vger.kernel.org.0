Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A710D79D942
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 20:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjILS7T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbjILS7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 14:59:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDAD12E;
        Tue, 12 Sep 2023 11:59:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97004C433C7;
        Tue, 12 Sep 2023 18:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694545154;
        bh=jftWwIEwYhY0nv0ehVD5JW22sh1eGlPfvv5jaavDG/E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nknLz1Rt/KctYvbvWl8gqlKaMa/L74N7nlpG+PyBLTuvmnsOgB/WWtKfqgH+FolQB
         DuLiQv5cFDc5Vo0Qdw82uUnn2Lf/9+Md4WHcVBKTNHJr2cULMEWhhQOVzuqEXDEyIG
         3YJCY7nx6H/IX3ecU4Wp19DBjEeH0lQSn38jgWBt//sU0rGgwVdXpAsn/WexWqc1Dl
         /GNJ1NOjHBrKXh7BastWO6sN5hoM8emHCnbc7DDgh6tg9ci5/tgRQLM7u3+6QcuFHJ
         qh2tCcZCD8Ic1qMTu9hDg4GAVAI8koRPfeweJOIbUG9IEDNWVtU/fSyYZle5wUbh3x
         yHMvM61YyzP+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84A56C04DD9;
        Tue, 12 Sep 2023 18:59:14 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1694467872.git.dsterba@suse.com>
References: <cover.1694467872.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1694467872.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc1-tag
X-PR-Tracked-Commit-Id: 5facccc9402301d67d48bef06159b91f7e41efc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3669558bdf354cd352be955ef2764cde6a9bf5ec
Message-Id: <169454515453.18467.2367254524908384442.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Sep 2023 18:59:14 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 12 Sep 2023 19:31:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3669558bdf354cd352be955ef2764cde6a9bf5ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
