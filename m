Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66865B36DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiIIMAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 08:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiIIL75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 07:59:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1EA5B78E;
        Fri,  9 Sep 2022 04:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33C4BB824FA;
        Fri,  9 Sep 2022 11:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC32CC4314A;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662724794;
        bh=3/JEam4qM1jugxxc3v3EGTIsl5vydUnBietiDQKtddI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H64aLc8nEmmeFVHjt4MiR+fJK9QOmkUxSLTdgd7oh7P6JRLcBL/4n/5HXh+jCXq8l
         7+j+nxZt0xnBCOG7yVm7Wshwr6oxlHYmaH+BCHnKZ7rXjF+vPw/OOPzYlHWr3j/jlL
         8nq6VQ6nDJ4+cMUOxgxZT0aAVB313D5yAd77Pe/E2Lda3jrU5Ve/PKcCERI25kzKRQ
         ATGsuJcgbysNNwwwm+iL3on7rY3IV0iph/F1fuWA1O+R2xworeMnk6TkGp0BNeemJ3
         13rR4pH2mKEaP7viIKrx0vDEjmkITzA93mCK70ph6DcJ4giX7qBwqoUYbESFdz7YJV
         DJhOqv7L9//8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D97C5C4166E;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1662664764.git.dsterba@suse.com>
References: <cover.1662664764.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1662664764.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc4-tag
X-PR-Tracked-Commit-Id: 5da431b71d4b9be3c8cf6786eff9e2d41a5f9f65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b4509495418a0effe964b0aad9a522be5a3b6d5
Message-Id: <166272479388.31182.10974639181232571511.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 11:59:53 +0000
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

The pull request you sent on Fri,  9 Sep 2022 11:06:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b4509495418a0effe964b0aad9a522be5a3b6d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
