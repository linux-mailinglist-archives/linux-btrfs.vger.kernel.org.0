Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9677CFF15
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 18:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbjJSQJO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjJSQJN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 12:09:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A335C119;
        Thu, 19 Oct 2023 09:09:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B042C433C8;
        Thu, 19 Oct 2023 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697731752;
        bh=x1d7HrapiAXh/Tag7OTeOm/D+TYb3TqIZdXhliR6v0Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GZnpHsTka7nbHD6FudWrw9JE6e0Hap8FBJYKJWCcTZwvZAkKasQBw4OK+ncWMJcK/
         f10kxTfLUYdKKVEMN+9yqUQdVaa6xe0P+ZZPUZlAohDbcSM/KojMTx4FuEgUm/mVDA
         CYFefN2KDPBF0eUwWFBfzRwQrjjR+2hZon9bZN9ZLSDj+QGdW92j/QP3RCGKwuyNK3
         v/tzYDMcAoccDd7ILiZpng1gSI6CFbWDAoxgAp8dDtBTjjiVWlazmEM/p+BtrGTfrD
         UOFnAG/Lnt454HGxmMhOcufPGYP7+F7fpHIWU2DkAlXN/1MttvNbzy4ZZS1SAnLBHI
         qWafrAG1YB6gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3622BC04DD9;
        Thu, 19 Oct 2023 16:09:12 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1697555249.git.dsterba@suse.com>
References: <cover.1697555249.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1697555249.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc6-tag
X-PR-Tracked-Commit-Id: 8a540e990d7da36813cb71a4a422712bfba448a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cf4bea77ab60742c128c2ceb4b1b8078887b823
Message-Id: <169773175220.31060.12834433081282827720.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Oct 2023 16:09:12 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Tue, 17 Oct 2023 17:34:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cf4bea77ab60742c128c2ceb4b1b8078887b823

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
