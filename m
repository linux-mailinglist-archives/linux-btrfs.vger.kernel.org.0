Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E762057E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 18:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbgFWQuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 12:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732953AbgFWQuV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 12:50:21 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592931021;
        bh=Sd6SjhyVGewNRWiidoTTRQ5tZ9NYamhA0C4eDTLjMkU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XmLc9zP1SStylE8J/3uCJj+ygUrpgOwdWTWlUWO+UbAyh1WFqsxgXQNCjPUTAg8sj
         ZOQRAZODkXmTmKmn1NcpCU9hBfQumte6RB16Noy2wuHR6whXOpnAyamMY+ZJ9DYgJZ
         yol7Ta/s04uUWLwHUlqnt6v39xLXd12dbjVM2qGo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1592918083.git.dsterba@suse.com>
References: <cover.1592918083.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1592918083.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-rc2-tag
X-PR-Tracked-Commit-Id: b091f7fede97cc64f7aaad3eeb37965aebee3082
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e08a95294a4fb3702bb3d35ed08028433c37fe6
Message-Id: <159293102113.9844.16810566723336922683.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Jun 2020 16:50:21 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 23 Jun 2020 15:53:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e08a95294a4fb3702bb3d35ed08028433c37fe6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
