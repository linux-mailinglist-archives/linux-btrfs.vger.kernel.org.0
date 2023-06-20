Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D4773779E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 00:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjFTWxx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 18:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjFTWxv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 18:53:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AB81727;
        Tue, 20 Jun 2023 15:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B28FB611C3;
        Tue, 20 Jun 2023 22:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27617C433C8;
        Tue, 20 Jun 2023 22:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687301630;
        bh=3GovWlVnUEKFJalEl/cLazJQEZWiKwuBQ0LhfV1ZtkQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eSQg3dsF5RCglBUvFD2ai0jORI/U6SHO2+irH18+H0KPqvA3IPml5R96JGHD6Wb8o
         NC3vmryq/dQtKh7soijMLY55yrrsuEr+CWsSjzdMyapCofWy3cnf272CW1+cBXs51C
         tR53bKlsLiEvu/VOwKPlqLWUz6+pmsBKrKE0rY9ouulxSZ0hRCiG2J9vhimIcZp9rc
         KzWO9VIeUPAhMdIzQC45eIvrb1q/VmHMHCOjrcrBFJbpsaOz8PuDBJJdsXQ6roUCkp
         EALnYIGMOiX1EyslNkuh6gjmgc3PIONyTA/c4Fm5nFYTe+WwCU5XdL1NXPrapUWG+d
         iroUyLxH8pBPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 153CFC395D9;
        Tue, 20 Jun 2023 22:53:50 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.4-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1687283675.git.dsterba@suse.com>
References: <cover.1687283675.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1687283675.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc7-tag
X-PR-Tracked-Commit-Id: a7299a18a179a9713651fce9ad00972a633c14a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b0c7a1ba09386e26cf9e55cd375af8e0f48662e
Message-Id: <168730163007.29619.17305982572371973339.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Jun 2023 22:53:50 +0000
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

The pull request you sent on Tue, 20 Jun 2023 20:24:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b0c7a1ba09386e26cf9e55cd375af8e0f48662e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
