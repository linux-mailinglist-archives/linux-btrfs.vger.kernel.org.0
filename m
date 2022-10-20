Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C31606242
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJTNxg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 09:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJTNxd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 09:53:33 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6218C5B70C
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 06:53:27 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 9E29E5A2366; Thu, 20 Oct 2022 09:53:10 -0400 (EDT)
Date:   Thu, 20 Oct 2022 09:53:10 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Endless "reclaiming chunk"/"relocating block group"
Message-ID: <Y1FSxogPeNIUfyVn@hungrycats.org>
References: <1666204197@msgid.manchmal.in-ulm.de>
 <Y1Crh/Cz2rcbIayw@hungrycats.org>
 <1666262200@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666262200@msgid.manchmal.in-ulm.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 20, 2022 at 01:01:48PM +0200, Christoph Biedl wrote:
> Thanks for add the toughts shared ...
> 
> Zygo Blaxell wrote...
> 
> (...)
> > It makes me think of possible rounding errors (e.g. the threshold
> > calculation divides by 100, or there's a sum of quantities that leads
> > to a percentage > 100, but the code treats zero as a special case and
> > bails out long before, so I don't see how we'd reach those corner cases.
> 
> Out of desperation, I followed an approach I could read between the lines
> here. The thing I did not mention (just because I forgot about it) is
> the compiler version used to build the kernel. For reasons, this is
> still a gcc-5 (5.4.0, to be precise). After a rebuild using gcc-11,
> things are nice and smooth.

That's...not the weirdest thing I've ever seen, but maybe the weirdest
thing I've seen this month.

> Now I cannot deny I'm quite confused. Assuming this is really the cause,
> how should I go from here? I can patch the sources at will, but it's a
> huge amount of code, and I don't even know where is start. Also from
> expericence, debug print statements do bar the optimizer from creating
> the problematic instructions.

That in itself would (weakly) confirm a compiler issue.  But it might
be simpler than that, like a bug in the implementation of a math builtin
that wasn't popular in the kernel 8 years ago, but is popular now after
the implementation was debugged in GCC.  I don't know if that's the case
in this instance, but similar things have happened in the past.

>     Christoph
> 
> FWIW, according to Documentation/process/changes.rst, that old gcc-5 is
> considered sufficient. I didn't expect that :)

On paper maybe, but maybe not in real-world use.  Somewhat related thread
on linux-kernel:

	https://lore.kernel.org/all/Y0hz3u8ZNO2yFU2f@sirena.org.uk/T/

TL;DR not enough people are testing new kernel code against old compilers.
If it's problematic to keep the host system's gcc up to date, a build
chroot for kernel building with an up to date toolchain is the way to go.
