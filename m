Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC074349C70
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 23:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCYWmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 18:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhCYWmU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 18:42:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2F755619E8;
        Thu, 25 Mar 2021 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616712140;
        bh=80s5vCFIUOAL9osUzboNGTXGqEGPfcwdrXgHJYMmcgM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o07epAOTGEVwlS4CX4ubWZ7B3Q2Mr1qpBgZLrH2/WF+QDwoDOC+BZK8axYv0D9Ptw
         BuELVbVuI6HduPMYZ2CDMzUhZE1h3jYSINuoUMShB34yib1j4YyPnCWhMVGmEvjSh0
         6qOy90tDk2f7C60iudINBx1kgja4WNYXv1KuHrCtn3ip/4QDp/iIdum6SgHYxmBdET
         Rol78ix27lWNyE9XuXyrqBVRJ15YNEV/8rh2r+5+PrmPGeVkt9IVZMn/PwIAKtLWrb
         rNzfscWGj27tnfXhhlQ0eaGOZ8fT14i+hHbK08bInW+af9jOEwdRhRpyzprYmXhxDn
         9oh0Wujw7TZ6A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 179746096E;
        Thu, 25 Mar 2021 22:42:20 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.12-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1616690512.git.dsterba@suse.com>
References: <cover.1616690512.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1616690512.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc4-tag
X-PR-Tracked-Commit-Id: c1d6abdac46ca8127274bea195d804e3f2cec7ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 701c09c988bd60d950d49c48993b6c06efbfba7f
Message-Id: <161671214002.30956.4861624334084118679.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Mar 2021 22:42:20 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.cz>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Thu, 25 Mar 2021 22:36:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.12-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/701c09c988bd60d950d49c48993b6c06efbfba7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
