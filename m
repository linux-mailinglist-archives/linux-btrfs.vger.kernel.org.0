Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38CAF77136
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 20:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbfGZSZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 14:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387575AbfGZSZ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 14:25:27 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564165526;
        bh=tGsCQfITcjN4tf8DHBRLtnpDdVJ8vB8SOpGlnvFr5y0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FXUIhPfM1AEgzJPmTfl8v7RhsYmr4SNDtr3jFmHZFJ82G/kpkPv6Ta+yTBeNzAwvg
         ig0tgNaN9YM0w37R0YCsJiuBzT4/TiH6WHy41N7dDGcy8t/ogxZR4PtM4JUPUHQ1+N
         VnuIU2xnxmFu87YNVLj/9XHya7NJ9uDe90FGorw8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1564158940.git.dsterba@suse.com>
References: <cover.1564158940.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1564158940.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc1-tag
X-PR-Tracked-Commit-Id: a3b46b86ca76d7f9d487e6a0b594fd1984e0796e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4792ba1f1ff0db30369f7016c1611fda3f84b895
Message-Id: <156416552659.19332.16696308843926887249.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:25:26 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 18:42:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4792ba1f1ff0db30369f7016c1611fda3f84b895

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
