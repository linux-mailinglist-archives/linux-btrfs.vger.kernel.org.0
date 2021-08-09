Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CE93E45AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 14:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhHIMhB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 08:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhHIMhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 08:37:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECAFC0613D3
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Aug 2021 05:36:41 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id o20so23224497oiw.12
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Aug 2021 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=R5nLoqg/DgxvLxj8COiouJhS0dH9c0ZAj+4FPxEuc0w=;
        b=TGGy38d1IGkqCSyyznpBKjc2rir7iiFE/fCCcHL01ih5xiQEtaBUFti6SFUKZCQiXo
         5m/QbUrKdb1lEBek9PFn7+k4TjkKQpvpKrEl7P6ZR5MvGBnTjHtNgAJYY86IJK7Zzram
         SbYdm6H094WqQb5+/xKyG8/w86+8S14r/oKuEULkOvL9U3np+au1Ky4KzG5a5zbyWuqW
         IbrZviBy9PjN3hZRVrjHjB41N5ggcc1Y7HPkMW5HhKj6KAqMHRj3vzO8CS4L3fkYjvXC
         6vlyMcIT+un2KCDPPFnf8h+PmZIr2WodhMcBjTBMv08zVJAo4ZQuwQNswoplS351uMrP
         ZVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=R5nLoqg/DgxvLxj8COiouJhS0dH9c0ZAj+4FPxEuc0w=;
        b=HSIMpOzfF1iw1Bj8OPkCna8pKwG11PpUG6TvHO/9cdabyf6i84BVS2maVUyIFkpbdq
         2T9cF/tUcP/wKmUeorl+yM6rM/SgAK1jIiKCE/yFPrUoo4mqAUOqIcDTh6ksOkciX0js
         QkMQl0hEJJj/J0lO5GgYqSW22mCEKs0WPkjm5tzqtydJstHXO8/5NOZs/wm/9U4hWfux
         GT/1MSrTMpPTp2BHyfCShuH/ugVJqu3KWQWM6f4ajRvOMd7/c91ZSLxPqhRkPW6k/7dQ
         LMDYxksusAyvPlkDNMj6mpIs3P3lGYGqhORxLsHUUb+rFeiw8MZRM9QDfDjaTsyrgoGM
         bQ7g==
X-Gm-Message-State: AOAM531/Yn/ILZCAq1Yjk3l/4k1ttkk2UgVzr0JCWzGD32SlrM8Ws9Tt
        1Ben2iTeqDm8+m5zF4lglVemWYEB0xAGQHk6aWknsp+ZNew=
X-Google-Smtp-Source: ABdhPJxgBfGhyIeK3nNeKXq3qUQJ1FcTfwjNphykEQ5IBW1oYmMDTWnnmp4eNBCz+b1Aftlfmt7mxxe/iMqvL6EEIeo=
X-Received: by 2002:aca:5d83:: with SMTP id r125mr15727074oib.113.1628512600263;
 Mon, 09 Aug 2021 05:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPqC6xQcJa7y2mPWxRM7_kNtdawFgEtFtGLP0K2A_UXU0X6u8g@mail.gmail.com>
 <9073e835-41c2-bdab-8e05-dfc759c0e22f@gmx.com>
In-Reply-To: <9073e835-41c2-bdab-8e05-dfc759c0e22f@gmx.com>
From:   Serhat Sevki Dincer <jfcgauss@gmail.com>
Date:   Mon, 9 Aug 2021 15:36:28 +0300
Message-ID: <CAPqC6xQZvcg1XNeRGYW+1UAXrVXbWhxp4Hqq2nMMJXTvKYnT+g@mail.gmail.com>
Subject: Re: max_inline: alternative values?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also, in the case of DUP metadata profile, how about duplicating
"only" the metadata in the two blocks? The total inline data space of
2 * 2048/3072 =3D 4096/6144 bytes
can carry unduplicated data.
That requires I think metadata and inline data have separate crc32c sums.
Is that feasible?

On Mon, Aug 9, 2021 at 3:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/8/9 =E4=B8=8B=E5=8D=887:15, Serhat Sevki Dincer wrote:
> > Hi,
> >
> > I was reading btrfs mount options and max_inline=3D2048 (by default)
> > caught my attention.
> > I could not find any benchmarks on the internet comparing different
> > values for this parameter.
> > The most detailed info I could find is below from May 2016, when 2048
> > was set as default.
> >
> > So on a new-ish 64-bit system (amd64 or arm64) with "SSD" (memory/file
> > blocks are 4K,
>
> For 64-bit arm64, there are 3 different default page size (4K, 16K and 64=
K).
> Thus it's a completely different beast, as currently btrfs don't support
> sectorsize other than page size.
>
> But we're already working on support 4K sectorsize for 64K page size,
> the initial support will arrive at v5.15 upstream.
>
> Anyway, for now we will only discuss 4K sectorsize for supported systems
> (amd64 or 4K page sized aarch64), with default 16K nodesize.
>
>
> > metadata profile "single" by default), how would max_inline=3D2048
> > compare to say 3072 ?
> > Do you know/have any benchmarks comparing different values on a
> > typical linux installation in terms of:
> > - performance
> > - total disk usage
>
> Personally speaking, I'm also very interested in such benchmark, as the
> subpage support is coming soon, except RAID56, only inline extent
> creation is disabled for subpage.
>
> Thus knowing the performance impact is really important.
>
> But there are more variables involved in such "benchmark".
> Not only the inline file limit, but also things like the average file
> size involved in the "typical" setup.
>
> If we can define the "typical" setup, I guess it would much easier to do
> benchmark.
> Depends on the "typical" average file size and how concurrency the
> operations are, the result can change.
>
>
>  From what I know, inline extent size affects the following things:
>
> - Metadata size
>    Obviously, but since you're mentioning SSD default, it's less a
>    concern, as metadata is also SINGLE in that case.
>
>    Much larger metadata will make the already slow btrfs metadata
>    operations even slower.
>
>    On the other hand it will make such inlined data more compact,
>    as we no longer needs to pad the data to sectorsize.
>
>    So I'm not sure about the final result.
>
> - Data writeback
>    With inline extent, we don't need to submit data writes, but inline
>    them directly into metadata.
>
>    This means we don't need to things like data csum calculation, but
>    we also need to do more metadata csum calculation.
>
>    Again, no obvious result again.
>
>
> > What would be the "optimal" value for SSD on a typical desktop? server?
>
> I bet it's not a big deal, but would be very happy to be proven run.
>
> BTW, I just did a super stupid test:
> ------
> fill_dir()
> {
>          local dir=3D$1
>          for (( i =3D 0; i < 5120 ; i++)); do
>                  xfs_io -f -c "pwrite 0 3K" $dir/file_$i > /dev/null
>          done
>          sync
> }
>
> dev=3D"/dev/test/test"
> mnt=3D"/mnt/btrfs"
>
> umount $dev &> /dev/null
> umount $mnt &> /dev/null
>
> mkfs.btrfs -f -s 4k -m single $dev
> mount $dev $mnt -o ssd,max_inline=3D2048
> echo "ssd,max_inline=3D2048"
> time fill_dir $mnt
> umount $mnt
>
> mkfs.btrfs -f -s 4k -m single $dev
> mount $dev $mnt -o ssd,max_inline=3D3072
> echo "ssd,max_inline=3D3072"
> time fill_dir $mnt
> umount $mnt
> ------
>
> The results are:
>
> ssd,max_inline=3D2048
> real    0m20.403s
> user    0m4.076s
> sys     0m16.607s
>
> ssd,max_inline=3D3072
> real    0m20.096s
> user    0m4.195s
> sys     0m16.213s
>
>
> Except the slow nature of btrfs metadata operations, it doesn't show
> much difference at least for their writeback performance.
>
> Thanks,
> Qu
>
> >
> > Thanks a lot..
> >
> > Note:
> > From: David Sterba <dsterba@suse.com>
> >
> > commit f7e98a7fff8634ae655c666dc2c9fc55a48d0a73 upstream.
> >
> > The current practical default is ~4k on x86_64 (the logic is more compl=
ex,
> > simplified for brevity), the inlined files land in the metadata group a=
nd
> > thus consume space that could be needed for the real metadata.
> >
> > The inlining brings some usability surprises:
> >
> > 1) total space consumption measured on various filesystems and btrfs
> >     with DUP metadata was quite visible because of the duplicated data
> >     within metadata
> >
> > 2) inlined data may exhaust the metadata, which are more precious in ca=
se
> >     the entire device space is allocated to chunks (ie. balance cannot
> >     make the space more compact)
> >
> > 3) performance suffers a bit as the inlined blocks are duplicate and
> >     stored far away on the device.
> >
> > Proposed fix: set the default to 2048
> >
> > This fixes namely 1), the total filesysystem space consumption will be =
on
> > par with other filesystems.
> >
> > Partially fixes 2), more data are pushed to the data block groups.
> >
> > The characteristics of 3) are based on actual small file size
> > distribution.
> >
> > The change is independent of the metadata blockgroup type (though it's
> > most visible with DUP) or system page size as these parameters are not
> > trival to find out, compared to file size.
> >
