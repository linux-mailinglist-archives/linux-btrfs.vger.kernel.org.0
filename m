Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35345BBEEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 01:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503544AbfIWXVz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 19:21:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40361 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbfIWXVz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 19:21:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so15754066wru.7
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDrCeZpjAJfJ1+ExIY6o7IWA5FK2iRnCwzSGbrZ5ijY=;
        b=Xz4n2MAJsCu5WVJkL+2a8DAGFyfKClsNd0p7XJvhWKuvEnqqf5ZyibNS8sxzUssPN4
         gMO07dirEmvv6E9A66rVELjPGIbJenjRLAMtXIHoBEjyc0LbQrgEnvQPbIH8pg51Q6DW
         J4smaYIS+Aq/tTUx0l3866q3FbD1YV3OkD2wbo1DkNPqEtHWrdxykTew0LEIvcImrqMN
         N1Tj+vDVIAG4cMgMweFQyldcDz3QCFvdQCU/1iChlqYqOe5nqRgtRZnhGvWNldV9ek66
         zB4gPfOFh0h8E3nw98YMVgiXQTaBNMpx9flagV+goyorWkWYJi/IwG5QId45b9W2UbIk
         S+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDrCeZpjAJfJ1+ExIY6o7IWA5FK2iRnCwzSGbrZ5ijY=;
        b=prV8exDxmQ5krqen6Gwd6z7w5IDjPPehGXLWVfuMEzmW8C8FnCgdT393pr/kPAfWip
         lrncjYyY9XzOMmlJpG6xFIF/MTVccGeFeVngBjGA4eBRSZpVPF40uy90RvOHAuJZLI8w
         NJFW+6eGKhk6mAXyfSWDXxd9Od3Zhf0MuIg6QJSUWsj7LvJP1AOKGopp6AyNhciVjEKN
         hIUw4xeaN9gVS+1R9qIbQzwFeCR0KLxlCtLj+uwg2EuSIgTk2DAiVl/l94bL655nHip9
         uc0ZkNmkDQQEdEXQqQ+pmynToVf7fAnjpJ0oaNrEXDb65pTVf8diErJUwMLi7wyykDjb
         63pQ==
X-Gm-Message-State: APjAAAUFhPYfq+v5linqSVeXiBD6ahLP7yGNMYb3/WENAC9cl5MwO68E
        1VUO7rePCwDOdAZOjbBGvzfqerpAiPz2HsaD4Qs9ow==
X-Google-Smtp-Source: APXvYqyzGJR6VLS83AOPW19DV+8ujx4TQI8C8XEbD8LR6nm1dLmGh+ioUTKzZ94qKxJdiLlWZAqaU2m+0PRIn6tvFBI=
X-Received: by 2002:adf:efcb:: with SMTP id i11mr1234200wrp.69.1569280913701;
 Mon, 23 Sep 2019 16:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
 <CAJCQCtRAnJR+Z8Z8Bq91YXiMpfmwOiHK0tQ+9zAJvSVvexHnxg@mail.gmail.com>
 <54fa8ba3-0d02-7153-ce47-80f10732ef14@petezilla.co.uk> <CAJCQCtQLk1m8yAxPPDLVZBr3MehdDD3EpNZ6O_OCRsO-FFzRNw@mail.gmail.com>
 <eb9fdaee-ec76-5285-4384-7a615d3cd5c1@petezilla.co.uk> <00be81e2-bca2-3906-c27d-68f252a6ffe1@petezilla.co.uk>
 <CAJCQCtRbjz138p_DVX4=v0e38rtDFjpqrOhBTc4o7Mc=s_zcEw@mail.gmail.com>
 <fe29580c-3239-f338-6a27-28739fbe7415@petezilla.co.uk> <CAJCQCtQrLfqzraCVsMpw99CkHjbAJcfJTrKAdLg6A2G3wtzZtQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQrLfqzraCVsMpw99CkHjbAJcfJTrKAdLg6A2G3wtzZtQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 23 Sep 2019 17:21:42 -0600
Message-ID: <CAJCQCtT6e+bvEn7Yn1+hfN30BnMudv2pmoDYzR1LwyRM1PV9Xg@mail.gmail.com>
Subject: Re: Balance ENOSPC during balance despite additional storage added
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 5:10 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Mon, Sep 23, 2019 at 4:11 PM Pete <pete@petezilla.co.uk> wrote:
> >
> > On 9/23/19 10:52 PM, Chris Murphy wrote:
> > > What features do you have set?
> > >
> > > # btrfs insp dump-s /dev/
> > >
> >
> > root@phoenix:/var/lib/lxc# btrfs insp dump-s /dev/nvme0_vg/lxc
> ...
> > sectorsize              4096
> > nodesize                16384
> ...
> > compat_ro_flags         0x0
> > incompat_flags          0x161
> >                         ( MIXED_BACKREF |
> >                           BIG_METADATA |
> >                           EXTENDED_IREF |
> >                           SKINNY_METADATA )
>
> Totally a default file system, looks like to me.
>
> Bug 204973 - ERROR: error during balancing '/': No space left on device (edit)
> https://bugzilla.kernel.org/show_bug.cgi?id=204973
>
> Since I've reproduced it with all new progs and kernel I don't think
> you need to add anything there.

Guys, I'm not seeing anything queued up for 5.4 related to this so I'm
not sure whether it's a known problem or not. This enospc happens with
5.1.21 through 5.3.0. I reproduced it on a brand new file system about
2 weeks old that's only ever seen 5.2.9+ kernels, first hit the enospc
with 5.3.0. I've got three complicating features set compared to the
original poster above: space_cache=v2, no holes, compress=zstd but
since he's hitting this, I don't think it's related to those features.

It seems what's in common is this type of error:

[  183.580410] BTRFS info (device sda4): unable to make block group 22020096 ro

-- 
Chris Murphy
