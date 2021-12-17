Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2046479700
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 23:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhLQWV2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 17:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhLQWV2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 17:21:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B7C061574;
        Fri, 17 Dec 2021 14:21:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAD8962415;
        Fri, 17 Dec 2021 22:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 495B7C36AF8;
        Fri, 17 Dec 2021 22:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639779687;
        bh=TJA/qzJTaOBHV2GxOQqTScPDI6Xrc44F9ueTZJ0t1Qg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hNEzeSzdjknDuT1i539lDunEKodOnfLtyflQb8A6t+JmhHxnMw0CFeviX5gQOfuVt
         xD5ARQ7iRlj4D4wdz/glQZ7uEduNkIqC2S57OyAaaTFtbz576BhHNAZz8VZP/NzAnZ
         TOfpKcXWH37jLBMZaluIjkyyTykogR2NVeIHYwZL6HjguzPuwyhDWIkZDUOwnmzOdr
         gClWw7OaKlwamBSlHPoCdRM/cnWgZUcCSYSIG15UgJBvdFzrqcNtZ6NMIuXU7PD1JI
         hTPFiX1ygkww2xqmSM3SpOP0bXGqBZCFhG3EkL3qUMzW4m5k/GlF+OSPcxmEHY3R5m
         Xu5gBA09i3xXQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3939860A39;
        Fri, 17 Dec 2021 22:21:27 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1639775076.git.dsterba@suse.com>
References: <cover.1639775076.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1639775076.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc5-tag
X-PR-Tracked-Commit-Id: 4989d4a0aed3fb30f5b48787a689d7090de6f86d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9609134186b710fa2104ac153bcc27b11c3e8c21
Message-Id: <163977968722.18736.6525832847263693299.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Dec 2021 22:21:27 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 17 Dec 2021 22:19:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9609134186b710fa2104ac153bcc27b11c3e8c21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
