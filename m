Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA27F44F5CF
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 01:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhKNAqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Nov 2021 19:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhKNAqK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Nov 2021 19:46:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9821960F6E;
        Sun, 14 Nov 2021 00:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636850597;
        bh=kSQEnUJSy37aGANrQ0WdPrI9GiTPhxp3CH9jlHblAPo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t81FBQMT9zJaqYM4DVlFdGCyh6sbvtGes3NVDeMmoXbeqDi164d6XajAGsQ0fK8EO
         hfyFhNKirhXaqa0yr44VdyHdNZ9w89WXHV47MXn3W18Vz8nKk/hN/MtQhfcNeejJWb
         MmU7cGI1MU/jz8j9YgNx+5+IPlOTdbZO/FR2f8OuOwecSrvfsKK9/Zw6e8l5mG8MQu
         EZ9MaGj8mACg5OphZSz6ARieCBVkHEdF7ifinbTACHd09lrd9Yg/an8dz/7SHnMInd
         hyGHNCqkFL1MwD8zHsMkBJoK1veHfZyv9vWJejJyTaE/Q0u/hRZolTKwyznpro1qpo
         kDXJiqM3nSf9w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 785F9609E9;
        Sun, 14 Nov 2021 00:43:17 +0000 (UTC)
Subject: Re: [GIT PULL] zstd changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211109013058.22224-1-nickrterrell@gmail.com>
References: <20211109013058.22224-1-nickrterrell@gmail.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211109013058.22224-1-nickrterrell@gmail.com>
X-PR-Tracked-Remote: git@github.com:terrelln/linux.git tags/zstd-for-linus-v5.16
X-PR-Tracked-Commit-Id: 0a8ea235837cc39f27c45689930aa97ae91d5953
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8c109546a19613d323a319d0c921cb1f317e629
Message-Id: <163685059743.28431.13950472778417333186.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 00:43:17 +0000
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Jones <paul@pauljones.id.au>,
        Tom Seewald <tseewald@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Jean-Denis Girard <jd.girard@sysnux.pf>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pull request you sent on Mon,  8 Nov 2021 17:30:58 -0800:

> git@github.com:terrelln/linux.git tags/zstd-for-linus-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8c109546a19613d323a319d0c921cb1f317e629

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
