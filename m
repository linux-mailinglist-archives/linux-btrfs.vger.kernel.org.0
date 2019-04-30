Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B74F181
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2019 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfD3Hiy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Apr 2019 03:38:54 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:36739 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfD3Hiy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Apr 2019 03:38:54 -0400
Received: by mail-lj1-f179.google.com with SMTP id y8so5412087ljd.3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2019 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ZLLH8Qj9pb+KTGQEkwrtM7Gj4MkooWEzt2fAf4p+6c=;
        b=Yi6s2MpxJm5tRvetKpA61Yf6bFh9k8kr+H6E9ZOQ3D4BhCtTeIelHrEYcPMmER92L0
         Y0Q2GI5fwJeGffq4kQJY/ClZa8RyadGT/3scPoR635tJbfG5oo1afgB+2TbLpGCskHaJ
         FthHU/4p2YV/eKGBNAspMgVFbRkXR+nM3WDmLLWM1Mt7hU0zFrc4Pt8eq3ryDNDhdEbW
         3SwjoEVenJFBnOfD3XUaU9saon6UcFZO9Dq4KavsmhHejZgTo4u2GKFRS8AgNUNBeuge
         et8YF2lSXIHekuKEW1n1DJGwfSaLunLoAnjFfqwHRdpR/1JBBYS30hlQubVC593EejA6
         q3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZLLH8Qj9pb+KTGQEkwrtM7Gj4MkooWEzt2fAf4p+6c=;
        b=pHy5gfaDHjRwjrz/2Xr6Po5j4mb34kIx/RwwPLCDPcAytc95xWbPEw6PP6G2UspFEJ
         EWvfL3shZWrXEhtj0Y0E0L9viGqFX6Bz1fkWGZIPs5ngnqonfp/gKVPLYgaXJDLMjUzC
         wkrDpQfPR10yn2p0BBfY7o1tDGq1LHD262TnvEqFbqyuc+8MyfNK/N46oLt8vmW5HamK
         DxhjZhsmOsMk7KCFrtLkRbGQ7SWg5gmxIxwkklZNnWYyfWLamN4j8+V9Ub6vJtq5u6Yw
         qLkQYe4k3SwwIUj7SQe7JfoFQBMDYwmxUzg4sbLwLAVn0JGrlcMNrsJge14YNBh0D0Am
         6GHw==
X-Gm-Message-State: APjAAAXWs1SpAlltFcH3jHd+j9EjwOaNIzx5Bh56b+g+JcK9yCx+DoDf
        +eDQsdyhQVLyRTMelUx8MlNbgJGMVSKD6gz3dbXNF9DrkAY=
X-Google-Smtp-Source: APXvYqyjXOlj6Y7VUkdnVwXYZT3YH8KntYIs/SWjgaolku7s2YXaW9vsHSzsv7Ci+nI5nMhNXeIX028snWW/aIXnfoc=
X-Received: by 2002:a2e:9350:: with SMTP id m16mr1402912ljh.38.1556609932053;
 Tue, 30 Apr 2019 00:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR03MB413128509989947DE4AA7DEF92380@AM0PR03MB4131.eurprd03.prod.outlook.com>
 <5e02c6d3-9024-10fa-51f0-629ff5e604fe@gmail.com> <CAA91j0UGPKgqu_TYKQdfnAxe5pfLLvkVaaUNgUZmEh10MrWJ+w@mail.gmail.com>
In-Reply-To: <CAA91j0UGPKgqu_TYKQdfnAxe5pfLLvkVaaUNgUZmEh10MrWJ+w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 30 Apr 2019 01:38:40 -0600
Message-ID: <CAJCQCtS2tgsV92uqKXExwXr_wc2apVYYCQc8ahep15RKwayzfw@mail.gmail.com>
Subject: Re: recommended way to allow mounting of degraded array at boot
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Alberto Bursi <alberto.bursi@outlook.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 29, 2019 at 5:57 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>
> On Mon, Apr 29, 2019 at 2:38 PM Austin S. Hemmelgarn
> <ahferroin7@gmail.com> wrote:
>
> > * If you're doing this on a system using systemd, it actually doesn't do
> > what you are trying to do.  Systemd will refuse to mount the volume if
> > all the constituent devices aren't present,
> >
>
> It is not quite correct. systemd will not even attempt to mount
> incomplete btrfs because it will wait for all devices (including
> missing ones) to appear before proceeding to mount it. And if this
> check is disabled, it will actually just call mount.btrfs, it will
> certainly not "refuse" to do anything. So the following may work
>
> - disable udev rule calls "btrfs device ready"  (it actually calls
> internal variant, but it does not matter).
> - replace mount.btrfs with your own script that tries to mount btrfs
> and if it fails tries to mount it degraded.

Yeah what I don't like about this udev rule is the indefinite hang. I
don't know enough about udev, whether it can support a timeout? If the
missing devices haven't appeared in 30 seconds, good chance they won't
appear, and then either fail at this rule or continue on with the
mount attempt (which then fails). But either way, the user gets to a
prompt, and can troubleshoot the problem from there rather than being
stuck with force poweroff being the only alternative.

-- 
Chris Murphy
