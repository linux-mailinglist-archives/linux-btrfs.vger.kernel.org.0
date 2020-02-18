Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37013162C8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBRRUo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 12:20:44 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37336 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBRRUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 12:20:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id w23so3844075otj.4
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2020 09:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngzxBNrl0+Hz3mvhrlR7YQDAgLkUQF7SDAl4iuMU+88=;
        b=JeHN72a1ApHJxASm5ek9n4K2kDljgpAlbRh31RwAh8k7SsUhxHgncPZ4aLoYK634k/
         WHSuuwEXh6kNdXy25y6hthlc7tsghx7v+VXhzRhTCAhI+/9q7H29cErhWEALsCIV7hle
         /oDbm1FqZf30miFE1EMBLEAw7Jpjqpl7zzVinE6XK7L/7GNgTch4wbHvG31Fzzc1HL4F
         9KWdU94BrlceeNf+Xl9vhdA43lezN2ZhP0WGDd1t/8vDTWpgv0dobDWhlYthwqKHb4yZ
         hiKd4rr4IUG8pHcei0s+Z6b+QkZuz6+1861ab4rMM25xIFGj8tZU//ZojGt25+sWV14Z
         /h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngzxBNrl0+Hz3mvhrlR7YQDAgLkUQF7SDAl4iuMU+88=;
        b=SIbR3X+aqbqx5HqPT9VNpqP3EVcZqqoDBzKamN11lzsMPsSXHP4md5VzJbhbYaFAGl
         sFc51G6urVn+kUVo+I3DIAU1YKF/AFPe9gjxMF6IQQv9MC/o+3+8JTTv2cF80YeHkEvY
         NlvOlGi/ShDWimlkt2Q7aJt1BKI4c6/+ygHukmdj/VwS/f41e+aRVKXdQtCJ8f6eWRiW
         X+K1BOecpCDgD1IaWe4Lcjhpjmp+M/fMxmKW7sLJOUhUPZQ8kdiJzbHU3Af30d8F/Zll
         IUGhddnOgcvW+mHT5bK6+zze3D3ZaFBs/yEecuvm9rptjksta3keGKwK/t0FNTCLNj9O
         qdRw==
X-Gm-Message-State: APjAAAUVD/ta7uphM3K+Mi+BfhfpWeasJUx10TtKu0o0yHrzq0yBdLR1
        roqUhewraiq63xo3d/uAXPsgT5eDUE5/ktD454O93tQk
X-Google-Smtp-Source: APXvYqzqsB7nh0xq64tebma01M0+nkb/N5wFI710juMer0J92ZI0kvnxf3vUIBtbJUG4smHPZcAQ40TXWZBNZZVvnUI=
X-Received: by 2002:a9d:624e:: with SMTP id i14mr16853976otk.371.1582046442915;
 Tue, 18 Feb 2020 09:20:42 -0800 (PST)
MIME-Version: 1.0
References: <8fb8442b-dbf9-4d4b-42bb-ce460048f891@sfelis.de>
 <CAPmG0ja40xPPcXxM+uv_v339v+8Jc5TLP_kONbkw1vWHFUer-Q@mail.gmail.com> <CAJCQCtQjRMctPYtPM-v2=ZGBMJ5T88eyVcvdgR9SfpTVWBgSOQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQjRMctPYtPM-v2=ZGBMJ5T88eyVcvdgR9SfpTVWBgSOQ@mail.gmail.com>
From:   Henk Slager <eye1tm@gmail.com>
Date:   Tue, 18 Feb 2020 18:20:31 +0100
Message-ID: <CAPmG0jYW+OFUSzYiRAQDLD_GsnBYpriABA7cT6U-=O96N15=_w@mail.gmail.com>
Subject: Re: kernel incompatibility?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Simeon Felis <simeon_btrfs@sfelis.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 18, 2020 at 3:15 PM Chris Murphy <lists@colorremedies.com> wrote:
> The btrfs device size is smaller than the partition size in both
> cases. Using an identically sized sparse file (same number of 512 byte
> sectors), both fdisk and gdisk produce a single partition that fails
> to end on a 4KiB boundary. But in any case Btrfs doesn't seem to care,
> it sets the total number of bytes for the partition to the nearest
> 4KiB.
Yes indeed, I see it now. If I create a Btrfs raid1 with same
(simulated) disksizes as in this error case, it mounts without
problems in raspbian kernel7 4.17.97 on a RPi3B+

> > Then still, there are some other errors somewhere, that might be
> > triggered by having unequeal sized partitions sdb1 and sdc1\
>
> I'm not sure how it'll matter, since Btrfs allocates a chunk, with
> same stripe sizes, and any difference between partition sizes is
> overcome by chunk allocation. Within the allocated chunks, they're the
> same. Unallocated space isn't used for anything. Quite a lot of people
> are using Btrfs raid1 with dissimilar sized devices.
Indeed shouldn't be a problem, but I was thinking some other tool or
something in the blocklayer did something wrong in the past.
The fact that sdb1 is using a proposed max/largest sector for
end_sector while sdc1 does not, I find remarkable.

> > You could look at backports w.r.t. 32-bit vs. 64-bit, maybe related to
> > changes 512 sector sizes and 4k page sizes.
>
> I wasn't aware Btrfs ever had an internal sector size less than 4KiB.
Also this remark refers to outside btrfs scope in principle, Btrfs
itself is 4KiB, but there have been changes in implementation in the
relation between logical setctors and 4k pages as far as I remember.
Although it is long time ago, so I think older than 4.19
