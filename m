Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4CC282E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 23:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbfI3VGB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 17:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732517AbfI3VF5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 17:05:57 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569864625;
        bh=Lt1tLI/vGjcqVnueWsPgg4QYQ4vOpKjkWPbCcwmMOUU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZpzzFho/T39gxcP5rCXed6xY6D8l6G+HUXIYAeeeaQtQMH3JysMqgfZeptXy/g+bW
         VtZRW+BGdxkfhrgXgI6MD3i0P2/UmhbueqtVVHhkLfQSPak6cwTdvryz6xfUKKYycr
         eUBiGX58QquKlDVM2QXnZfDmlom6Q0c8kFNbblTA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1569852875.git.dsterba@suse.com>
References: <cover.1569852875.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1569852875.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc1-tag
X-PR-Tracked-Commit-Id: d4e204948fe3e0dc8e1fbf3f8f3290c9c2823be3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb48a59135926ece9b1361e8b96b33fc658830bc
Message-Id: <156986462567.9141.8547553588030012107.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Sep 2019 17:30:25 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 30 Sep 2019 16:25:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb48a59135926ece9b1361e8b96b33fc658830bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
