Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0E4D23C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 23:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiCHV70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 16:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiCHV7Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 16:59:25 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7955B1C10D
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 13:58:28 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id q1-20020a4a7d41000000b003211b63eb7bso652740ooe.6
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 13:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISniBudmid6NEr+Mocu26vuOCaMQYLPeBTZk+TUseUI=;
        b=l1JM79SkUtlVPTKuPYh2NWnnqg/ph4pA6HAxs0SrC6PhvLKWI7lWUEVpV7QGVatp3x
         BaXWJ6novxp8xFzTlDzFWn+agax5j7ZTXU/I7cI7Ic+4rBfzNhmDo55Eby1M0eTEshvJ
         VVtqFmSmkAHb9f/ENwqxMxX+Vjb8Dl4W0/hI/hlLkTfDcSUAmu5gViomt97pAssDc6FU
         +tN7vb7su6mXXPIHsFRupthC7m0GjjZxoLGyo/LOxFauOcmAv0CdvYbEo4y8A1QODS2a
         BG5gl4yuVzJmkxqV6RwLArf93JbQm6ApMQM1U5gWRLMgRmGUKzNKOJvq53aHLPwPHB/H
         WVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISniBudmid6NEr+Mocu26vuOCaMQYLPeBTZk+TUseUI=;
        b=HyLqv6DESlRYFlsfcUApEOKGiVQazCkEdRAOvEMWkg7eTBBHSwhF0ESO5y19kpY5yK
         zccKLN7+pRGMXns9gRGoTZrxM8yNoxcrfFxC4Ml95s0MiN5mX610g92xMQMuVAanbrmF
         oqg+GjisT7oRjTYckJuosrDNE3Hr0OLr4q1gFYGKpdvVL6ty725IuiHQ0IrMphCvVgrd
         q2FgyzdoF8kPxFaIMEiRFI3EVVIR3K/aj7p/dLcLTTUEapCtYTaxZRKV1NzXVU5Cu4GS
         ctCH0+ei8S7cfyZPw+lHC74CpdmjohNFOVsTztenWCLJBwwADtBCJb2fKAzY3xinVc1u
         poNw==
X-Gm-Message-State: AOAM532VkB/rjkFJAz1LO8cXgxyZzUlI2SvqF6IKxaMA7mB7D3eqM4Kf
        rdrxDG/Bfb7QpzDwzjVJHnIHs3riIpByNjcDm4VUKJCVo5g=
X-Google-Smtp-Source: ABdhPJw+qycRk4SZ5kWG8sire85i8kr0xA/XMcMJG3HxpTqd4z2DhLXPB49bZxb+1A7V64F+Qx3nMbcUcDnDUejwkxQ=
X-Received: by 2002:a05:6870:2418:b0:d3:1052:aac0 with SMTP id
 n24-20020a056870241800b000d31052aac0mr3840902oap.80.1646776707797; Tue, 08
 Mar 2022 13:58:27 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com> <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
In-Reply-To: <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Tue, 8 Mar 2022 22:57:51 +0100
Message-ID: <CAODFU0pEd+QTJqio6ff5nsA_c--iCLGm52t0z6YBgzJcWPxy9g@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 7, 2022 at 3:39 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2022/3/7 10:23, Jan Ziak wrote:
> > BTW: "compsize file-with-million-extents" finishes in 0.2 seconds
> > (uses BTRFS_IOC_TREE_SEARCH_V2 ioctl), but "filefrag
> > file-with-million-extents" doesn't finish even after several minutes
> > of time (uses FS_IOC_FIEMAP ioctl - manages to perform only about 5
> > ioctl syscalls per second - and appears to be slowing down as the
> > value of the "fm_start" ioctl argument grows; e2fsprogs version
> > 1.46.5). It would be nice if filefrag was faster than just a few
> > ioctls per second.
>
> This is mostly a race with autodefrag.
>
> Both are using file extent map, thus if autodefrag is still trying to
> redirty the file again and again, it would definitely cause problems for
> anything also using file extent map.

It isn't caused by a race with autodefrag, but by something else.
Autodefrag was turned off when I was running "filefrag
file-with-million-extents".

$ /usr/bin/time filefrag file-with-million-extents.sqlite
Ctrl+C Command terminated by signal 2
0.000000 user, 4.327145 system, 0:04.331167 elapsed, 99% CPU

Sincerely
Jan
