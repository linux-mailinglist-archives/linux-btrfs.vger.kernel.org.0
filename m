Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7072EA0CC
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 00:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhADX2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 18:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbhADX2Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 18:28:24 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C11C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 15:27:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i5so20097867pgo.1
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Jan 2021 15:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=56VrfVVaXhapBMRvTmfVSpJdIBNNiw1iEEl/pRVGJyQ=;
        b=Qgx3ZCVzgKCJnFCr5+iv3pACpxZ8skqw+D9GuLCLl3Mdh95UKlabX2QQBk727qFzwj
         pGm5Ya8V9fYHrCX4MA2NIjrrXrXp0Kbu4RJf1W7NgxX5+dLs/IHu4KHjgmek51plkbS8
         gvN3u1bUMjrKlwNHmX1PDD1Ue2ihAacmsX+all7B8XF6e/e43Hb6eYOfAndMURl/oadE
         4ofQc3MqnzTRuA/XiYj+p4iuDLVqUf2EO1IrvvLLEA9eE2vbaxbSAYtlAUr5tXWQBI1+
         HgfBCJyazjiCD8J2ng2uigNn0kQwOjvNp5U+6499jnxTucnLy7b9p5LjpXtgZxFiTqop
         k8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=56VrfVVaXhapBMRvTmfVSpJdIBNNiw1iEEl/pRVGJyQ=;
        b=OkfeSSNoqQKC7TLKGZo3gMOQ+oKsq2iboCorvoZ/kom5QI4j2foUzrmHpWvQPKH06E
         j7fKvFMR7Kgs2tqA1yahwI2kLgczP/GDMmXM6HBpjZCwfnpy5VB3m+rl60xv9jRKVmRZ
         fg7mXI7aRcFwak5JU2lVHWfWxwlvq4r4yJ5/gXyeMfLJaYJURsoH5k8mdgjA7sKEIZHX
         jyeS54Sl4KH2scXm4v7oQXHfa0645qxVriYiPV9eJmjtFuJkug4enTQQ25agH47t4tlP
         ExJKeZTDw1domICdnKorNJyLilsVzzj9dw4SCVIbauZVj260mvibGm0EY5h30GQGlZqS
         pQ7A==
X-Gm-Message-State: AOAM5310Xgj8l9HbYiCss+ZeR/fTMM0x48qiYTz7o0jStIdk1//tsByP
        9BS+vEZ5lqtKTP1i7Eu62ovGaxUBkDR3PeKyJyDYKMmex+Wq7w==
X-Google-Smtp-Source: ABdhPJy3U50xXZAT/lNr4D3Pve6evX+lYoVFAz1FQSOxuwpTKkVB6d6E0TexSGCjMnbyzhieH7FnExohXc6mhuxGkUo=
X-Received: by 2002:a63:2009:: with SMTP id g9mr49432460pgg.219.1609801030951;
 Mon, 04 Jan 2021 14:57:10 -0800 (PST)
MIME-Version: 1.0
References: <CAKxU2N_=1uKoVMh20h=_8SyOnHM=WvfZjfQP3t81yN2QTZS4Xg@mail.gmail.com>
 <20210104144437.GE6430@twin.jikos.cz>
In-Reply-To: <20210104144437.GE6430@twin.jikos.cz>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Mon, 4 Jan 2021 14:56:59 -0800
Message-ID: <CAKxU2N-Q5mjTS6arE5+-UgTgAZMGhTMDaGUAT-bQwe4BdjKOsg@mail.gmail.com>
Subject: Re: Question about btrfs and XOR offloading
To:     dsterba@suse.cz, Rosen Penev <rosenp@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 4, 2021 at 6:46 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Sat, Jan 02, 2021 at 07:50:38PM -0800, Rosen Penev wrote:
> > I've noticed that internally, btrfs' XOR code is CPU only. Does anyone
> > know if there is a performance advantage to using a hardware
> > accelerated path? I ask as I use BTRFS on a Marvelll ARM platform with
> > XOR offload capability.
>
> Even if it's CPU, it's accelerated and best algorithm is selected at
> boot time:
>
> [   16.357703] raid6: avx2x4   gen() 30635 MB/s
> [   16.425701] raid6: avx2x4   xor() 10727 MB/s
> [   16.493701] raid6: avx2x2   gen() 32995 MB/s
> [   16.561701] raid6: avx2x2   xor() 19596 MB/s
> [   16.629701] raid6: avx2x1   gen() 26349 MB/s
> [   16.697710] raid6: avx2x1   xor() 17794 MB/s
> [   16.765701] raid6: sse2x4   gen() 17354 MB/s
> [   16.833701] raid6: sse2x4   xor()  9653 MB/s
> [   16.901706] raid6: sse2x2   gen() 18495 MB/s
> [   16.969702] raid6: sse2x2   xor() 11562 MB/s
> [   17.037701] raid6: sse2x1   gen() 14440 MB/s
> [   17.105818] raid6: sse2x1   xor() 10387 MB/s
> [   17.108300] raid6: using algorithm avx2x2 gen() 32995 MB/s
> [   17.110703] raid6: .... xor() 19596 MB/s, rmw enabled
> [   17.113587] raid6: using avx2x2 recovery algorithm
> [   17.327666] xor: automatically using best checksumming function   avx
Yeah...

[    0.316064] raid6: neonx8   xor()  1087 MB/s
[    0.452063] raid6: neonx4   xor()  1372 MB/s
[    0.588064] raid6: neonx2   xor()  1610 MB/s
[    0.724061] raid6: neonx1   xor()  1345 MB/s
[    0.860072] raid6: int32x8  xor()   337 MB/s
[    0.996092] raid6: int32x4  xor()   373 MB/s
[    1.132087] raid6: int32x2  xor()   348 MB/s
[    1.268090] raid6: int32x1  xor()   281 MB/s
[    1.268093] raid6: .... xor() 1610 MB/s, rmw enabled

Not as fast here.
>
> The xor/parity calculations are done synchronously, while the offloading
> to hw usually requires asynchronous submit/wait mechanism. This brings
> some overhead, so it depends. The code in btrfs would need to be adapted
> to do the async way, unless it's all somehow hidden under the crypto
> API.
