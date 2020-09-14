Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB5269937
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 00:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgINWsd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 18:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgINWs1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 18:48:27 -0400
Subject: Re: [GIT PULL] Btrfs fix for 5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600123707;
        bh=fqhQ1JW3aFG/vf47JBec590V5O7uEvYm7URaeQpMXW8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kaxNg9e5Du691il5KOmxNZpUNvh9RdRO6fv79drQDixAH1kuwUMZ5D6SuUhjKjhjg
         +vpVBRp1mFVSE7Skq0CtzjcbFWLTRyPYa5tZfLXTBC9/nXOCImLZKLNlP0tC+3c+mp
         TkL29cGAldhne+Sx4/H1aPk3o9knLTBU7NhcHPqI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1600098180.git.dsterba@suse.com>
References: <cover.1600098180.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1600098180.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc5-tag
X-PR-Tracked-Commit-Id: 1c78544eaa4660096aeb6a57ec82b42cdb3bfe5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc4f28bb3daf3265d6bc5f73b497306985bb23ab
Message-Id: <160012370701.25401.14894924300271556198.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Sep 2020 22:48:27 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 14 Sep 2020 17:56:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc4f28bb3daf3265d6bc5f73b497306985bb23ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
