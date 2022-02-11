Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505934B2274
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 10:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbiBKJvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 04:51:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiBKJvx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 04:51:53 -0500
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 01:51:52 PST
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 765B4E51
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 01:51:52 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 3A6F736758B;
        Fri, 11 Feb 2022 10:45:22 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: It's broke, Jim. BTRFS mounted read only after corruption errors on Samsung 980 Pro
Date:   Fri, 11 Feb 2022 10:45:18 +0100
Message-ID: <32904791.jyT166o8Jf@ananda>
In-Reply-To: <20210904233842.GD27656@hungrycats.org>
References: <9070016.RUGz74dYir@ananda> <10160891.dnzDEemO5X@ananda> <20210904233842.GD27656@hungrycats.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo Blaxell - 05.09.21, 01:38:42 CET:
> Also, regardless of kernel implementation, the hibernation procedure
> is extremely _invasive_.  It necessarily transports every process and
> significant chunks of kernel state to disk and back to memory, and has
> opportunities to corrupt data in transit or at rest.

Well, my hope was that hibernation would be a solved problem. At least 
on ThinkPad T14 AMD Gen 1 it isn't. At least not with the kernel I had 
in use back then.

I did not dare to test again, nowadays running 5.17-rc3. Cause if the 
price for a while test is corruption of BTRFS, I do not really look 
forward to it.

The only laptop where hibernation really works without any issues I 
currently have is a ThinkPad T520 (Intel Sandybridge). It also works on 
X260 and T560. However there starting with kernel 5.16 it does not 
automatically switch off after writing the hibernation image. With 5.15 
and prior it switched off except after the initial boot. It switched off 
automatically on the second hibernation cycle.

> > > Start a memory tester running (e.g. 'memtester' or '7z b 9999
> > > -md=xxM' where xx is large enough to allocate most of the free
> > > RAM), do hibernation and resume, and see if the memory tester
> > > reports failure after resume.
> > 
> > I may still do this. However I already run the UEFI Lenovo
> > Diagnostic
> > tool and had it do a memory test. It appears to be fine. I did the
> > quick test but then also ran a good part, but not all of a several
> > hour long test. No issues.
> 
> The environment might be different for a stand-alone memory tester
> compared to one that can run on Linux alongside a production workload.
> e.g. if a bus component is failing due to heat stress, that failure
> might not be triggered in the standalone case where the failing bus
> componenet is inactive, but will be triggered under a full system
> load where the failing component is active.  Similarly bugs in the
> Linux kernel itself, or interactions between kernel and firmware,
> will not be visible with a standalone test.
> 
> On the other hand, if the problem _is_ a RAM component failure, a
> standalone test will verify it's that and nothing else.

What I can say so far:

If I avoid hibernation, then all is fine. Starting with kernel 5.16 the 
Windows based deeper standby that usually worked with 5.15 and prior 
does not reliably work anymore, so I switched the BIOS back to using the 
one for Linux again.

Really would love to use hibernation again, but so it is.

At least I am pretty confident it is no BTRFS issue, cause I had no 
corruption issue again after avoiding hibernation. And hibernation with 
BTRFS works just fine on T520.

Best,
-- 
Martin


