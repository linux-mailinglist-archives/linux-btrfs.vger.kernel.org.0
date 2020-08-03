Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5561423ABE6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgHCRzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 13:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgHCRzH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 13:55:07 -0400
Subject: Re: [GIT PULL] Btrfs updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596477305;
        bh=mdtM58bGypOBBJbZOsVFxNEJkWt2yXbMQumS+SXkuf8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l4dkoo3zWjD5PWBDA7Ku8bX7fHbZHs9+jTI/e55IlxHzXGuResd2YPb2f7d5i/3BC
         Eg37cPKaAvrdJGaR8UVDyoGQiXSlBUrfgOqZKYzdNcblqAff27qxYUWtqg5VMeRuz+
         tkgmoflAm+okNVW/AzCoxry2c38LLt4yHggckxYA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1596213437.git.dsterba@suse.com>
References: <cover.1596213437.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1596213437.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-tag
X-PR-Tracked-Commit-Id: 5e548b32018d96c377fda4bdac2bf511a448ca67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dec9f406c1f2de6d750de0fc9d19872d9c4bf0d
Message-Id: <159647730580.19506.9811815891412880498.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 17:55:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 31 Jul 2020 18:42:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dec9f406c1f2de6d750de0fc9d19872d9c4bf0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
