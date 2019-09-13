Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B364FB1A6A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 11:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbfIMJFH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 05:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387536AbfIMJFH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 05:05:07 -0400
Subject: Re: [GIT PULL] Last btrfs fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568365506;
        bh=0hPwizLNWDeNLiSepXf9JSBRoD2nWHbIOgr9k7QCFg0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Efe07q1UOy80KdPb+ICcITjq8WFOGhrbDo14WOTEblPTB5fWMbLDmMD8jB8cemm5t
         7iJxu8Vvw+eOVZzHYszbVOqaGO/EHoGwTovu0X3so55zGqBkDPBPy0bzbL5h7cxQRh
         KeeKBV2imPJM8z8wQpISSo/yIC/7rmwRljreiia8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1568307806.git.dsterba@suse.com>
References: <cover.1568307806.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1568307806.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc8-tag
X-PR-Tracked-Commit-Id: 18dfa7117a3f379862dcd3f67cadd678013bb9dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b304a1ae45de4df7d773f0a39d1100aabca615b
Message-Id: <156836550649.13985.2850548447903893133.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Sep 2019 09:05:06 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Thu, 12 Sep 2019 19:37:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc8-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b304a1ae45de4df7d773f0a39d1100aabca615b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
