Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BFB7C5FB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 23:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjJKV6n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 17:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJKV6m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 17:58:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC69E;
        Wed, 11 Oct 2023 14:58:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3987C433C7;
        Wed, 11 Oct 2023 21:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697061520;
        bh=Z5Lv2kVODgdkveHeKQu4bqvPDbTNiQ4buVXpY2T6CJA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=abr2osvBSe5/mnePYjhMxVM4XW6CHopBaxML7Wz922b6y7uj3aUYpO9cRTkUVRpHY
         rtH70q5K8kXRZVM7J8PgwWE+cnGJV+PS/2KtBfC7PYiuAicUY0/tCJWta3WZvEpKUr
         XtE60POAuyOYW8FOY5DJVpExh5eZf9tNRteQ1A9FqUjw75+UvFmKKS66vai4GSJJtk
         Cyy308c9ifZG3AfAaBhNlo+yaJUwj49T8Q08VXV/7cqzSMHY1+xf0L1zrLGRzeric2
         EwSTz0VFrK2xTG3IlsXdaO89QzhPppmTsPE3qSVNSk40qZZ32JuzwSZrSQRYQJRqMI
         WAfoKVmaAOaqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C17F9C595C4;
        Wed, 11 Oct 2023 21:58:40 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1697017675.git.dsterba@suse.com>
References: <cover.1697017675.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1697017675.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc5-tag
X-PR-Tracked-Commit-Id: 75f5f60bf7ee075ed4a29637ce390898b4c36811
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 759d1b653f3c7c2249b7fe5f6b218f87a5842822
Message-Id: <169706152077.2549.8610712762847742178.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Oct 2023 21:58:40 +0000
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

The pull request you sent on Wed, 11 Oct 2023 11:51:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/759d1b653f3c7c2249b7fe5f6b218f87a5842822

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
