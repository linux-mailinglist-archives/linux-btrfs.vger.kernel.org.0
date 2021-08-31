Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734753FCCE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 20:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbhHaSUe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 14:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239094AbhHaSU2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 14:20:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5AD65610CA;
        Tue, 31 Aug 2021 18:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630433973;
        bh=dQeMft7pJ4e+Jo+7Yp/LFy7sxgvNMY/8/roDAlUVSo8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q5c8PfmBOy2mC1+DDsnG8Z05nPWQC9e+XyiHQ32eF09xk/Wn5Uo16qFqBet9fO+E2
         kS5wu8Nciq8ZdNf2p3XJvdRe3q6W+ZEvipbKZKLeWWMP4goFsTh98qKWJowASisK5c
         804mk2x0aJaYBKggV9sAJI3zALiqPyluK5JlehjK1IOefw5QexXVaLHcUgpJtIxAYE
         AXNUSzbRESJ4OimoaQVzkAwniCv3slKDuN9z2iAlpJdiH5FedxyY3pCnp4LQp7dZXR
         lG2/pzKiSGGVDObO94rozgppWRgFsqjAOGwRWZ+ODRrlDhADk0Gdc2NS2d0CtzMGML
         svfwJXoIuINmA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 565C160A6C;
        Tue, 31 Aug 2021 18:19:33 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1630327914.git.dsterba@suse.com>
References: <cover.1630327914.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1630327914.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-tag
X-PR-Tracked-Commit-Id: 0d977e0eba234e01a60bdde27314dc21374201b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87045e6546078dae215d1bd3b2bc82b3ada3ca77
Message-Id: <163043397334.24672.15965399120758473408.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 18:19:33 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 15:18:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87045e6546078dae215d1bd3b2bc82b3ada3ca77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
