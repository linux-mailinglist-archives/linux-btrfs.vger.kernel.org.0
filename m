Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE521B8D78
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 09:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDZHg3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgDZHg2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 03:36:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651C6C061A0C
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 00:36:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v8so13362506wma.0
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+9/f/jUEDWVveCOKpAM+EhxqNGQdwlllXIWUzZJEZs=;
        b=AVMcyO4YbF+nAlQGuAS/yjKPXJkNJeMNBHWYQ8XL3MVZaGffJn77rsz7G3N5trCHx2
         6O3fwgyzxcDOe9YXPpTCRlh8/Z5hD3JoaUoU5amF841Q3vWH21yKI0ZcxPHW3LNOlspx
         C5/RyZ/JfOnuNPRcayKzdZNB/ZGKqnyzCXwcPf0higOs55guPl7nsYTSQ5hwm9+A3lxB
         gRBExHHi01uLgsfbLrk48qQFPzUIW2jDDwoXY2Hg3nyhgPoiOlQC39iwgVdc/LDIW6av
         qnN4pkNxKR7KBGpbtcemfYOFS3qdg8PQ2f+Qrk6c40I8JIIrg/Bg2C8W0/GXPJz5NK5t
         mdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+9/f/jUEDWVveCOKpAM+EhxqNGQdwlllXIWUzZJEZs=;
        b=EFBivHX3oKOZGoHyxNIXxIvnkI4SNSyu5+3dcUIZPrJi3xyfi6uuO440P2d6ZN1Njt
         8VGlX0Oc7rxdNqX1FdZonmWKyRx0T732RQMwIM7kZieua7EPOGwm2jC7reFvrqtQUWDO
         XwkWaPJBdlhyV2EZIPK7p81ShwtQ5BicNr5D1keLBwhJAdZLTQUNVzYRYN/IubZ+SqDs
         5cUrHwE8kVaFArIdNxKuaK4Hy9vG4NIf+hdOyA7O9z6h0w68NK6igpLU/XLjvK7K6s0N
         S2cAboXNpkusuWBppQi2qj5AhIL4Isg280bjZFnYNktvKWDLcz19NyWqkFsLnP7mdAoG
         775w==
X-Gm-Message-State: AGi0PuYZORr0kOqdfvm1O0WLlORXdqv0EdHrBT/VgsLe744bNtAsJ01j
        IE1nWgT7RW0zBxbmdbKXKDJZeNxsoPJt0xYEmyvPww==
X-Google-Smtp-Source: APiQypJ/NL9XFsa0faPCmbJdnQnH1dfN433OZ5WS+F8n/1utyHe/XB56joYuUYXPTHwBudmVr7vHyQRS9PG6xnkqlQY=
X-Received: by 2002:a1c:6455:: with SMTP id y82mr19472031wmb.128.1587886586882;
 Sun, 26 Apr 2020 00:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
 <CAJCQCtTdghbU1au1AOpeF2v_YxZoh_d1JZpu2Jf7s_xMdT=+rQ@mail.gmail.com>
 <CAP7ccd8u-pStGzCau+bcYEVjRy+SPE+JQz169i_2NiY8dfUXuQ@mail.gmail.com>
 <CAJCQCtSdyP_SspJGwitWSOM1mvT-_ykXGq_azk=R+jqCZ+V4Yw@mail.gmail.com> <CAP7ccd8WTtCMb2t4FWPEwrh+d3sNSPrkkpa4R=Z91-ieXK_vMA@mail.gmail.com>
In-Reply-To: <CAP7ccd8WTtCMb2t4FWPEwrh+d3sNSPrkkpa4R=Z91-ieXK_vMA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 26 Apr 2020 01:36:10 -0600
Message-ID: <CAJCQCtRy5-PBRP0K-4BDkdMJfD3U6FPDAYZSxwhFB9KoX0XUTA@mail.gmail.com>
Subject: Re: Help needed to recover from partition resize/move
To:     Yegor Yegorov <gochkin@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(sorry, reply all this time)

On Sun, Apr 26, 2020 at 12:23 AM Yegor Yegorov <gochkin@gmail.com> wrote:

> $> btrfs insp dump-s -f /dev/nvme0n1p3
>
> chunk_root              1048576
> chunk_root_level        1

> sys_chunk_array[2048]:
>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 1048576)
>                 length 4194304 owner 2 stripe_len 65536 type SYSTEM
>                 io_align 4096 io_width 4096 sector_size 4096
>                 num_stripes 1 sub_stripes 0
>                         stripe 0 devid 1 offset 1048576
>                         dev_uuid e2815a2c-6ec8-45c6-baae-7f429a5f0f78

Super and backups say the system chunk is at 1048576, and root is at 8612052992.

btrfs insp dump-t -b 8612052992
btrfs insp dump-t -b 1048576


> superblock: bytenr=274877906944, device=/dev/nvme0n1p3
> ---------------------------------------------------------
> ERROR: bad magic on superblock on /dev/nvme0n1p3 at 274877906944

? OK but why does it even go looking for this 3rd super? A file system
of this size doesn't have a 3rd super, which appears at 256G.

There's no dmesg for the resize? This should report the block group
changes that happen as part of the resize; and also the fs size
change; and also the partition map change. And if it is rebooted, then
dump-super shouldn't be looking for a 3rd super.

What do you get for 'lsblk'

--
Chris Murphy
