Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109536FCC5F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjEIRIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjEIRIA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 13:08:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C617959E7;
        Tue,  9 May 2023 10:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB54B64768;
        Tue,  9 May 2023 17:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DE7FC4339E;
        Tue,  9 May 2023 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683651885;
        bh=E3+K58qU414bRsnbd15n0OCOfU/IdaXFKVzoQ8rHz/Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ConwubS8n7VUfAZhpEsWdYrv5FZNtjEcpCnRI2dMUQQzIf7mfF2C3J5QMeHzxR29u
         vj4pxvVI5Xd825toniHrINiAR5dVnaDfIJnVsiRcKmxT6hoB8s0iED/OIrsNukMjaA
         LTKi7/8kxcv1IIPtw3n4iAYNjCoVQz3zXr1ELnv4imAmIux7ji1GMGSZ1GG9HIVQmS
         +l3Qnj6JCj4aDOXJe9MMs6nVTjJQOeYdREa4hiJCdM8jkh2lL8wNZ/W5eaHFG6hiDS
         /s7gn2pfDAWol3qeCu6wBsyEDHXhLEgUtov84yccOqNjSyinFmtvZ6+9/cZq1gAQDk
         147rhltIFz3Iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08636E26D23;
        Tue,  9 May 2023 17:04:45 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1683645063.git.dsterba@suse.com>
References: <cover.1683645063.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1683645063.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc1-tag
X-PR-Tracked-Commit-Id: d246331b78cbef86237f9c22389205bc9b4e1cc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dc3731daf1f350cfd631b5559aac865ab2fbb4c
Message-Id: <168365188502.31493.12802949372404519924.pr-tracker-bot@kernel.org>
Date:   Tue, 09 May 2023 17:04:45 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue,  9 May 2023 18:02:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dc3731daf1f350cfd631b5559aac865ab2fbb4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
