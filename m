Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 719A441A1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 03:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406304AbfFLBzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 21:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404091AbfFLBzL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 21:55:11 -0400
Subject: Re: [GIT PULL] Btrfs fix for 5.2-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560304510;
        bh=IH2n/rNr1mNHaQl1eZb628HBD5FQEExCtCUPXnWNU0U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ad/LBcVo4xSD3yQM7qrV8GHflqQhcSG0wjZ2DYjfOI2QAeMCH5xZtoMiVib4ryAQo
         wNPKEwGPFC5fd/F6lU5tHojHjfpqMNWQXKNOb0YLmN4TvbVCn324b8XWBJZC4+URjk
         JcGQOti5lRMwq4yogYG7St9DJtnTkSB9WvNmeSx0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1560268545.git.dsterba@suse.com>
References: <cover.1560268545.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1560268545.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc4-tag
X-PR-Tracked-Commit-Id: 8103d10b71610aa65a65d6611cd3ad3f3bd7beeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fa425a2651515f8d262f2c1d972c6632e7c941d
Message-Id: <156030451057.13515.14003261403956431603.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jun 2019 01:55:10 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 11 Jun 2019 18:16:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fa425a2651515f8d262f2c1d972c6632e7c941d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
