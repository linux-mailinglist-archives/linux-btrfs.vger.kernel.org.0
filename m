Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876943798FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhEJVQQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 17:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhEJVQP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 17:16:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D631A611BF;
        Mon, 10 May 2021 21:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620681309;
        bh=3Vj9bVU+GVAGugxZ47r7R2NOdGtWuc2M/1/A3jaXu4o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KXaSuvSB2ZTzxASPWmwd3qZ+9pOWrTSS3UcUSY3RqUoEajCk0tx49eT+0yolpq/6E
         Ejgn2Dc0oNddQJGiVOSQFJAmaR11qZtlGRNK/iCSIB0In3GAonBqyZu01DDLP7J4HW
         eoLdmChAMwMkA4dG/Cowc1iAUsWOq4Dfi+Af6fFFx6kP/fNVtuIF9umITPL78+P3JY
         JXegGGdvLLXkEUznJuVnm1AmpnxOZPaz9AoheSEtSUcnX4Jx6rr/Vawe6TAiH75geU
         +/ZjByG6dj+6V7afnBusBoKJCmGJp8AeNb2LsrgLiMQQ/vhxUwutitQElHJZYi3lpn
         rlRsTj9gp+W7Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C0C1060A27;
        Mon, 10 May 2021 21:15:09 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1620679798.git.dsterba@suse.com>
References: <cover.1620679798.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1620679798.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc1-tag
X-PR-Tracked-Commit-Id: 77364faf21b4105ee5adbb4844fdfb461334d249
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 142b507f911c5a502dbb8f603216cb0ea8a79a48
Message-Id: <162068130972.21764.17439713318608297507.pr-tracker-bot@kernel.org>
Date:   Mon, 10 May 2021 21:15:09 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 10 May 2021 23:06:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/142b507f911c5a502dbb8f603216cb0ea8a79a48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
