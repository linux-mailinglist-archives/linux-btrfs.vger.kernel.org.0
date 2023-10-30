Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8877DC353
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 01:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjJ3XuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbjJ3XuJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64257113;
        Mon, 30 Oct 2023 16:50:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AB44C116AE;
        Mon, 30 Oct 2023 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709805;
        bh=T+tIrmubtQ4Q0leyqIkdkvqxfLQ4+NsEiSIargOqyoQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pd9IZ7OBDkSRUAwfnBIgD6CpYgb613jvHMHgn6HFVcdWnAUAr67fpzvOJh0g381TH
         ivfN1ckukFvvOnwnYWN58ViOsz7PPLn6YQcpT9tv0L2QIDRg45fjb5ZKeq/vHLspDx
         OANjjz/S/gOkkWPVCheyTb18ivcplOz7le02Xdu4uONLqXe5GVp9kvxUbflUeqpW7h
         UFh6zw+GvivJ2TJfUiQLHxT98e9V0DIPy7g2fLEGG0gbisq5icgsQ/RG1M4i9ZHAjQ
         46bOh+MEU269X3iwQSgRH6JJouRejTsWHEAZGmsFfBF2Sj+gT3jyGApml8Cd1YMf71
         IhSCcH5jc71cQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4A04EAB08B;
        Mon, 30 Oct 2023 23:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1698679287.git.dsterba@suse.com>
References: <cover.1698679287.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1698679287.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-tag
X-PR-Tracked-Commit-Id: c6e8f898f56fae2cb5bc4396bec480f23cd8b066
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5acbc60fafbe0fc94c552ce916dd592cd4c6371
Message-Id: <169870980493.17163.17235191105576942473.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:04 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 18:35:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5acbc60fafbe0fc94c552ce916dd592cd4c6371

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
