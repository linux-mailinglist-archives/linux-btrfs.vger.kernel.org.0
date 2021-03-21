Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA03C343097
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Mar 2021 03:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCUCEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Mar 2021 22:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCUCEM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Mar 2021 22:04:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E89AC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 19:04:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k128so5081583wmk.4
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 19:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktXw3pRefZkNBIViGloIIYaL8kzv3Hy7MHjB4ORS4J8=;
        b=MorrX7uvHm6l/ju7MteUTGuJo+83XVNqEXLGIVkUqTZvP4Y6yzCTl2jN2pq7bEKVZc
         Q5EFvDikbR5cDbhE+e1ZGjjvv8GoOtew0jd6xtu2Hzwf174eFw5fN6YO/G/psCoZYZqR
         6RbjD2dPEs3yr6W7dRXRDjyrm+HBot/I0hVWscHFBqrxGD4jxr0CQHmwVFvq4+pA5Emi
         bda7yVf6EfOQDlKqtHmGPYxVVZYGtmdv/csDieCX8IdhfAqj3bc5ro9OSjkLsLasLJE6
         7YPvJO3ee2vAngDvNfukCtgMTQ2ncDqjx9k++79nLylqKe6oJxulZElP+i+092iYtYZJ
         q7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktXw3pRefZkNBIViGloIIYaL8kzv3Hy7MHjB4ORS4J8=;
        b=S+NUklRXD8Kh1urYyUe4YtsCJYeGCdgVWUOq1y5L6/wddLDwksXCSVc1vjc7PGyoOs
         CpUW2/jT2KKbQ/+EK2OkGpn3+vm/vHHOUWkPV5JYVrCsyWFxinLcCFCTeOam5Gh6cRwL
         DVSoBpvn/2AnPdiVVvhofv/VSDd+lbcy3N/IaR5HRxfjWvTt/ZnkPYJUAv9jjDioxREc
         eCkj9ZnV0a2u41Kn65n0hJBszCwJEQPP6527az0tk6pwUzEaWmsvT6sYfIRVlwD4GD3E
         vjMAfikT/jGLdzEkxBnuIwCOmSK8XHShQg2l8Sp9VCg5krv6/PjhELQhQgGA0wsb+nO9
         ECfA==
X-Gm-Message-State: AOAM531DVBrtu18nRc1dnpspFYhqnk2+gLJXH8zaCNUOG11bXnVLusd8
        aRh9wLf8tfBV6CBzLD/y47SnnAJ9ovIgeebBMEqNVLM/0I/7Jjh0
X-Google-Smtp-Source: ABdhPJx91aOsUyk5CCjeSJYrV4QGlxywKGhpzEd8/A9HmYAh7aV8dNWaccqU7Bs6isig3+ed9gRZ2wMQfqoszQVPvYo=
X-Received: by 2002:a05:600c:2cd8:: with SMTP id l24mr9671512wmc.88.1616292250666;
 Sat, 20 Mar 2021 19:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
In-Reply-To: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 20 Mar 2021 20:03:54 -0600
Message-ID: <CAJCQCtSBc-Dmks2jdgr-Bcpdh_iLvVevtGOa4LdYgHc2eZE6Hg@mail.gmail.com>
Subject: Re: parent transid verify failed / ERROR: could not setup extent tree
To:     Dave T <davestechshop@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 20, 2021 at 5:15 AM Dave T <davestechshop@gmail.com> wrote:
>
> I hope to get  some expert advice before I proceed. I don't want to
> make things worse. Here's my situation now:
>
> This problem is with an external USB drive and it is encrypted.
> cryptsetup open succeeds. But mount fails.k
>
>     mount /backup
>     mount: /backup: wrong fs type, bad option, bad superblock on
> /dev/mapper/xusbluks, missing codepage or helper program, or other
> error.
>
>  Next the following command succeeds:
>
>     mount -o ro,recovery /dev/mapper/xusbluks /backup
>
> This is my backup disk (5TB), and I don't have another 5TB disk to
> copy all the data to. I hope I can fix the issue without losing my
> backups.
>
> Next step I did:
>
>         # btrfs check /dev/mapper/xyz
>         Opening filesystem to check...
>         parent transid verify failed on 2853827608576 wanted 29436 found 29433
>         parent transid verify failed on 2853827608576 wanted 29436 found 29433
>         parent transid verify failed on 2853827608576 wanted 29436 found 29433
>         Ignoring transid failure
>         leaf parent key incorrect 2853827608576
>         ERROR: could not setup extent tree
>         ERROR: cannot open file system


From your superblock:

        backup 2:
                backup_tree_root:       2853787942912   gen: 29433      level: 1

Do this:

btrfs check -r 2853787942912 /dev/xyz

If it comes up clean it's safe to do: mount -o usebackuproot, without
needing to use ro. And in that case it'll self recover. You will lose
some data, between the commits. It is possible there's partial loss,
so it's not enough to just do a scrub, you'll want to freshen the
backups as well - if that's what was happening at the time that the
trouble happened (the trouble causing the subsequent transid
failures).

Sometimes backup roots are already stale and inconsistent due to
overwrites, so the btrfs check might find problems with that older
root.

What you eventually need to look at is what precipitated the transid
failures, and avoid it. Typical is a drive firmware bug where it gets
write ordering wrong and then there's a crash or power fail. Possibly
one way to work around the bug is disabling the drive's write cache
(use a udev rule to make sure it's always applied). Another way is add
a different make/model drive to it, and convert to raid1 profile. And
hopefully they won't have overlapping firmware bugs.


-- 
Chris Murphy
