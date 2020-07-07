Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF35217A43
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 23:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgGGVZK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 17:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbgGGVZG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 17:25:06 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594157106;
        bh=KUztR4Jum92Md7UpQDEmje2OUx2HjVKgHkBhyzgyzBk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=T+gfp5oUgS0Gzct6NRHLXLxteo4ijP2Pj7XqDne2OmKF9Mw/6w52qoTYSpzMCW7N7
         chBsCvVD1/wUJKbdqZZLKHWkPiY+do/2fr0IctDVQldns3/3m4eaMhEhnbMHunIoWu
         HM728XqI8pK8lSexlKl0GXZmfE/rcEJUK94bNPG0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1594127892.git.dsterba@suse.com>
References: <cover.1594127892.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1594127892.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-rc4-tag
X-PR-Tracked-Commit-Id: 0465337c5599bbe360cdcff452992a1a6b7ed2d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa27b32b76d0b1b242d43977da0e5358da1c825f
Message-Id: <159415710654.29940.11335794129191881695.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Jul 2020 21:25:06 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue,  7 Jul 2020 15:27:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa27b32b76d0b1b242d43977da0e5358da1c825f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
