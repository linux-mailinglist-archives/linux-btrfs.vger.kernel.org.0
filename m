Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB86608B6
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jan 2023 22:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbjAFVTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Jan 2023 16:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbjAFVTG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Jan 2023 16:19:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A282F52;
        Fri,  6 Jan 2023 13:19:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55997B81ECC;
        Fri,  6 Jan 2023 21:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA8B6C433EF;
        Fri,  6 Jan 2023 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673039941;
        bh=aTV7YFEGgB0PRzT7PEXTbnqQStpCxY32fKpJpiJ0lrA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vBBHgPPX/3cZPF3HdWbmi6bTttcpJaflhX/qR83piztz1c1/m4yKDyzCAxfOrt16X
         nLUTwfMm3fTLDBIrphMeKyNWhM4kIS/OGbPM0nNXBdFTYxX4wLRRplqWEQl39YJqQK
         ubu7t3gk7RBXFQy1YhjzKsenNeER1PuCRk27dCmxY7Cvn8RzGNal9GnfnbBzubBoAW
         6PdB/mSpDpe29v5QCworlfQ4+/4h85uPVLLTlwT+8LkapEP17lgJHkhMMvaxiphTK6
         OrvVPdzTkREoSVhS1gHE8pyTIuz/dYU8UVdourPcY0u8y0sf9UUfMxOKWWewgO7buV
         sLl+SdSKqMMiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5B25E57254;
        Fri,  6 Jan 2023 21:19:00 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.2-rc3, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1672944066.git.dsterba@suse.com>
References: <cover.1672944066.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1672944066.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc2-tag
X-PR-Tracked-Commit-Id: 2ba48b20049b5a76f34a85f853c9496d1b10533a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc7b76c4a4d139ebcae2af3bd75215fc90834e3b
Message-Id: <167303994087.10294.8896725754802818777.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Jan 2023 21:19:00 +0000
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

The pull request you sent on Fri,  6 Jan 2023 15:38:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc7b76c4a4d139ebcae2af3bd75215fc90834e3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
