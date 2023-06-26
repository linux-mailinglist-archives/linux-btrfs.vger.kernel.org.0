Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C798F73EB95
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 22:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFZUGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 16:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFZUGA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 16:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68B11987;
        Mon, 26 Jun 2023 13:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EEA560FB7;
        Mon, 26 Jun 2023 20:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5BBEC433CA;
        Mon, 26 Jun 2023 20:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687809765;
        bh=pR5uYHKuBMIQ6AErHECeqCYmgFJfy36bD9p/7SIgvuM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yiii9ncUZ4+4lo9RKaPl8uJgg6VGdDZTemwJhQ5HJenzl/29FZlOJKaTfI76kB5G5
         A26PUmUhQt6oKUlI7MznAu6UwOnU/OYZGVJB7vm+per4v6MTqnwwsHzyywIgUcoj/e
         JqBrSra80KR9k/hKDJ7QV+sVS34xlsD7if+3RHDfqIcu80qmVUcIsAZ9LEn2qLP+2w
         MZZ0sArfh1oDqqNL0SodTk6GFO0whC/ZPP0bKEArIobycp36eWzZlynEAdf/V4UtpI
         UEYxJQqI5MRkThvcR57RCP8Ql2aQUzqaT90KS5XbZOPptZiXGwGGOE3B55NlpeZ/yF
         pR9BsJcRq7SZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5579E537FE;
        Mon, 26 Jun 2023 20:02:45 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1687802358.git.dsterba@suse.com>
References: <cover.1687802358.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1687802358.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.5
X-PR-Tracked-Commit-Id: 8a4a0b2a3eaf75ca8854f856ef29690c12b2f531
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc423f6337d0a5ff1906f3b3d465d28c0d1705f6
Message-Id: <168780976573.7651.10316510860564213650.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 20:02:45 +0000
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

The pull request you sent on Mon, 26 Jun 2023 20:14:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc423f6337d0a5ff1906f3b3d465d28c0d1705f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
