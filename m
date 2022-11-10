Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD36247DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 18:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKJRDg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 12:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiKJRDa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 12:03:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79992AF8;
        Thu, 10 Nov 2022 09:03:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5218861CF1;
        Thu, 10 Nov 2022 17:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5181C4347C;
        Thu, 10 Nov 2022 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668099808;
        bh=XDBQq4iMPx3EWKk4RatZOGhk85s2C+Zlo+0tcRjFxKo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EaW4FKKsNjr1M/pWUvhkw7ICdYzfRqZc2qDJXbS0Tr5dVRb2iZA8XN/oM7f+Agkwb
         vBi8TO2VjlSgkJHHVXwEcbg5s4jQWa2xLgQXOLOfVEkKVKHRNyXBsJr2uRHiO5XHBp
         MANMjJ1fmW399Fxnh10obdpQ2WJf3TnEoQv05KETqXcoOSecjqFsmxCFkjqVr5CVBZ
         VsOGmdaR/XdqGgY39daxF13NMDgyXQugbhuPXvjQr0HneTsrPI1H3pThqJ8azI22Z9
         3Hz+OSkCrPQqow89TUlvj0df3R/9nvIIhy0Ebw9sjTfG1/EjGyi9A5HbkoIS6X9gS+
         cgGMA/IyzGKlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A35B6C395F8;
        Thu, 10 Nov 2022 17:03:28 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1668091779.git.dsterba@suse.com>
References: <cover.1668091779.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1668091779.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc4-tag
X-PR-Tracked-Commit-Id: c62f6bec53e63b11112e1ebce6bbaa39ce6f6706
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1767a722a708f1fa3b9af39eb091d79101f8c086
Message-Id: <166809980866.1852.9645201957289290945.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Nov 2022 17:03:28 +0000
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

The pull request you sent on Thu, 10 Nov 2022 16:29:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1767a722a708f1fa3b9af39eb091d79101f8c086

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
