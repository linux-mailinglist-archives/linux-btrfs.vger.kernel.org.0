Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A092D8A3A
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Dec 2020 22:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407976AbgLLVxu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Dec 2020 16:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLLVxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Dec 2020 16:53:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F307BC0613CF
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Dec 2020 13:53:09 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v14so10506780wml.1
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Dec 2020 13:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQKxROwdZ4hWiVl9QIpyjsbDekc/drOnqB8ZDshaIn0=;
        b=NSQhE7vIWbY2j8shsc4I5UlWqoySTveuzQo14OGHDMhvL2LKJApOBGWPqZ+yiuMovL
         BnhaT629qEsWXoq9uRvbwKuJ8OoHySkedZdMu1Z0sPjLWQrVGnuB8XPKFlYwZaKd74No
         d1SPK6+pCbf0yQILv3d9SjgBiaJnO3YbMbQDU+RK+Z4WtS4bFjYFGBotIJTkaoDKuSn/
         F/gBAVlvHb/2j5bNuNtPMv+Nw/zUZBTp7aN7LokqaBJJIqUcTofXZVX2VuSn8WQNYbsj
         g0VniZpnn44VJCUb904CIgaKEvoh4pbePN9nuGMT8ta5Be7ya8vqCPXqnMNYkYvrJSgW
         zciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQKxROwdZ4hWiVl9QIpyjsbDekc/drOnqB8ZDshaIn0=;
        b=Z3HORyyorWTsF1p+soE2poicCV4jszOhsx7CSCK5SNtw0fmQVW+KSupVhr9MquoVll
         VbaUmggZCgOlL89Z0JSsQUf9xLS64QAzXWluVPXv+Psi1uKr/V9fv2pJQaThBdHrT79N
         kUt6QEJdyBXUthOAkEFH9VtBtXs5kp6xK479IqNpwXS3LimyGqnKDGN6RCAkrAAdywjt
         0qqM3iiwoCdfoTWz1ZVwJ9QX3RgBrqyx5VKpUa6wpPbhk+VfyDf7hSIW8CzJ1LubIoxJ
         OwsLQblVpRah1KwnXur+SRDNFdpbsgpnNb9fsiR+6uWNsVQ5rquFrENPtrnXf+EZ5vIW
         mKmQ==
X-Gm-Message-State: AOAM531zhoLNoiZSj1KNF5+WT+t3H1ImOP86AK4I04Xc10Rd1i8SKWRR
        RKFxJ12CsaokmVMdeGE2BZ/0V4F6iGyoJ2CumnUwlSzF23LV1g==
X-Google-Smtp-Source: ABdhPJyRLBqa0+3G4qOSPHEka0nPJSB8GYQApO0WEdvTgFl1ky6Cs8Tlm4Q1BA8MrPO5hWqNVQov0Ext8cBCcdMzCFQ=
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr20554475wme.182.1607809987367;
 Sat, 12 Dec 2020 13:53:07 -0800 (PST)
MIME-Version: 1.0
References: <CAMaziXsqG-z029cCTd1BBn6HTm2EDLxsSocSOVs1s5RoK_Q0aQ@mail.gmail.com>
 <CAJCQCtT+sfHjhKn4a+GdT5ktxzuRooxffuoK5M5T8mMbM6o4Bw@mail.gmail.com> <CAMaziXtPXvKS=FETe1pU7YecY8Tsxdf5k1Auretd0bFn6mLOag@mail.gmail.com>
In-Reply-To: <CAMaziXtPXvKS=FETe1pU7YecY8Tsxdf5k1Auretd0bFn6mLOag@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 12 Dec 2020 14:52:51 -0700
Message-ID: <CAJCQCtTHiN7dFMeHQh7hhFze9BDcY=042XQ-0ENh3DzMxsQ1pQ@mail.gmail.com>
Subject: Re: btrfs swapfile - Not enough swap space for hibernation.
To:     Community support for Fedora users <users@lists.fedoraproject.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 11, 2020 at 7:02 AM Sreyan Chakravarty <sreyan32@gmail.com> wrote:
>
> The only reason I can fathom is that systemd-logind is unable to
> access the directory /var/swap. IIRC, you were the one who suggested I
> mount in that directory.
>
> Not blaming you, but the question is what do I do now ?

Well, what I recommended is a swap partition to avoid all of these
limitations and questions. If you're going to use swap on Btrfs then
you're kinda in the same boat as the rest of us who are trying to
address each limit. This is why it's not the default and why I haven't
written up anything yet.

My expectation is that swapfiles on btrfs need a helper service of
some sort, in order for it to be generally usable.

> The bug that you have linked to is about /home not /var.

It's a reference for a similar problem, not an identical problem, with
a how to enable debug for logind.

> So where should I keep the swap for logind to access it without any problems ?

You are in adventure land. So you're going on an adventure. If you
want it to just work, use a swap partition.


> I don't think that is possible since the file was created with dd, not
> fallocate.

Why? I've mentioned fallocate several times, and also man 5 btrfs
several times, and there it recommends fallocate. Nowhere is dd
suggested. It may not work with dd depending on the dd exact dd
command used.


-- 
Chris Murphy
