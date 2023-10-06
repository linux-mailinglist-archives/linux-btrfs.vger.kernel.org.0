Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94067BBB8B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjJFPPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 11:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjJFPPf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 11:15:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1421683;
        Fri,  6 Oct 2023 08:15:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF011C433C8;
        Fri,  6 Oct 2023 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696605333;
        bh=9ezRekxN6YU5tq4ZWLRrIprd5Geouc2TkH7vBEELh/I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oid85xCCoUQaMbQuqU8144moMzrJXb3UIguitycE8jNhvD9DF0S1wtpGaD+89kHP9
         O+fl6fQJ52N3KjEV+tZuKng7HBQkMsc+2MRSKqtmMA/SXStZmbVhqzaBgScJucGe5+
         OcmevPFZUrXQTokgBNYupg0uyw4HinV9414aqeeKfuNnALXfo099nylROE7rUEiwX4
         baK3jecbfPzWTXJ7VzuMbIe3/4goChNwQ0Ab5MVoDGnag0fBtPVra5zU5wortx0rkU
         f1zDHdyb9zrnLS48vEXMmlQ+IqXAbV7U9/Sdl4donbCthFDj+Nda0eKdOPfbZbweil
         qKykTVdGQNVNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DAA8E632D2;
        Fri,  6 Oct 2023 15:15:33 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1696529195.git.dsterba@suse.com>
References: <cover.1696529195.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1696529195.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc4-tag
X-PR-Tracked-Commit-Id: e36f94914021e58ee88a8856c7fdf35adf9c7ee1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7de25c855b63453826ef678420831f98331d85fd
Message-Id: <169660533364.6239.8858441122653358446.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Oct 2023 15:15:33 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Fri,  6 Oct 2023 15:27:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7de25c855b63453826ef678420831f98331d85fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
