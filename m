Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B5667DD20
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 06:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjA0FgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 00:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0FgE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 00:36:04 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AAA46D48;
        Thu, 26 Jan 2023 21:36:03 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x26so1861938qkj.4;
        Thu, 26 Jan 2023 21:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OrbhxDljA7pofoDZLQ8+ctV2VLccAZizxJoTKGIdHlI=;
        b=IgBtvIuRfHldaNygLhEAmOZ9nQY14FlO3CRcB5W6td+P90sJCDjX1Lzz3VJbXQy+C7
         1pSpenVD+kEBrI9svCD/1Rb779PMKD+JFKSeGB6BkJZYa/oCPiRqI0YTnkQkGXC6Z+hN
         /L8RSC7d7/wa3jug33EXSdEnKXF1aeQU2xuFFXpgG6BKyoO2LjWsAPCc1Jo/SwU4LJiY
         na0X9yMOLpcUXfyvaixgIn4mdiNzAhlqpYY1dTO0EgQ6Hv7n0DlIf6BVf/Xd1fDmd9cs
         ejmoT1r4MU2jyAj/h8+1t3YNHjOJyGohkD2TPbh6ytzABBLUuv3y4TF3b5fF3u9+2/oP
         pTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrbhxDljA7pofoDZLQ8+ctV2VLccAZizxJoTKGIdHlI=;
        b=JPGn2AnZ204hcKzmxi1OCd0Q3qmYoXIxKxgF526U/XkpQUsb8MQ2WD0iZEhHnOk/wd
         aJ9vC9OepzcH9qhOEPIUjeGYsKztWnf+TZbK822R1ZO1nVFzj2ammiUtXZiX8UyWVF0w
         oWlol4MRKMCLhumwgfQoe1K5aHDOxRGPHeW1w2kWBAfOU+mXEGZ8wgEmzpyR0Hf2/JCw
         ABGm6KQIi9UFkoFn0EkYmoltVYBQRNFdz8ZqX40H0DPbrvhfxhgpS/PcbmCjucQKL6Ez
         92S4tcAf8Va+MLbqQBC/QT824PXmK3LBSyYTpTTBbqMZHF3eepwI2st3OMFCa29zKMFO
         SJ9A==
X-Gm-Message-State: AFqh2kogMjQlcS1W9vPECI5mFdhZJQ3KpjwvWHr8yLT04Jr8jeMyNNcR
        eo2bRv+LyngRO1rxxru25Mbch4brWhHQTPssSgk=
X-Google-Smtp-Source: AMrXdXsgwVeLFLDjD7X7ZFoMFXRc2M1F1eFpuydvYpQOzzOwCXP5hrBRJcwv5wQrbWC5QRrDXLb5YwAiALHd5Q6zEy0=
X-Received: by 2002:a05:620a:5371:b0:6fe:e6c3:2d3e with SMTP id
 op49-20020a05620a537100b006fee6c32d3emr2215285qkn.365.1674797762204; Thu, 26
 Jan 2023 21:36:02 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz> <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz> <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux> <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
 <a8992f62-06e6-b183-3ab5-8118343efb3f@redhat.com> <7e48c1ec-c653-484e-88fb-69f3deb40b1d@app.fastmail.com>
 <Y9NN9CFWc40oxmzP@boqun-archlinux>
In-Reply-To: <Y9NN9CFWc40oxmzP@boqun-archlinux>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 27 Jan 2023 10:35:51 +0500
Message-ID: <CABXGCsNmQEyvPxL0-BT4Cz0xGuawQz1TjtbbOSjDqvV_H=Z6ew@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Waiman Long <longman@redhat.com>,
        David Sterba <dsterba@suse.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 27, 2023 at 9:08 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Thu, Jan 26, 2023 at 10:37:56PM -0500, Chris Murphy wrote:
> >
> >
> > On Thu, Jan 26, 2023, at 7:20 PM, Waiman Long wrote:
> > > On 1/26/23 17:42, Mikhail Gavrilov wrote:
> > >>> I'm not sure whether these options are better than just increasing the
> > >>> number, maybe to unblock your ASAP, you can try make it 30 and make sure
> > >>> you have large enough memory to test.
> > >> About just to increase the LOCKDEP_CHAINS_BITS by 1. Where should this
> > >> be done? In vanilla kernel on kernel.org? In a specific distribution?
> > >> or the user must rebuild the kernel himself? Maybe increase
> > >> LOCKDEP_CHAINS_BITS by 1 is most reliable solution, but it difficult
> > >> to distribute to end users because the meaning of using packaged
> > >> distributions is lost (user should change LOCKDEP_CHAINS_BITS in
> > >> config and rebuild the kernel by yourself).
> > >
> > > Note that lockdep is typically only enabled in a debug kernel shipped by
> > > a distro because of the high performance overhead. The non-debug kernel
> > > doesn't have lockdep enabled. When LOCKDEP_CHAINS_BITS isn't big enough
> > > when testing on the debug kernel, you can file a ticket to the distro
> > > asking for an increase in CONFIG_LOCKDEP_CHAIN_BITS. Or you can build
> > > your own debug kernel with a bigger CONFIG_LOCKDEP_CHAIN_BITS.
> >
> > Fedora bumped CONFIG_LOCKDEP_CHAINS_BITS=17 to 18 just 6 months ago for debug kernels.
> > https://gitlab.com/cki-project/kernel-ark/-/merge_requests/1921
> >
> > If 19 the recommended value I don't mind sending an MR for it. But if
> > the idea is we're going to be back here talking about bumping it to 20
> > in six months, I'd like to avoid that.
> >
>
> How about a boot parameter then?

I would like this option.
This is better than rebuilding the kernel yourself and asking the
distribution's maintainers to increase this value.

Thanks.

-- 
Best Regards,
Mike Gavrilov.
