Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDDD2EB576
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 23:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbhAEWlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 17:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbhAEWlU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jan 2021 17:41:20 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C38C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jan 2021 14:40:40 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v19so827521pgj.12
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jan 2021 14:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GokFglWoZ0pAbBaOhyeJxr7mEUEFukscETHDwZMjSto=;
        b=okJgoZqhfX6HdB2HYL4WLI9JsNdDq2+WA/ECL/gksATFJb43jvQIIZ26RtNr4IDPdw
         T5syc0EkPNnSupNyiH0JVnDNut2+pW9ifIXUxlp1A6V/FMdYnuaBXbJ3Dlph++VPdNpn
         wm8GkxmVouY8GrqFHiyqtRt3kjoS/1okz+ISDDmTFrK0K0NoIxoUUhBevXgMSjgq8fZc
         qfGJ3jCyh+C9dLu/ihAQHiFKB69NpFcQC+c6xedEOrPScmpq1QJDDF+AMIS6s/g/+yiA
         anZe9VAMvtoOYPCMxQm3Qveb1vTOY+omnHRzQ4VUYP+7wKpxByFDdL/2+JN3fWOBpPrK
         fvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GokFglWoZ0pAbBaOhyeJxr7mEUEFukscETHDwZMjSto=;
        b=HzgB1x/pWOmFGa5qzomk2ufVkBEALc0amlqIU0bOTYOUz7hEDhaXRw4X5ipWxAlp7Z
         oUpxuUZE4gov0V5mMn2fm7LyCgIJjs3ZZeudWlFruFfpunrCSaIyCKHJfbhcvmvkaSTR
         FjmNuMCcEuEtyfXytw5IlzYY4aI2ng4zmkki1b7zlyDvM8wuGRz35cqghapT7VN0Ba1R
         dFciqkX0LsdOUNO16tWfN4TNYEZXIxU+rWJUigJHgex6BErwj9NJUJsdWojf/5urmVKD
         RULKgOiafvchZiA56DOBcQWRezeIOO8tezJpuhzqkCKFdgw69zBgDq1WJb8fU8syPWHS
         rczA==
X-Gm-Message-State: AOAM532OWtOnxftSsr6ir9a4NdAbnJuj1uJge+dIHV8ArjF7Tp1iZW4J
        TnQPfC6ufgJcCrc0YRuHhXga+869J3lAyxo9T3g=
X-Google-Smtp-Source: ABdhPJzsksIvqNJIA1APNjQKcqiUrtYrMmj4v0Fv+j07G+STBDT9PULaUHfshwkJGfkSPKCNCrCV0VXk41MgxcuCozo=
X-Received: by 2002:a63:2009:: with SMTP id g9mr1313425pgg.219.1609886439947;
 Tue, 05 Jan 2021 14:40:39 -0800 (PST)
MIME-Version: 1.0
References: <CAKxU2N_=1uKoVMh20h=_8SyOnHM=WvfZjfQP3t81yN2QTZS4Xg@mail.gmail.com>
 <20210104144437.GE6430@twin.jikos.cz> <CAKxU2N-Q5mjTS6arE5+-UgTgAZMGhTMDaGUAT-bQwe4BdjKOsg@mail.gmail.com>
 <20210105153312.GM6430@twin.jikos.cz>
In-Reply-To: <20210105153312.GM6430@twin.jikos.cz>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Tue, 5 Jan 2021 14:40:28 -0800
Message-ID: <CAKxU2N9XkG72T0pUb2iSeATXB-Sh9j+rBpSogfAVH0Zccui_mg@mail.gmail.com>
Subject: Re: Question about btrfs and XOR offloading
To:     dsterba@suse.cz, Rosen Penev <rosenp@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 5, 2021 at 7:35 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Jan 04, 2021 at 02:56:59PM -0800, Rosen Penev wrote:
> > On Mon, Jan 4, 2021 at 6:46 AM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Sat, Jan 02, 2021 at 07:50:38PM -0800, Rosen Penev wrote:
> > > > I've noticed that internally, btrfs' XOR code is CPU only. Does anyone
> > > > know if there is a performance advantage to using a hardware
> > > > accelerated path? I ask as I use BTRFS on a Marvelll ARM platform with
> > > > XOR offload capability.
> > >
> > > Even if it's CPU, it's accelerated and best algorithm is selected at
> > > boot time:
> > >
> > > [   16.357703] raid6: avx2x4   gen() 30635 MB/s
> > > [   16.425701] raid6: avx2x4   xor() 10727 MB/s
> > > [   16.493701] raid6: avx2x2   gen() 32995 MB/s
> > > [   16.561701] raid6: avx2x2   xor() 19596 MB/s
> > > [   16.629701] raid6: avx2x1   gen() 26349 MB/s
> > > [   16.697710] raid6: avx2x1   xor() 17794 MB/s
> > > [   16.765701] raid6: sse2x4   gen() 17354 MB/s
> > > [   16.833701] raid6: sse2x4   xor()  9653 MB/s
> > > [   16.901706] raid6: sse2x2   gen() 18495 MB/s
> > > [   16.969702] raid6: sse2x2   xor() 11562 MB/s
> > > [   17.037701] raid6: sse2x1   gen() 14440 MB/s
> > > [   17.105818] raid6: sse2x1   xor() 10387 MB/s
> > > [   17.108300] raid6: using algorithm avx2x2 gen() 32995 MB/s
> > > [   17.110703] raid6: .... xor() 19596 MB/s, rmw enabled
> > > [   17.113587] raid6: using avx2x2 recovery algorithm
> > > [   17.327666] xor: automatically using best checksumming function   avx
> > Yeah...
> >
> > [    0.316064] raid6: neonx8   xor()  1087 MB/s
> > [    0.452063] raid6: neonx4   xor()  1372 MB/s
> > [    0.588064] raid6: neonx2   xor()  1610 MB/s
> > [    0.724061] raid6: neonx1   xor()  1345 MB/s
> > [    0.860072] raid6: int32x8  xor()   337 MB/s
> > [    0.996092] raid6: int32x4  xor()   373 MB/s
> > [    1.132087] raid6: int32x2  xor()   348 MB/s
> > [    1.268090] raid6: int32x1  xor()   281 MB/s
> > [    1.268093] raid6: .... xor() 1610 MB/s, rmw enabled
> >
> > Not as fast here.
>
> What's the raw speed of the hw offload? Measured on large data so that
> the overhead is negligible.
I have no idea how to benchmark such a thing. I assume it could be
done indirectly.
>
> It might make sense to add the async support in case the speed is
> comparable or better to the CPU, but also to reduce the CPU load.
I think the latter is the reason Marvell added hardware support for
doing parity calculations.
