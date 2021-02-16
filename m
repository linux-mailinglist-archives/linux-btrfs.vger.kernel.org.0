Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6CB31CE0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhBPQ3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 11:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhBPQ3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 11:29:08 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1524AC0613D6
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 08:28:28 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id m9so8910856ybk.8
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u4wpdcglr6pfCNe03DeTC27/Y/d/2lu2DlIRSP05z74=;
        b=l9qxmvUFLZfexVFhjWo2j3i6zEu3mhqBdQBhml30+OfkCAlYx8S+C8MyJDAbWBJ3jd
         ZdWkH4Jd7ZCqco0fVH1JaUYo6fa+Gs/SyI8qGCbbWrpE+Z5HcXySFEYd0V1Nsr2zvBzT
         X1TFtmSMH81Nusul2wEnVJamWQr5BPmqREtiR2lmsnN7DNDv2A49PUIPThq67iEJ+5Sj
         G9s8ilL7TURIn2pDxrkw+WF5HI8IR8Uz8jvGJWSfBjiIO4ck0cNU0+nnWaY/G4MZjTt0
         MSRSLp09vt6Y9R5dzb1gOoZ764t59ovQIpGB8NkPDj2V3/Dw+h48Pxct/hH+l+UTvnL3
         QQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u4wpdcglr6pfCNe03DeTC27/Y/d/2lu2DlIRSP05z74=;
        b=WdiqBfxHot2bw8py30IGzn5eUeOiVOK2Ga//4hcgNTss+E1npNhIv1SDbsZLXZhiuG
         0Tg0z2FuMRcT88zEbVDxlyEUnhxxd4gkMKK8/nlSDFLF5jfFYccZahj4BE1K48HnCw1T
         +/v8RP7DhyZA3UJ6URWiKpMOkybAg1vZ5lM+/5P4oEAlZkJqweHi5KF4jQPpEzAJ38Td
         UQ/GxeH9SeVxnqHh18ox9PS67njhxeICiYg6yWYICYAhaEztumcyKFQwyhbz6PlygdHB
         5ZhciwNxXU5u2Lt8IhzJL0k/IZ0P6D5a5dR4WQ8ZAzPdFXRsy47LuK8DTWaz8Cay9jQS
         vtEQ==
X-Gm-Message-State: AOAM530dZfyJTzGlfPteyvM3YQu5+ZRcYvqby1MQWqFMWmUcNgq38aaH
        tq46xDEOgNswU6t3O5WOGeKVPt0LMovE7Ll/oQssKHC19WofZw==
X-Google-Smtp-Source: ABdhPJyhzbSxUK7Es/qvOFQhYzJsSDq5A37czheTYHUuk/2IeKQiAZkxXk6lIV4yjQ3GXZKVd4xoburKikqhikhAMOg=
X-Received: by 2002:a25:d145:: with SMTP id i66mr32378366ybg.0.1613492907236;
 Tue, 16 Feb 2021 08:28:27 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com>
In-Reply-To: <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 16 Feb 2021 11:27:51 -0500
Message-ID: <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/14/21 3:25 PM, Neal Gompa wrote:
> > Hey all,
> >
> > So one of my main computers recently had a disk controller failure
> > that caused my machine to freeze. After rebooting, Btrfs refuses to
> > mount. I tried to do a mount and the following errors show up in the
> > journal:
> >
> >> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk =
space caching is enabled
> >> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has s=
kinny extents
> >> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): c=
orrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, invalid i=
node transid: has 888896 expect [0, 888895]
> >> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): bloc=
k=3D796082176 read time tree block corruption detected
> >> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): c=
orrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, invalid i=
node transid: has 888896 expect [0, 888895]
> >> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): bloc=
k=3D796082176 read time tree block corruption detected
> >> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): co=
uldn't read tree root
> >> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open=
_ctree failed
> >
> > I've tried to do -o recovery,ro mount and get the same issue. I can't
> > seem to find any reasonably good information on how to do recovery in
> > this scenario, even to just recover enough to copy data off.
> >
> > I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
> > the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
> > using btrfs-progs v5.10.
> >
> > Can anyone help?
>
> Can you try
>
> btrfs check --clear-space-cache v1 /dev/whatever
>
> That should fix the inode generation thing so it's sane, and then the tre=
e
> checker will allow the fs to be read, hopefully.  If not we can work out =
some
> other magic.  Thanks,
>
> Josef

I got the same error as I did with btrfs-check --readonly...

# btrfs check --clear-space-cache v1 /dev/sda3
> Opening filesystem to check...
> parent transid verify failed on 796082176 wanted 888894 found 888896
> parent transid verify failed on 796082176 wanted 888894 found 888896
> parent transid verify failed on 796082176 wanted 888894 found 888896
> Ignoring transid failure
> ERROR: could not setup extent tree
> ERROR: cannot open file system


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
