Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D802FDD0F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 00:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbhATWfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 17:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732882AbhATW1K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 17:27:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 36C0A235E4;
        Wed, 20 Jan 2021 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611181587;
        bh=ve7pURTsRKdcm8d893lDukmE3h/bF0bwAyCinm90zNw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=do3ypckNZ3+w2u8N2KYfINGc6FcLG25p+uoKRKthV/5ubcHQDan+PapoPHcDCg/Aa
         4gLdyzMovz3nI3/bTW7P+J6MSO7SgdYrdrec1FhfBuVhGMTcnPplVtDwgwltSEV2Kx
         Mq0aJRWucrHq9GAfjS0twhjuF0goSczlJUvlskeLDZwX331cy0Fdh06VoRMyUklSY8
         GJbh5TkrOWiSknAillBQSCP3ijSrkD86UvejW3/7LbLpjoet6YwJcaEHRKumY0SOHx
         UvwkNuZArL4UyI0nMuv8U0itqL1YttkzZrypIPwVdQx98c8ACC5I+w9XkdQtD1CrIG
         8sQhKpYdCHVsw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 29D93604FC;
        Wed, 20 Jan 2021 22:26:27 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1611178630.git.dsterba@suse.com>
References: <cover.1611178630.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1611178630.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc4-tag
X-PR-Tracked-Commit-Id: 34d1eb0e599875064955a74712f08ff14c8e3d5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9791581c049c10929e97098374dd1716a81fefcc
Message-Id: <161118158708.31946.5819274062586024596.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Jan 2021 22:26:27 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Wed, 20 Jan 2021 22:49:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9791581c049c10929e97098374dd1716a81fefcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
