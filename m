Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1583CC00C
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 02:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGQAVs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 20:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGQAVs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 20:21:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CACC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 17:18:51 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id y66so3548385oie.7
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 17:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RcXfLHT29IhHNR83HiPsMtQ7SUhrgmHVxIwu5g49lo=;
        b=O9BGCkh1E30LFJtcWeBlq6fLbusGZ9cxIzzxbUGbjsyniyQp3NM/Nb+8A0RqZdxg3H
         6Lt+KRy1qiJSTCSzRX34tbp4VA/gWvWlxc2kzaVwMS+HyOQsBYmo1boFuxoSViB7DWL3
         bYm1aRTiejJUqw3nFkeKbiLj33MH2gk1Kdr4jgSk/WlgqVdvSe9uWJYDn2g25QeQZ4n1
         1hLstW491S2Bmqs8V3deQQpNEY9xss1jPGB2CP4NJ7oW/eJTR2CHeYCP+/QQThA7doCR
         Jx2TDVlzEUXKAgy9buasjdAmcw4I7luo0a5K26kZtg84SAET70tw+KNQJWWBfXCBgwX+
         PSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RcXfLHT29IhHNR83HiPsMtQ7SUhrgmHVxIwu5g49lo=;
        b=jGQFlhRQyv4PDePMycKesE7WOb78AYNLOyw+0VqD0BCdego8J97h+tvab1ihAonkKz
         rWE4vgbtcg4kbji8nllPLY7tu9h2Ed9ijg2+2e9/O3pDWlw3g05GElDKczR6RU/8WfA6
         MXixl3Vkz2Dp7TyAwdG0EHUZlZqbYv6x2twdu3ccjwpBjMqRCS+S7jyUAb4v0rbPDYOj
         JnRZsuPhuxGAc4NUI0pX/W0inGq7WO6eBdeXmZVqdTKk7ue9+ENZHnRKyBxvdr8m1ARH
         AV5v6KWeZXLRaN8FvezBu6GwOKg754B1Dl9N4ZuiyakFa7ece6B5qAN8h/F/Wq6P/eg2
         Fbjg==
X-Gm-Message-State: AOAM5300NfFf3HeHHPNy36QaBKC5ENr12BipDHQiVNLmm2ngprMKoFKy
        jnmJJc6pluY53d4aw8xqVEbrbyoKFpc5BgrjGDw=
X-Google-Smtp-Source: ABdhPJzkevBJ4lNWVDZ1jMKVzec8LKvssvDyb4lKN0fuFsWxYDXeHPrEyP0OfoUTBR+ksc0baluvhPLTsH9v2V4agH0=
X-Received: by 2002:a54:4e95:: with SMTP id c21mr14467463oiy.137.1626481131023;
 Fri, 16 Jul 2021 17:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com> <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com> <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
 <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com> <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
 <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com> <CAGdWbB6Y0p3dc6+00eTnf1XSS1rUMbPUckQabi6VJQXdjRt2jg@mail.gmail.com>
 <88005f9b-d596-f2f9-21f0-97fc7be4c662@gmx.com> <CAGdWbB59w+5=3AoKU0uRHHkA1zeya0cRhqRn8sDYpea+hZOunA@mail.gmail.com>
 <e42fcd8e-23d4-ee98-aab6-2210e408ad3f@gmx.com>
In-Reply-To: <e42fcd8e-23d4-ee98-aab6-2210e408ad3f@gmx.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Fri, 16 Jul 2021 20:18:39 -0400
Message-ID: <CAGdWbB7z2Q8hCFx_VriHaV1Ve1Yg7P38Rm63hMS6QxbVR=V-jQ@mail.gmail.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 16, 2021 at 7:06 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> So far so good, every thing is working as expected.

Thank you for confirming. I learned a lot in this discussion.


> Just the btrfs-check is a little paranoid.
>
> BTW, despite the bad file extent and csum missing error, is there any
> other error reported from btrfs check?

No, there was not. However... (see below)

> It's a pity that we didn't get the dmesg of that RO event, it should
> contain the most valuable info.
>
> But at least so far your old fs is pretty fine, you can continue using it.

... since you don't need me to do any more testing on this fs and I
don't need the old fs anymore, I decided to experiment.

I did the following operations:

btrfs check --mode=lowmem /dev/mapper/${mydev}luks
This reported exactly the same csum issue that I showed you
previously. For example:
ERROR: root 334 EXTENT_DATA[258 73728] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 334 EXTENT_DATA[258 73728] is compressed, but inode flag
doesn't allow it
The roots and inodes appear to be the same ones reported previously.
Nothing new.

So I experimented with these operations:
# btrfs check --clear-space-cache v1 /dev/mapper/${mydev}luks
Checking filesystem on /dev/mapper/sda2luks
UUID: ff2b04ab-088c-4fb0-9ad4-84780c23f821
Free space cache cleared
(no errors reported)

I wanted to try that on a fs I don't care about before I try it for
real. I also wanted to try the next operation.

# btrfs check --clear-ino-cache  /dev/mapper/${mydev}luks
...
Successfully cleaned up ino cache for root id: 5
Successfully cleaned up ino cache for root id: 257
Successfully cleaned up ino cache for root id: 258
(no errors reported)

I have never used the repair option, but I decided to see what would
happen with this next operation. Maybe I should not have combined
these parameters?

# btrfs check --repair --init-csum-tree /dev/mapper/${mydev}luks
...
Reinitialize checksum tree
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
ref mismatch on [22921216 16384] extent item 1, found 0
backref 22921216 root 7 not referenced back 0x56524a54f850
incorrect global backref count on 22921216 found 1 wanted 0
backpointer mismatch on [22921216 16384]
owner ref check failed [22921216 16384]
repair deleting extent record: key [22921216,169,0]
Repaired extent references for 22921216
ref mismatch on [23085056 16384] extent item 1, found 0
backref 23085056 root 7 not referenced back 0x565264430000
incorrect global backref count on 23085056 found 1 wanted 0
backpointer mismatch on [23085056 16384]
owner ref check failed [23085056 16384]
repair deleting extent record: key [23085056,169,0]
... more
(The above operation reported tons of errors. Maybe I did damage to
the fs with this operation? Are any of the errors of interest to you?)

I ran it again, but with just the --repair option:
# btrfs check --repair /dev/mapper/${mydev}luks
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/mapper/xyzluks
UUID: ff2b04ab-088c-4fb0-9ad4-84780c23f821
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
ref mismatch on [21625421824 28672] extent item 17, found 16
incorrect local backref count on 21625421824 parent 106806263808 owner
0 offset 0 found 0 wanted 1 back 0x55798f5fdc10
backref disk bytenr does not match extent record, bytenr=21625421824,
ref bytenr=0
backpointer mismatch on [21625421824 28672]
repair deleting extent record: key [21625421824,168,28672]
adding new data backref on 21625421824 parent 368825810944 owner 0
offset 0 found 1
adding new data backref on 21625421824 parent 309755756544 owner 0
offset 0 found 1
adding new data backref on 21625421824 parent 122323271680 owner 0
offset 0 found 1
adding new data backref on 21625421824 parent 139575754752 owner 0
offset 0 found 1
adding new data backref on 21625421824 parent 107060248576 owner 0
offset 0 found 1
adding new data backref on 21625421824 parent 107140677632 owner 0
offset 0 found 1
adding new data backref on 21625421824 parent 107212980224 owner 0
offset 0 found 1
adding new data backref on 21625421824 parent 771014656 owner 0 offset 0 found 1
adding new data backref on 21625421824 parent 180469760 owner 0 offset 0 found 1
adding new data backref on 21625421824 root 26792 owner 359 offset 0 found 1
adding new data backref on 21625421824 parent 160677888 owner 0 offset 0 found 1
adding new data backref on 21625421824 parent 461373440 owner 0 offset 0 found 1
adding new data backref on 21625421824 root 1761 owner 359 offset 0 found 1
adding new data backref on 21625421824 root 280 owner 359 offset 0 found 1
adding new data backref on 21625421824 root 326 owner 359 offset 0 found 1
adding new data backref on 21625421824 root 26786 owner 359 offset 0 found 1
Repaired extent references for 21625421824
ref mismatch on [21625450496 4096] extent item 17, found 16
incorrect local backref count on 21625450496 parent 106806263808 owner
0 offset 0 found 0 wanted 1 back 0x55798f5fe340
backref disk bytenr does not match extent record, bytenr=21625450496,
ref bytenr=0
backpointer mismatch on [21625450496 4096]
repair deleting extent record: key [21625450496,168,4096]
adding new data backref on 21625450496 parent 368825810944 owner 0
offset 0 found 1
adding new data backref on 21625450496 parent 309755756544 owner 0
offset 0 found 1
adding new data backref on 21625450496 parent 122323271680 owner 0
offset 0 found 1
adding new data backref on 21625450496 parent 139575754752 owner 0
offset 0 found 1
adding new data backref on 21625450496 parent 107060248576 owner 0
offset 0 found 1
adding new data backref on 21625450496 parent 107140677632 owner 0
offset 0 found 1
adding new data backref on 21625450496 parent 107212980224 owner 0
offset 0 found 1
adding new data backref on 21625450496 parent 771014656 owner 0 offset 0 found 1
adding new data backref on 21625450496 parent 180469760 owner 0 offset 0 found 1
adding new data backref on 21625450496 root 26792 owner 369 offset 0 found 1
adding new data backref on 21625450496 parent 160677888 owner 0 offset 0 found 1
...more
It reported many, many more errors. I'm not sure if any of that
interests you. My plan now is to wipe and reuse this SSD for something
else (with a BTRFS fs of course).

I'm just curious about one thing. Did I create all these problems with
the repair option or were these underlying issues that were not
previously found?
