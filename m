Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A388E533530
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 04:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbiEYCQh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 22:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbiEYCQf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 22:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5454C19C09;
        Tue, 24 May 2022 19:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5CF261525;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54878C3411C;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653444993;
        bh=dfHMyOZnaARkoKk4YpvYbY/6wliduYj77zO1he9XM5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vR9l16ab8nKM2vp1s85K3P+vyg+lwKn9JoyDAETpyjpionbZKWQmxDfSZ7wbKG84g
         isudHDKr9DlDrtLDBHj9YC30177PHvzkIffLkM3LBYzXUqvlnrsygD2DomJzmW9CnC
         hxS7B1USUfaa3crbAAlYoIMR3NH01YtmBr+5qsnS8vj07mw/CV9J+xr0GKcIR/9kJv
         PUgMvxLISSZ6YxyV0b2qBMiL8T6HdKrFXxWunFjYHhS5/w2J/v+q4M42xL1ziHNfTi
         IqOgo759VsCU7vtODY8mgBGlqweKyR4GKkz+6tfUuWc2TDm98YaCT0UfC6ZoX+mQIH
         WZ/2dqW5W6l0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44B41E8DD61;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1653327652.git.dsterba@suse.com>
References: <cover.1653327652.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1653327652.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-tag
X-PR-Tracked-Commit-Id: 0a05fafe9def0d9f0fbef3dfc8094925af9e3185
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd1b7c1384ec15294ee45bf3add7b7036e146dad
Message-Id: <165344499327.22339.9929776118900178945.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 02:16:33 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 17:50:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd1b7c1384ec15294ee45bf3add7b7036e146dad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
