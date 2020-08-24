Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2425092C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHXTWC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 15:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgHXTV7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 15:21:59 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296919;
        bh=HQYIhDEJFQHKLSfJOitcmoFKB9nF0wPzPT9kJIALLnU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bmy4pv8VwKj5DcdfYhQ52d2i0UoNjpWDXsDLqmYbAi7Z2W3f4yi6hjTywnIHDjFJH
         iq6Fbds+85Yk6NX43WjYL427y9EKFYlueQGhwPOcUjlal5x/7rZHPc9EoynJj0J6rg
         jOWz/hJbVPWned7sy1MDrK81u3oJOrcS/lY6+UgY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1598283719.git.dsterba@suse.com>
References: <cover.1598283719.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1598283719.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc2-tag
X-PR-Tracked-Commit-Id: a84d5d429f9eb56f81b388609841ed993f0ddfca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9907ab371426da8b3cffa6cc3e4ae54829559207
Message-Id: <159829691929.31349.7697841057318029219.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Aug 2020 19:21:59 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 24 Aug 2020 18:43:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9907ab371426da8b3cffa6cc3e4ae54829559207

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
