Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9210959F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 23:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfKYWpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 17:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfKYWpF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:05 -0500
Subject: Re: [GIT PULL] Btrfs updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721905;
        bh=ZClY/lm1Iav2NgRbsrICC8kisv5A90msTOuVRsCMpFw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jLVqA+a23ELumM+o/45vWqUuMQYFFv7MEHwbh2Uxuaz+/dJbs33kvjFaVcVBftSjT
         9RvWSALk0txJaGhSiN4VN4SQwHdMRSYtPfUCeMefasbwEgQpI+ny02FQ/JHqmcRzi8
         0grJkwgUGpUDrGUm/UrteCUzNCxLCU0e5TOwBqbA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1574439340.git.dsterba@suse.com>
References: <cover.1574439340.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1574439340.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-tag
X-PR-Tracked-Commit-Id: fa17ed069c61286b26382e23b57a62930657b9c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97d0bf96a0d0986f466c3ff59f2ace801e33dc69
Message-Id: <157472190532.22729.17441948611368975877.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 17:23:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97d0bf96a0d0986f466c3ff59f2ace801e33dc69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
