Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FF619CCA9
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 00:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbgDBWLj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 18:11:39 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:32908 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgDBWLi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 18:11:38 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 32E6F9C424; Thu,  2 Apr 2020 23:11:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1585865497;
        bh=hVLh1CvauMBW/pikXwaFgxaftSfE1FeX1y/tFn5QBLo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Mqk4r0uX8LwphgXQrOFihTlph962iGMLHiHdX5zRrAZA4aI7a6bFtWy4w8ANyyX1m
         rJhWDB4tBEIlGW1GaWTxxNvIqPdduhm2Ya9XDLql7MqpikDYEPb430VRwwaHavu2Op
         PQfYRjVRBNt1LM1ffM7Ozwj1juBL2GT4rwdUV7iLOoa4XZL2j13RHarE/N3kfxtY2e
         L9Zi6tynxsylbJ/eaP3uyOFxipdwE/N0pI7yCIRoOpQm2nmfMHZJR7jmHxzX789kaN
         fQnc8DtpgrbTD54nBh0hCmvpo00M+xUmTGP9G2L6nbKL1QFzsxhMvCsDkfNc4xIJZT
         DsBKx2jk29eaQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 1CE629B92E;
        Thu,  2 Apr 2020 23:11:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1585865491;
        bh=hVLh1CvauMBW/pikXwaFgxaftSfE1FeX1y/tFn5QBLo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=gG0h0lX6or2vkFEo5M7cUW0oGxpRe1xe9xNYbiQO4j/EGhm96q11k3GpPkcF+uiWS
         G0fQP47ub7AhecjQmJKn07CyGouPvFEL+3LS24Cg79H1nJcqKShRRKCFph+TtfkfFi
         9nLDRGS8IeTEJMlS5UppL5AjNQgpJxkWzqLHUQW2hv0lPC76fW17M//ajQcaonHxCH
         cNAm4xIBqdZgoZWgQTmxPyzUhRrpFV+EWYN9W+JAuvLi407UjX39xKXo2asH2p8djk
         nUIxKIhAxzI11dKN1oX6JbFwc+c+h+hJrDh6kzuXapbX0jYSw9mqabTKTPwaiY4ZI/
         iWKyt5HMUTO6w==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 92815DF2FA;
        Thu,  2 Apr 2020 23:11:30 +0100 (BST)
Subject: Re: btrfs filesystem takes too long to mount, fails the first time it
 attempts during system boot
To:     Helper Son <helperson2000@gmail.com>, linux-btrfs@vger.kernel.org
References: <CANs+87QtdRhxx8gSsHzweMfbznJXLXRdn3SQDPd5uv-K-BZM=w@mail.gmail.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <58f96768-79cb-89c4-7335-0db1d2976b59@cobb.uk.net>
Date:   Thu, 2 Apr 2020 23:11:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CANs+87QtdRhxx8gSsHzweMfbznJXLXRdn3SQDPd5uv-K-BZM=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/04/2020 21:55, Helper Son wrote:
> Hello,
> 
> I'm running a fully updated Manjaro install on kernel
> 5.5.13-1-MANJARO, but this problem occurs on other kernel versions as
> well. I believe I tried 5.4 and 5.6.
> 
> I have a btrfs filesystem that looks like this:
> 
> Overall:
>     Device size:                  14.55TiB
...
> 
> When the system was at only a couple terabytes of usage, everything
> was fine. But, as it got progressively filled with more data, it
> started to take longer to mount during bootup. At one point it
> extrapolated the 90 second limit and the system failed to boot because
> of that; I then added nofail to the fstab entry so boot would continue
> while the system mounted.
> 
> However, even after taking around two minutes to mount, it still fails:

I see the same problem (I am running Debian Testing - Bullseye).

I *think* (I haven't bothered to test carefully) the problem is that
when the 90 second default mount timer runs out, systemd cancels the
mount.  The fix is simple: increase the systemd timeout for that mount.

In fstab, add the option: x-systemd.mount-timeout=N with N long enough
(I am using 180). More info is available (at least in my distribution)
in systemd.mount(5).

If anyone else is a Debian user, they may want to add a comment to my
bug report (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=955413)
asking for a warning to that effect to be added to the NEWS file for
btrfs-progs and the bullseye release notes.

