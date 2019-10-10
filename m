Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A7DD2E07
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfJJPpL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 11:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfJJPpL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:45:11 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570722310;
        bh=Zxi7XabPgawIRxeJF7rkwQdOHbEHK7U2QcmnnfgeLPY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zIRUOh9d1Nx19XmkC8BLaoxaTLHsPOh31PPqpAOvVeC+wUP/uNlEdHdJ9d8IULfvc
         g2vZ8S00/SCpMwFzakdVsYgDx2hDx/uJHkih0Z/olpFFM/fUanWNt5VXUWXJ8weE1r
         d4+ZDWDYTdSq1d6/LwUTsBqJcXIPLCOS36Ojtvdo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1570718349.git.dsterba@suse.com>
References: <cover.1570718349.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1570718349.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc2-tag
X-PR-Tracked-Commit-Id: 431d39887d6273d6d84edf3c2eab09f4200e788a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8779876d4a79d243870a5b5d60009e4ec6f22f4
Message-Id: <157072231090.27255.2914511217246664772.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Oct 2019 15:45:10 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Thu, 10 Oct 2019 16:48:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8779876d4a79d243870a5b5d60009e4ec6f22f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
