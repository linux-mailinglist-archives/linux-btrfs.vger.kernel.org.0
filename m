Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C97E478049
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 00:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbhLPXF1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 18:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbhLPXFY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 18:05:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04423C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 15:05:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF4E1B82652
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 23:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7759AC36AE2;
        Thu, 16 Dec 2021 23:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639695921;
        bh=TpphQkCdCieuX1alL9mi5OJYjQk80syR0Y4VelgalcQ=;
        h=Date:From:To:Subject:From;
        b=jnJpytfUGLh7wWJluDO86Z1DZuJBRXx6ti/LyFbQl6LJfpPVp6mm1Mcf4JIp2MidD
         JghY5RCQ16JA8EB94B1eVluD9qtY7EacbVjqfFi2bkESVlU7pZ7+5PX5PSEHfI7MY9
         1eVFPf98TwJAvFJeTY14x0nb5SPzxSP1Ft4BDVPvYpZUK5LUdtzW4wB/m+tTZ+jZX+
         dolPBgC3UYEiQ7fPeSvX4g/XtrTG8vc0sOcYuKAneVIlmZLqrb1qVBttV7ewhcOL3o
         5YaxTf1pcGna0FCKO8X2Mrgq8Cjoo1H01f33EWU1YCC456BQhWuWEuIliXpG5K8xfR
         QfQ1Ha4Y2nZgw==
Date:   Fri, 17 Dec 2021 00:05:15 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de
Subject: U-Boot btrfs implementation - will there by syncing?
Message-ID: <20211217000515.0e087027@thinkpad>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu and others,

one of the points of Qu's reimplementation of U-Boot's btrfs code that
made it somehow synced with btrfs-progs, was that the old
implementation was, quote

  pretty different from btrfs-progs nor kernel, making it pretty hard to
  sync code between different projects

Another point was that afterwards Qu wanted to bring some of the missing
btrfs features into U-Boot, since they should be much easier to
implement after the reimplementation.

I was looking at current btrfs-progs, and noticed that there were many
changes since then, but only one or two were ever synced to U-Boot.

I would like to know if Qu, or anyone else, is planning to do this
code-syncing, and maybe implement some of the missing features?

The reason I am asking this is that in the meantime I've reached the
opinion that the idea of code-syncing in this sense almost never really
works. It is usually proposed by one person who ports the code from
another project, and then keeps it synced for a time, but then stops
doing it because they have too much other work, or change employer, or
another reason.

It happened multiple times. One example is U-Boot's Hush shell, which
was imported from busybox, with the intention to keep it in sync, but
the reality is that U-Boot's implementation is now years (decade?) old,
and there were so many ad-hoc fixes done in U-Boot that currently the
only way to sync is basically to change the whole code (which will also
cause issues with existing user scripts, but maybe it should be done
anyway).

Another reason why I am writing this is that I think that with the
amount of work Qu put into that reimplementation last year, he could
have instead implemented some of the new features in the old
implementation and spend a similar amount of time doing that, and the
result would be those new features in U-Boot for over a year by now.

Also, I've come to the opinion that maybe two different and maintained
implementations are a good thing for such a project as a filesystem,
similar to how multiple implementations of C/C++ compiler are a good
thing.

For the last few months I was on-and-off thinking about whether it
would make sense to revert to the original implementation and then
implement some of the missing features. But it would not make sense if
Qu, or anyone else, is planning to do that code syncing and bringing of
new features from btrfs-progs, so that's why I am asking.

Please give your opinions, people.

Thanks.

Marek
