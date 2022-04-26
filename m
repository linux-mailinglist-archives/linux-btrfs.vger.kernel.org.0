Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146335108B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 21:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiDZTLF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 15:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354008AbiDZTKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 15:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C63526B;
        Tue, 26 Apr 2022 12:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EFC1B8224C;
        Tue, 26 Apr 2022 19:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4A42C385A0;
        Tue, 26 Apr 2022 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651000018;
        bh=NQQlPsGNGqRgOpMwlAgsLiwkrv/by9GcDK6NktJhn0c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hGsQJUHACryQtgK1knTFR+AaFa3arqbkwFiskEAI88C16Nyh6wZFCw7p1yvjmC3mQ
         1VZ21nazDnAef920/jpdNSjuQ4IlqnvwM4ZLB2OBMEu5mi7F9SbZMmkeZflfBhloxz
         ccRKnRbVrugM9f3Wm9MhXr+KYiEuT47uBL6e3qMAvoLNaXScBuvW2bK/SSX6/gbtnB
         kwV8UvbjfDFrCrlFbs9vvRlPqjIrZ2vQ02xp3ExRxcrCW90fH6dgjEpiNJYuxVYaO5
         tZe79ShTuxHWPMgY2hFA94NPrWbp9HsMDjXEWCD1JW2GJLCe1JyDnLm5oAMdnF/sKZ
         sUUZ0z2uk1i8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D09BBE8DD85;
        Tue, 26 Apr 2022 19:06:58 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1650923679.git.dsterba@suse.com>
References: <cover.1650923679.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1650923679.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc4-tag
X-PR-Tracked-Commit-Id: 5f0addf7b89085f8e0a2593faa419d6111612b9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd574a2f841c8f07b20e5b55391e0af5d39d82ff
Message-Id: <165100001884.21339.7646463642564667021.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Apr 2022 19:06:58 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 26 Apr 2022 14:46:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd574a2f841c8f07b20e5b55391e0af5d39d82ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
