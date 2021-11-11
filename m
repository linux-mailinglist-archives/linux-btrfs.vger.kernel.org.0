Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079CF44CE94
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 02:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhKKBKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 20:10:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbhKKBKi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 20:10:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 570B86135E;
        Thu, 11 Nov 2021 01:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636592870;
        bh=0XVgoaE1gcgfoEqBzxC+CW2CBZY5v560y6QZ1l7Gndo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PrqH6ctElEZ/wjHa5dGQivKY5L9aliU6U4MIE/rdsPjrIgRMI+CntYd1UQl1jezKr
         J/e/gSAh1M7EbEMVgsUClmDJJDSC4HOZ4Sy9G2Tg9RtVCZ2MtSRrLAFTOkiUbgy+hK
         OLoxEKY9+yoSsvmKYT/u/mjvhejygthdSMsowvZ0XhbsBCkIecKyYHnUpaeZn9hrRM
         v4ZvZXxXtC/+IxUfWQyDBLXyjltSoyFmoo/FB3ckZYIgq6K25WD0v/Qm5fY+2GvfNJ
         jG3mz9xaEOOguZQTiQaszkR/BEJKgJTNzgpYsR9u1Q/RX7vOv6aAYf92dNuN8ISQqC
         U3wLQgTlqzrUA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 46C6F60965;
        Thu, 11 Nov 2021 01:07:50 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs update, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1636564333.git.dsterba@suse.com>
References: <cover.1636564333.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1636564333.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-deadlock-fix-tag
X-PR-Tracked-Commit-Id: 51bd9563b6783de8315f38f7baed949e77c42311
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6070dcc8e5b1495e11ffd467c77eaeac40f95a93
Message-Id: <163659287022.32583.17378469213133143021.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 01:07:50 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 18:38:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-deadlock-fix-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6070dcc8e5b1495e11ffd467c77eaeac40f95a93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
