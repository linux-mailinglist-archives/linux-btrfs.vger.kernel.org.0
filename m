Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD53E4B1954
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 00:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbiBJXUw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 18:20:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345604AbiBJXUv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 18:20:51 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E19B5F59
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 15:20:51 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y6so20018865ybc.5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 15:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0Ak/MEnOSrDZCgA1aELgL32mvxm/Hxx1Goin9XizE4=;
        b=H1JXQPe4JZkQXVPyNLd35ywbdmCqLgeIKRRTEf6PLn6wdxAnleIabFwySS2O6sEGBQ
         nFisPKHtTm5tprdDTWa/jPeee+0Oba0l5v/JRJiitnHmrxa1C8syE9oxsnvJlbViKkF8
         PSALaiNuAJQ8SkG7NQJgH4Cv0ymfQb+gf7lQ+FbAwI1q/z22t8IHG1OBMX/i2Nip7mUu
         01+JNMGQUj4K3kyX4OXhjjDVea++Tsdzd+t+6kK7elBlpHHg3pVE4r8VLb9jSSwsFlM2
         NjRqh3XK0DBvCc05H3PkET4i/mYLrvYX4KQASZNG7YYsvhol4/1tlpblbBI6Wp7VSq7p
         rvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0Ak/MEnOSrDZCgA1aELgL32mvxm/Hxx1Goin9XizE4=;
        b=b1PDe5lsOXsfTU3HO7fiUVLSH3d6MTJwNvi2cnIrNpQ64i2VEl5Lup3ljtXmFWodOE
         L9N5vQGSpvoA3TmNNy4p/y3eVhG8NPixOdRPfAQgkP1L1Ditd8TX0qZebfQ1x7wrOb0Y
         FFK5SkJiqAZsm5fpv70LZy3LUmRqMJmFzshAETNO9nmvOmUBp2w373Jj9Pm5nBUzYSwM
         YzG+8deSjSFEdkBQXVMT43D6FxTE0zwSbk+eTZi7uav6qTTVuR3RuPM89A/bieB+4JMH
         2k2s1hmvfBL2mhlHe52L/NPvl0C9TeVAuN4etIcGY/Fjohw6n8D/iReXjBniLTc4e4o+
         wjow==
X-Gm-Message-State: AOAM531mhmKhmwh+nSQ/3dwi/HxMsmjV3kCymwgrHIurYNQQ+OO9Dwop
        ciwducdqK+01U65+T7Fl3TEEZIwsK0pfxR/3FOoct/2zUaCJ6ggT
X-Google-Smtp-Source: ABdhPJw39nJXnl7whxMKsxnejLOAf3xO6SMsRyBw1b+FKLbCN+AWkvmzZ+dpm3ckMjUDKM/NPP142T95tRpzd3nULy8=
X-Received: by 2002:a81:4054:: with SMTP id m20mr9670062ywn.167.1644535250458;
 Thu, 10 Feb 2022 15:20:50 -0800 (PST)
MIME-Version: 1.0
References: <776a73dbf91d4518a36b465ac9ac2d5a@hemeria-group.com>
 <51b5c958-1df6-e95e-d394-c95a0863ea0f@gmx.com> <1d68c14001434e9b9ccbb808a9eaad6c@hemeria-group.com>
In-Reply-To: <1d68c14001434e9b9ccbb808a9eaad6c@hemeria-group.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 10 Feb 2022 16:20:34 -0700
Message-ID: <CAJCQCtQn63ukiZ3dYPaOEBPmXMr4fx5cmgmThQN9rQtu0ROzMg@mail.gmail.com>
Subject: Re: Root level mismatch after sudden shutdown
To:     BERGUE Kevin <kevin.bergue-externe@hemeria-group.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 1:48 AM BERGUE Kevin
<kevin.bergue-externe@hemeria-group.com> wrote:
>
> The SSD reports itself as an INTEL SSDSC2KG960G8.

Well, sample size of one, user with SSDSC2KW256G8 that has firmware
LHF002C reports it was fine until 200% write endurance. It's not a
known problem SSD anyway.





-- 
Chris Murphy
