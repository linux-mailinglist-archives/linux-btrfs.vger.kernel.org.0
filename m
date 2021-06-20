Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3643AE096
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jun 2021 23:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFTVMK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhFTVMJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 17:12:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757FFC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 14:09:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r9so17275689wrz.10
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkhBqg+1WDrg9CzF9hLoL+VlWkza1dzvDbr2a7ETnLM=;
        b=QJpljYFt6LeyiKgg7R4DWeFkzBajhlWJ2MnVBnUYIyTWPbnIv/Okz1/m1TxaMq0cEu
         mt8LDwY+Co/pkfMMGP1VjvkC62frgbsbH6bk7fq7c/cxjnYFOVo4ZYnDYRrKubqLFrA4
         maUPHJGPKpIcqGR62RzwjQKNrjTMxT74dJMa6XfsryYJyNcHAfOdJdtIhxUHUhVJw5NS
         q83ioCqHrjdtfq8nYym9SMma68OS6xQJBxYg3Q93XgGiNUGL+XO3e3Q9Tm+FwCAi8EdC
         GN2bB8Ubo2NJ5UtYIQt5V/EMyJOBBbbph0j3cY+8RIRnajJLJHKWgvn3CPelR3bDxhEZ
         3MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkhBqg+1WDrg9CzF9hLoL+VlWkza1dzvDbr2a7ETnLM=;
        b=YCqz1Opj/y6cB2TYbd/Ww9sas6P8/wihMTJjs3KXKT3B2SKoJR0Wn0PqJS/5Pm6KzU
         q7hJ3R8Gt9YfCVKYPo4Zl9jrTpHAglS9ilslXVJmOFxXYdGBqA4Je2nXRAJXWqtMGG23
         fvfRJUk79Rx5XKWmMOuEofbn3bn1UjqhQymZX78KSaRN19iGG1QPv6JvFotMGglZrQjh
         mmHAwRgkROERrVMd3lsyshJDAVwZw0T0U19ppkwgq5t470IF5spee790DApHx2//61FN
         DOyPtHa6Fa9pIBFWIj/wlRohZya8fb5tn03XB7tTVIwLLYlSeY4PxCs055tnY3lhj0Gr
         j8Zg==
X-Gm-Message-State: AOAM530mYs/eNmUw9Um4nJlu4seaP/Dqio7TGgiLz93QWpr01o0oodsH
        4JzmopIyr4JWIxJCSYIfymCS9eBgr9WyGg8UxAgzYw==
X-Google-Smtp-Source: ABdhPJzYwXvdp5YQuEJ3ZwPAT1vjdAczI6jyPHFbS+QooyDe/MkidI8oD68TEyRSR7DljuqQp4j9qF1ydiIIUJo8TsY=
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr5151894wrx.236.1624223394107;
 Sun, 20 Jun 2021 14:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEhgEss-SusbDdw1qz-7hB3SbQyWhkYNkVLHdQuE+NhMXe27A@mail.gmail.com>
In-Reply-To: <CAEEhgEss-SusbDdw1qz-7hB3SbQyWhkYNkVLHdQuE+NhMXe27A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 20 Jun 2021 15:09:38 -0600
Message-ID: <CAJCQCtQVqPbwnQXjEECxO-YQVp5XV3cLip8izbTVUkPtOL7P2g@mail.gmail.com>
Subject: Re: Recover from "couldn't read tree root"?
To:     Nathan Dehnel <ncdehnel@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 20, 2021 at 2:38 PM Nathan Dehnel <ncdehnel@gmail.com> wrote:
>
> A machine failed to boot, so I tried to mount its root partition from
> systemrescuecd, which failed:
>
> [ 5404.240019] BTRFS info (device bcache3): disk space caching is enabled
> [ 5404.240022] BTRFS info (device bcache3): has skinny extents
> [ 5404.243195] BTRFS error (device bcache3): parent transid verify
> failed on 3004631449600 wanted 1420882 found 1420435
> [ 5404.243279] BTRFS error (device bcache3): parent transid verify
> failed on 3004631449600 wanted 1420882 found 1420435
> [ 5404.243362] BTRFS error (device bcache3): parent transid verify
> failed on 3004631449600 wanted 1420882 found 1420435
> [ 5404.243432] BTRFS error (device bcache3): parent transid verify
> failed on 3004631449600 wanted 1420882 found 1420435
> [ 5404.243435] BTRFS warning (device bcache3): couldn't read tree root
> [ 5404.244114] BTRFS error (device bcache3): open_ctree failed
>
> btrfs rescue super-recover -v /dev/bcache0 returned this:
>
> parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> Ignoring transid failure
> ERROR: could not setup extent tree
> Failed to recover bad superblocks
>
> uname -a:
>
> Linux sysrescue 5.10.34-1-lts #1 SMP Sun, 02 May 2021 12:41:09 +0000
> x86_64 GNU/Linux
>
> btrfs --version:
>
> btrfs-progs v5.10.1
>
> btrfs fi show:
>
> Label: none  uuid: 76189222-b60d-4402-a7ff-141f057e8574
>         Total devices 10 FS bytes used 1.50TiB
>         devid    1 size 931.51GiB used 311.03GiB path /dev/bcache3
>         devid    2 size 931.51GiB used 311.00GiB path /dev/bcache2
>         devid    3 size 931.51GiB used 311.00GiB path /dev/bcache1
>         devid    4 size 931.51GiB used 311.00GiB path /dev/bcache0
>         devid    5 size 931.51GiB used 311.00GiB path /dev/bcache4
>         devid    6 size 931.51GiB used 311.00GiB path /dev/bcache8
>         devid    7 size 931.51GiB used 311.00GiB path /dev/bcache6
>         devid    8 size 931.51GiB used 311.03GiB path /dev/bcache9
>         devid    9 size 931.51GiB used 311.03GiB path /dev/bcache7
>         devid   10 size 931.51GiB used 311.03GiB path /dev/bcache5
>
> Is this filesystem recoverable?
>> (Sorry, re-sending because I forgot to add a subject)

Definitely don't write any irreversible changes, such as a repair
attempt, to anything until you understand what what wrong or it'll
make recovery harder or impossible.

Was bcache in write back or write through mode?

What's the configuration? Can you supply something like

lsblk -o NAME,FSTYPE,SIZE,FSUSE%,MOUNTPOINT,UUID,MIN-IO,SCHED,DISC-GRAN,MODEL



-- 
Chris Murphy
