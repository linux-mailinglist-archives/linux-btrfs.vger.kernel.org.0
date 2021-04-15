Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A806B36024A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 08:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhDOGTz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 02:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhDOGTz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 02:19:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A715C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 23:19:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n138so37422601lfa.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 23:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caEAXPXg15WaEQQmshxB/9vXCvTzdqEGJmhHWDA/zzw=;
        b=KZTo2YdV/l+ddb2FS/En8YNRzuLgqALtl4Wz8aU2RsfcGdKsWFRG1o8wBBOB2aDfKR
         k9S8F366+kfBa9oPZAQlrPj5iUxOxQimezKddMOyhBMSupXryuzmjzqIg7C4tU+CBVRZ
         hA8b4TRhjpRhc1Zi/+ovbPQpW8Xwmp2bC5DinFsxCoxdEK/HFkcvy50PBpE0ZB/Uzcze
         QqHF8cHvwzKWlkIA0a7IaT/t0KcF/rnv0r3VXNlQoQYyj4Uu7KC7/BHDFDaws5ibfRoe
         j+UhsbAUJodBdSyTtAs8MbE/Qv35Y72tkTyRHro8YKquHnddkJTNLK4FdZb8STKIjVA7
         dS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caEAXPXg15WaEQQmshxB/9vXCvTzdqEGJmhHWDA/zzw=;
        b=Dz1fSoFT5Ag4q5c9pD/F8wmafYv8AFRNdYJtKixyc1BzxKrM1m0O0/iMB5wm8CSl12
         1t4QTzPrfHsmAnqwcgv90vMKMNGn1sA9DFoM9UgKId55ZMFiGOiTuP63IOaZ0WLe6imm
         3R07m2PfSFrtYKSnj7KXsXt7iaAnT71U+9T/SVhyHT7ccjCmQhDObnzs7fZ3ixvkLGga
         f1pFRfH4QlOMjsMOztnmTC29gZ5xoUVJWZGClMjY1pV9wLbo5YKtdKdrCvhJERkXuWbI
         xbqUYzU5uLOrbEmL/WOnirXlIxeILqFAYKcg05m0rwIJXg67eU+WauXxQjx9eJSKNl3s
         VIGw==
X-Gm-Message-State: AOAM533w0fT6aLyZ5GV8Z/2Ot6KZwNciupjmsP9tPLu0IygDyGWVLigc
        /Hb8geML/qmfb/TEKOyglwPUBJaIpm30OZHMorOGemIQjU04fPBm
X-Google-Smtp-Source: ABdhPJxSzVPlE9ptscxfV/ni4ZZL+hYeWHVSODWvb9CrrAD6X4fnVCFF56nk1VN6OP52Jm5iRzejvloyzBjgH1eNT8w=
X-Received: by 2002:a05:6512:2209:: with SMTP id h9mr1427676lfu.552.1618467568978;
 Wed, 14 Apr 2021 23:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210325131008.105629-1-foxhlchen@gmail.com> <20210409123251.86BE.409509F4@e16-tech.com>
In-Reply-To: <20210409123251.86BE.409509F4@e16-tech.com>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Thu, 15 Apr 2021 14:19:17 +0800
Message-ID: <CAC2o3D+TkW7js=C+XYdnxs8wxruQ3kT3rutVBeuaozz2N9FDMA@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: utils: fix btrfs_wipe_existing_sb probe bug
To:     wangyugui@e16-tech.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 9, 2021 at 12:32 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> > btrfs_wipe_existing_sb() misses calling blkid_do_fullprobe() to do
> > the real probe. After calling blkid_new_probe() &
> > blkid_probe_set_device() to setup blkid_probe context, it directly
> > calls blkid_probe_lookup_value(). This results in
> > blkid_probe_lookup_value returning -1, because pr->values is empty.
> >
> > Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> > ---
> >  common/device-utils.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/device-utils.c b/common/device-utils.c
> > index c860b946..f8e2e776 100644
> > --- a/common/device-utils.c
> > +++ b/common/device-utils.c
> > @@ -114,7 +114,7 @@ static int btrfs_wipe_existing_sb(int fd)
> >       if (!pr)
> >               return -1;
> >
> > -     if (blkid_probe_set_device(pr, fd, 0, 0)) {
> > +     if (blkid_probe_set_device(pr, fd, 0, 0) || blkid_do_fullprobe(pr)) {
> >               ret = -1;
> >               goto out;
> >       }
> > --
> > 2.31.0
>
>
> With this patch,  'mkfs.btrfs -f /dev/nvme0n1 /dev/sdb' output some
> error when /dev/nvme0n1 have 2 partitions.
>         ERROR: cannot wipe superblocks on /dev/nvme0n1

I am not sure this error is caused by my improper fix, or bugs lie
somewhere else on mkfs.btrfs path.

But without this patch, I think, btrfs_wipe_existing_sb will not do
what is supposed to do -- wiping out existing superblocks.
Instead, it does nothing and always returns 1. Since it has no effect
and nobody complaints about it, that brings a question, do we really
need to call it in btrfs_prepare_device?

> # blkid
> /dev/nvme0n1: PTUUID="93a54ce8-04b2-470b-8c05-31bfcef02f28" PTTYPE="gpt"
> /dev/sda1: LABEL="OS_USB" UUID="2b7f4cb9-3dac-443f-8c96-a907b9276942" BLOCK_SIZE="512" TYPE="xfs" PARTUUID="ee58e9d3-01"
> /dev/nvme0n1p1: UUID="1d94dc2b-abd1-47df-bf39-ab31cf579d29" UUID_SUB="577542b7-91f5-48d4-a54c-98cbd4525c00" BLOCK_SIZE="4096" TYPE="btrfs" PARTLABEL="primary" PARTUUID="efed009f-8ae6-4567-9cd3-80a57cdcf225"
> /dev/nvme0n1p2: PARTLABEL="primary" PARTUUID="fcab66cd-daad-457f-a53c-110592d8941f"
> ...
>
>
> Without this patch,  'mkfs.btrfs -f /dev/nvme0n1 /dev/sdb' have some
> issue too when /dev/nvme0n1 and /dev/sdb  have some partitions.
>
> some blkid of partition is still left in the output of blkid.
> 'blockdev --rereadpt' will let them disappear.
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/09
>
>

thanks,
fox
