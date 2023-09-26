Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E727AF16A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjIZQ7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjIZQ7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 12:59:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15DBE5;
        Tue, 26 Sep 2023 09:59:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D337C433C8;
        Tue, 26 Sep 2023 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695747572;
        bh=eV+pYjMbZToeyN+5N8F2hnT8qT++qhYzZsLNtmdWcIQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qdLeG/y47pihhLLAVQCaJbtE5h8j9YMsES+7OjGLSpp+ewKVl6v62MK3rDuJ5IgvG
         UxQk8wsFavzO1Apu9L0kkAUZ6t5LUcv46WnU8DJwuK9XLVdn2+1+FvCSEqarzlGJEW
         q/VYQtNpD6I10Qjo/K/i1sC6M1dw4JyGV3mW0Z3eGBk967BOwo6rTM5ot2GtG2BUm6
         XBEbSAh037YVWzkzwBXRRhtsvWxekr3UMS7iB94UnS45tf11o+QtQN2+FWKFdKY4lJ
         4xmVl8nQRv4mvZqrSbFpvzSToAFnC3+iyciBtEu5d8RCbmJXKerDIefx3mdewtoMux
         V2TUxnQPzrQZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AC34C64459;
        Tue, 26 Sep 2023 16:59:32 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1695744160.git.dsterba@suse.com>
References: <cover.1695744160.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1695744160.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc3-tag
X-PR-Tracked-Commit-Id: b4c639f699349880b7918b861e1bd360442ec450
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cac405a3bfa21a6e17089ae2f355f34594bfb543
Message-Id: <169574757222.7314.9849736636854970419.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Sep 2023 16:59:32 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 26 Sep 2023 18:22:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cac405a3bfa21a6e17089ae2f355f34594bfb543

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
