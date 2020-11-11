Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A592AF25F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 14:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgKKNkU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 08:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgKKNjd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 08:39:33 -0500
Subject: Re: [GIT PULL] Btrfs updates for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605101972;
        bh=Cbwjbr8ZYl5hBdxYNrziR8+bxvu5Ly10lwmLFdgvKnQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LJsjSolbtJpu6WMAnfBOTP3EPyuYGVW5t3+A+bBRV6I975fcacvAloR/gXaDooRGo
         CU6NXfeYpi7TyL1UkhQiWZrzDOIC2A0v6Ajc8YM1wt+BWf3F2RVATXdsCCDzh2cw7w
         DycO8VEw66frhbxqbdegtHNViL0bwRFqIKaWEnBk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1605023716.git.dsterba@suse.com>
References: <cover.1605023716.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1605023716.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.10-rc3-tag
X-PR-Tracked-Commit-Id: 468600c6ec28613b756193c5f780aac062f1acdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2f0c565ec70eb9e4d3b98deb5892af62de8b98d
Message-Id: <160510197276.25708.9852206429614144256.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Nov 2020 13:39:32 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 10 Nov 2020 17:05:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.10-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2f0c565ec70eb9e4d3b98deb5892af62de8b98d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
