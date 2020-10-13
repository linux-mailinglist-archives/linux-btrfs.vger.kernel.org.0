Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E76128D22F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbgJMQYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 12:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389679AbgJMQYE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 12:24:04 -0400
Subject: Re: [GIT PULL] Btrfs updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602606244;
        bh=KWAzpjmi9l7B0c4W5/JaRhuvdkK4DnAmvRgfkjSSJm8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hSOLxh093RVv+JyWQTgNOj31ryVZWyhutkTh2g/MgU/DU8PwrrlRFfi6OazXKU21R
         2MFCDxzOyYc0jy85HsmPzKR5rSBeJzBdGcKTSF1gqu6SAZGEoCdWQ2cwt631ulngj9
         YG0YwZbPOK0svrDwnB7DG/uYiP6dIB/WXBw0uBgs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1602519695.git.dsterba@suse.com>
References: <cover.1602519695.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1602519695.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.10-tag
X-PR-Tracked-Commit-Id: 1fd4033dd011a3525bacddf37ab9eac425d25c4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11e3235b4399f7e626caa791a68a0ea8337f6683
Message-Id: <160260624422.24492.10394506834366879321.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 16:24:04 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 22:25:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.10-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11e3235b4399f7e626caa791a68a0ea8337f6683

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
