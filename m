Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1012198733
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 00:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgC3WPF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 18:15:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37425 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgC3WPF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 18:15:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so23660409wrm.4
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Mar 2020 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFXmm3ou+M0vLo9A+Sc64SMvlcfpyBw1FMIVJKdZOvg=;
        b=N6YPcwXeQEmAPbLhwswAAto+9o7tdHbNVVEud3XXsfWCAlXmCj/fKhRA/vFfc8VsRl
         5JhAw4xRpB861fxJ/MmH/raWGh1Wt/buF/QH+m74GR4vkiMLucAKjzYI0dK+vqY3UlD9
         JUk7x4bh0zGv53kUeqLWTdCIHywkv57eUJzMrgM4x5Atkc/3qzGsDMRunMPLPUmROK/W
         970gloR4KOwgeN3a/l7mmGVaCu64HGziA4pJuXE4iZ5AOZQlHnkVHJMJjZkCjw+rrmGr
         GWvZRhiAfPiBkHUmqycMfMUuiS3BAnoqtp+TxB0Vwn+5qjt0xHZ2cVh0ePGBqd6X5nZE
         b8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFXmm3ou+M0vLo9A+Sc64SMvlcfpyBw1FMIVJKdZOvg=;
        b=fq7yFUvzXrvv5NFZklyywai0Cq8jLzwJTlBAVHKf/Gppjh06bBNGrFc1UNhHoRGDYD
         +ji2EtAg1zqpGvSB2DkSIjUoWax18GvZR1xI1DpJ3SYCKH0ieh2u4WjoiiA21YyrdK9k
         ySXBRDDVwlFkI2CQQPQVQCdPpAUc40RBX1GxFXZJdrFwDg1dmv04g6UszOl/2y8Ql4GV
         MmmZ+Hn0rPltCFO+T9VfwwUc2lI4kdxnnFVA0Jm7kHEGPbzl8zs+QjqOqPsNwGHXMYis
         GSUGCSdTGlT3U5aoMzVx5iJtY/qUpJ4VfIswAS4IwO9X9HaBR05wPDTH3hylBwNgxb6m
         UUXg==
X-Gm-Message-State: ANhLgQ3gP7VD3XCWHIBNIOJFhEOt2SWjecHxEY33K8VEIf6Zs6rY5iuy
        F8HB8HOL1txnhC/yCh12Jul2DN7XP0LwcreMA2SB8H+f+k8=
X-Google-Smtp-Source: ADFU+vuU00xYhm/JRN1s/eCt2yAwfolwQEhqqrpEl5ePX8XAwjpuW+kpqY6YIepdIDBT7XY+EbVpoinkDdvei23LUiY=
X-Received: by 2002:a5d:6847:: with SMTP id o7mr16679188wrw.274.1585606503019;
 Mon, 30 Mar 2020 15:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <7c0a1398-322f-400a-abe4-dfea98fd46e1@templetons.com>
 <20200328212021.GA13306@hungrycats.org> <7778ece0-67d4-8d1c-b773-35f07d81dcbe@templetons.com>
 <20200329064216.GB13306@hungrycats.org>
In-Reply-To: <20200329064216.GB13306@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 30 Mar 2020 16:14:46 -0600
Message-ID: <CAJCQCtQjjHWunKi7T2GC4MN708sF5RPJmx+w1o8Y_LDzdK3RXQ@mail.gmail.com>
Subject: Re: btrfs-transacti hangs system for several seconds every few minutes
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Brad Templeton <4brad@templetons.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 29, 2020 at 12:42 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> 90 seconds sounds about right for the block group scan when mounting on
> a 10TB filesystem.  There's a feature called block group tree in kernel
> 5.5 that helps with that:  it lays out block group items on disk closer
> together so they can be read in milliseconds.  This is an on-disk format
> change, so once you enable that feature, you wouldn't be able to mount
> the filesystem on an older kernel.  This can be a problem if your
> sound drivers have regressions.  You might want to wait a few kernel
> releases to be sure you don't need to downgrade.

I'm not seeing anything about block group tree in btrfs/super.c.

There is block_group_cache_tree but I'm not seeing anything about it
in 'man 5 btrfs' using btrfs-progs 5.4, or in the devel branch.

So I'm not sure what mount option or btrfstune option this would be,
seems to be automatic?
https://github.com/kdave/btrfs-progs/commit/2eaf862f46b3ccb6b7248a0417ebf7096bc93b80



--
Chris Murphy
