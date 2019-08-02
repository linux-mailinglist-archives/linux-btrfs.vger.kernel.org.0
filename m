Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6018680295
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 00:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437228AbfHBWKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 18:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbfHBWKM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 18:10:12 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564783812;
        bh=0ADvaENQ+brKEvELvSqXvOMv47PciEcB7jt9Ddc06OY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mfdpYtRI3yYscPVSqG9g3qwe7n8wrUY/fj2P9ZWADfEv9RsUF1gJrZE3uq/cKkMQs
         wKVb0OskQ7rbZdS+2UvTghvC/oEc+n+qqf8MM1YWGBZkeKs46no1LAcQIoBwGZNB4X
         uFaBXnp5F4pfSM2mAsp6nULs7W3EMEr6xJV/5ab8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1564757308.git.dsterba@suse.com>
References: <cover.1564757308.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1564757308.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc2-tag
X-PR-Tracked-Commit-Id: a6d155d2e363f26290ffd50591169cb96c2a609e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d38c3fa6f959b8b5b167f120d70d66418714dbe4
Message-Id: <156478381210.28292.4383010166227745942.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 22:10:12 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri,  2 Aug 2019 18:50:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d38c3fa6f959b8b5b167f120d70d66418714dbe4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
