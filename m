Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C450E5771C0
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jul 2022 00:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiGPWKO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jul 2022 18:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiGPWKM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jul 2022 18:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FB01D0E0;
        Sat, 16 Jul 2022 15:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58C246130A;
        Sat, 16 Jul 2022 22:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1E10C34114;
        Sat, 16 Jul 2022 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658009410;
        bh=Bje2ilZrUR9lD6VMB27ouSShVhQoklmqL0Up7U5MZxw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K0YQPjeQADIAlPFOzTfft4MC7W1KZdVgtw7NhF+rnyOhJisZN0a2G1kEIBNVu2jGz
         JaLTZKqruTxSAD2vfZ2yKe6VXdFJrFjbJtOcPQRI83EZ7MH1wCXW42xwyaYuXKuqNo
         HxccrzOR/oXA5Nk+hpJeC64eQTPNH4huaVU09Qd/0GaA+ZxAT+3VTVsPWHGnBz0A+l
         V+sPYhXcFPrn2ITjTv5Hv3OQyzMUxcWwivtOa5mN8D0iB7pkIDGfzVHdQqG5FfgJNg
         eUfFl+Pz0hEZ9UDnu3oti3J3cWN5jjzwl1gw+x81Zvo+ptjdX+cxe7OCR2w1bmfnvR
         IffwRTl5mWsCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81C3BE45227;
        Sat, 16 Jul 2022 22:10:10 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1657976305.git.dsterba@suse.com>
References: <cover.1657976305.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1657976305.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc7-tag
X-PR-Tracked-Commit-Id: 088aea3b97e0ae5a2a86f5d142ad10fec8a1b80f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 972a278fe60c361eb8f37619f562f092e8786d7c
Message-Id: <165800941048.14726.9050276456572030018.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jul 2022 22:10:10 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Sat, 16 Jul 2022 16:06:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/972a278fe60c361eb8f37619f562f092e8786d7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
