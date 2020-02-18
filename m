Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2A0162080
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 06:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgBRFkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 00:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgBRFkS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 00:40:18 -0500
Subject: Re: [GIT PULL] Btrfs fix for 5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582004418;
        bh=97SUQ24phw+psmy6TmZZtzFUJl9LBoxcMVLoYt+B9J4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jxurf7V69n3HGzrX8kB998tHCcoRjW5MdICDq6ctwEH3nP1XQJ38bC6M4WNdkYcAd
         J8HJoSl7HkxBXS0GBQKNqJV38T4WdBAomF42Gp3po/4i6M/O2T/PitfOrkVOv+R1D1
         0/xI/dWda852eSZZquom4L4XbtCS91ZLqZClTXF4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1581962653.git.dsterba@suse.com>
References: <cover.1581962653.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1581962653.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc1-tag
X-PR-Tracked-Commit-Id: 52e29e331070cd7d52a64cbf1b0958212a340e28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaea2947063ac694cddff1787d43e7807490dbc7
Message-Id: <158200441799.24167.9075205058877968253.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Feb 2020 05:40:17 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 17 Feb 2020 19:43:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaea2947063ac694cddff1787d43e7807490dbc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
