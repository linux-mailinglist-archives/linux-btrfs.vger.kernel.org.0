Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED2F54AEFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 13:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354897AbiFNLEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245560AbiFNLEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 07:04:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4158F427C7
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 04:04:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id u99so14501977ybi.11
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4hlskbR8nwH1VZlqNfbmq7ueG19aNoVv/uwQuxMhVw=;
        b=QDGqC9Km6rMieU/z5OJ+smduhkNEnsWyKcwAcKki8ruBeKEr40mlPYTU8Zldp7nwut
         sD8ZQErJuwoSOwJ69SzRTgida8ry0GxRxHK1nN8JSeMhTkwmERbPbUl+RXm42lHoZo3T
         orf7DdgsDK3wHx1G0cYKJGnfwwEVq6oMY02Dohe1xjwtNHZi8Hlodrpk+ZZ2pdDv8+w+
         htRuzPienQDpqKYoMoRNtdFyXUdeLL9gli3ZGE8Q1zHBxowf0Z+HlLFnuaiSEmo1MvlX
         FJjEQhhAHbUb+zvpxDJuIsubM8gs3Y+asa6poEmYaA9UtHz0nVawZliUQT8pZMRnDW6/
         zHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4hlskbR8nwH1VZlqNfbmq7ueG19aNoVv/uwQuxMhVw=;
        b=yfwJpQCZWicRnKrSQQiaHDP9r6lkdI51r0PYhD7tZ1U0rChWWbQaUbq2zIlB8KDBfC
         ZvIkDBPfP7kdzshZ2xtW5uNt5ViOCMXJwfaU3nZPslWma+mJUZwsQfdF1xMQZQmO/u/6
         5rlkl9NSzEpoxComa0L3hE0glnvYzV0KDsK/3vuZFpzFU5vtC22SLsfvm6Q0IKHXEzbB
         kuMCmGpO6sb+iBcaZ+30JVCPjAs2XVru4c0d8aHCNCNYcYvba2z2ZH+mZxZ8M8SvTGmV
         l7kpUGuneVAFehbhumL9ndJf7mLklATeJDVR1nP4qNGfq1rLRINFGLhZvhO3drlEyn+A
         IZ+A==
X-Gm-Message-State: AJIora/ialz4xw/WFNyNsym2kJnu7DlVHccm0UA+Z2xsS/Vj5FrKaoTy
        FH/5ClagfAebNqKQYGWkNUtLwbb2O/z/4Ylkoqc=
X-Google-Smtp-Source: AGRyM1sok7Pz0lLSth2bAS5PLpIOzdyqm4dXi3/iBqH7VqMbEI/ZiO0Q/+4XlumDMxevRK/4hK+g19svppO9gBOIkKg=
X-Received: by 2002:a25:8892:0:b0:64d:d0c8:2460 with SMTP id
 d18-20020a258892000000b0064dd0c82460mr4313378ybl.531.1655204645092; Tue, 14
 Jun 2022 04:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220611045120.GN22722@merlins.org>
In-Reply-To: <20220611045120.GN22722@merlins.org>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Tue, 14 Jun 2022 21:03:53 +1000
Message-ID: <CAN05THQs9BkQCd+TnqbGik1Yj-JjJ_Q6Of6pCn8tft873aBToQ@mail.gmail.com>
Subject: Re: Suggestions for building new 44TB Raid5 array
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
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

On Sat, 11 Jun 2022 at 17:16, Marc MERLIN <marc@merlins.org> wrote:
>
> so, my apologies to all for the thread of death that is hopefully going
> to be over soon. I still want to help Josef fix the tools though,
> hopefully we'll get that filesystem back to a mountable state.
>
> That said, it's been over 2 months now, and I do need to get this
> filesystem back up from backup, so I ended up buying new drives (5x
> 11TiB in raid5).
>
> Given the pretty massive corruption that happened in ways that I still
> can't explain, I'll make sure to turn off all the drive write caches
> but I think I'm not sure I want to trust bcache anymore even though
> I had it in writethrough mode.
>
> Here's the Email from March, questions still apply:
>
> Kernel will be 5.16. Filesystem will be 24TB and contain mostly bigger
> files (100MB to 10GB).
>
> 1) mdadm --create /dev/md7 --level=5 --consistency-policy=ppl --raid-devices=5 /dev/sd[abdef]1 --chunk=256 --bitmap=internal
> 2) echo 0fb96f02-d8da-45ce-aba7-070a1a8420e3 >  /sys/block/bcache64/bcache/attach
>    gargamel:/dev# cat /sys/block/md7/bcache/cache_mode
>    [writethrough] writeback writearound none
> 3) cryptsetup luksFormat --align-payload=2048 -s 256 -c aes-xts-plain64  /dev/bcache64
> 4) cryptsetup luksOpen /dev/bcache64 dshelf1
> 5) mkfs.btrfs -m dup -L dshelf1 /dev/mapper/dshelf1
>
> Any other btrfs options I should set for format to improve reliability
> first and performance second?
> I'm told I should use space_cache=v2, is it default now with btrfs-progs 5.10.1-2 ?
>
> As for bcache, I'm really thinking about droppping it, unless I'm told
> it should be safe to use.
>
> Thanks,
> Marc

My needs are much more basic.
I have a LOT of large files. ISO images and QEMU disk images. I also
have hundreds of thousands of photos.

I used different multi-disk solutions but found them all too fragile
so now, last 8 years, I have used a setup that is basically
5 disks each with their own EXT4 filesystem ontop of LUKS and two
additional drives to have 2 disk parity in snapraid.
Now, snapraid does not do in-line raid updates so I carefully manage
how I handle the data.
Audio, photos and QEMU base images are immutable so these files are
not a problem.
For VM images I have for each machine an immutable 'base' image that
snapraid takes care of and I have live images based on that that are
not
handled by snapraid.  (qemu-img create -b base.img cow.img)
If a live image goes corrupt due to a poweroutage or similar I just
re-create it ontop of the latest archived base image.
As I often do stuff to the VM images that cause kernel panics, this is
a very convenient way to restore them quickly and with little effort
to a known good state.

If one disk has a catastrophic failure, I only lose the files on that
particular disk and just have to restore them but nothing else.
Now I do export them as 5 different filesystems/shares  but that is
just because I am too lazy to set up some kind of "merge fs".

If your use case is mostly-read and mostly-archive this might work for
you too and it is VERY reliable.
Ease of mind knowing that if a single disk dies I do not have a total
dataloss scenario. If the Windows VM disk dies, I just restore those
images while all the other disks are still online.


It is simple, primitive and 1980 type of technology but it works. And
it is reliable.

> --
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>
> Home page: http://marc.merlins.org/
