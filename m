Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE95A3F0A
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Aug 2022 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiH1SSi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Aug 2022 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiH1SSd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Aug 2022 14:18:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3826AED;
        Sun, 28 Aug 2022 11:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C56FB80B8A;
        Sun, 28 Aug 2022 18:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3525C43470;
        Sun, 28 Aug 2022 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661710709;
        bh=DvYkl+ieyA4IhDG/sdFILB+gMm14s2VYDeuX4qdiN5k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pMkEBcKAoAO/52YWb29UpUuIythuqmm9x5fB3uf1Ut04KR9jP4KoZ6B1FZhkqch5D
         etnxtkPksDwHFMy6tv6kf9QSG2zSSZiaZsUFmR7n6UPJM4hNJl8dRUsbpy1xNfKk3e
         8/rwD5QiltWf9v+r91P1UxUTxsjI2jeJ71mC1t/OaYWFcFJkO7fAP+Ac9JIv2M7yh1
         PHaN5MY9usIegTYWYGlV/TUwNUDAiCLYgqm6nmaISSTV61VNsxvkPfEfd9S4gZTIzT
         ZhbOQSCaUZKUT5wxodUnMBauRlac9MJ32N8TwfAe6AJEfi1aVSpLcMnbLNwLCyjj3E
         UHP6iYdD+1e3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2A00C4166E;
        Sun, 28 Aug 2022 18:18:29 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1661690960.git.dsterba@suse.com>
References: <cover.1661690960.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1661690960.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc3-tag
X-PR-Tracked-Commit-Id: f2c3bec215694fb8bc0ef5010f2a758d1906fc2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8379c0b31fbc5d20946f617f8e2fe4791e6f58c1
Message-Id: <166171070979.6107.1251277983847921240.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Aug 2022 18:18:29 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sun, 28 Aug 2022 14:57:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8379c0b31fbc5d20946f617f8e2fe4791e6f58c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
