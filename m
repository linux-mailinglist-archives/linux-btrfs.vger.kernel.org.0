Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE456EF8F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjDZRGs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDZRGf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 13:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC9B7A98;
        Wed, 26 Apr 2023 10:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C5D7635EA;
        Wed, 26 Apr 2023 17:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72002C433EF;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682528793;
        bh=3JVsHNV4DJB/c8wwYh2xGd8WIfqBkwSXOjm5ynOAvvg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T/3EqxnQRyU+JSf2Hu6yx5Zd4SwEgF7P2QNzjswvj6ZPAGJAsqJzrFm+jOoNcDuGV
         eTuob8yg/PddQuvW6FeSBwO2gEKwmGWPgPTMMib3IzVUwWFUvkrjzjBYESHftyaTJg
         EtfXmo0yugAoBfFFk3UzQgaO3qknz7LvAQwF1B/PDPULb/5/RZ/xAGKS90WyiBqcjT
         kGAxhDZS4GknsCvCOfjcRJ/No7pKwmyOnkcvk5lXJJevFDnc7ooq6KPWSRKFUazdbG
         w7l/otreE6kUFpVYZz/3vgEnMDusJR91D1EDm3cTx49e9fJ2GflBn9n0Pp7NwIZVo+
         EVSksKv7oWWmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6268AC43158;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1682378675.git.dsterba@suse.com>
References: <cover.1682378675.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1682378675.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-tag
X-PR-Tracked-Commit-Id: f372463124df5f980de6ee0cd6000a3e43df0e01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85d7ab2463822a4ab096c0b7b59feec962552572
Message-Id: <168252879339.19907.13492399842815040668.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 17:06:33 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 16:51:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85d7ab2463822a4ab096c0b7b59feec962552572

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
