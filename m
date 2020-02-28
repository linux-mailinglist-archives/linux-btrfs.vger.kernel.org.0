Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3517F172ECF
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 03:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgB1C3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 21:29:03 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38104 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgB1C3D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 21:29:03 -0500
Received: by mail-ot1-f53.google.com with SMTP id z9so1249875oth.5
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2020 18:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYJrCFc/wHCj74TgPVXcHDywlNjE7knAgpJJ5+2BOR4=;
        b=vh+oLdzmNedaZWqpSdImlCdeSm/E6voJr4Y7gopjaw8DyIe1LUQ+I7slx991CBNtU6
         l0EZ9ox9khJ5j7ZY5JVD8bsMhn4q3WpcGjN0TopcZfWojXNSjdBZ+hXNW6HI6cPafBoT
         4SNuw6QogyoJOBNdGB3ywNA3U1g8pUKPSUdf87XuqJv9OVU9Xk8f2NpiH1M362pSupd7
         3EpY2thmob78mkzKVPehCEsA93WkDcqpGYYoNPXh+uvc+WNhWAE6qhad2RolIL0VaYos
         CSzWeUQo+wcVvnah5Gstlzj69rM4+ttvBa7UxERND3TUiaINvJi88+FKvHjGFrMxRLT4
         ZN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYJrCFc/wHCj74TgPVXcHDywlNjE7knAgpJJ5+2BOR4=;
        b=pqG87N4iB64Nk93qDLkN2zjPwx/7Bv4IRnx++3oWUyS/jeAV4UjDfuoWSiBfb9lUsW
         Rw+tocCKG4wLpw/DttcyXgadij75e940bZ7Oqvm9QAK8L/3Fzz9NAeQxMXJbr092zPL/
         AUlXWwoARGuzxtP+Wbk0mDCv8D3Xpu3kD4DKCqz55AfVX7xlanwbFctota6nIMtqHLbX
         DU6u0LEkbp2HKOb32I9zSi1tbkGVTwrNAb4hgFzFHSAaOw4rEROpacaupJCFVJShrpgl
         86tjbj6xi+wo0b9XUxYR+bQxrtLvjtNCLdft+x58x+Nxn+HdWi1xLJRoY9roScvq/DrX
         fITg==
X-Gm-Message-State: APjAAAUdjLEG0YGamv96ybJ50bR48frsnkAni/hKWRoCpxxH3dAF2MB1
        nBpfbTyy8JkJL1uTOO3ds0kF6tHHDebqzeMpym0=
X-Google-Smtp-Source: APXvYqw6RBtFmrbNJo8c2AyO5H+YK+vXPc8kLziw3ceBpliiLiydQl0NlmAj0zfoGc2X/54n7hRI984ZINLA2xmYsoY=
X-Received: by 2002:a05:6830:1317:: with SMTP id p23mr1554160otq.3.1582856940185;
 Thu, 27 Feb 2020 18:29:00 -0800 (PST)
MIME-Version: 1.0
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
 <587446db-5168-d91d-c1fa-c7bef48959d9@gmx.com>
In-Reply-To: <587446db-5168-d91d-c1fa-c7bef48959d9@gmx.com>
From:   4e868df3 <4e868df3@gmail.com>
Date:   Thu, 27 Feb 2020 19:28:23 -0700
Message-ID: <CADq=pgn3-4S3ErK0G+ajf-5M=8CSaE6iow25ASaBxCygedy=7g@mail.gmail.com>
Subject: Re: corrupt leaf
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> What are the details of the storage stack? What are the Btrfs devices backed by on the host? Physical partitions, or qcow2, or raw files? If they are files, is chattr +C set?
6x 2tb scsi drives. Raw physical partitions, working through LUKS.
Proxmox passes the devices directly through to the VM without touching
them.

> btrfs ins dump-tree -b 2533706842112 /dev/dm-0
btrfs-progs v5.4
leaf 2533706842112 items 9 free space 5914 generation 360253 owner CSUM_TREE
leaf 2533706842112 flags 0x1(WRITTEN) backref revision 1
fs uuid 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
chunk uuid c3b187d2-64c1-46f0-a83f-d0aeb0e37fe4
        item 0 key (EXTENT_CSUM EXTENT_CSUM 68754231296) itemoff 16279
itemsize 4
                range start 68754231296 end 68754235392 length 4096
        item 1 key (EXTENT_CSUM EXTENT_CSUM 68754235392) itemoff 13167
itemsize 3112
                range start 68754235392 end 68757422080 length 3186688
        item 2 key (EXTENT_CSUM EXTENT_CSUM 68757422080) itemoff 12891
itemsize 276
                range start 68757422080 end 68757704704 length 282624
        item 3 key (EXTENT_CSUM EXTENT_CSUM 68757819392) itemoff 12767
itemsize 124
                range start 68757819392 end 68757946368 length 126976
        item 4 key (EXTENT_CSUM EXTENT_CSUM 68757946368) itemoff 11359
itemsize 1408
                range start 68757946368 end 68759388160 length 1441792
        item 5 key (EXTENT_CSUM EXTENT_CSUM 68759388160) itemoff 9567
itemsize 1792
                range start 68759388160 end 68761223168 length 1835008
        item 6 key (EXTENT_CSUM EXTENT_CSUM 68761178112) itemoff 9363
itemsize 204
                range start 68761178112 end 68761387008 length 208896
        item 7 key (EXTENT_CSUM EXTENT_CSUM 68761387008) itemoff 7739
itemsize 1624
                range start 68761387008 end 68763049984 length 1662976
        item 8 key (EXTENT_CSUM EXTENT_CSUM 68763049984) itemoff 6139
itemsize 1600
                range start 68763049984 end 68764688384 length 1638400

> btrfs check --force /dev/mapper/luks0
Opening filesystem to check...
WARNING: filesystem mounted, continuing because of --force
Checking filesystem on /dev/mapper/luks0
UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
there are no extents for csum range 68757573632-68757704704
Right section didn't have a record
there are no extents for csum range 68754427904-68757704704
csum exists for 68750639104-68757704704 but there is no extent record
there are no extents for csum range 68760719360-68761223168
Right section didn't have a record
there are no extents for csum range 68757819392-68761223168
csum exists for 68757819392-68761223168 but there is no extent record
there are no extents for csum range 68761362432-68761378816
Right section didn't have a record
there are no extents for csum range 68761178112-68836831232
csum exists for 68761178112-68836831232 but there is no extent record
there are no extents for csum range 1168638763008-1168638803968
csum exists for 1168638763008-1168645861376 but there is no extent record
ERROR: errors found in csum tree
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 3165125918720 bytes used, error(s) found
total csum bytes: 3085473228
total tree bytes: 4791877632
total fs tree bytes: 1177714688
total extent tree bytes: 94617600
btree space waste bytes: 492319296
file data blocks allocated: 3160334041088
 referenced 3157401378816
