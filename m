Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2136E214BD1
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jul 2020 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgGEKah (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jul 2020 06:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgGEKah (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jul 2020 06:30:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B792DC061794
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jul 2020 03:30:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e4so41972597ljn.4
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jul 2020 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ginkel.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKxFQ5gGA9KxrBrxwRFhTxln7X8io4f182pntXFEnx4=;
        b=FTnWVt8n+CbJpK4l/q0sWhuD6ING6knF6F68xUkNMNGfakSTiV/xdoR1Wk3hJ6K3Da
         P5x4Y/8c6kYu9tw+CmiXUaYGecR/7tl39vfHWb7cgC1D0pPW4Sce+D1f5CRoYeM/2pU1
         U5nVigbcEwpIstbzlrWFeca8BqctQHzyuTedM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKxFQ5gGA9KxrBrxwRFhTxln7X8io4f182pntXFEnx4=;
        b=EO6ajQiOAcQ+bDMmNYzIz0F/8HWoeHy36q3LNLwzMv8gu3j4wsfOGxJ4KPKkIeeSFo
         z3IarErv4LljLcnLcTd3oPFNQqRnCy5sE+UVZU8qEzcvL3H0gijhz45IpwdHwDed483V
         QH04d4A8Q3gOYHTQT41fnx/gwrptADxIzz8gqdW/QifMCShRrVJ7H425EUwy9cG35F9v
         1tYi7Yrj7Xkd43O1mll3OduEnKC7E3ywJ6TTwF1ye5N48TWOe04w4niBhiGSKfTs90LC
         3g5+KgfFB1LLeyeBREewuG3HTR0uEI9Wke++E5R9XOptcx0nn89FcbTc8WIzq5iKjMxe
         VOzQ==
X-Gm-Message-State: AOAM531hXbEptMLnWLLwi6M57JzUGThx1rVaI3iGxgq9qCHwQvZARruU
        XbaNtLanbcntBZR/uzGK6F2JLBYeiW1al3GN7McwCw==
X-Google-Smtp-Source: ABdhPJwXXv5WDPpjRhRTfCagy0SbbmlCR5/n2SuiZFUEG0Z/ObHxDOU3qlp4UhOAWtb9rkN1jfS/i7xhA2ebihi/soE=
X-Received: by 2002:a2e:6a05:: with SMTP id f5mr24797150ljc.385.1593945035019;
 Sun, 05 Jul 2020 03:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <CANvSZQ_5p4JD4v79gFkSRBBvehCDh_Q5bBKeyNi912tr0biNLg@mail.gmail.com>
 <90c7edc7-9b1d-294f-5996-9353698cedbe@gmx.com>
In-Reply-To: <90c7edc7-9b1d-294f-5996-9353698cedbe@gmx.com>
From:   Thilo-Alexander Ginkel <thilo@ginkel.com>
Date:   Sun, 5 Jul 2020 12:30:19 +0200
Message-ID: <CANvSZQ_HDZ=54MW+dSAP1A_zUiaGR_PLkV7anQj5K+qNds0QsQ@mail.gmail.com>
Subject: Re: Growing number of "invalid tree nritems" errors
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 5, 2020 at 11:53 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> How producible is this?

I did some log analysis: The problem started showing up on two of
three servers starting July 3rd, 2020. This coincides with an applied
Ubuntu Linux kernel update to 4.15.0-109-generic whose changelog shows
plenty of btrfs changes:
https://launchpad.net/ubuntu/+source/linux/4.15.0-109.110

Server #2 (still online) shows 16 error messages in its log since
2020-07-03 whereas server #3 shows 310 error messages.

On thing special about server #3 is that its btrfs file system has a
huge metadata section (probably due to it hosting many [~ 50 Mio]
small files), which doesn't seem too healthy:

# btrfs filesystem usage /mnt
Overall:
    Device size:                 476.30GiB
    Device allocated:            372.02GiB
    Device unallocated:          104.28GiB
    Device missing:                  0.00B
    Used:                        272.16GiB
    Free (estimated):            194.49GiB      (min: 194.49GiB)
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              512.00MiB      (used: 0.00B)

Data,single: Size:284.01GiB, Used:193.80GiB
   /dev/mapper/luks      284.01GiB

Metadata,single: Size:88.01GiB, Used:78.36GiB
   /dev/mapper/luks       88.01GiB

System,single: Size:4.00MiB, Used:80.00KiB
   /dev/mapper/luks        4.00MiB

Unallocated:
   /dev/mapper/luks      104.28GiB

> If it still shows the same symptom after verifying the RAM, would you
> please apply this small debug diff on your kernel?

I'll see what I can do.

Thanks,
Thilo
