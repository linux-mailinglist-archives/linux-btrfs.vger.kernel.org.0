Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4D1F8A37
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jun 2020 20:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFNSz3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jun 2020 14:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgFNSz2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jun 2020 14:55:28 -0400
Subject: Re: [GIT PULL] Btrfs updates for 5.8, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592160928;
        bh=K4xDUOtGypMVSxo0Vi1uThZVPbJLPemsQEnMFSr/HGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=maXewfQQyTyPay1Rfp+i3bcLD1g/E6BJsHPlSxmGT7jSHRmdzRisu5AIDI/vHkdTl
         0A0rA84wy4zsWFArpkEhN8ELroBhnvST2bDCsYlZiK43kkuO5NEDKZJxPVvc/gnaVp
         ThayHSu7xO3bfkx8O264EpIfpLTQr0mTXeeH55AY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1592135316.git.dsterba@suse.com>
References: <cover.1592135316.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1592135316.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
 for-5.8-part2-tag
X-PR-Tracked-Commit-Id: 55e20bd12a56e06c38b953177bb162cbbaa96004
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d645db853a4cd1b7077931491d0055602d3d420
Message-Id: <159216092857.5153.16082036974540107892.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Jun 2020 18:55:28 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sun, 14 Jun 2020 13:56:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-part2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d645db853a4cd1b7077931491d0055602d3d420

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
