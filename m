Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0DAB2C92
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2019 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfINS3Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Sep 2019 14:29:24 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36810 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfINS3Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Sep 2019 14:29:24 -0400
Received: by mail-wr1-f49.google.com with SMTP id y19so35014588wrd.3
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Sep 2019 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+B8cS2oIYsj6YFpXZomp80xkEi7aTwh4Z9BAF6bovc=;
        b=sZqNPIIYxMZOTGi1Ypz4YVDoSfxWLx5NTr4gdiIydpUquJqPQONTp4fysmKHgdZfDv
         9aBm9E3W7JZRU2GvAH6N4s96UO1uk05JJxTeAuQ8ZHvggBjEi7lruyHB6RxXw8faBZzw
         T3ZqP0gIxtW5Itv0Q+u71umwzfKJsnilQ8zAPCvSFGat4mXnO8fAJuoRYn2OCbG4sbRZ
         mkhPcwI7Qpr8hqDtn589vE2GjnL7ojr8BZXB1rsPyGyT5kY0ac6yVNAjgjQaHOEd2VmF
         2cY8F5zdfnn+9wFwuC7RXueiFUUyMwlO2dp4YubxppG816xUQRg/9r80js07QBrCSyuz
         zHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+B8cS2oIYsj6YFpXZomp80xkEi7aTwh4Z9BAF6bovc=;
        b=uZxyEPcbbQ6YULTjBxY+LkhWRQv6edM1yurvZnU3ryPX9dyEMWPwj+ullxbjNNcFNS
         lbrZTgMWwfrj3F7bkvPNtEOHmYms9O+D5IM1J93vXw94a2slI1GIdYaNVWuZLYhR3vnZ
         eS4kloXP4AmCTeFNT9WmtQzGVvW3uvY3tU0uQJCHZrYYCoBDizZJhQkBCBGvbnEmf+Ta
         tVdVQaMmAcikS6eYpSjI5vMLLfK/SgaIOHRIMmmTPmlujWiX3TSRWnb+vY0xfrhUl0Zz
         saGiGGtZcQyJ8VqHy+z0ZkCG7amT0P7cBXCeHHKqguE/tYR/xDgGJ57wvaQVll+9jIJC
         MERQ==
X-Gm-Message-State: APjAAAXr5kdT8y7BmKVu42MPaHdm6Sh8yY4uSSUQ4Sxsqm7XWGdosVhb
        YFharMzeSPWfAdeKU+t641AkZBVL0dnJgg2sQ47K4Q==
X-Google-Smtp-Source: APXvYqwsQ/WrNgdi0/GRuYTEbn9mhgG7+ZN7Do2l0vrGHZGNwM0cqrUqh0/kQO5FcXSc+UsDhdSITTLo10fEMoDAMjU=
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr4858281wrs.268.1568485761877;
 Sat, 14 Sep 2019 11:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com> <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com> <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org> <fdec5a56-8337-4cfb-4d07-425e8785102d@gmail.com>
In-Reply-To: <fdec5a56-8337-4cfb-4d07-425e8785102d@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 14 Sep 2019 12:29:09 -0600
Message-ID: <CAJCQCtQ9729my4i2hdqwyTD-PVhsQk8cRaTg9vbDT4Yn2s7SAA@mail.gmail.com>
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        General Zed <general-zed@zedlx.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 13, 2019 at 5:04 AM Austin S. Hemmelgarn
<ahferroin7@gmail.com> wrote:
>
> Do you have a source for this claim of a 128MB max extent size?  Because
> everything I've seen indicates the max extent size is a full data chunk
> (so 1GB for the common case, potentially up to about 5GB for really big
> filesystems)

Yeah a block group can be a kind of "super extent". I think the
EXTENT_DATA maxes out at 128M but they are often contiguous, for
example

    item 308 key (5741459 EXTENT_DATA 0) itemoff 39032 itemsize 53
        generation 241638 type 1 (regular)
        extent data disk byte 193851400192 nr 134217728
        extent data offset 0 nr 134217728 ram 134217728
        extent compression 0 (none)
    item 309 key (5741459 EXTENT_DATA 134217728) itemoff 38979 itemsize 53
        generation 241638 type 1 (regular)
        extent data disk byte 193985617920 nr 134217728
        extent data offset 0 nr 134217728 ram 134217728
        extent compression 0 (none)
    item 310 key (5741459 EXTENT_DATA 268435456) itemoff 38926 itemsize 53
        generation 241638 type 1 (regular)
        extent data disk byte 194119835648 nr 134217728
        extent data offset 0 nr 134217728 ram 134217728
        extent compression 0 (none)

Where FIEMAP has a different view (via filefrag -v)

 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..  131071:   47327002..  47458073: 131072:
   1:   131072..  294911:   47518701..  47682540: 163840:   47458074:
   2:   294912..  360447:   50279681..  50345216:  65536:   47682541:
   3:   360448..  499871:   50377984..  50517407: 139424:   50345217: last,eof
Fedora-Workstation-Live-x86_64-31_Beta-1.1.iso: 4 extents found

Those extents are all bigger than 128M. But they're each made up of
contiguous EXTENT_DATA items.

Also, the EXTENT_DATA size goes to a 128K max for any compressed
files, so you get an explosive number of EXTENT_DATA items on
compressed file systems, and thus metadata to rewrite.

I wonder if instead of a rewrite of defragmenting, if there could be
improvements to the allocator to write bigger extents. I guess the
problem really comes from file appends? Smarter often means slower but
perhaps it could be a variation on autodefrag?


-- 
Chris Murphy
