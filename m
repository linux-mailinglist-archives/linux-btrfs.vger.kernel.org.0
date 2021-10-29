Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2389D440274
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 20:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2SwC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 14:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230024AbhJ2SwC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 14:52:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2C1B760ED3;
        Fri, 29 Oct 2021 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635533373;
        bh=xKjj5TUOX7+7DgXitp6eG/MdSyD3aU2l4IhFJfI2Kes=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gOrP+TQ3N+Azv+CfmtnhgDU0KiGS+K5t5HPkeOSCufPo5+nJazfR+tKHj7Jn4lOY2
         qaayHuhjEv1hGz2S+yBXDDXU5HRW5k2AbtuMV05WwT6QUM+7RxJChhIEPmd0qtxeq6
         abBaOy2xDlBUZsgEJwrZ/RoxlfAcHulAvIrbDF2IKjo/+XO2OV9/Glc4jF/nGxPxKK
         glvvLSa516SiH0RaYxUT4yWJ/Jd1K8S3OVFeTSQ5sRz17zeeljI5FUFxmDiaC87w/e
         Jf7OllwjjZ0dmr1TGdVnjGywbHJXcNHvMXGy2s6pB3uKB/8HLMyv6deyZSXdAio7Am
         g50RS7xRw+SYQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 24EF260A17;
        Fri, 29 Oct 2021 18:49:33 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.15-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1635506911.git.dsterba@suse.com>
References: <cover.1635506911.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1635506911.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc7-tag
X-PR-Tracked-Commit-Id: ccaa66c8dd277ac02f96914168bb7177f7ea8117
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd919bbd334f22486ee2e9c16ceefe833bb9e32f
Message-Id: <163553337314.6387.16781699699043718675.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Oct 2021 18:49:33 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 29 Oct 2021 14:17:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd919bbd334f22486ee2e9c16ceefe833bb9e32f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
