Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBCA3FC682
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 13:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbhHaLXG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 07:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbhHaLXF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 07:23:05 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13C7C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 04:22:10 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ew6so10092210qvb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qedAv8cgRW+lyO+mYCUNqrvWuH3+WzLppepdqwnS7Bc=;
        b=rZUdc7rEwJQ81+JPDCYWB15Rqb3iBYhnX6H2HLD//2NB1pb6qaHZw2voBxLKePr00H
         CEZzfMrFXRHCaBlTvYzT1p3k11fPgOAjo66TB6gegRZ7i9YdbNkdn+m1XIaMXFMKQbC9
         g+WjihZ1PJ33aDDJTAgszr82ws/gH7Mye4nSxd9nSnlyqXSuM7huO/J+UZEXDmggUX/J
         sII9SDF2T1mUYiYgaDtEGBC8hhfnIprWo2ZlWgk4BCS67YMpKs49t4SZ+Nl5ReWwucwf
         au28KO6Ntfn4V6Nx9RYW1oHMDalNTXiUW2SjGshH6rDBfLGT14veoZ0NqTygmyhUAHec
         SPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qedAv8cgRW+lyO+mYCUNqrvWuH3+WzLppepdqwnS7Bc=;
        b=aHOhtHxz/mljHXV0RlGruDuoW/Z5MRIpLRmH8bAO56Fy+M8IxBj5raMbHUW2gToknj
         qaj0p9TvOQpSraL3qAgp6r4R/kWMSWV6yejujNT6sjO1NdQUcd29K4mUSE/uKqWwrbuY
         SibMBaCf5HY+22hvbLAhLQk3mkpnXeOnW6+87v4fTcGBNH4q/54OzTTubKUVGctZmdpw
         j9Tp8Yraal2tcwW57vlZjRvZJ8k/HUURToj9JMggsoqA4/v+IQn4IoCCqkcty/hqg9L2
         3+n/PDZrSgfKQcmk4eBwmQxae5RMHB5qyjnoerVw1D5qc1o5pkpLoGRmRZuQzWtn6DM5
         y9pQ==
X-Gm-Message-State: AOAM531NIjf8mvwh0M05fb0auyNejm6Kkk+/mf/YzkUuRxwIi07RvsG5
        oDb3QueQi9cOIrWArU4Nh/DLIFeWDFlODk4hvW6OcH2i
X-Google-Smtp-Source: ABdhPJx04ebksKT/rPNC2JBKonsbqNx8xCenmQBwQ4D2OrHb5TluVcmmVBavnCES31X7cS9jfz6ZC6UkqOL1czTWwf0=
X-Received: by 2002:a0c:ac48:: with SMTP id m8mr22061892qvb.28.1630408929869;
 Tue, 31 Aug 2021 04:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
 <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
 <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
 <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
 <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com>
 <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com>
 <CAOaVUnVL508_0xJovhLqxv_zWmROEt-DnmQVkNkTwp0GHPND=Q@mail.gmail.com>
 <CAL3q7H7MxhvzLAe1pv+R8J=fNrEX2bDMw1xWUcoZsCCG-mL5Mg@mail.gmail.com>
 <CAOaVUnXB4qoAyVcm3H03Bj2rukZ+nbSzOdB4TsKpJjH8sqOr7g@mail.gmail.com>
 <CAL3q7H7vTFggDHDq=j+es_O3GWX2nvq3kqp3TsmX=8jd7JhM1A@mail.gmail.com>
 <CAOaVUnW6nb-c-5c56rX4wON-f+JvZGzJmc5FMPx-fZGwUp6T1g@mail.gmail.com> <CAL3q7H6h+_7P7BG11V1VXaLe+6M+Nt=mT3n51nZ2iqXSZFUmOA@mail.gmail.com>
In-Reply-To: <CAL3q7H6h+_7P7BG11V1VXaLe+6M+Nt=mT3n51nZ2iqXSZFUmOA@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 31 Aug 2021 12:21:33 +0100
Message-ID: <CAL3q7H5p9WBravwa6un5jsQUb24a+Xw1PvKpt=iBdHp4wirm8g@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 12:20 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Tue, Aug 31, 2021 at 3:46 AM Darrell Enns <darrell@darrellenns.com> wr=
ote:
> >
> > Debug output from the latest patch attached. Here's the error:
> > BTRFS info (device dm-3): clone: -EINVAL other, src 400186 (root 2792)
> > dst 400186 (root 2792), off 79134720 destoff 79134720 len 4751360 olen
> > 4751360, src i_size 83886080 dst i_size 83886080 bs 4096 remap_flags 0
>
> Yep, the same weird thing as before.
>
> So the receiving filesystem gets that error, which is perfectly valid
> since we are asking to clone from the same inode to the same inode in
> the same root (snapshot) with the same source and destination offsets
> - source range and target range overlap, whence the error.
>
> However, if we go the dmesg log:
>
> [   99.834090] BTRFS info (device dm-0): send: clone_range() start ino
> 400698 offset 79134720 send root 977, clone root 881 ino 400698 offset
> 79134720 data_offset 491520 len 4751360 disk_byte 308100730880
> clone_src_i_size 83886080 next_write_offset 79134720
> [   99.834094] BTRFS info (device dm-0): send: clone_range() step 1
> ino 400698 offset 79134720, root offset 79134720 ino 400698
> data_offset 491520 len 4751360, key.offset 78675968 ext_len 5210112
> clone_data_offset 32768 found disk_byte 308100730880 next_write_offset
> 79134720
> [   99.834096] BTRFS info (device dm-0): send: clone_range() step
> 2-1-2 ino 400698 offset 79134720, root offset 79134720 ino 400698
> data_offset 491520 len 4751360, clone_len 4751360
> [   99.834112] BTRFS info (device dm-0): send: clone_range() end ino
> 400698 offset 79134720 send root 977, clone root 881 ino 400698 offset
> 79134720 data_offset 491520 len 0 disk_byte 308100730880
> clone_src_i_size 83886080 next_write_offset 79134720 ret 0
>
> We see that send is issuing a clone command using different roots
> (snapshots) for the clone operation (send root is 977 and clone root
> is 881).
> The root/snapshot IDs are different in the source and destination
> filesystems - that's normal and it's what happens most of the time.
> However I don't understand how is the inode number different, nor much
> less how the receiver attempts to use the same root/snapshot as both
> the source and destination for the clone operation - it should use
> different roots/snapshots.
>
> Ok, so, here's another kernel debug patch and also a patch for
> btrfs-progs, both added as attachments.
>
> The kernel one also at:  https://pastebin.com/raw/nfHfRuy7
> And the progs one also at:  https://pastebin.com/raw/9CbN9C0H
>
> When you run 'btrfs receive', you'll have to pass '-vvv' to it in
> order to get the debug output.
>
> Also, please provide the output of:
>
> 1) btrfs subvolume list -puqR <source fs mount path>
> 2) btrfs subvolume list -puqR <destination fs mount path>
> 3) cat /proc/mounts
>
> I'm starting to suspect that somewhere, possibly the receiving side,
> we make confusion with the snapshot uuids or generate wrong paths for
> the clone operation.

Also, what's the btrfs-progs version being used? (type "btrfs
--version" to get it)

>
> Thanks!
>
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
