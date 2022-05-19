Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E728C52D141
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiESLOq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiESLOo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:14:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A153A939DE
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:14:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f4so8458146lfu.12
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTeKFl5j/z/HJUZZ0HCocb6tDEXjAKbqNwJrOyFcT/g=;
        b=ZOdEhQl0EbiO4VCT4mXMS7IiyRSlNUv7n7KMrCWKMQQ273KmzPvlFg7CqDJkLQUmFz
         fWcdQ0KYWk9lN9gwaoObGOi3bnDg6sCP2IYV21/iQgVbBtByFX0XChK107G6o9L2Ln0g
         EhU2QLAnJY62ar/Y9eyLq+ttlsigGF4a7AqKqqBM/3UWvDNUL9cC4J49BsFQsN/KsGcY
         8gL7ZFXsqL7YR/VFBygIvabvwGmVJRcFAb2/yKv/lHmMc2Z1XCcg+LTzdKnJMVLqZJzO
         d/sHK6AvWHORcud0FyD6sCWy4Iq0yRSKX6y+LqbjKNRxag7sB7yOOpFoGBpDmG7bCWBa
         KSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTeKFl5j/z/HJUZZ0HCocb6tDEXjAKbqNwJrOyFcT/g=;
        b=IFJNqR1X60Th7xP26jlqIo8Hfh3xdbDogIVpS7TJu4PRzO/DfT5XB0p+x91taHuz8O
         rPkUQ6+uQ3/JfIYwJOuRMYLopTAA/bEwxDdSFvtnpBFHDk/mWJPkS8ewLJAG2OuczUic
         C5pnvIsWglWQGXnIDit/LXsXdkoPzQZwCkDxudCpKO750UdXZJMdD54QBIJjOuI3QQ0y
         Q3ajfXPJ6kPD/W6QYp3h9s1P2qHRL6zpJaRThOglKc8OB0qo+KA24l0uMaPVZ2gL3A6C
         /qBwHLTJlplKMavaUA7Qh/RLZHnk/T93cX5w9IWy4qiV4k97bc/AWBZTbbG/MzjDCJyB
         9k3Q==
X-Gm-Message-State: AOAM530/A3ZyR7w7wGYhTc+gYSdL8+fuOg6YMh5f2wufxwbLjpYm0698
        kXBrhW7wURR2AGLSsdFS5TIS4d2fIaeexn+S4gt0QKe+A3k=
X-Google-Smtp-Source: ABdhPJzHHc4Bny36SW7Tt/60MjrdrvcfWIXDjQwybgyGmiqDjMdyOnJkyfpe5/BdPtiv4GQtP/npqY2zJUOwlZnwMGg=
X-Received: by 2002:a05:6512:12c3:b0:473:c7e2:b46b with SMTP id
 p3-20020a05651212c300b00473c7e2b46bmr3046513lfg.382.1652958881969; Thu, 19
 May 2022 04:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
 <275444b7-de43-d0b5-dd4b-41670164e351@cobb.uk.net>
In-Reply-To: <275444b7-de43-d0b5-dd4b-41670164e351@cobb.uk.net>
From:   arnaud gaboury <arnaud.gaboury@gmail.com>
Date:   Thu, 19 May 2022 13:14:30 +0200
Message-ID: <CAK1hC9usm5ArZEf3xd4Tnd730_EBU4zwv3tL5wopu=XP2a4gJA@mail.gmail.com>
Subject: Re: can't boot into filesystem
To:     Graham Cobb <g.btrfs@cobb.me.uk>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

the issue has been solved.
I chrooted the filesystem, then run btrfs filesystem show. There, I
saw the external device I tried to attach tomy btrfs filesystem. That
was the change in my fstab. But I realized that the device was still
in my filesystem.
I ran btrfs delete and now I Am Back to my OS.
My error came from the fact that going back to the original fstab was
not enough as the external device was still added tomy filesystem.

On Thu, May 19, 2022 at 12:39 PM Graham Cobb <g.btrfs@cobb.me.uk> wrote:
>
> You will probably get a much more useful reply from a developer later
> but in the meantime...
>
> Probably your rescue CD has an older kernel - new kernels do more
> validation on the filesystem. In that case, there is something wrong
> with the filesystem but the old kernel hasn't noticed.
>
> You might want to try a rescue CD based on a newer kernel. And/or you
> should do a "btrfs check" with the latest btrfs-progs that you can run.
> You could even chroot into /mnt/@ (bind mounting dev, proc and sys, of
> course) and see if you can run the btrfs image from /mnt/@/usr/bin/btrfs
> while booted in your rescue CD. If so, try using it to do a "btrfs
> check" on your filesystem. If not, use the btrfs check from the rescue
> CD itself. In either case, DO NOT SPECIFY --repair UNLESS A DEVELOPER
> TELLS YOU TO!!
>
> By the way, /mnt/@ IS your root - it isn't a copy of it. You can see in
> fstab that the "@" subvolume of your disk gets mounted into "/" on boot.
>
> On 19/05/2022 10:58, arnaud gaboury wrote:
> > My OS has been freshly installed on a btrfs filesystem. I am quite new
> > to btrfs, especially when mounting specific partitions. After a change
> > in my fstab, I couldn't boot into the filesystem. Booting from a
> > rescue CD, I changed the fstab back to its original. Unfortunately I
> > still can't boot.
> > Here is part of the error message I have:
> > devid 2 uuid XXYYY is missing
> > failed to read chunk tree: -2
> >
> > part of my fstab:
> > LABEL=magnolia   / btrfs  rw,noatime.....,subvol=@
> > LABEL=magnolia  /btrbk_pool  btrfs  noatime,....,subvolid=5
> > LABEL=magnolia   /home   btrfs .....,subvol=/@home
> > ......
> >
> >
> >
> > I am now back to rescue CD. I can mount my filesystem with no error:
> > # mount -t btrfs /dev/sdb2 /mnt
> > # ls -al /mnt/
> > @
> > btrbk_snapshots
> > @home
> > home
> >
> > I can see my filesystem when I ls the @ directory.
> > What can I do to boot my filesystem which is perfectly reproduced in
> > the @ subvolume? Shall I simply cp the whole filesystem stored in @ to
> > the root of /mnt  when my device sdb2 is mounted?
> > Sorry for the lack of formatting and info, but I can't use the browser
> > from the rescue CD so I am writing from another computer.
>
