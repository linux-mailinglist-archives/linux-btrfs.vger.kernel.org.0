Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1F6613E82
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 20:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJaTn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJaTnx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 15:43:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E80D13F3F;
        Mon, 31 Oct 2022 12:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA84561451;
        Mon, 31 Oct 2022 19:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BF42C433D7;
        Mon, 31 Oct 2022 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667245431;
        bh=aW4DABoCaJJzBN+Vzrru9ThjdxNP2EIYYsCHkhC4vxs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CnW72KrWblwTLBKbjOxMi3MuqOPBGdLGt/NEUhAmLeGhr8fhTImILkcuN2e3mYGwu
         jDMXB7yXxcgNqbJm+S8dI1zvKqupmktXO9Rmc77als4fx0UbCNvXog3ywFt82P4Asj
         w4OnzN4Y4xCeWJuuX9/K3zINoTiNqpHhxy/gVBcm8CdboPjohIQ0bwhJuy1a79dQY8
         hGAJmZ1gDI7QVC9bUB/DpIEm6wf8IB/4MGTJRjeTsQgR3cauqHRQ492T5LU1RNGUhX
         PCHuduAR6f5pnPqD+asTkv+XivzknX/QOcbr+Z4L7lU4Zv8sm/J8MZpxnuXYZA1A+V
         j/UK7spHHZGVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 382CCC41621;
        Mon, 31 Oct 2022 19:43:51 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1667223120.git.dsterba@suse.com>
References: <cover.1667223120.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1667223120.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc3-tag
X-PR-Tracked-Commit-Id: 76a66ba101329316a5d7f4275070be22eb85fdf2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5aaef24b5c6d4246b2cac1be949869fa36577737
Message-Id: <166724543122.6677.4957962711371870169.pr-tracker-bot@kernel.org>
Date:   Mon, 31 Oct 2022 19:43:51 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 31 Oct 2022 15:00:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5aaef24b5c6d4246b2cac1be949869fa36577737

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
