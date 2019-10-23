Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AECCE17CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 12:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbfJWKZH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 06:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391001AbfJWKZG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 06:25:06 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571826306;
        bh=dkE3MrqlPJvwnrTN1PpFKAE8Ll7LIwAMZtG0/eVUxes=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QKjMO6Iwqc6sLTVHlbFoAqM0SzLM1e/lUeMfH9HNby9O2345vN1Z2ACs8nV+SpsZb
         qsuwxrYEvD7UajIyRzDK+FGo8ciSVXFjdWNWyZCDBdqrmq/M0Xit2owJwxqLc9+swq
         2ASByCg2akqS8pjjk+lVMi0kBCcq/6VPuZQfjNB4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1571751313.git.dsterba@suse.com>
References: <cover.1571751313.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1571751313.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc4-tag
X-PR-Tracked-Commit-Id: ba0b084ac309283db6e329785c1dc4f45fdbd379
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54955e3bfde54dcdd29694741f2ddfc6b763b193
Message-Id: <157182630637.4124.5490393115058163263.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Oct 2019 10:25:06 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 22 Oct 2019 15:52:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54955e3bfde54dcdd29694741f2ddfc6b763b193

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
