Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39BE77A28D
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Aug 2023 22:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjHLUhg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Aug 2023 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjHLUhM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Aug 2023 16:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D93C100;
        Sat, 12 Aug 2023 13:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B06A862041;
        Sat, 12 Aug 2023 20:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 252A4C433C7;
        Sat, 12 Aug 2023 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691872634;
        bh=eemhlEJZbKIuZVdvPPdUCOBI8dkKOnUWms+8FT7QMS8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KAvsjV/XLGShc+1yut1kM7s9su6XRoZsT3AaCX7yxag1CQvHr8ewoFwifQPyu2nlJ
         jk73p3xHI/awdEFmmaXpJVNudvJDsye7FSs5P5nN9AF7FHuyEDBG1jvcTWMYQf+uo6
         zAP0RNpMmg+n8/0y9RzoQFVAWTyCvmUBDqjZdVNBxy7RaF1A2KmCyF4KXEWIDVHTCn
         RZXxLo039E51+YKaSMfbFQNMDrJNKsJ/nfLaNUNRzrSEStE0WG2wdQxD+UPQlpqJ+5
         wrXMy12kJKjZIUi5RsNx1ipIf10CDPY5FjTQBsreJhYrdTY0s3HV8fqyStEOY9HFpX
         z6wkluOI1F7CA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13B21E505D5;
        Sat, 12 Aug 2023 20:37:14 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1691865526.git.dsterba@suse.com>
References: <cover.1691865526.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1691865526.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc5-tag
X-PR-Tracked-Commit-Id: 92fb94b69c6accf1e49fff699640fa0ce03dc910
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a785fd28d31f76d50004712b6e0b409d5a8239d8
Message-Id: <169187263407.19328.9122190103310248250.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Aug 2023 20:37:14 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sat, 12 Aug 2023 21:13:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a785fd28d31f76d50004712b6e0b409d5a8239d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
