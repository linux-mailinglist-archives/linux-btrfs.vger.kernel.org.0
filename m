Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1D6501B78
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 21:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbiDNTBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 15:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344815AbiDNTBa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 15:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DD3E887B;
        Thu, 14 Apr 2022 11:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24F9A61AE4;
        Thu, 14 Apr 2022 18:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AEE8C385A9;
        Thu, 14 Apr 2022 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649962744;
        bh=cGeSw59Fv7JJDhyg+1pXh9iLfGBu4RQKPA3b4RX+TOI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y4eokNXHsEpDDAVoJJAQYaQnOT4OJKEB+Tlhgh57zJkwuFnhdnClmP70fuSslWJIx
         k2DMbGRaQL3jq6j0y7FUTIkRoonXG8K7jaMYq17+Nt6eEH2yBdf9WGTM4mU3ovLEv1
         xTqWI0UyspZqWaH8pslErRGfpRmwrIT9xLQftp9eHK5IUpRuEoC1A1O1sqw0eez+Uh
         CDtP6yOM2FOCkbld6FHWqkJ2AnMcuuqBwFX+JSzRXHY6/mAEM12Y0o1cDZrtbq+8kY
         umo0GrptincA4WFIMFJ+WBmU9mZ5iz7C63UxJfEJgWq6lw/ZZqK4ga+8WQ3LH+bejb
         hn/CuG1dR6MLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77FD7E8DBD4;
        Thu, 14 Apr 2022 18:59:04 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1649705056.git.dsterba@suse.com>
References: <cover.1649705056.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1649705056.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc2-tag
X-PR-Tracked-Commit-Id: acee08aaf6d158d03668dc82b0a0eef41100531b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 722985e2f6ec9127064771ba526578ea8275834d
Message-Id: <164996274448.15440.11784724442404556147.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Apr 2022 18:59:04 +0000
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

The pull request you sent on Mon, 11 Apr 2022 23:31:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/722985e2f6ec9127064771ba526578ea8275834d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
