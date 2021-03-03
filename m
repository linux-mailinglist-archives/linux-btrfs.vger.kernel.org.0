Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4453C32C553
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450727AbhCDAUA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245432AbhCCTlu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Mar 2021 14:41:50 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A80CC061761
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Mar 2021 11:39:22 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id q85so25272715qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Mar 2021 11:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OkJS/YO0F32zHHpt9QReq+hbaQX+zkpisJWGOn/DHlw=;
        b=EftgGqshMdO1P9WCgAXRL9N8gpbUTtro6f39nKtHu9Fy9ESlIeBs5YYkv/qx1kd65H
         /akjNeO/GPPz22Yt05CaaVnN2LFOQzqdz4DOekbMznqoEsmP/Tn6iRHAebwwawqE2myv
         piMdE+QuT7tmWRZuzqk9ICCwNUTeW9u6QBNta7SlqTICrxwTMax7XwZXGE+YvCGViQUV
         itXnTW87jp5UZlCXILoTbuIC9sGXioY5IcxwKsQ4ml6EJ+PfK43qIICOy6oXFG3oZ8TA
         jyzSwmgWBDNkiwcVzrZFcvM8hBc113Y+xA3vau7GD4TsOi9UlBUdcUyyIAvrOlsJu7aE
         DgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=OkJS/YO0F32zHHpt9QReq+hbaQX+zkpisJWGOn/DHlw=;
        b=IvCgo9YdJlCy/t/iulPlvs9cvJCCS0ufjl0Jx4wxM9/XiRJ3RY6vxQJqCxu8LXhGzW
         o3saoJfnQ2Wo+7O0+4Ir50s2FIRelccUiQb4esO7L38QNcXh6to8O/B8yOLb30kVGb38
         YaQnvTGp+5hwm237yxApXOWdzFX/RISZUYBs8mZAFGth4kTKXB3qomuG5FLTgkWlyu/m
         F/Zt3SS2tbA09/hOGpaKuDk4/6vPcI/FJxYQjd9z40lPtTtegd74+liJ+hnboZT4K3qS
         tAeC6kwN0Y23jhcyKeIYdPmVhJ7sz99KXCQiEjSOiGaFdLjs7Esk5PuSestfJizQmAjF
         zPPw==
X-Gm-Message-State: AOAM533X0EDffFcuhDlE/6y3ctBBcctrsiTSdZ+A2JtGTdjk9O6AaXqj
        74mcJE7B5dhzCCQQLmhLxE51rCZn6js1EyhK5T28mqBJeAEZyA==
X-Google-Smtp-Source: ABdhPJysLb3eSS+DrN8k8tZYcJwL6lfWs+C44Rt+G5CrTlOME9d7Hh2MIWnAtG5FWjGYwqiC+ddUQJWlldyI44Anoi8=
X-Received: by 2002:a37:b501:: with SMTP id e1mr668523qkf.30.1614800361727;
 Wed, 03 Mar 2021 11:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20210227200702.11977-1-davispuh@gmail.com> <20210302141701.GI7604@twin.jikos.cz>
In-Reply-To: <20210302141701.GI7604@twin.jikos.cz>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Wed, 3 Mar 2021 21:39:09 +0200
Message-ID: <CAOE4rSxzMUQurSp6GqHYeW8=JoMR5atvfP_Ot-Jn0maP-i8U+Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: Fix checksum output for "checksum verify failed"
To:     dsterba@suse.cz,
        =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

otrd., 2021. g. 2. marts, plkst. 16:18 =E2=80=94 lietot=C4=81js David Sterb=
a
(<dsterba@suse.cz>) rakst=C4=ABja:
>
> On Sat, Feb 27, 2021 at 10:07:02PM +0200, D=C4=81vis Mos=C4=81ns wrote:
> > Currently only single checksum byte is outputted.
> > This fixes it so that full checksum is outputted.
>
> Thanks, that really needs fixing.
>
> > Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
> > ---
> >  kernel-shared/disk-io.c | 47 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 42 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> > index 6f584986..8773eed7 100644
> > --- a/kernel-shared/disk-io.c
> > +++ b/kernel-shared/disk-io.c
> > @@ -160,10 +160,45 @@ int btrfs_csum_data(u16 csum_type, const u8 *data=
, u8 *out, size_t len)
> >       return -1;
> >  }
> >
> > +int btrfs_format_csum(u16 csum_type, const char *data, char *output)
> > +{
> > +     int i;
> > +     int csum_len =3D 0;
> > +     int position =3D 0;
> > +     int direction =3D 1;
> > +     switch (csum_type) {
> > +             case BTRFS_CSUM_TYPE_CRC32:
> > +                     csum_len =3D 4;
>
> This duplicates the per-csum size, you could use btrfs_csum_type_size
>

Didn't notice this, fixed in v2.


> > +                     position =3D csum_len - 1;
> > +                     direction =3D -1;
> > +                     break;
> > +             case BTRFS_CSUM_TYPE_XXHASH:
> > +                     csum_len =3D 8;
> > +                     position =3D csum_len - 1;
> > +                     direction =3D -1;
>
> So the direction says if it's big endian or little endian, right, so for
> xxhash it's bigendian but the crc32c above it's little.
>

The problem is that both crc and xxhash uses native CPU endianess -
they're 32-bit and 64-bit numbers. But sha256 and blake2 always uses
big endian when displayed.
So here I implemented this difference.

> In kernel the format is 0x%*phN, which translates to 'hexadecimal with
> variable length', so all the work is hidden inside printk. But still
> there are no changes in the 'direction'.

I wasn't aware of such format specifier, but unfortunately here in
btrfs-progs printk is just alias to fprintf which doesn't support this
format. So not sure if there's any better way to implement this.

> I haven't actually checked if the printed format matches what kernel
> does but would think that there should be no direction adjustment
> needed.

I looked at kernel's implementation and it always outputs in big
endian and that's why there's no such direction.

kernel output:
> checksum verify failed on 21057101103104 wanted 0x753cdd5f found 0x9c0ba0=
35 level 0

this patch's output:
> checksum verify failed on 21057101103104 wanted 5FDD3C75 found 35A00B9C

As you can see for crc32c they're reversed. This isn't really big
problem but it can be confusing as most tools output crc as number
which converted to hex won't match kernel's output.
Not sure if we should stick to how kernel is outputting for sake of
consistency or if this would be better...
