Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4DD2CD0CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbgLCIHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387399AbgLCIHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 03:07:12 -0500
X-Greylist: delayed 407 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Dec 2020 00:06:32 PST
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B17EC061A4D
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 00:06:32 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 5390C1937BC;
        Thu,  3 Dec 2020 08:59:41 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Jens Bauer <jens-lists@gpio.dk>
Subject: Re: How robust is BTRFS?
Date:   Thu, 03 Dec 2020 08:59:38 +0100
Message-ID: <7851285.T7Z3S40VBb@merkaba>
In-Reply-To: <20201203035311997396.38ae743f@gpio.dk>
References: <20201203035311997396.38ae743f@gpio.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Jens Bauer - 03.12.20, 03:53:11 CET:
> After correcting the problem, I got curious and listed the statistics
> for each partition. I had more than 100000 read/write errors PER DAY
> for 6 months. That's around 18 million read/write-errors, caused by
> drives turning on/off "randomly".
> 
> AND ALL MY FILES WERE INTACT.

Awesome! Really awesome!

I am running BTRFS on a ThinkPad T520 since at least 2014. After all 
these initial free space related issues went away with linux 4.5 or 4.6 
I had no issues with it anymore. In part I use BTRFS RAID 1 with an 
mSATA SSD on the laptop and it recovered from what I believe had been 
power loss related errors on the mSATA SSD twice already. Of course that 
is not anywhere near the dimension of errors the filesystem you have 
experienced.

I use it on my backup drives and I use it on my server VMs.

It works for me.

Best,
-- 
Martin


