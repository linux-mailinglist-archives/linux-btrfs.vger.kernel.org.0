Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0B3DBE1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 20:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhG3SLY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 14:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhG3SLX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 14:11:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 565F660F4A;
        Fri, 30 Jul 2021 18:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627668678;
        bh=4ZezLC63uVr6lHfiKHMKZR26pnrj8nKYI/r7OFxsTNw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k7RjuIDp3icl9WEuXWHZNMFLARtf/xZ6Co2U7ThxxjQQe8u9yaysIiaRdnsx6/uWx
         g/TuFRi0b/Nf6kNTES0hXJ93cQOXELvvxGsJ6zzNsY+ZohLKJw6N5BYtON9OvKrvKO
         dsw4HIJEDSVkDCXZYub2bdukTkivf9ExZANgDteNGK1vHDrGqz6hHf0oI2HFktKFqD
         SKuWEumqNJImIQmCZECKoQXwtlquNTGd8y5fyivX8B3DfJTews03xt7T1vXFMkBYLH
         JTYLh+LjpiJAup/z4wyY/5Wz+GctuGz6UnYqWKJxtXl1EDqk1DYD//Ce2ZcqA62mhr
         TTJsOKZtwScUg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 50E02609E4;
        Fri, 30 Jul 2021 18:11:18 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes fro 5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1627655635.git.dsterba@suse.com>
References: <cover.1627655635.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1627655635.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-rc3-tag
X-PR-Tracked-Commit-Id: 7280305eb57dd32735f795ed4ee679bf9854f9d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 051df241e44693dba8f4e1e74184237f55dd811d
Message-Id: <162766867832.11392.11005003505348647478.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jul 2021 18:11:18 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri, 30 Jul 2021 16:40:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/051df241e44693dba8f4e1e74184237f55dd811d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
