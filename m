Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B621538B519
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 19:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhETRWO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhETRWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 13:22:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E42C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 10:20:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c12so1265169pfl.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5xyOVZubGAfAnhw9daBqJU/5UeMbkdCDzwusFb4a2A=;
        b=tBj/vOfvyWpej1htlc+FrEJqkapnsJsbRsyaP2vdYnVbcRoUfg6Z1xLExttPFk19d2
         0XastGzZk5v13JxvlQ3IztGdGrZvDC8odfYhOEk6Wii0oYwda2a7AOKazPaJLrxra5rb
         OhhC4yDWkGtA2/wmJ0uZ6zfDVa+5oG0Suw3QoTqvzqD02SDgzgIPzarg2EI7mhvGtpdQ
         dsuP54yjTMo1bzCyI3vgcbFnMHzIZMPbEny179/XwqQnp1UcBgCMy1wc3AOxnKy1EDgx
         OU/BWs+AsqPRRAz+R8BUYXxJ3uwTac2EvGDJBEoN8SWlBkkFtabLkRRpiPfnoGwiFCSz
         8loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5xyOVZubGAfAnhw9daBqJU/5UeMbkdCDzwusFb4a2A=;
        b=YKNiSdWdA/G4EGQse/4l3xbz/ioSa5+Jjvp4YGnyDZ6h6+/QRS52ZzVTZVwWrM+O30
         9I9JfpUsk3wiDMS9YJmb7usdIF8VhkbvItB0oftFzGVtfi5QAVbm0zSOv4aLPkOWvySp
         AN0yaDASC5ircUsvrdriARWat6ypmdfaIkrnnBIm8JNlaGJkwyEKoXdI9OebVOYIYzOs
         Zazpi6Xc7AUTvhSyMAGWUuDqWINlNXHI07G2ptMhU04OcWz8txYUCyP51wvNtcYwdFFg
         1g/ehpgat9Jv7AaDWA2RFAtuZ92p09FqnViT2PIKCHkncKYmD/8AocuFXmVnzyKiwPxk
         +iaw==
X-Gm-Message-State: AOAM533r0sKC168uz4W6naxK1AePzY6c1ZxKtw+Sq7f9OmvHohCjhz2d
        Oh0+KmICFtaky1vLj/8OEUJBB60nsUj3kCMfu83ObpmTfCw=
X-Google-Smtp-Source: ABdhPJzseDEjVS3mLviBK7HjntNQ0EaogCGaI3GKcKR+exK3jkjIpyC/FqRfqWAkWnhU/Ouba3zSdVqlSvzrYebaKCE=
X-Received: by 2002:a65:564c:: with SMTP id m12mr5773113pgs.298.1621531250865;
 Thu, 20 May 2021 10:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHPNGSTFw1rPFpnWF9OHzqKnxUSijYYUYtsenhj5YuNaSTGBgA@mail.gmail.com>
 <CAHPNGST+ZuZOg+TXab-DXLKdAiDtN5e=pdarYA7rb0P0NYzA2Q@mail.gmail.com> <20210520202222.40B0.409509F4@e16-tech.com>
In-Reply-To: <20210520202222.40B0.409509F4@e16-tech.com>
From:   Octavia Togami <octavia.togami@gmail.com>
Date:   Thu, 20 May 2021 10:20:39 -0700
Message-ID: <CAHPNGSTmwDOURhLuvryAGrJ9sayQAHdQRJ3+f8Aia6s4v-UJmQ@mail.gmail.com>
Subject: Re: btrfs check: free space cache has more free space than block
 group item
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
The other device is missing because I mistakenly deleted it in
GParted, thinking that GParted would detach it from the array or at
least warn me if it couldn't. It did not do that, so now I believe the
array is technically degraded. However, as the balance command
segfaulted, I would think that it doesn't matter, but I wanted to
report this before I touched the device any further.

> Then, 'btrfs check' does not support the filesystem with multiple device?

I am not sure what you mean by this.

On Thu, May 20, 2021 at 5:22 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> > Apologies, I missed the required commands, output from them is as
> > follows & attached.
> >
> > $ uname -a
> > Linux data-acorn-token 5.12.5-arch1-1 #1 SMP PREEMPT Wed, 19 May 2021
> > 10:32:40 +0000 x86_64 GNU/Linux
> > $ btrfs --version
> > btrfs-progs v5.12.1
> > $ sudo btrfs fi show
> > Label: 'Parallel eXceed'  uuid: 2d80eaf7-6588-41b3-add3-1d4a3a2996eb
> >         Total devices 2 FS bytes used 281.77GiB
> >         devid    1 size 317.71GiB used 317.71GiB path /dev/nvme0n1p6
> >         *** Some devices missing
>
> Firstly, we need to know why '*** Some devices missing' happened?
> the output of 'blkid' maybe helpful.
>
> Then, 'btrfs check' does not support the filesystem with multiple device?
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/05/20
>
