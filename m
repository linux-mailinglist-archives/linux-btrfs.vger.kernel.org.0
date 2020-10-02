Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB512818F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbgJBRPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 13:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388181AbgJBRPP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Oct 2020 13:15:15 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.9-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601658915;
        bh=/xqQeskoEGId2eDkzvcqQ0L15X/8YEXOztIEY1EMWwY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bCAKxULOEOuc2XcYhBiEYsjNBKu6/Z6y5QS/47Q5UwdfrBCH2ftOQSVBXfx2B7gPv
         Mm8D6nX0PByaov198uNDEu3MeH9hgY7M47UwkkrPLYgH6wTc9q+RN68Y/J1DT+xTMm
         NVd87ScAFyNlGJIEyv6zFRff5hVeVvqSz1Ma8qFU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1601650060.git.dsterba@suse.com>
References: <cover.1601650060.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1601650060.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc7-tag
X-PR-Tracked-Commit-Id: 4c8f353272dd1262013873990c0fafd0e3c8f274
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e3b9ce271b4b54d2293a3916d22e4ddc0c89aab
Message-Id: <160165891553.31225.16441597036192185427.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Oct 2020 17:15:15 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri,  2 Oct 2020 17:30:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e3b9ce271b4b54d2293a3916d22e4ddc0c89aab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
