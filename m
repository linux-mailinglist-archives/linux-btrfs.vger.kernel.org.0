Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B6666CEB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjAPSYU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 13:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjAPSXP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 13:23:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8E13A86E;
        Mon, 16 Jan 2023 10:10:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0909EB810B9;
        Mon, 16 Jan 2023 18:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1945C433EF;
        Mon, 16 Jan 2023 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673892633;
        bh=r4wn5IfK4rWXNnKTgLxwRsf8oxLccMHAZmJQj7XM23Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CGf1cK/PTpzzZ6j0Wj9isbPsvqs1Tni6fCra7Ktnk8Ms9uxmPi/OrRXayQz7XR06q
         UQjBTiE8Th/okMBQNy6Ne9UFjy1h75a4qviL99ZDxIbyme8IDVxvmBwBbZZz5pyfz/
         nSs3LYxMyxlg+8Y1vtSLvWtS9rvIR7hSkehTOSQggJdgQ/PjK0x4RPb2Vvs8zJdW8u
         hjYTUcELqsrfB75TSCN9/yaJBvEWKvmLOxPSnV84Gz7nypkJdKlH/Ch4PuVKt8arHI
         y0CP6LRZjUhr1ctrbb3rEvhPcaqgxE3bgzeXTZj4a59vp7lCemMhchYcyWejeXbUfN
         nZPmP19iUsBaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F9EDE54D27;
        Mon, 16 Jan 2023 18:10:33 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1673876631.git.dsterba@suse.com>
References: <cover.1673876631.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1673876631.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc4-tag
X-PR-Tracked-Commit-Id: 09e44868f1e03c7825ca4283256abedc95e249a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d532dd102151cc69fcd00b13e5a9689b23c0c8d9
Message-Id: <167389263364.22071.2585873381936427854.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Jan 2023 18:10:33 +0000
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

The pull request you sent on Mon, 16 Jan 2023 15:45:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d532dd102151cc69fcd00b13e5a9689b23c0c8d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
