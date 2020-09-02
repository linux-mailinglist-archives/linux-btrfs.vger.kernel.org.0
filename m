Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0900925A31F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 04:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIBCpR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 22:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgIBCpP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Sep 2020 22:45:15 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599014715;
        bh=WG/yXwjv4L2MXI8+Zs5SazBK9AySgQfmEdwFwAdAHJY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JPXLowZJsCpJasjRWGKPcKLxTCC+P45mXS0hw3lf8UYFyMbudO7bJUFW3cT7tbNOe
         csXjik3yhgLInBFLowdE9IKtaczaC6wIAshWEs7Y/Or7okYInUC4aiTb4Tg+gDrome
         uWKh5MUzTxM9oBxuWXN7PllkOop8JNR7cyIBiWjM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1598905089.git.dsterba@suse.com>
References: <cover.1598905089.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1598905089.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc3-tag
X-PR-Tracked-Commit-Id: f96d6960abbc52e26ad124e69e6815283d3e1674
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcdfd9cc28ddd356d24d5461119e4c1d19284ff5
Message-Id: <159901471527.4624.11112977292229789155.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Sep 2020 02:45:15 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue,  1 Sep 2020 01:20:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcdfd9cc28ddd356d24d5461119e4c1d19284ff5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
