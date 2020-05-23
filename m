Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529291DFBAA
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 May 2020 01:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbgEWXVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 May 2020 19:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388010AbgEWXVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 May 2020 19:21:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4230C061A0E
        for <linux-btrfs@vger.kernel.org>; Sat, 23 May 2020 16:21:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c71so1527453wmd.5
        for <linux-btrfs@vger.kernel.org>; Sat, 23 May 2020 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5LD3PHJkCZ//stLTmXPZ9wkFEdR5qZBQ+05z24HzKQo=;
        b=N5jN8EiHWQDeipblaSDtZlQrJc7I8pjP5Zy6hJton3csaXAyHg1IrFD/Ot1gpNXbAw
         pbvLosv9PFit3F4cBfwjXQFujvL0i3zPvECZ9He9oNoWM9wKJNH1gkoF30YR/XyZAowf
         53FSQrOrcBmMwo51NgCLV+krE4GXoMmmO5l691wrzpAOp+vtu54TY3VjEB/UiBm8fdd+
         Eg3G95VysHbIRZk4YJS1qBAenk75RtHv6DmJXJiEvUokGFC63eWKYJ24uPQWRNLL/vYU
         i8a90pTb3W2tz7LGJb9jYbAdV5QIIbBZxXUJah2vb9dKtXMKR+SDckHeKZUBnfNULQSB
         2vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=5LD3PHJkCZ//stLTmXPZ9wkFEdR5qZBQ+05z24HzKQo=;
        b=JmtUf8f/bb39bV8pCeH9NiYo5nYELmUfTR+b9cCGMu4p0ED5AlyWqKQvcy2CPJ/FFS
         8y8jYCdPLLTj84gUvw6uN5xJjTSWGEsRa1aOjJrIuc0Rj7WTVgHEs7Fxq7tthKM1PpAC
         GVZ2mVTGa83470NndW3jsBPALP1nsCXW4fnlgZC8O5xlq+nzOG2L8yRHZWP0nteCa/R5
         iTVKqPWKchLB2bDa2O33KuNE3AIUg6413nvW73mUxQQho78Nm1WiqTCL4CSc1qCg5Vrs
         ealpy6/ESGjhB+lXcp1faASCKOrDidAtHxsYT0pyV3GTq/lbCldB/V21B2VQYruiX9V9
         Z4kw==
X-Gm-Message-State: AOAM530PKCa4Q15tA91GyWeWvdmgKQJ8XXDMQHGqZlL5p2zGUL12QVtW
        l6W0+VTBC+IIJpRRJ5SwvXw/fXS/fpJ3AoxMtE3Scw==
X-Google-Smtp-Source: ABdhPJyVJgxxJVpDY9insgMX6W4W7G8Oh6wrR0fBtN3/ValDDe+pJNsgheDGKqmofXkzKWCVe0Ap8/pllpiRBgywY/0=
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr18406362wml.128.1590276109183;
 Sat, 23 May 2020 16:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <1e6bc0e299901f90613550570446777fbccdc21e.camel@seznam.cz>
 <CAJCQCtSWX0J69SokSOgAhdcQ6qkKHfaPVhbF4anjCtVFACOVnQ@mail.gmail.com>
 <139f40a70cf37da2fef682c5c3d660671d8af88d.camel@seznam.cz>
 <CAJCQCtQXBphGneiHJT_O7VHgZkfqfHaxmkAwFEzGPXY5E7U_cA@mail.gmail.com> <3bc39223e567b7a4eca13bc554c74ef0c36fbaf2.camel@seznam.cz>
In-Reply-To: <3bc39223e567b7a4eca13bc554c74ef0c36fbaf2.camel@seznam.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 23 May 2020 17:21:33 -0600
Message-ID: <CAJCQCtQmTan=rrRJ2ALM25DnUt05Xdsuae9GR88L5mB=OR+QVA@mail.gmail.com>
Subject: Re: I can't mount image
To:     =?UTF-8?B?SmnFmcOtIExpc2lja8O9?= <jiri_lisicky@seznam.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 23, 2020 at 8:38 AM Ji=C5=99=C3=AD Lisick=C3=BD <jiri_lisicky@s=
eznam.cz> wrote:
>
> [root@localhost-live tmp] # btrfs rescue super -v /dev/loop4
> All Devices:
>         Device: id =3D 1, name =3D /dev/loop4
>
> Before Recovering:
>         [All good supers]:
>                 device name =3D /dev/loop4
>                 superblock bytenr =3D 65536
>
>                 device name =3D /dev/loop4
>                 superblock bytenr =3D 67108864
>
>         [All bad supers]:
>
> All supers are valid, no need to recover

OK. So they're good.

>
>
>
> [root@localhost-live tmp]# mount -o ro,recovery /dev/loop4 ./mnt
> mount: /home/jirka/tmp/mnt: can't read superblock on /dev/loop4.


But it can't be read? This doesn't make sense. What kernel messages
are reported at the time of the mount attempt? When using a newer
kernel, the recovery command is deprecated but should still work. The
new command is 'usebackuproot'

What do you get for:

# btrfs insp dump-s -fa /dev/

--=20
Chris Murphy
