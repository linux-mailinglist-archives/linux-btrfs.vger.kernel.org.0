Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C11EC7F9
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 05:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgFCDuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 23:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgFCDuJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jun 2020 23:50:09 -0400
Subject: Re: [GIT PULL] Btrfs updates for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591156209;
        bh=uxLBNfsO/YI2tyqQItJTfnnheIwxdADpEhCmBIFstxw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Gt6pipdcoelkT5803FBU39++5b9k27KCsZR6u6Oz9Be31HU0GoA5Z+xYyfuOCby1u
         9S2YxL9oIvZmc4qj9CVc7blBlpkWld/6Z/hhrg8nQbQZDsjMwywpe9JzWbuK8fxGWg
         frtl39jOviqSMjArjiwJyjhD6Jf4f5jTi2Wxj8hA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1591014060.git.dsterba@suse.com>
References: <cover.1591014060.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1591014060.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-tag
X-PR-Tracked-Commit-Id: 2166e5edce9ac1edf3b113d6091ef72fcac2d6c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3cdc8ae116e27d84e1f33c7a2995960cebb73ac
Message-Id: <159115620927.30123.8464936394919802236.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 03:50:09 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon,  1 Jun 2020 14:37:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3cdc8ae116e27d84e1f33c7a2995960cebb73ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
