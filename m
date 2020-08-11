Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA824215A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 22:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHKUkc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 16:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKUkc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 16:40:32 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1300C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 13:40:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m7so97838qki.12
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dallalba.com.ar; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=whZCHDIJ4YJscjqVBPfi7RfKyzMvNAzR4Cx6pA1Pmbo=;
        b=LuuTLdYx34zBWPfVR2xb5UHMlsx5zP5TTJ7ACShARQJahkm0ZxXKCjmQf+VLIimtRr
         snbEaGkrjAfnMAQKZO3mVtfRbfU1VSF90/qWBkK30VH0lBb5h7GhCayxR3F2RC4+hFtH
         syIUtZQVsU2k+fINSHhtEsc5b8g/1G3K8+RPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=whZCHDIJ4YJscjqVBPfi7RfKyzMvNAzR4Cx6pA1Pmbo=;
        b=sVgL5wMG21Fk13t4aokQa2qNreubpfnQK43Ij4iyea78PjQiHy+mgrkt+++83hKGtl
         39Jp2rjQLw+xLT2JqJqd5PFoZXoAAYEpykhVP+pxfi50KbtWnCW1kJJ/4iKbT9h7JDSk
         ej7Bdkc5mqTvfEbkG0QWAAGlw2WuVtkkJFyZCm3sIyU51ym1r+800uDnehOd8wDFSek5
         sCbTHi4mjcf422LjcYPRmFHPcidMTDNJzpN1y+vbOAKzvmecv7RYjZih6UmZVjES9Lwx
         klkR8ck2TyigQE/Xtb/lH9PBMB7EN+IWuHRItC9mIFT8bfWREl6INjXUcC2ON4oFSSa6
         9ctw==
X-Gm-Message-State: AOAM530aDcu/Arg1/ZOQRigSP3WGVT0igI/WhbyFTdwl+BCqDVpMWfBV
        CCk2kIJYqf+AcTJSxMg3sS89gwiJBA==
X-Google-Smtp-Source: ABdhPJzlvAs74EVJmGP40VVEuAFJGWs4IfThj16S8dRMlbFM9PKTaNhBfy1rmblT6nV81Uzed38ssQ==
X-Received: by 2002:a05:620a:c88:: with SMTP id q8mr2897847qki.49.1597178430969;
        Tue, 11 Aug 2020 13:40:30 -0700 (PDT)
Received: from atomica ([2803:9800:a011:8d29:c925:c91f:a66d:7fc])
        by smtp.gmail.com with ESMTPSA id g129sm19065902qkb.39.2020.08.11.13.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:40:30 -0700 (PDT)
Message-ID: <d46401cf4af5c6ebc7cc7ce584570bc901978151.camel@dallalba.com.ar>
Subject: Re: raid10 corruption while removing failing disk
From:   =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Tue, 11 Aug 2020 17:40:27 -0300
In-Reply-To: <CAJCQCtSdJVw5o2hJ3OyE6-nvM2xpx=nRHLVNSgf9ydD2O--vMQ@mail.gmail.com>
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
         <CAJCQCtReHKtyjHL2SXZXeZ4TwdXf-Ag2KysSS0Oan5ZDMzm8OQ@mail.gmail.com>
         <dc0bea2ee916ce4d1a53fe59869b7b7d8868f617.camel@dallalba.com.ar>
         <CAJCQCtSdJVw5o2hJ3OyE6-nvM2xpx=nRHLVNSgf9ydD2O--vMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2020-08-11 at 13:17 -0600, Chris Murphy wrote:
> That drive should have '/sys/block/sda/device/timeout' at least 120.
> Although I've seen folks on linux-raid@ suggest 180. I don't know what
> the actual maximum time for "deep recovery" these drives could have.

I'll do this. Is there any reason not to set _every_ drive to 180s? As
far as I can tell it doesn't really hurt to have the timeout be very
long when the drives do support SCT ERC and if I simply write an udev
rule that matches all disks I won't have to remember to do this again
in the future

> As the signal in a sector weakens, the reads get slower. You can
> freshen the signal simply by rewriting data. Btrfs doesn't ever do
> overwrites, but you can use 'btrfs balance' for this task. Once a year
> seems reasonable, or as you notice reads becoming slower. And use a
> filtered balance to avoid doing it all at once.

I suspect it's the head that's damaged, not the sectors. I forgot to
set the idle3 timer on this drive, which is a power saving "feature" of
WD greens, to something reasonable for years and in the meantime the
head has parked 1.7 million times. Keeping this in mind it sounds to me
like a bad idea to write to it.

> I only fully understood what you meant by this:
> > instead of `found BAB1746E wanted A8A48266` it prints `found 0000006E wanted 00000066`
> 
> once I re-read the first email that had the full 'btrfs check' output
> from the old version. And yeah I don't know why they're different now.

I looked at the code and I think it's just a presentation bug. In disk-
io.c:177 both `result` and `buf->data` are arrays of u8, while they
used to be casted to u32 in btrfs-progs v4.15. The memcmp checks the
full checksum anyway so there's no worries about btrfs check doing the
wrong thing.

> Ballpark 8 hours for --repair given metadata size and spinning drives.
> It'll add some time adding --init-extent-tree which... is decently
> likely to be needed here. So the gotcha is, see if --repair works, and
> it fixes some stuff but still needs extent tree repaired anyway. Now
> you have to do that and it could be another 8 hours. Or do you go with
> the heavy hammer right away to save time and do both at once? But the
> heavy hammer is riskier.
> 
> Whether repair or start over, you need to have the backup plus 2x for
> important stuff. To do the repair you need to be prepared for the
> possibility tihngs get worse. I'll argue strongly that it's a bug if
> things get worse (i.e. now you can't mount ro at all) but as a risk
> assessment, it has to be considered.

It's 16 hours I can run overnight vs 1 - 2 weeks of copying 4 TB of
non-essential data over the Internet at 100 Mbps. I think I'll make
sure there's two copies of the important stuff somewhere and take the
risk.

Is it worse to do the --repair while degraded? I'm sure the failing
drive will manage to ruin the day if leave it connected, as I said it
sometimes decides to hang forever.

Thanks a lot.

