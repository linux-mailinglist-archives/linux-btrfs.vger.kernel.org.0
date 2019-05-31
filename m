Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A5C30784
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 06:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfEaEAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 00:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfEaEAO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 00:00:14 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559275214;
        bh=4jTofTqvvNDlF4QyiVcyAPeb4h9iYelQixHrFf5lvnU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dh0i+GrAq7KdZvLW8yx40GPqQadwwk+aAr71pzB1lWDQGKJsYgLhdQPqAfl6zFJYS
         01fImTlpcntu20mnB6ZTP8POGlC6ks7mPIfBccWybZQehEvaQN0uxIIbgXooZ9wv08
         RM6+CLgs/7sSh6Vx71s8dav93GpeTkXTh5wNSD7c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1559167316.git.dsterba@suse.com>
References: <cover.1559167316.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1559167316.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc2-tag
X-PR-Tracked-Commit-Id: 06989c799f04810f6876900d4760c0edda369cf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 318adf8e4bfdcb0bce1833824564b1f24278927b
Message-Id: <155927521427.31954.14941314038418072131.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 04:00:14 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Thu, 30 May 2019 12:44:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/318adf8e4bfdcb0bce1833824564b1f24278927b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
