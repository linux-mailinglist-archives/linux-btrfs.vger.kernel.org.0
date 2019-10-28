Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A794DE714F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2019 13:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbfJ1M0S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Oct 2019 08:26:18 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:37728 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfJ1M0S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Oct 2019 08:26:18 -0400
Received: by mail-wm1-f41.google.com with SMTP id q130so8925791wme.2
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2019 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oY4fXwd0VpdNxPEA2oM21TcCp9xxlSjs2d9z4htUOws=;
        b=LPXL92QGZfCzDGqQddXKx8no66RAal0M+aK7Z6I2hDZ4XoIybaTRQmz38G4g9XPhag
         JOCfMSIqkEn9epXGFplwdfP2SCJ5p+ghZXePtHlBDhHvtuw6u+HLgZqKCJdlc3H3mjM4
         QR3aFpR1l2tVEI88y1Yrdkd/y/T7ml2xwX4GTOqR7Fbq6JjSBPiedHDFChR5tFmLgSzW
         PLcKX8uvc/C+k+ra77teOQ5evPCm96pru4kjRCiwHs+5+rHzi/ylQUl4VzcBbT//Nt1c
         cuvfS9ZDCCbRzwSHNZYtscJ6WNBEqesMcCLk7DwP7VKm1E1T7CE9svsxsy0QPBepmhdB
         L1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oY4fXwd0VpdNxPEA2oM21TcCp9xxlSjs2d9z4htUOws=;
        b=UP8iVC7NxlvwHczqLY/4+ivo8htFxnHstH779xKCeIesdalkOaKl4Y19KgQTmB4KHp
         RXZiiIjo7Mc+GQgfqzAoBkSwy1nKej1d7xd9oLft9omj+lGkfjj2Gvuhk7J7hx2vuaJc
         fvCdBIhztEYhhbMFBturAOiU3aqKSSw4r6QZrNdhWZhw9AEE+8AjClPNAOh1wzyGMPJz
         gMPq3wsaIzEc7+RR0RGHodLxjDVaX5/vCsFsu6gVL/kcFqzqtti76Rw9Qa4MVfm0MLvM
         2IO/09HBgiy5zE8ywxC9RW4TqSlBQoRhyuVyYq+J+ubgUeEH2d3AAXo2ZH+QxClVJV/g
         Q5bg==
X-Gm-Message-State: APjAAAUUVggdM6MDxDbWdULOYTmNGYH6Zuxp7fLXfkboAmIhvh7jm7x5
        V4FZQXlgPbEMDIEEz+WR4dAa5rGThDuuJhTV0UE=
X-Google-Smtp-Source: APXvYqwt5Lq3kRwea70jIT/RBUmQYYMwe9q0w+4W5bNAbi5FNWGc8KbevxKnHCjebps4VqxpN8xGOrF/wJnYjKF4GSM=
X-Received: by 2002:a7b:c049:: with SMTP id u9mr15090507wmc.12.1572265576172;
 Mon, 28 Oct 2019 05:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com> <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com> <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
 <220ed79f-7028-497d-caf4-1841d5f6d970@gmx.com>
In-Reply-To: <220ed79f-7028-497d-caf4-1841d5f6d970@gmx.com>
From:   Atemu <atemu.main@gmail.com>
Date:   Mon, 28 Oct 2019 13:26:05 +0100
Message-ID: <CAE4GHgn+R8hgbwQbYnnS30Qv0jviXnf3Qr3+POO7PvZ6-swspA@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > Is there any way to "unshare" these worst cases without having to
> > btrfs defragment everything?
>
> Btrfs defrag should do that, but at the cost of hugely increased space
> usage.

Yeah, that's why I was asking for a way to do it without btrfs defrag,
somehow have only those extents split up and update the references in
the inodes.

> BTW, have you verified the content of that extent?
> Is that all zero? If so, just find a tool to punch all these files and
> you should be OK to go.

How I can get the content of those objectids and find out which inodes
reference them?
