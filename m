Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0273B14DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 21:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfILTok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 15:44:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42505 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfILTok (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 15:44:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id q14so29679064wrm.9
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/qqkspYESQk7ASaaUF2wdXPFFl46PXFiF93YTJFVnM=;
        b=cMxhy85cGkCZdFKZZR+J6EFP2EJdojz0m+ig5fxDpYYun39nJFF1mCCIu3aNk8fykp
         tl8Zqumik2K+ZY+nF4VGpE9dmraIrxeN1/AILdjw+iFuPOcHx7VBQOJyxbY65rY43Zc8
         PoFgfF3GYC7rZ8TpgAUzfpy3109eEdcYQYgR9E7/r6enAkF/pxY7wiA2gFHIxgVFK6OB
         V/7vz5BN/wr8h69/wr2I45CZBfgwwbeEjSY31UEt4YWmbZO60Y7r7cuKkXqc8LTEgXBL
         nAIozgJW3rWwNDBU4SN6diMM8xntr9cDH1U4BRE0rP0DjFeIKYvlr13AqubjqCBHX20O
         22og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/qqkspYESQk7ASaaUF2wdXPFFl46PXFiF93YTJFVnM=;
        b=KQ5pMsCXLJDyomsqhwm0IFrxfme5pV/worSQlQKMPfSP7b0ewXs8G03rdM1xL0hzTq
         Q2aPBwbIZYC0sejERO07uZdNLV7t9cAkehaxEa0Minh0ZNqHOmpY+wd35/z5RGeQByiX
         /5+WzY/PxV2L+vOUBB7wc655HVL+WL+30E1m/rTYD6jxv7LjacTR1qBcGWguAWubGBJ0
         50t5PQAisumgk4JzaygxgojQ6Xh14d4F/8qERz+43828++aZY6imoG78hd60mAjeD6qB
         +jA0f45JMvvhk8aYYrCk9wHhd3R71YgQvPGgCVXdhEejs8FavD8JpSiQ7XoebP4rD/88
         JCMA==
X-Gm-Message-State: APjAAAXaSwjRtMXtFSaJqddVh+TgVfdUc7P2QDOsR9zah17evjVrL4wM
        RyS+NswO6zgCsa5zTlI/FsW+Shfgpbe+gsvaIDd/QA==
X-Google-Smtp-Source: APXvYqxfOB/i5sn7Lo376BS+4ywv/r6Vlh6pMUEe+HI28qQ+gd57fsrCUURXg0W323LC/e86NAefADEMbzSG0BZ2r6Q=
X-Received: by 2002:adf:e390:: with SMTP id e16mr6995419wrm.29.1568317476961;
 Thu, 12 Sep 2019 12:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com> <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com> <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com> <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com> <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com> <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com> <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
In-Reply-To: <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 12 Sep 2019 13:44:25 -0600
Message-ID: <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     webmaster@zedlx.com
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 1:18 PM <webmaster@zedlx.com> wrote:
>
> It is normal and common for defrag operation to use some disk space
> while it is running. I estimate that a reasonable limit would be to
> use up to 1% of total partition size. So, if a partition size is 100
> GB, the defrag can use 1 GB. Lets call this "defrag operation space".

The simplest case of a file with no shared extents, the minimum free
space should be set to the potential maximum rewrite of the file, i.e.
100% of the file size. Since Btrfs is COW, the entire operation must
succeed or fail, no possibility of an ambiguous in between state, and
this does apply to defragment.

So if you're defragging a 10GiB file, you need 10GiB minimum free
space to COW those extents to a new, mostly contiguous, set of exents,
and then some extra free space to COW the metadata to point to these
new extents. Once that change is committed to stable media, then the
stale data and metadata extents can be released.

And this process is subject to ENOSPC condition. That's really what'll
tell you if you don't have enough space otherwise your setup time for
a complete volume recursive defragment is going to be really long, and
has some chance of reporting back that defragment isn't possible even
though most of it could be possible.

Arguably the defragmenting strategy should differ depending on whether
no_ssd or ssd mount option is enabled. Massive fragmentation on SSD
does impact latency, but there are no locality concerns, so as long as
the file is defragmented into ~32MiB extents, I think it's fine.
Perhaps ideal would be erase block sized extents? Whereas on a hard
drive, locality matters as well.


-- 
Chris Murphy
