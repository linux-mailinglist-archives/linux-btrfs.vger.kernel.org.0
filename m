Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054AD19A143
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbgCaVuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 17:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731703AbgCaVuM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 17:50:12 -0400
Subject: Re: [GIT PULL] Btrfs updates for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585691411;
        bh=vwS2WyuE8y0mjPNrYzxpKkhHhYf8AtDFYMmOyIH/StI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MJRHfZqwriYITu3P1PxhHqGrvnCiaR1lWC7iOZAveP48CbzhBGqVnKeuA/K/JmU+M
         uEPY+fT2pLh7gFOX3e3heF+ucRx8rao4VjgBHoRB7/NWEtofOnGc0XwQUmg4wWlnob
         trfP42bR8NGnM8yNkttDRuIMoyyvnxFow+NU8dBg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1585581921.git.dsterba@suse.com>
References: <cover.1585581921.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1585581921.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.7-tag
X-PR-Tracked-Commit-Id: 6ff06729c22ec0b7498d900d79cc88cfb8aceaeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15c981d16d70e8a5be297fa4af07a64ab7e080ed
Message-Id: <158569141150.7220.17016209965429680277.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 21:50:11 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 20:37:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15c981d16d70e8a5be297fa4af07a64ab7e080ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
