Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC864692F68
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 09:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBKIia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Feb 2023 03:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBKIi3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Feb 2023 03:38:29 -0500
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC15EA08
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 00:38:22 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 118AD5EDBF2;
        Sat, 11 Feb 2023 09:38:19 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     waxhead@dirtcellar.net
Subject: Re: Never balance metadata?
Date:   Sat, 11 Feb 2023 09:38:18 +0100
Message-ID: <1755726.VLH7GnMWUR@lichtvoll.de>
In-Reply-To: <ad4de975-3d5f-4dbb-45a5-795626c53c61@dirtcellar.net>
References: <ad4de975-3d5f-4dbb-45a5-795626c53c61@dirtcellar.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

waxhead - 11.02.23, 02:36:26 CET:
> I have read several places, including on this mailing list that
> metadata is not supposed to be balanced unless converting between
> profiles.
> 
> Interestingly enough there is nothing mentioned about this in the
> docs... https://btrfs.readthedocs.io/en/latest/btrfs-balance.html
> 
> Should one still NOT balance metadata? If so - please update the docs
> with a explanation to why one should not do that.

If that is still the case, it may also be good to by default omit 
metadata on a balance without parameters.

A long, long time ago I experienced a much longer boot time after a 
balance, I decided to refrain from balancing my BTRFS file systems. 
Especially as long as there is still unallocated space on them. Cause as 
long as BTRFS can still allocate a chunk, I thought that is fine. I 
thought I would be getting a faster system, but it was much much slower. 
That was on a SATA SSD. 

An additional reason for not, or at least not regularly balancing for me 
is avoiding needless writes to flash storage like SATA or NVMe SSDs. 
Usually they can take it, but why age them more than needed?

Maybe all or some of this is not accurate anymore and one should balance 
BTRFS regularly like default in SUSE distributions, maybe regular 
balancing even reduces writes on other occasions, however I never fully 
understood the performance impact of a regular balance. However in a 
virtual environment with lots of virtual machines it may not be best to 
start balance on a lot of them at same or similar times either, 
considering the load it creates for the underlying storage.

I know balancing not the same as defragmenting files in other filesystems, 
but I still remember the strong warnings of XFS developers not to ever 
just defragment a XFS filesystem just cause you feel like it. The 
reasoning behind these warnings was that defragmenting files tends to 
fragment free space. But balancing actually defragments free space as 
far as I understood and thus is different.

Anyway, I am keen to read on more insight on this from people who 
understand better what impact a BTRFS balance really has.

Thanks,
-- 
Martin


